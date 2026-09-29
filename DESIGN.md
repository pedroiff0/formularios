# DESIGN — Formulários Architecture & Design Rules

## 1. Estrutura Modular

```mermaid
graph TD
    Root["formularios/"] --> Main["main.tex (Documento Unificado)"]
    Root --> Config["latexconfig/settings.tex (Macros Comuns)"]
    Root --> Calculos["calculos/ (Sub-arquivos de Cálculo I-IV)"]
    Root --> Fisicas["fisicas/ (Sub-arquivos de Física I-IV)"]
    Root --> Scripts["scripts/build_chapter.sh (Orquestrador)"]
    Root --> Make["Makefile (Alvos Modulares)"]
```

---

## 2. Padrões de Design Tipográfico

1. **Equações e Notação:**
   - Todo capítulo usa o pacote `siunitx` para grandezas e unidades.
   - Constantes e variáveis devem manter consistência conceitual em todo o compêndio.
2. **Isolamento de Compilação:**
   - Cada pasta de disciplina contém um arquivo `.tex` mestre próprio e arquivos por capítulo (`cap*.tex`), permitindo compilações granulares sem overhead.
