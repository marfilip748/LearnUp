# Architecture (public sketch)

High-level only — enough for technical interview conversation, not a rebuild guide.

```mermaid
flowchart LR
  subgraph Clients
    W[Web browser]
    D[Desktop window]
  end
  subgraph AppRuntime["App runtime (Flet)"]
    UI[UI tree / screens]
    ST[Session state]
    SVC[Feature services]
  end
  subgraph Data
    DB[(SQLite)]
    AS[Art assets]
  end
  W --> UI
  D --> UI
  UI --> ST
  ST --> SVC
  SVC --> DB
  UI --> AS
```

## Domains (names only)

| Domain | Responsibility |
| --- | --- |
| Learn | Quiz / boss / readiness / catalogs |
| Economy | Currency, shop rotation, LiveOps windows |
| Social | Invites, duels, weekly tournament |
| Companion | Seba presentation + tips (+ optional LLM) |
| Shell | Nav, theme, onboarding, share/web host |

No schemas, endpoints, or algorithms are published here.
