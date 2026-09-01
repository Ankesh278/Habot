# HabotConnect — LSA Profile Verification

Hiring project for **Digivir — Flutter Mobile App Developer**.

This Flutter app simulates an **LSA Profile Verification** screen. It is intentionally small: one feature, one security pipeline, and three evaluator scenarios that all run through the same code path.

The goal is to show production judgment:

- A centralized design system (theme, colors, typography, strings, dimensions)
- Stateless UI with GetX for logic and lifecycle
- Shared widgets composed by feature-specific **Byt** components
- Data lineage (`predecessor_id`) as a hard security gate
- Fail-closed execution (quarantine and stop; never send partial data)
- Per-attempt UUID `trace_id` and deterministic SHA-256 `logic_hash`
- UI friction tracking after a 5 second stall (`AppDurations.frictionThreshold`)

---

## Architecture

```text
Presentation (Stateless screen + Byts)
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
```

The application centralizes visual and textual concerns so feature screens remain focused on composition and business workflow.

Security sits beside this stack, not inside widgets:

```text
Input → Validation → Lineage → Compliance Gate → Metadata → API → Response validation
```

---

## Design System

Styling is theme-first. Widgets do not invent padding, borders, or colors.

| Concern | Source |
| --- | --- |
| User-facing copy | `AppStrings` |
| Spacing, radius, widths | `AppDimensions` |
| Timeouts, friction window | `AppDurations` |
| Semantic colors | `AppColors` / `ColorScheme` |
| Material 3 light + dark | `AppTheme` |
| Buttons, fields, cards | `AppButton`, `AppTextField`, `AppCard`, … |

Feature Byts compose those shared widgets. They never call APIs or make security decisions.

---

## GetX

`LsaVerificationBinding` registers Dio, `ApiClient`, the API service, repository, `QuarantineService`, and `LsaVerificationController`.

The controller owns:

- `TextEditingController`s and `formKey` (disposed in `onClose`)
- Reactive status used by the UI (`status`, `isSubmitting`, audit fields)
- The submission pipeline and demo entry points
- `FrictionTracker` lifecycle

Widgets call `Get.find<LsaVerificationController>()` and pass callbacks. They do not look up repositories.

---

## Byt Standard

A Byt is a feature-specific atomic widget: one responsibility, constructor data/callbacks only.

```text
LsaProfileVerificationScreen
 ├── ProfileHeaderByt
 ├── VerificationFieldByt   → AppTextField
 ├── VerificationStatusByt  → AppStatusBadge
 └── DemoControlsByt
```

Shared components (`AppButton`, `AppTextField`) are generic. Byts apply them to LSA verification.

---

## Security

| Control | Behavior |
| --- | --- |
| `predecessor_id` | Required lineage. Missing → quarantine, **no API** |
| `trace_id` | New UUID v4 on every submit attempt |
| `logic_hash` | SHA-256 of canonical logic; generated only after gates pass |
| Compliance gate | All required fields valid; no defaults |
| Quarantine | In-memory record + structured log; data movement stops |
| Fail-closed | Invalid/null mandatory input or response → stop |
| Response validation | HTTP 200 is not enough; `success` and `verification_id` required |

Demo Test Controls call `runValidSubmission()`, `runMissingLineage()`, and `runFailClosed()`, which fill the form and then call the same `submitVerification()` pipeline.

---

## Friction

`FrictionTracker` uses `AppDurations.frictionThreshold` (5 seconds). Field focus, tap, or typing starts/resets the window. One stall → one event. The next event requires a new interaction. The UI stays a `StatelessWidget`.

---

## Test Cases

| Test Case | What it does | Expected result |
| --- | --- | --- |
| Valid Submission | Fills all fields, mock API returns a valid body | **SUBMITTED**, API sent |
| Missing Lineage | Clears `predecessor_id`, same pipeline | **QUARANTINED**, API **not** sent |
| Fail-Closed Error | Valid fields, mock `verification_id: null` | **QUARANTINED**, execution stopped |

---

## Testing

```bash
flutter pub get
flutter run
flutter test
flutter analyze
```

There is no live backend. Dio builds the request; a local interceptor returns the selected mock scenario.

---

## Architecture Decisions

**Why GetX?**  
One focused screen does not need BLoC. GetX gives DI, controller lifecycle for the friction timer, reactive status, and snackbars.

**Why a design system instead of one giant widget?**  
Shared widgets encode *how* controls look. Byts encode *what* this feature needs. The screen only composes.

**Why StatelessWidget?**  
Form buffers, timers, and submission state live on the controller. Rebuilds come from `Obx`.

**Why not more layers?**  
Extra interfaces would hide the security story. This stays a small app using enterprise principles.

---

## Project Layout

```text
lib/
  core/       constants, theme, extensions, validators, security
  shared/     reusable widgets and layouts
  data/       models, Dio client, services, repository
  features/   LSA verification binding, controller, screen, Byts
  friction/   stall detector
  routes/
```

Do not commit `.env`, API keys, or certificates. This project does not ship any.
