# 🧪 Tests UI automatisés — ParaBank

Tests UI automatisés avec **Selenium** et **Behave (BDD)** sur le site de démo
[ParaBank](https://parabank.parasoft.com/parabank/index.htm).

---

## 📋 Features testées

| Feature | Scénarios | Statut |
|---|---|---|
| 🔐 Login | 3 | ✅ |
| 💸 Transfer Funds | 5 | ✅ |
| 🔍 Find Transactions | 4 | ✅ |
| 💰 Request Loan | 12 | ✅ |
| 🏦 Création Compte | 4 | ✅ |
| 💳 Bill Pay | - | ✅ |
| **Total** | **28+** | **✅** |

---

## 📁 Structure du projet
```
Test_PB/
├── .github/
│   └── workflows/
│       └── tests.yml              ← CI/CD GitHub Actions
├── features/
│   ├── login.feature              ← Scénarios login
│   ├── transfer.feature           ← Scénarios transfert
│   ├── find_transactions.feature  ← Scénarios recherche transactions
│   ├── request_loan.feature       ← Scénarios demande de prêt
│   ├── creation_compte.feature    ← Scénarios création compte
│   ├── bill_pay.feature           ← Scénarios paiement factures
│   └── steps/
│       ├── login_steps.py
│       ├── transfer_steps.py
│       ├── find_transactions_steps.py
│       ├── request_loan_steps.py
│       ├── creation_compte_steps.py
│       └── bill_pay_steps.py
├── screenshots/                   ← Screenshots en cas d'échec
├── environment.py                 ← Configuration driver Edge/Chrome
├── fusionner.py                   ← Fusion des rapports JSON
├── generer_rapport.py             ← Génération rapport HTML
├── rapport.json                   ← Rapport JSON fusionné (généré)
├── rapport.html                   ← Rapport HTML final (généré)
├── transaction_id.txt             ← ID transaction CAS 14 (généré)
├── .gitattributes
└── README.md
```

---

## 🛠️ Technologies

| Outil | Version | Rôle |
|---|---|---|
| Python | 3.14 | Langage |
| Behave | 1.3.3 | Framework BDD |
| Selenium | 4.40.0 | Automatisation navigateur |
| Edge | - | Navigateur local |
| Chrome | - | Navigateur CI/CD |
| GitHub Actions | - | CI/CD |

---

## ⚙️ Installation
```bash
# 1. Cloner le repo
git clone https://github.com/yassminekh/Test_PB.git
cd Test_PB

# 2. Installer les dépendances
pip install behave selenium webdriver-manager
```

---

## 🌐 URLs

| Environnement | URL |
|---|---|
| Local | http://localhost:8080/parabank |
| CI/CD | https://parabank.parasoft.com/parabank |

---

## 👤 Compte de test

| Champ | Valeur |
|---|---|
| Username | john |
| Password | demo |

---

## ▶️ Lancer les tests en local
```bash
# Tous les tests
py -m behave --no-capture -v

# Feature spécifique
py -m behave features/login.feature --no-capture -v
py -m behave features/transfer.feature --no-capture -v
py -m behave features/find_transactions.feature --no-capture -v
py -m behave features/request_loan.feature --no-capture -v
py -m behave features/creation_compte.feature --no-capture -v
py -m behave features/bill_pay.feature --no-capture -v
```

---

## 📊 Générer le rapport HTML
```bash
# 1. CAS 14 en premier (génère transaction_id.txt)
py -m behave features/transfer.feature --no-capture --name "CAS 14 - Vérifier les détails d'une transaction après transfert"

# 2. Lance tous les tests
py -m behave features/login.feature --format json --outfile rapport_login.json --no-capture
py -m behave features/transfer.feature --format json --outfile rapport_transfer.json --no-capture
py -m behave features/find_transactions.feature --format json --outfile rapport_find.json --no-capture
py -m behave features/request_loan.feature --format json --outfile rapport_loan.json --no-capture
py -m behave features/creation_compte.feature --format json --outfile rapport_creation_compte.json --no-capture
py -m behave features/bill_pay.feature --format json --outfile rapport_bill_pay.json --no-capture

# 3. Fusionne les JSON
py fusionner.py

# 4. Génère le HTML
py generer_rapport.py

# 5. Ouvre le rapport
start rapport.html
```

---

## 🔄 CI/CD GitHub Actions

Le workflow se déclenche automatiquement à chaque **push** ou **pull request** sur `main`.
```
Push sur GitHub
      ↓
┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│  Login   │  │ Transfer │  │   Loan   │  │ Bill Pay │  ← parallèle
└──────────┘  └────┬─────┘  └──────────┘  └──────────┘
                   ↓ transaction_id.txt
        ┌──────────────┐  ┌──────────────────┐
        │Find Trans.   │  │ Création Compte   │  ← parallèle
        └──────────────┘  └──────────────────┘
                    ↓ if: always()
             ┌─────────────┐
             │Rapport Final│  ← toujours généré
             └─────────────┘
```

### Télécharger le rapport depuis GitHub Actions
```
GitHub → Actions → dernier run → Artifacts → rapport-html-final
```

### Voir le rapport en ligne
```
https://yassminekh.github.io/Test_PB/
```

---

## 🖥️ Navigateurs supportés

| Environnement | Navigateur | Mode |
|---|---|---|
| Local (Windows) | Microsoft Edge | Visible |
| CI/CD (Ubuntu) | Google Chrome | Headless |

---

## 📸 Screenshots

Les screenshots sont **automatiquement sauvegardés** dans `screenshots/`
uniquement en cas d'échec d'un test.

---

## 🐛 Bugs connus

| Feature | Scénario | Statut |
|---|---|---|
| Transfer Funds | Montant négatif accepté | ❌ BUG |

> ParaBank accepte les montants négatifs lors d'un transfert.
> Un message d'erreur devrait s'afficher — tag `@known_bug`.

---

## 📦 Dépendances
```
behave==1.3.3
selenium==4.40.0
webdriver-manager
```
```bash
pip install behave selenium webdriver-manager
```