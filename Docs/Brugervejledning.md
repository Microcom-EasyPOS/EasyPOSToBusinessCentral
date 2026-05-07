# Brugervejledning - EasyPOS To Business Central

## Hvad er dette?

En Windows Service der automatisk overforer data mellem EasyPOS kasseapparatsystemet og Microsoft Business Central. Servicen koerer i baggrunden og synkroniserer varer, salg, flytninger, finansposter og kostpriser.

---

## Installation

### Forudsaetninger

- Windows Server 2016+ eller Windows 10+
- Adgang til EasyPOS Firebird database
- Business Central API credentials (OAuth2 eller Basic Auth)
- SMTP server til email-notifikationer (valgfrit men anbefalet)

### Installer servicen

```cmd
EasyPOS_To_BusinessCentral.exe /install
```

### Start servicen

```cmd
net start "EasyPOS To Business Central"
```

Eller via Windows Services (services.msc).

### Stop og afinstaller

```cmd
net stop "EasyPOS To Business Central"
EasyPOS_To_BusinessCentral.exe /uninstall
```

---

## Konfiguration

Al konfiguration sker via filen `Settings.INI` i samme mappe som EXE-filen. Brug den medfølgende **EP_To_BC_Editor.exe** til nemt at redigere indstillingerne.

### Timer - Hvornaar koerer synkroniseringen?

Der er tre modes:

| Mode | RUNTIME | RUN AT EACH MINUTE | Beskrivelse |
|------|---------|-------------------|-------------|
| Fast tidspunkt | `22` | `0` | Koerer en gang dagligt kl. 22:00 |
| Tidsinterval | `2205` | `0` | Koerer mellem kl. 22:00 og 05:00 |
| Fast interval | `60` | `1` | Koerer hvert 60. minut hele dagen |

### Hvad synkroniseres?

I sektionen `[SYNCRONIZE]` styres hvilke moduler der er aktive:

| Setting | Retning | Beskrivelse |
|---------|---------|-------------|
| `Items=1` | EasyPOS -> BC | Varer og varianter |
| `SalesTransactions=1` | EasyPOS -> BC | Salgslinjer fra kasser |
| `MovementsTransactions=1` | EasyPOS -> BC | Lagerflytninger |
| `FinancialRecords=1` | EasyPOS -> BC | Kassekladde/Z-rapporter |
| `Costprice from BC=1` | BC -> EasyPOS | Kostpriser |
| `StockRegulationsTransactions=0` | - | **SKAL vaere 0!** |

> **ADVARSEL:** `StockRegulationsTransactions` SKAL altid staa paa `0`. Aktivering kan give uforudsigelige resultater.

### Business Central forbindelse

I sektionen `[BUSINESS CENTRAL]`:

| Setting | Beskrivelse |
|---------|-------------|
| `BC_BASEURL` | Business Central API URL |
| `BC_ENVIRONMENT` | Environment (fx "Production") |
| `BC_USERNAME` | Client ID (OAuth2) eller brugernavn (Basic Auth) |
| `BC_PASSWORD` | Client Secret / Password |
| `BC_ACTIVECOMPANYID` | Virksomheds-GUID i BC |
| `Online Business Central` | Kundetype: "KAUFMANN" (on-prem) eller "NYFORM" (cloud) |

### Email-notifikationer

Sektionen `[MAIL]` konfigurerer fejlnotifikationer. Naar en synkronisering fejler, sendes automatisk email til den angivne modtager.

---

## Daglig drift

### Servicen koerer selv

Naar servicen er installeret og konfigureret, koerer den automatisk. Der er normalt ikke behov for daglig interaktion.

### Tjek om servicen koerer

1. Aaben `services.msc`
2. Find "EasyPOS To Business Central"
3. Status skal vaere "Running"

### Logfiler

Logfiler placeres i mappen angivet under `LOGFILEFOLDER` i Settings.INI:

```
C:\Logs\EasyPOS_BC\
  Log20260507.txt                   <- Daglig hovedlog
  BC_Log\BusinessCentral*.txt       <- BC API kommunikation
  FinansEksport\EkspFinancial*.txt  <- Finanseksport detaljer
```

Brug **EP_To_BC_Editor.exe** til at gennemse logfiler direkte (fanerne "Programlog", "Business Central Log", "Finanseksportlog").

### Windows Event Log

Kritiske fejl logges ogsaa til Windows Event Viewer:
- Aaben Event Viewer
- Gaa til Application and Services Logs
- Find "EasyPOS To Business Central"

---

## Fejlfinding

### Servicen starter ikke

1. Tjek at `Settings.INI` ligger i samme mappe som EXE
2. Tjek at database-stien er korrekt i INI-filen
3. Tjek Windows Event Log for fejlbeskeder
4. Proev at koere i Debug-mode for at se fejl direkte

### Ingen data synkroniseres

1. Tjek at det relevante modul er aktiveret i `[SYNCRONIZE]`
2. Tjek `Last run` vaerdien i INI-filen - opdateres den?
3. Gennemgaa logfilen for fejl
4. Tjek at BC credentials er korrekte

### HTTP 503 fejl

Naar Business Central returnerer 503 (Service Unavailable), pauser servicen automatisk API-kald i en periode. Dette er normalt under BC-vedligehold. Servicen genoptager automatisk naar BC er tilgaengelig igen.

### Email-notifikationer virker ikke

1. Tjek SMTP-indstillinger i `[MAIL]` sektionen
2. Verificer at `UseTSL` er sat korrekt (1 for TLS, 0 for ingen)
3. Tjek at port er korrekt (typisk 587 for TLS, 25 for uden)

---

## INI-Editor (EP_To_BC_Editor.exe)

Et separat vaerktoej til at redigere Settings.INI med grafisk interface:

- **Program-fanen:** Database, timer, logmappe
- **Business Central:** API forbindelse
- **Mail:** SMTP indstillinger
- **Syncronize:** Aktiver/deaktiver moduler
- **Items/Financial/Sales/etc.:** Per-modul indstillinger
- **Log-faner:** Gennemse logfiler direkte

Editoren gemmer automatisk ved lukning og tager backup af den eksisterende INI-fil foerst.

---

## Support

Ved problemer:
1. Tjek logfiler for fejlbeskeder
2. Gennemgaa Windows Event Log
3. Kontakt IT-support med logfil vedlagt
