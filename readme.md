# Formulários Acadêmicos

Este repositório contém folhas de fórmulas para disciplinas acadêmicas, compiladas em LaTeX.

## Estrutura do Projeto

- `main.tex`: Arquivo principal para compilação.
- `latexconfig/forms.sty`: Pacote de estilos personalizados para fórmulas e caixas.
- `calculoiv/`: Folhas de Cálculo IV e básicas (Matemática Básica, Cálculo Básico).
- `fisicaiii/`: Folhas de Física III, incluindo deduções.
- Outras pastas: `calculoi/`, `calculoii/`, `calculoiii/`, `fisicai/`, `fisicaii/`.

## Como Compilar

Para gerar o PDF, execute:

```bash
pdflatex main.tex
```

Certifique-se de ter LaTeX instalado (TeX Live, MiKTeX, etc.).

## Funcionalidades

- Caixas coloridas para fórmulas e deduções.
- Figuras com TikZ para ilustrações.
- Numeração de equações por seção.
- Ambiente `deducao` para centralizar deduções.
- Macro `\deducaostep` para etapas de dedução em caixas.

## Contribuição

Edite os arquivos `.tex` nas pastas correspondentes e recompile.