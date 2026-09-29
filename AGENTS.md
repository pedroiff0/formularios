# AGENTS.md — Formulários Acadêmicos

> Diretrizes e regras operacionais para Agentes de IA no repositório `formularios`.

---

## 1. Visão Geral
- **Repositório:** `pedroiff0/formularios` (`~/Repositorios/academicos/formularios`).
- **Propósito:** Coleção modular de folhas de fórmulas, resumos matemáticos e físicos em LaTeX para o ciclo básico e profissional de engenharia.
- **Estrutura:** `calculos/` (Cálculo I-IV), `fisicas/` (Física I-IV), `latexconfig/` (estilos e macros compartilhadas).

---

## 2. Regras de Compilação & Edição para Agentes

1. **Modularidade e Macros:**
   - Todo capítulo deve ser compilável individualmente através de `make <disciplina> cap<N>` ou em conjunto via `make all`.
   - Utilizar as macros unificadas em `latexconfig/settings.tex`.
2. **Qualidade Tipográfica:**
   - Usar `siunitx` para notação de grandezas físicas e unidades padronizadas do SI.
   - Preservar alinhamentos de equações com `align*` ou `cases`.
3. **Preservação de Cota de CI:**
   - Limite máximo de execução de 5 minutos por workflow (`timeout-minutes: 5`).
