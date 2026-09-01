#!/bin/bash

# ==========================================
# Script de Despliegue con Rsync / SCP
# ==========================================

SERVER_ALIAS="mi-mv-ubuntu"
REMOTE_DIR="/var/www/mi-web"
LOCAL_DIR="./public/"

echo "🚀 Iniciando el despliegue de la web estática..."

# Comprobar si rsync está instalado (suele faltar en Windows/Git Bash)
if command -v rsync >/dev/null 2>&1; then
    echo "📦 Usando Rsync para sincronizar (Modo Avanzado DevOps)..."
    rsync -avz --delete "$LOCAL_DIR" "$SERVER_ALIAS:$REMOTE_DIR"
    DEPLOY_STATUS=$?
else
    echo "⚠️ ADVERTENCIA: No se ha detectado 'rsync' en tu sistema."
    echo "💡 Esto es normal si estás usando Windows (Git Bash)."
    echo "📦 Cayendo de pie: Usando 'scp' (Secure Copy) como alternativa..."
    
    # scp copia todo de forma bruta, no sincroniza inteligentemente como rsync, pero sirve para aprender.
    scp -r "$LOCAL_DIR"* "$SERVER_ALIAS:$REMOTE_DIR"
    DEPLOY_STATUS=$?
fi

if [ $DEPLOY_STATUS -eq 0 ]; then
    echo "✅ ¡Despliegue completado con éxito!"
    echo "🌍 Tu web ya debería estar disponible en la IP de tu servidor."
else
    echo "❌ Error durante el despliegue."
    echo "Asegúrate de que la carpeta $REMOTE_DIR existe en el servidor y de que tu usuario tiene permisos (sudo chown -R \$USER:\$USER $REMOTE_DIR)."
    exit 1
fi
