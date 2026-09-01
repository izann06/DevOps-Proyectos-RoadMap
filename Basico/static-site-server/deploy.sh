#!/bin/bash

# ==========================================
# Script de Despliegue con Rsync
# ==========================================

# Variables de configuración
# Usamos el alias SSH que configuramos en el reto anterior
SERVER_ALIAS="mi-mv-ubuntu"
REMOTE_DIR="/var/www/mi-web"
LOCAL_DIR="./public/"

echo "🚀 Iniciando el despliegue de la web estática..."

# Ejecutar rsync
# -a: modo archivo (preserva permisos, fechas, recursivo)
# -v: verbose (muestra lo que está haciendo por pantalla)
# -z: comprime los datos durante la transferencia para mayor velocidad
# --delete: borra en el servidor los archivos que hayas borrado en tu PC (sincronización exacta)
rsync -avz --delete "$LOCAL_DIR" "$SERVER_ALIAS:$REMOTE_DIR"

if [ $? -eq 0 ]; then
    echo "✅ ¡Despliegue completado con éxito!"
    echo "🌍 Tu web ya debería estar disponible en la IP de tu servidor."
else
    echo "❌ Error durante el despliegue."
    echo "Asegúrate de que la carpeta $REMOTE_DIR existe en el servidor y de que tu usuario tiene permisos (sudo chown -R \$USER:\$USER $REMOTE_DIR)."
    exit 1
fi
