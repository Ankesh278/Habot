# Architecture

HabotConnect hiring app — LSA Profile Verification.

The application centralizes visual and textual concerns so feature screens remain focused on composition and business workflow.

## Layers

```text
Presentation
 ↓
GetX Controller
 ↓
Repository
 ↓
API Service
 ↓
API Client
```

```text
Shared Design System
├── Theme
├── Colors
├── Typography
├── Dimensions
├── Strings
└── Reusable Widgets
          ↓
Feature Byts
          ↓
Screen
```

## Design system

| File | Responsibility |
| --- | --- |
| `AppTheme` | Material 3 light/dark `ThemeData` |
| `AppColors` | Semantic color tokens |
| `AppTextStyles` | Typography derived from `TextTheme` |
| `AppButtonStyles` / `AppInputStyles` / `AppCardStyles` | Component themes |
| `AppStrings` | All user-facing copy |
| `AppDimensions` | Spacing, radius, layout widths |
| `AppDurations` | Friction threshold, snackbar, API timeout |

Shared widgets (`AppButton`, `AppOutlinedButton`, `AppTextField`, `AppCard`, `AppSection`, `AppStatusBadge`, `AppScaffold`, `ResponsiveLayout`) consume the theme. Feature Byts compose them. The screen does not hardcode decoration.

## Security types

- `LineageValidator` — `predecessor_id` present
- `ComplianceGate` — all required fields valid, no defaults
- `MetadataGenerator` / `RequestMetadata` — UUID `trace_id`, SHA-256 `logic_hash`, outbound headers
- `QuarantineService` — in-memory record + `debugPrint`
- `FrictionTracker` — `AppDurations.frictionThreshold`

## Submission pipeline

```text
Submit pressed
      ↓
Collect form values → LsaProfileModel
      ↓
Generate trace_id
      ↓
Validate predecessor_id     → fail → quarantine → STOP
      ↓
Compliance gate             → fail → quarantine → STOP
      ↓
Generate logic_hash
      ↓
Create VerificationRequest (RequestMetadata)
      ↓
Headers: Content-Type, trace_id, logic_hash
      ↓
POST /api/v1/lsa/profile/verify
      ↓
Validate response body      → invalid/null → quarantine → STOP
      ↓
Submitted
```

## Request shape

```json
{
  "full_name": "Jordan Hale",
  "email": "jordan.hale@habotconnect.test",
  "phone": "+1 415 555 0198",
  "verification_id": "VER-88421",
  "predecessor_id": "LSA-ROOT-001",
  "metadata": {
    "trace_id": "<uuid-v4>",
    "logic_hash": "<sha-256 of canonical logic>"
  }
}
```

## Canonical logic (hashed)

```text
lsa_profile_verification:v1:
full_name|required|
email|required|email|
phone|required|
verification_id|required|
predecessor_id|required|
fail_closed:true
```

## Mock API scenarios

| Scenario | Result |
| --- | --- |
| `success` | 200 + `success: true` + `verification_id` |
| `invalidResponse` | 200 + `verification_id: null` (fail-closed) |
| `serverError` | 500 DioException → FAILED, data not accepted |

Production swap: remove the interceptor and point `ApiConstants.baseUrl` at a real host. Controller and widgets stay unchanged.

## Byt boundary

Widgets under `features/lsa_verification/widgets/` do not import repositories, Dio, or security types. They take strings, controllers, and callbacks.

## What we deliberately omitted

BLoC, Riverpod, GetIt, repository interfaces, use cases, and unused widgets such as dropdowns. They would not make the three demo cases clearer.
