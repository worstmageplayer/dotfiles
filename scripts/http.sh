#!/bin/bash
cd ~/public
PORT="8888"
IP="$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="src") {print $(i+1); exit}}')"
echo "http://$IP:$PORT/"
python3 -m http.server $PORT
