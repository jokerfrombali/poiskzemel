#!/bin/bash
# Обновляет poiskzemel.ru на Timeweb из GitHub (main).
# Нужен SSH-ключ ~/.ssh/id_ed25519_timeweb в ~/.ssh/authorized_keys на хостинге.
set -e
ssh -i ~/.ssh/id_ed25519_timeweb cg50486@bitrix408.timeweb.ru '
set -e
cd ~/poiskzemel
if [ -d src/.git ]; then git -C src fetch -q origin && git -C src reset -q --hard origin/main; else git clone -q https://github.com/jokerfrombali/poiskzemel.git src; fi
rsync -a --delete --exclude .git --exclude netlify.toml --exclude deploy-timeweb.sh --exclude cgi-bin src/ public_html/
echo "Deployed $(git -C src rev-parse --short HEAD)"
'
