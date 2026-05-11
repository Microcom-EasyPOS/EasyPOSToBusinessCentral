# Business Central URL-opbygning

## Oversigt

Servicen kommunikerer med Microsoft Dynamics 365 Business Central via REST/OData API'er. URL'en til Business Central bygges op af flere dele, som alle konfigureres i `Settings.INI` under sektionen `[BUSINESS CENTRAL]`.

---

## Base URL – opbygning

Den fulde base URL, som alle kald bygges oven på, ser sådan ud:

```
{BC_BASEURL}{BC_COMPANY_URL}/{BC_ENVIRONMENT}
```

| INI-nøgle | Beskrivelse | Eksempel |
|---|---|---|
| `BC_BASEURL` | Microsofts API-endpoint inkl. API-version | `https://api.businesscentral.dynamics.com/v2.0/` |
| `BC_PORT` | Portnummer (0 = udelades) | `0` |
| `BC_COMPANY_URL` | Tenant ID (GUID) | `9b19d0dd-0a6e-4596-82c8-7b58c535d85f` |
| `BC_ENVIRONMENT` | BC-miljøets navn | `Production_DK` |

**Eksempel på samlet base URL:**

```
https://api.businesscentral.dynamics.com/v2.0/9b19d0dd-0a6e-4596-82c8-7b58c535d85f/Production_DK
```

> **Bemærk:** Editoren sørger automatisk for at `BC_BASEURL` ender på `/v2.0/`. Hvis man kun angiver `https://api.businesscentral.dynamics.com`, tilføjes `/v2.0/` automatisk.

---

## Authentication (OAuth2)

Alle cloud-forbindelser bruger OAuth2 Client Credentials flow:

| INI-nøgle | Beskrivelse |
|---|---|
| `BC_USERNAME` | OAuth2 Client ID |
| `BC_PASSWORD` | OAuth2 Client Secret |

Token hentes fra:

```
https://login.microsoftonline.com/{BC_COMPANY_URL}/oauth2/v2.0/token
```

Med scope: `https://api.businesscentral.dynamics.com/.default`

---

## Verifikation af forbindelse – Companies endpoint

For at kontrollere at base URL og authentication er korrekt, kan man kalde **Companies API**:

```
{BaseURL}/api/v2.0/companies
```

**Fuld eksempel-URL:**

```
https://api.businesscentral.dynamics.com/v2.0/9b19d0dd-0a6e-4596-82c8-7b58c535d85f/Production_DK/api/v2.0/companies
```

Et succesfuldt svar (HTTP 200) returnerer en liste af firmaer med `name` og `id`:

```json
{
  "value": [
    { "id": "aabbccdd-1234-5678-abcd-ef0123456789", "name": "Mit Firma" },
    { "id": "11223344-aaaa-bbbb-cccc-ddeeff001122", "name": "Testfirma" }
  ]
}
```

> **Tip:** Editoren (`EP_To_BC_Editor`) gør præcis dette som første test. Hvis Companies-kaldet fejler, er der typisk noget galt med base URL, Tenant ID, Environment, eller credentials.

---

## OData sync-endpoints

Når base URL og firma er verificeret, bruges OData-endpointet til selve datasynkroniseringen. Her tilføjes `Company`-segmentet:

```
{BaseURL}/ODataV4/Company('{BC_ACTIVECOMPANYID}')/{endpoint}
```

| INI-nøgle | Beskrivelse | Eksempel |
|---|---|---|
| `BC_ACTIVECOMPANYID` | Firmanavnet i BC | `Mit Firma` |

**Fuld eksempel-URL:**

```
https://api.businesscentral.dynamics.com/v2.0/9b19d0dd-0a6e-4596-82c8-7b58c535d85f/Production_DK/ODataV4/Company('Mit Firma')/nfItem
```

### Tilgængelige endpoints

Endpoint-navnene har et kundespecifikt prefix (f.eks. `km` eller `nf`) som er defineret af den custom API extension der er installeret i BC. Her er de endpoints der testes:

| Sync-modul | Endpoint | Beskrivelse |
|---|---|---|
| Kassekladde (Financial Records) | `{prefix}Cashstatements` | Finansposteringer fra EasyPOS → BC |
| Varer (Items) | `{prefix}Item` | Varedata fra EasyPOS → BC |
| Varevarianter | `{prefix}VariantId` | Variantoplysninger |
| Salg (Sales) | `{prefix}ItemSale` | Salgstransaktioner fra EasyPOS → BC |
| Flytninger (Movements) | `{prefix}ItemMove` | Flytnings-/reguleringsposteringer |
| Lager (Stock) | `{prefix}ItemStock` | Lagerbeholdning |
| Vareadgang | `{prefix}ItemAccess` | Vareadgangs-information |
| Kostpriser (Cost Prices) | `costPrice` | Kostpriser fra BC → EasyPOS |
| Leverandører (Vendors) | `{prefix}Vendor` | Leverandøroplysninger |

> **Bemærk:** `costPrice`-endpointet har *ikke* prefix – det er ens uanset kunde.

---

## Verifikation af endpoints

Editoren tester hvert endpoint med et simpelt GET-kald og måler svartiden. Et kald til f.eks. Items ser sådan ud:

```
GET https://api.businesscentral.dynamics.com/v2.0/{tenant}/{environment}/ODataV4/Company('{firma}')/{prefix}Item
```

**Forventet resultat:** HTTP 200 med en JSON-respons indeholdende `value`-array (kan være tomt).

### Test-rækkefølge i editoren

Editoren (`EP_To_BC_Editor`) udfører følgende tests i rækkefølge:

| # | Test | Hvad den bekræfter |
|---|---|---|
| 1 | Companies API | Base URL, Tenant, Environment, OAuth2 credentials |
| 2 | Cashstatements | Custom API extension + OData-adgang |
| 3 | Item | Vare-endpoint |
| 4 | VariantId | Variant-endpoint |
| 5 | ItemSale | Salgs-endpoint |
| 6 | ItemMove | Flytnings-endpoint |
| 7 | ItemStock | Lager-endpoint |
| 8 | ItemAccess | Vareadgangs-endpoint |
| 9 | costPrice | Kostpris-endpoint |
| 10 | Vendor | Leverandør-endpoint |

Hvert resultat vises som:

```
  Item: OK (200) (145 ms)
  costPrice: OK (200) (98 ms)
```

Hvis et endpoint fejler med f.eks. HTTP 404, mangler den tilhørende API extension sandsynligvis i BC-installationen.

---

## OData query-parametre

Sync-modulerne bruger standard OData query-parametre:

| Parameter | Beskrivelse | Eksempel |
|---|---|---|
| `$filter` | Filtrering af data | `$filter=status eq 'Open'` |
| `$orderby` | Sortering | `$orderby=entryNo asc` |
| `$select` | Feltselektion | `$select=itemNo,description` |

**Eksempel med filter:**

```
GET .../ODataV4/Company('Mit Firma')/nfCashstatements?$filter=status eq 'Open'
```

Ved **PUT/PATCH** (opdatering) tilføjes systemId til URL'en:

```
PATCH .../ODataV4/Company('Mit Firma')/nfItem(aabbccdd-1234-5678-abcd-ef0123456789)
```

---

## Samlet URL-diagram

```
Base URL (fra INI)
├── BC_BASEURL ─────────── https://api.businesscentral.dynamics.com/v2.0/
├── BC_COMPANY_URL ─────── 9b19d0dd-0a6e-4596-82c8-7b58c535d85f
├── BC_ENVIRONMENT ─────── Production_DK
│
├── Standard API ──────── /api/v2.0/companies          ← Verifikation
│
└── OData Sync ────────── /ODataV4/Company('{firma}')
                            ├── /{prefix}Cashstatements  ← Kassekladde
                            ├── /{prefix}Item            ← Varer
                            ├── /{prefix}VariantId       ← Varianter
                            ├── /{prefix}ItemSale        ← Salg
                            ├── /{prefix}ItemMove        ← Flytninger
                            ├── /{prefix}ItemStock       ← Lager
                            ├── /{prefix}ItemAccess      ← Vareadgang
                            ├── /costPrice               ← Kostpriser
                            └── /{prefix}Vendor          ← Leverandører
```
