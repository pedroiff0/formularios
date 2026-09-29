# HANDOFF — Formulários Acadêmicos

## 1. Contexto Rápido
- **Repositório:** `pedroiff0/formularios` (`~/Repositorios/academicos/formularios`).
- **Função Principal:** Suíte de folhas de fórmulas científicas em LaTeX para Cálculo e Física, compiladas modularmente via Makefile.
- **Estrutura:** `calculos/` (Cálculo I-IV), `fisicas/` (Física I-IV), `latexconfig/` (macros compartilhadas).

## 2. Arquitetura de Build
- **Motor LaTeX:** `pdflatex` com suporte a `siunitx` e `amsmath`.
- **Compilações Suportadas:**
  - Build completo: `make all` -> `main.pdf`.
  - Build combinado: `make combined` -> `combined.pdf`.
  - Builds por disciplina: `make fisicas`, `make calculos`.
  - Builds rápidos (rascunho): `make fisicas-fast`, `make calculos-fast`.

## 3. Estado Atual & Diretrizes Operacionais
- **Governança:** AGENTS.md, DESIGN.md, Makefile e templates do GitHub ativos.
- **Comandos Principais:**
  - `make help`: Lista todos os alvos do Makefile.
  - `make clean`: Remove arquivos auxiliares de compilação TeX.
- **Próximos Passos:**
  - Adicionar formulários de disciplinas adicionais (Álgebra Linear, Equações Diferenciais).
