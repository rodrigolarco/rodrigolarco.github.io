#!/bin/zsh
# Publica el sitio de CorteCard en GitHub Pages (repositorio público de usuario "rodrigolarco.github.io").
set -e
cd "$(dirname "$0")"
[ -d .git ] || git init -q -b main
git add -A
git commit -q -m "Sitio de CorteCard" || true
git remote remove origin 2>/dev/null || true
if ! gh repo view rodrigolarco/rodrigolarco.github.io >/dev/null 2>&1; then
  gh repo create rodrigolarco.github.io --public --source=. --remote=origin --push --description "Sitio web de CorteCard"
else
  git remote add origin https://github.com/rodrigolarco/rodrigolarco.github.io.git
  git push -u origin main
fi
gh api -X POST repos/rodrigolarco/rodrigolarco.github.io/pages -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/' >/dev/null 2>&1 || true
echo
echo "Listo. En uno o dos minutos el sitio estará en:"
echo "  https://rodrigolarco.github.io/"
echo "  https://rodrigolarco.github.io/privacidad   (Privacy Policy URL)"
echo "  https://rodrigolarco.github.io/soporte      (Support URL)"
