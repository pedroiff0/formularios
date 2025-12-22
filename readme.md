[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

# Formulários — Coleção de folhas de fórmulas 📚

---

Breve: coleções de resumos e folhas de fórmulas em LaTeX organizadas por disciplina.

## Sumário

- [Requisitos](#requisitos)
- [Uso rápido](#uso-rápido)
- [Construções por capítulo](#capitulos)
- [Alvo combinado](#combinado)
- [Integração contínua (CI)](#ci)
- [Contribuição](#contribuicao)
- [Licença](#licenca)

---

## Requisitos <a name="requisitos"></a>

- TeX (pdflatex) — TeX Live ou similar
- make

---

## Uso rápido <a name="uso-rapido"></a> ✅

- Gerar o documento principal:

```bash
make all
```

- Gerar toda a disciplina (PDF dentro da pasta da disciplina):

```bash
make fisicas        # -> fisicas/fisicas.pdf
make calculos       # -> calculos/calculos.pdf
```

- Gerar um capítulo específico (exemplos):

```bash
make fisicas cap30                  # forma posicional
```

Observações:
- Arquivos temporários (build_*.tex, .aux, .log, .synctex.gz) são removidos automaticamente após build bem-sucedido.


## Fast builds

Para ciclos de desenvolvimento rápidos, há um modo "fast" que compila em modo rascunho e roda pdflatex apenas uma vez:

```bash
make fisicas-fast      # equivalente a: make fisicas FAST=1
# ou
make fisicas FAST=1
```

Útil para checar o layout sem processar imagens pesadas.

## Construções por capítulo (por disciplina) <a name="capitulos"></a>

Gera um PDF por capítulo (arquivo individual dentro do diretório da disciplina). Use o alvo `disciplinas` (pt) ou `disciplines` (en) com a variável contendo disciplinas separadas por vírgula.

Exemplos:

```bash
# gera um PDF por capítulo em calculos/ e fisicas/
make disciplines="calculos,fisicas"       # ou make disciplinas="calculos,fisicas"

# gerar só calculos
make disciplines="calculos"
```

Comportamento:
- Cria um PDF para cada entrada listada em `CALCULOS_INCLUDES` e `FISICAS_INCLUDES` (por exemplo: `calculos/calculoi/calculoi_calculo_basico.pdf`, `fisicas/fisicaiii/fisicaiii_cap30.pdf`).
- Silencioso por padrão; passe `VERBOSE=1` para ver os passos:

```bash
make disciplines="calculos,fisicas" VERBOSE=1
```

---

## Integração contínua (CI) <a name="ci"></a>

Há um workflow GitHub Actions em `.github/workflows/test-builds.yml` que executa em push e em pull requests. O job:

- instala pacotes LaTeX mínimos na runner;
- executa `make disciplines="calculos,fisicas" VERBOSE=1` (gera PDFs por capítulo);
- executa `make combined VERBOSE=1` (gera `combined.pdf`);
- publica os PDFs como artifacts para inspeção.

O job falhará caso qualquer build retorne erro — útil como teste automático de regressão.

---

## Testes locais

Para reproduzir o que o CI faz, execute localmente:

```bash
# gerar um PDF por capítulo para calculos e fisicas
make disciplines="calculos,fisicas" VERBOSE=1

# gerar combinado
make combined VERBOSE=1
```

Os arquivos são gerados nas pastas correspondentes (e.g., `calculos/...pdf`, `fisicas/...pdf`) e `combined.pdf` é criado no repositório raiz.

---

## Contribuição <a name="contribuicao"></a>

- Envie PRs para mudanças; inclua uma descrição clara e, quando possível, um teste ou verificação simples.
- Prefira imagens vetoriais (TikZ, PDF) e considere marcar recursos pesados para serem ignorados em builds rápidos (FAST=1).
- Ao alterar `Makefile` ou scripts de build, adicione verificações que possam ser executadas no CI.

## Autoria

- Pedro — mantenedor do repositório

---

## Licença

MIT — veja `LICENSE`.

---

Se quiser, adiciono um badge do CI (status) no topo do README e/ou um alvo `verify` no `Makefile` que confirme a existência dos PDFs esperados (útil para CI).

---

Obrigado — documentação simplificada e focada nas operações de build está pronta. Se quiser, posso também abrir um PR com essas mudanças, adicionar o badge do workflow e criar um alvo `verify` que o CI utilize para validar os PDFs.