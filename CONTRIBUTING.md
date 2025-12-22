# Contributing

Thanks for contributing! This file explains how to build parts of the project and the preferred workflow.

## Build targets (Makefile)
- `make all` — build the full `main.tex` and produce `main.pdf`.
- `make calculos` — build only the calculation sheets (produces `calculos.pdf`).
- `make fisicas` — build only the physics sheets (produces `fisicas.pdf`).
- `make build-parts PARTS=calculos,fisicas` — build a custom combination (comma separated list).
- `make clean` / `make distclean` — remove temporary and generated files.

## Workflow
1. Create a new branch: `git checkout -b feature/my-change`.
2. Make changes in the appropriate `capNN.tex` or package file.
3. Run the appropriate `make` target (e.g. `make fisicas`) to verify output.
4. Commit and open a pull request with a brief description.

## Chapter / Section rules
- To set the visible/numbering context for a chapter or section, edit the `capNN.tex` file and add or update the `\subsection{...}` at the top (this project hides titles visually but keeps numbering consistent).
- Use `
- Keep LaTeX code tidy; prefer `align` for multi-line equations and `tcolorbox` for formatted boxes.

## Code style
- Keep lines reasonably short (~100 chars).
- Use existing macros in `latexconfig/forms.sty` when possible.

If anything in this document is unclear or you'd like stricter CI/build checks, open an issue or PR and we can add it. Thanks! 
