To secure a subset of your Gopass vault with separate access controls, use **sub-stores/mounts** with isolated recipients. Here's how to implement it:

---
Generate a GPG key
```bash
gpg --full-generate-key
Please select what kind of key you want:
   (1) RSA and RSA
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (9) ECC (sign and encrypt) *default*
  (10) ECC (sign only)
  (14) Existing key from card
Your selection? 2
DSA keys may be between 1024 and 3072 bits long.
What keysize do you want? (2048) 3072
Requested keysize is 3072 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 10y
```

### 1. **Create a New Restricted Store**
Initialize a separate store with its own recipients:
```bash
# Create and mount new store
gopass init --store restricted --path ~/.password-store-restricted

# Verify mount
gopass mounts
```
Output:
```
gopass (/home/user/.password-store)
└── restricted (/home/user/.password-store-restricted)
```

---

### 2. **Manage Store-Specific Recipients**
Add/remove recipients **only** for the restricted store:
```bash
# Add recipient (e.g., teammate@company.com)
gopass recipients add --store restricted 0xTEAMMATE_GPG_KEY

# Remove recipient
gopass recipients remove --store restricted 0xFORMER_TEAMMATE_KEY
```

---

### 3. **Store Secrets in Restricted Area**
Use the store prefix to isolate secrets:
```bash
# Add secret to restricted store
gopass insert restricted/aws/prod/credentials
```

---

### 4. **Access Control Verification**
Check permissions:
```bash
# List recipients for restricted store
gopass recipients --store restricted

# Attempt access without permissions (will fail)
gopass show restricted/aws/prod/credentials
```

---

### 5. **Sync Separately (Optional)**
Configure independent Git remotes:
```bash
gopass git remote add --store restricted origin git@github.com:yourorg/restricted-store.git
gopass sync --store restricted
```

---

### Key Implementation Details
| Feature | Main Store | Restricted Store |
|---------|------------|------------------|
| **Recipients** | Default team | Explicitly added users |
| **Storage** | `~/.password-store` | `~/.password-store-restricted` |
| **CLI Access** | `gopass show secret` | `gopass show restricted/secret` |
| **Git Sync** | Separate repository | Isolated history |

---

### Advanced: Move Existing Secrets
Transfer secrets from main to restricted store:
```bash
gopass mv main-store/secret restricted/secret
```

This architecture ensures sensitive credentials in the restricted store are **only decryptable by explicitly authorized recipients**, while maintaining a shared store for general secrets.

Citations:
[1] https://github.com/gopasspw/gopass/blob/master/docs/features.md
[2] https://github.com/gopasspw/gopass/issues/1564
[3] https://www.codecentric.de/en/knowledge-hub/blog/manage-team-passwords-gopass
[4] https://dev.to/camptocamp-ops/simple-secret-sharing-with-gopass-and-summon-40jk
[5] https://woile.github.io/gopass-cheat-sheet/
[6] https://gopass.org/faq
[7] https://hceris.com/storing-passwords-with-gopass/
[8] https://felixhammerl.com/2024/04/24/gopass-for-secrets.html
[9] https://ajtech.nl/how-to-use-gopass-on-multiple-linux-machines/
[10] https://www.varac.net/docs/security/passwords/gopass.html
[11] https://www.thoughtworks.com/en-es/radar/tools/gopass
[12] https://news.ycombinator.com/item?id=13551692
[13] https://www.justwatch.com/blog/post/announcing-gopass/
[14] https://woile.dev/posts/sharing-team-secrets/
[15] https://discussions.apple.com/thread/8335752
[16] https://jcompetence.se/2021/01/04/adding-a-new-store-to-gopass-in-windows/
[17] https://medium.selbstge.cloud/my-go-to-pragmatic-security-tools-8c9a6094c07d
[18] https://daryl.wakatara.com/password-management-with-gopass-password-store-gopass-bridge-and-pass-for-ios/
[19] https://github.com/frntn/vault-token-helper-gopass
[20] https://community.jamf.com/t5/jamf-pro/filevault-2-with-userdata-users-on-a-separate-parttiion/m-p/74119

---
Answer from Perplexity: pplx.ai/share
