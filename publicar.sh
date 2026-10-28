#!/bin/zsh
# Publica el sitio de CorteCard en GitHub Pages (repositorio público "cortecard").
set -e
cd "$(dirname "$0")"
[ -d .git ] || git init -q -b main
git add -A
git commit -q -m "Sitio de CorteCard" || true
if ! gh repo view rodrigolarco/cortecard >/dev/null 2>&1; then
  gh repo create cortecard --public --source=. --remote=origin --push --description "Sitio web de CorteCard"
else
  git remote get-url origin >/dev/null 2>&1 || git remote add origin https://github.com/rodrigolarco/cortecard.git
  git push -u origin main
fi
gh api -X POST repos/rodrigolarco/cortecard/pages -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/' >/dev/null 2>&1 || true
echo
echo "Listo. En uno o dos minutos el sitio estará en:"
echo "  https://rodrigolarco.github.io/cortecard/"
echo "  https://rodrigolarco.github.io/cortecard/privacidad   (Privacy Policy URL)"
echo "  https://rodrigolarco.github.io/cortecard/soporte      (Support URL)"
