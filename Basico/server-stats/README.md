# 📊 Server Performance Stats

¡Hola! Bienvenido al proyecto **Server Performance Stats**. Este es un proyecto de nivel **básico** ideal para familiarizarse con el scripting en bash y los comandos de diagnóstico en Linux.

## 🎯 Objetivo
El objetivo es escribir un script `server-stats.sh` que pueda analizar y mostrar estadísticas básicas de rendimiento de un servidor Linux.

## 📝 Requisitos

El script debe ser capaz de ejecutarse en cualquier servidor Linux y proporcionar la siguiente información:

1. **Uso total de CPU.**
2. **Uso total de memoria** (Libre vs Usada, incluyendo el porcentaje).
3. **Uso total de disco** (Libre vs Usada, incluyendo el porcentaje).
4. **Top 5 procesos** por uso de CPU.
5. **Top 5 procesos** por uso de Memoria.

*(Extra añadido: Versión del SO y tiempo de actividad o uptime).*

## 🛠️ Paso a Paso para la Ejecución

### 1. Clonar el repositorio
Si aún no lo has hecho, clona este repositorio y navega hasta esta carpeta:
```bash
git clone https://github.com/izann06/DevOps-Proyectos-RoadMap.git
cd DevOps-Proyectos-RoadMap/Basico/server-stats
```

### 2. Dar permisos de ejecución
Antes de poder ejecutar el script, necesitas darle permisos de ejecución:
```bash
chmod +x server-stats.sh
```

### 3. Ejecutar el script
Ejecuta el script para ver las estadísticas de tu sistema:
```bash
./server-stats.sh
```

## 🧠 Explicación del Código (Paso a Paso)

Si estás empezando con Bash y Linux, es normal que algunos comandos te parezcan extraños. Aquí te explico qué hace cada parte del script `server-stats.sh`:

### 1. Obtener la versión del SO y el Uptime
```bash
cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f 2 | tr -d '"'
uptime -p
```
- **`cat /etc/os-release`**: Lee un archivo del sistema que contiene información sobre la distribución de Linux que estás usando.
- **`grep PRETTY_NAME`**: Filtra el archivo para quedarse solo con la línea que tiene el nombre bonito del SO (ej. "Ubuntu 22.04 LTS").
- **`cut` y `tr`**: Limpian el texto quitando el signo `=` y las comillas `"` para que quede perfecto.
- **`uptime -p`**: Te dice cuánto tiempo lleva encendido el servidor en un formato fácil de leer (ej. "up 2 hours, 15 minutes").

### 2. Uso de CPU
```bash
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'
```
- **`top -bn1`**: Ejecuta el administrador de tareas `top` en modo "batch" (`-b`) y se cierra tras 1 iteración (`-n1`).
- **`grep "Cpu(s)"`**: Busca la línea exacta que nos da el resumen del estado de la CPU.
- **`sed ...`**: Usamos una expresión regular para encontrar la cantidad de CPU que está inactiva ("id" de idle).
- **`awk '{print 100 - $1}'`**: Resta a 100 el porcentaje de CPU inactiva. ¡El resultado es el porcentaje de CPU que se está usando!

### 3. Uso de Memoria RAM
```bash
free -m | awk 'NR==2{printf "Total: %s MB | Used: %s MB (%.2f%%) | Free: %s MB\n", $2, $3, $3*100/$2, $4}'
```
- **`free -m`**: Muestra la memoria RAM del sistema en Megabytes (`-m`).
- **`awk`**: Es un lenguaje de procesamiento de texto potentísimo. 
  - `NR==2`: Le decimos que solo lea la segunda línea (donde están los datos reales de RAM).
  - Imprimimos el total (`$2`), lo usado (`$3`) y lo libre (`$4`).
  - Hacemos las matemáticas `($3*100/$2)` al vuelo para sacar el porcentaje de uso.

### 4. Uso de Disco
```bash
df -h / | awk '$NF=="/"{printf "Total: %d GB | Used: %d GB (%s) | Free: %d GB\n", $2, $3, $5, $4}'
```
- **`df -h /`**: Muestra el espacio en el disco raíz (`/`) en un formato "humano" (`-h` para Gigabytes/Megabytes).
- **`awk`**: Lo usamos de nuevo para aislar las columnas de Total (`$2`), Usado (`$3`), Porcentaje (`$5`) y Libre (`$4`).

### 5. Top 5 Procesos (por CPU y Memoria)
```bash
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```
- **`ps -eo ...`**: Lista los procesos activos (`ps`) y le decimos exactamente qué columnas queremos ver (`pid, cmd, %mem, %cpu`).
- **`--sort=-%cpu`**: Ordena la lista de procesos de mayor a menor consumo de CPU (el símbolo `-` es para orden descendente). Si cambiamos a `-%mem`, ordena por memoria.
- **`head -n 6`**: Coge solo las primeras 6 líneas de esa lista (la línea 1 son las cabeceras de las columnas, y las siguientes 5 son nuestros procesos top).

---
*Reto original propuesto por [roadmap.sh](https://roadmap.sh/projects/server-stats)*
