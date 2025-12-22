<p align="center">
  <img width=160px src="https://i.imgur.com/FxL5qM0.jpg" alt="Formulários logo">
</p>

<h2 align="center">Formulários — Coleção de folhas de fórmulas</h2>

<div align="center">
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)
</div>

---

<p align="center"> 🤖 Few lines describing what your bot does.
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Build & Usage](#build)
- [Fast builds](#fast)
- [Per-chapter builds](#per-chapter)
- [Contributing](#contributing)
- [Authors](#authors)

## 🧐 About <a name = "about"></a>

This repository collects compact formula sheets for several disciplines (Cálculo, Física, Álgebra, Eletrônica, Equações Diferenciais, Fenômenos de Transporte, Cálculo Numérico, Matemática Discreta). Files are plain LaTeX sources and a small Makefile is provided to build per-discipline PDFs or specific chapters.

---

## 🛠️ Build & Usage <a name = "build"></a> ✅

Requirements:
- TeX Live (pdflatex)
- make

Common examples:

- Build full main document:

```bash
make all
```

- Build an entire discipline (PDF saved in discipline folder):

```bash
make fisicas        # -> fisicas/fisicas.pdf
make calculos       # -> calculos/calculos.pdf
```

- Build a specific chapter (by name):

```bash
make fisicas CHAP=cap30           # builds fisicas_cap30.pdf
make fisicas cap30                # positional form
make fisicas F=cap30              # short flag
make calculos CHAP=calculoiv/calciv   # accepts full path too
```

Notes:
- Output filenames with single-chapter selection are suffixed with the chapter basename: e.g. `fisicas/fisicas_cap30.pdf` or `calculos/calculos_calciv.pdf`.
- Temporary files (build_*.tex, .aux, .log, .synctex.gz) are removed automatically after a successful build.

## ⚡ Fast builds <a name = "fast"></a>

To speed up iteration, a fast mode compiles in "draft" graphics mode and only runs pdflatex once:

```bash
make fisicas-fast      # shorthand target that runs `make fisicas FAST=1`
# or
make fisicas FAST=1
```

This disables inclusion of external raster/vector images (graphicx in draft) and compiles only once — useful for quick checks.

## 🧩 Per-chapter selection (examples) <a name = "per-chapter"></a>

You can select by basename or full path:

```bash
make calculos calciv            # positional goal `calciv` -> calculos_calciv.pdf
make calculos CHAP=calculoiv/calciv
make calculos F=calciv
```

If the provided chapter name doesn't match any include, the full discipline PDF is built as a fallback.

---

## Contributing <a name = "contributing"></a>

- Keep LaTeX code tidy; prefer `align` for multi-line equations and `tcolorbox` for formatted boxes.
- When adding diagrams, prefer vector TikZ where possible; consider heavy drawings in separate files or mark them to be skipped in fast builds if you want rapid iteration.
- Add unit checks and simple comments for complicated derivations.

## Authors <a name = "authors"></a>

- Pedro — repository owner and maintainer

---

If you'd like I can add CI (GitHub Actions) to validate that the project builds on push and that each discipline compiles successfully.

<sup>Beep boop. I am a bot. If there are any issues, contact my [Master](https://www.reddit.com/message/compose/?to=PositivePlayer1&subject=/u/Wordbook_Bot)</sup>

<sup>Want to make a similar reddit bot? Check out: [GitHub](https://github.com/kylelobo/Reddit-Bot)</sup>

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them.

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running.

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo.

## 🚀 Deploying your own bot <a name = "deployment"></a>

To see an example project on how to deploy your bot, please see my own configuration:

- **Heroku**: https://github.com/kylelobo/Reddit-Bot#deploying_the_bot

## ⛏️ Built Using <a name = "built_using"></a>

- [PRAW](https://praw.readthedocs.io/en/latest/) - Python Reddit API Wrapper
- [Heroku](https://www.heroku.com/) - SaaS hosting platform

## ✍️ Authors <a name = "authors"></a>

- [@kylelobo](https://github.com/kylelobo) - Idea & Initial work

See also the list of [contributors](https://github.com/kylelobo/The-Documentation-Compendium/contributors) who participated in this project.

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Hat tip to anyone whose code was used
- Inspiration
- References