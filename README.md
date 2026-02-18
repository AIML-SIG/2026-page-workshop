# A Glimpse into AI/ML Applications for Pharmacometrics

Welcome to the hands-on session code for "A Glimpse into AI/ML Applications for Pharmacometrics" workshop at PAGE 2026.

## Devcontainer notes (Julia startup speed)

The devcontainer builds a Julia sysimage during image build so common course packages (default: `CSV`) are ready at first use.

- Package list is controlled with `JULIA_PACKAGES` in `.devcontainer/Dockerfile`.
- The `julia` command is wrapped to always use `--project=/opt/course-julia -J/opt/julia/course.so`.
- `JULIA_PKG_PRECOMPILE_AUTO=0` is enabled to avoid auto-precompile delays during class.

If you change `JULIA_PACKAGES`, rebuild the container so the sysimage is regenerated.
