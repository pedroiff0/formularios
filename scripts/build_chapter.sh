#!/usr/bin/env bash
set -euo pipefail
module="$1"
token="${2:-}"

# If token is empty, show usage and exit (prevents unbound variable errors when called without second arg)
if [ -z "$token" ]; then
    echo "Usage for physics modules: $0 <module> cap<num> | <module> <chapter_basename>" >&2
    exit 2
fi

# Determine where the module lives (fisicas or calculos)
if [ -d "fisicas/$module" ]; then
    # physics module -> token can be capNN or a chapter basename (e.g., deducao_biot_savart)
    if [[ "$token" =~ ^cap([0-9]+)$ ]]; then
        capnum=${token#cap}
        texfile="fisicas/$module/cap${capnum}.tex"
        pdffile="fisicas/$module/${module}_cap${capnum}.pdf"
        input_line="\\input{cap${capnum}.tex}"
    elif [ -f "fisicas/$module/${token}.tex" ]; then
        texfile="fisicas/$module/${token}.tex"
        pdffile="fisicas/$module/${module}_${token}.pdf"
        input_line="\\input{${token}.tex}"
    else
        echo "Usage for physics modules: $0 <module> cap<num> | <module> <chapter_basename>" >&2
        exit 2
    fi
    outdir="fisicas/$module"
elif [ -d "calculos/$module" ]; then
    # calculus module -> token is basename of the chapter (e.g., calciv, calculoii, calculo_basico)
    # Allow either capNN or a basename
    if [[ "$token" =~ ^cap([0-9]+)$ ]]; then
        capnum=${token#cap}
        texfile="calculos/$module/cap${capnum}.tex"
        pdffile="calculos/$module/${module}_cap${capnum}.pdf"
        input_line="\\input{cap${capnum}.tex}"
    else
        texfile="calculos/$module/${token}.tex"
        pdffile="calculos/$module/${module}_${token}.pdf"
        input_line="\\input{${token}.tex}"
    fi
    outdir="calculos/$module"
else
    echo "Erro: módulo desconhecido: $module" >&2
    exit 2
fi

if [ ! -f "$texfile" ]; then
    echo "Erro: $texfile não existe." >&2
    exit 1
fi

# create temporary wrapper in /tmp
tmpfile=$(mktemp /tmp/tmp_capXXXXXX.tex)
trap 'rm -f "$tmpfile"' EXIT
sed -n '1,/\\begin{document}/p' main.tex > "$tmpfile"
printf '%s\n' "$input_line" "\\end{document}" >> "$tmpfile"

# run pdflatex twice silently
pdflatex -interaction=nonstopmode -halt-on-error -output-directory="$outdir" "$tmpfile" >/dev/null 2>&1
pdflatex -interaction=nonstopmode -halt-on-error -output-directory="$outdir" "$tmpfile" >/dev/null 2>&1

tmpbase=$(basename "$tmpfile" .tex)
if [ -f "$outdir/$tmpbase.pdf" ]; then
    mv "$outdir/$tmpbase.pdf" "$pdffile"
    echo "Saved $pdffile"
else
    echo "Erro: falha na geração do PDF (veja o log em $outdir/$tmpbase.log)" >&2
    exit 1
fi

# cleanup aux files, but never remove chapter .tex
rm -f "$tmpfile" "$outdir/$tmpbase".*
# remove typical auxiliary files for chapter if they exist
if [ -f "$outdir/${token}.aux" ]; then
    rm -f "$outdir/${token}.aux" "$outdir/${token}.log" "$outdir/${token}.out" "$outdir/${token}.toc" "$outdir/${token}.synctex.gz" || true
fi

exit 0
