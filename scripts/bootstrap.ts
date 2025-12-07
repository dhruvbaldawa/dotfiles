#!/usr/bin/env bun
import * as p from "@clack/prompts";
import { $ } from "bun";
import { resolve } from "path";

const REPO_ROOT = resolve(import.meta.dir, "..");

interface BrewfileOption {
  value: string;
  label: string;
  hint?: string;
  path: string;
}

const BREWFILE_OPTIONS: BrewfileOption[] = [
  {
    value: "core",
    label: "Core CLI tools",
    hint: "Essential tools: git, fzf, ripgrep, starship, etc.",
    path: "files/brew/Brewfile",
  },
  {
    value: "casks",
    label: "Desktop applications",
    hint: "Apps: VS Code, iTerm2, Arc, Obsidian, etc.",
    path: "files/brew/Brewfile.casks",
  },
  {
    value: "work",
    label: "Work tools",
    hint: "Kubernetes, AWS, Helm, 1Password",
    path: "files/brew/Brewfile.work",
  },
];

async function checkCommand(cmd: string): Promise<boolean> {
  try {
    await $`which ${cmd}`.quiet();
    return true;
  } catch {
    return false;
  }
}

async function installHomebrew(): Promise<boolean> {
  const hasHomebrew = await checkCommand("brew");
  if (hasHomebrew) {
    p.log.success("Homebrew is already installed");
    return true;
  }

  const spinner = p.spinner();
  spinner.start("Installing Homebrew...");

  try {
    await $`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`;
    spinner.stop("Homebrew installed successfully");
    return true;
  } catch (error) {
    spinner.stop("Failed to install Homebrew");
    p.log.error(String(error));
    return false;
  }
}

async function installBrewfile(option: BrewfileOption): Promise<boolean> {
  const spinner = p.spinner();
  spinner.start(`Installing ${option.label}...`);

  try {
    const brewfilePath = resolve(REPO_ROOT, option.path);
    await $`brew bundle --file=${brewfilePath} --verbose`;
    spinner.stop(`${option.label} installed successfully`);
    return true;
  } catch (error) {
    spinner.stop(`Failed to install ${option.label}`);
    if (error && typeof error === "object" && "stderr" in error) {
      const stderr = error.stderr;
      if (stderr instanceof Buffer) {
        p.log.error(stderr.toString());
      } else {
        p.log.error(String(stderr));
      }
    } else {
      p.log.error(String(error));
    }
    return false;
  }
}

async function setupGitHubCLI(): Promise<boolean> {
  const hasGh = await checkCommand("gh");
  if (!hasGh) {
    p.log.warn("GitHub CLI not found. Please install core CLI tools first.");
    return false;
  }

  // Check if already authenticated
  try {
    await $`gh auth status`.quiet();
    p.log.success("Already authenticated with GitHub");
    return true;
  } catch {
    // Not authenticated, proceed with login
  }

  p.log.info("Opening GitHub authentication...");
  try {
    await $`gh auth login`;
    return true;
  } catch (error) {
    p.log.error(`GitHub authentication failed: ${error}`);
    return false;
  }
}

async function setupGopass(): Promise<boolean> {
  const hasGopass = await checkCommand("gopass");
  if (!hasGopass) {
    p.log.warn("gopass not found. Please install core CLI tools first.");
    return false;
  }

  const shouldSetup = await p.confirm({
    message: "Do you want to clone the secrets repository?",
    initialValue: true,
  });

  if (p.isCancel(shouldSetup) || !shouldSetup) {
    p.log.info("Skipping secrets setup");
    return true;
  }

  const spinner = p.spinner();
  spinner.start("Cloning secrets repository...");

  try {
    await $`gopass clone git@github.com:dhruvbaldawa/secrets.git`.quiet();
    spinner.stop("Secrets repository cloned");
  } catch (error) {
    spinner.stop("Failed to clone secrets repository");
    p.log.error(String(error));
    return false;
  }

  p.log.warn("GPG key setup required:");
  p.log.info("1. Export your GPG key from another machine");
  p.log.info("2. Run: gpg --import < keyfile");
  p.log.info("3. Then run: gopass sync");

  await p.text({
    message: "Press Enter once GPG key is imported...",
    placeholder: "",
  });

  try {
    await $`gopass sync`;
    p.log.success("gopass synced successfully");
    return true;
  } catch (error) {
    p.log.error(`gopass sync failed: ${error}`);
    return false;
  }
}

async function setupChezmoi(): Promise<boolean> {
  const hasChezmoi = await checkCommand("chezmoi");
  if (!hasChezmoi) {
    p.log.warn("chezmoi not found. Please install core CLI tools first.");
    return false;
  }

  const spinner = p.spinner();
  spinner.start("Initializing chezmoi...");

  try {
    await $`chezmoi init --ssh dhruvbaldawa/dotfiles`.quiet();
    spinner.stop("chezmoi initialized");
  } catch (error) {
    spinner.stop("Failed to initialize chezmoi");
    p.log.error(String(error));
    return false;
  }

  const shouldApply = await p.confirm({
    message: "Apply chezmoi configuration now?",
    initialValue: true,
  });

  if (p.isCancel(shouldApply) || !shouldApply) {
    p.log.info("Run 'chezmoi apply' when ready");
    return true;
  }

  spinner.start("Applying chezmoi configuration...");
  try {
    await $`chezmoi apply`;
    spinner.stop("chezmoi configuration applied");
    return true;
  } catch (error) {
    spinner.stop("Failed to apply chezmoi configuration");
    p.log.error(String(error));
    return false;
  }
}

async function main() {
  console.clear();

  p.intro("🚀 Dotfiles Bootstrap");

  // Step 1: Select what to install
  const brewfileSelection = await p.multiselect({
    message: "Select packages to install:",
    options: BREWFILE_OPTIONS.map((opt) => ({
      value: opt.value,
      label: opt.label,
      hint: opt.hint,
    })),
    initialValues: ["core", "casks"],
    required: false,
  });

  if (p.isCancel(brewfileSelection)) {
    p.cancel("Bootstrap cancelled");
    process.exit(0);
  }

  // Step 2: Select additional setup steps
  const setupSteps = await p.multiselect({
    message: "Select additional setup steps:",
    options: [
      { value: "github", label: "GitHub CLI authentication", hint: "gh auth login" },
      { value: "secrets", label: "Secrets (gopass)", hint: "Clone and sync secrets repo" },
      { value: "chezmoi", label: "Apply dotfiles", hint: "Initialize and apply chezmoi" },
    ],
    initialValues: ["github", "chezmoi"],
    required: false,
  });

  if (p.isCancel(setupSteps)) {
    p.cancel("Bootstrap cancelled");
    process.exit(0);
  }

  // Confirm selections
  const selectedBrewfiles = BREWFILE_OPTIONS.filter((opt) =>
    (brewfileSelection as string[]).includes(opt.value)
  );
  const selectedSteps = setupSteps as string[];

  p.log.info("Selected packages:");
  selectedBrewfiles.forEach((opt) => p.log.message(`  • ${opt.label}`));

  p.log.info("Selected setup steps:");
  selectedSteps.forEach((step) => p.log.message(`  • ${step}`));

  const confirmed = await p.confirm({
    message: "Proceed with installation?",
    initialValue: true,
  });

  if (p.isCancel(confirmed) || !confirmed) {
    p.cancel("Bootstrap cancelled");
    process.exit(0);
  }

  // Execute installation
  p.log.step("Starting installation...");

  // Install Homebrew first if any packages selected
  if (selectedBrewfiles.length > 0) {
    const homebrewOk = await installHomebrew();
    if (!homebrewOk) {
      p.log.error("Cannot proceed without Homebrew");
      process.exit(1);
    }

    // Install selected Brewfiles
    for (const brewfile of selectedBrewfiles) {
      await installBrewfile(brewfile);
    }
  }

  // Run selected setup steps
  if (selectedSteps.includes("github")) {
    await setupGitHubCLI();
  }

  if (selectedSteps.includes("secrets")) {
    await setupGopass();
  }

  if (selectedSteps.includes("chezmoi")) {
    await setupChezmoi();
  }

  p.outro("✨ Bootstrap complete!");
}

main().catch((error) => {
  p.log.error(`Bootstrap failed: ${error}`);
  process.exit(1);
});
