# Vita

Quarto-based CV/resume system that keeps content in YAML + BibTeX and renders through lean LaTeX templates.

## Layout
- `content/` – structured data (`person.yaml`, `positions.yaml`, `education.yaml`, `awards.yaml`, `grants.yaml`, `talks.yaml`, `teaching.yaml`, `service.yaml`, `students.yaml`, `publications.yaml`, `projects.yaml`, `notable-publications.yaml`, `cv.yaml`, `resume.yaml`, `papers.bib`).
- `cv.qmd`, `resume.qmd` – entry points for the full CV and short resume.
- `templates/` – Pandoc/LaTeX templates used by Quarto (`cv.tex`, `resume-two-col.tex`, `resume.tex`).
- `_quarto.yml` – project defaults (PDF engine, fonts, output dir).
- `Makefile` – convenience targets `make cv`, `make resume`, `make all`.

## Build
Requires Quarto and a working LaTeX toolchain. The CV uses BibLaTeX/Biber through the custom template to print publication categories from `content/publications.yaml`.

```
make cv        # builds output/cv.pdf
make resume    # builds output/resume.pdf
make all       # builds both and refreshes root PDFs
```

Rendered PDFs land in `output/` (set in `_quarto.yml`). `make all` also refreshes the tracked root files `dlebauer-full-vita.pdf` and `dlebauer-resume.pdf` for existing public links.

## Editing content
- Personal info: `content/person.yaml`
- Employment: `content/positions.yaml` (`resume: true` and `resume_role` control short-resume inclusion)
- Education: `content/education.yaml`
- Publications: `content/publications.yaml` + `content/papers.bib` (categories map to biblatex categories)
- Grants/Awards/Service/Talks/Teaching/Students: respective YAML files in `content/`
- Resume-only pieces: `content/projects.yaml`, `content/notable-publications.yaml`, `content/resume.yaml`
- Section order (CV): `content/cv.yaml`

After edits, re-run the relevant `make` target.

## Resume layout (two-column)
- Template: `templates/resume-two-col.tex` (main column + sidebar via `paracol`), called from `resume.qmd`.
- Main column: summary (`content/resume.yaml`), experience (`content/positions.yaml` with `resume: true` + `resume_role`), projects (`content/projects.yaml`), education (`content/education.yaml`), notable publications (`content/notable-publications.yaml`).
- Sidebar: contact and links (`content/person.yaml`), focus keywords (`person.subject`), honors/awards (`content/awards.yaml` with `resume: true`), key capabilities sourced from project skill lines.
- Build with `make resume` or `quarto render resume.qmd`; output lands in `output/resume.pdf`.
