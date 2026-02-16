# Copilot/AI Agent Instructions for project-mon ⚙️

## Purpose
This repo contains a small Terraform configuration for provisioning GCP Compute Engine VM(s). The goal of these instructions is to give an AI coding agent the minimal, actionable context needed to make safe, correct changes and suggest fixes.

---

## Big picture 🧭
- Single-purpose Terraform configuration that creates one or more GCE VMs (`google_compute_instance.app_vm`).
- Providers and versions are pinned in `providers.tf` (Terraform >= 1.5.0, `hashicorp/google ~> 5.0`).
- No backend configuration is present (state defaults to local `terraform.tfstate`).

---

## Key files to read first 🔖
- `providers.tf` — provider and Terraform version constraints.
- `variables.tf` — declared inputs and defaults.
- `vm.tf` — core resource shape and naming/labeling conventions.

---

## Important project-specific patterns & conventions 🧩
- Instance naming follows: `${var.environment}-${var.vm_name}-${count.index + 1}`. Follow this pattern for any additional instances or resources that must match naming.
- Labels are set with `env = var.environment` and `app = var.vm_name` — use the same label keys for consistency.
- `count` is controlled via `var.vm_count` (default 1). Keep resources count-aware and use `count.index + 1` where human-friendly 1-based numbering is needed.
- Regions/Zones: `var.region` and `var.zone` are used by the provider; `zone` has a default (`asia-south1-a`) while `region` does not. Ensure both are present in `-var`/`.tfvars` or defaults are added when running commands.

---

## Known issues discovered (actionable) ⚠️
- `vm.tf` uses `var.machine_type`, but `variables.tf` does NOT declare `machine_type`. This will cause `terraform plan`/`apply` to error.
  - Suggested fix (add to `variables.tf`):

```hcl
variable "machine_type" {
  description = "GCE machine type, e.g. e2-medium"
  type        = string
  default     = "e2-medium"
}
```

Add this or pass `-var 'machine_type=...'` when planning/applying.

---

## How to run / developer workflow 🔧
- Prerequisites:
  - Terraform >= 1.5.0
  - GCP credentials available (e.g., `GOOGLE_APPLICATION_CREDENTIALS` set to a service account JSON with Compute permissions or use `gcloud auth application-default login`).
- Typical sequence:
  1. `terraform init` (downloads provider pinned in `providers.tf`)
  2. `terraform plan -var='project_id=<PROJECT>' -var='region=<REGION>' -var='zone=<ZONE>' -var='vm_name=<NAME>'`
  3. `terraform apply -var='...'`
- Because there is no remote backend in the repo, be explicit about state handling when collaborating (consider adding a backend for shared state).

---

## What to check when modifying the repo ✅
- Keep provider/version constraints in `providers.tf` consistent with changes; avoid wide provider upgrades without a compatibility check.
- If adding new variables, include clear `description`, `type`, and sensible `default` values when safe.
- Preserve the naming convention and labels (`env`, `app`) to avoid drift across resources.
- When adding resources that depend on networking, reference `var.network_name` and `var.subnetwork_name` rather than hard-coding strings.

---

## Example quick fixes / PR suggestions you may produce 📝
- Add the missing `machine_type` variable (see snippet above) and include a short test plan in PR description demonstrating `terraform plan` success with sample `-var` values.
- Add a brief `README.md` describing the minimal `terraform` workflow and GCP authentication steps.
- If team collaboration is a goal, add a `backend` configuration (e.g., GCS backend) with instructions to configure it securely.

---

If any of these points are unclear or you want me to implement the suggested fixes (for example, add the `machine_type` variable or a `README.md`), tell me which change you'd like and I'll open a PR. 🙌
