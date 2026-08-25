#!/bin/bash

# ==========================================
# Server Performance Stats Script
# ==========================================

echo "=========================================="
echo "      📊 SERVER PERFORMANCE STATS 📊"
echo "=========================================="
if [ -f /etc/os-release ]; then
    echo "OS Version: $(cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f 2 | tr -d '"')"
fi
echo "Uptime: $(uptime -p)"
echo "=========================================="

# 1. Total CPU usage
echo -e "\n💻 --- CPU USAGE ---"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "Total CPU Usage: $CPU_IDLE%"

# 2. Total memory usage (Free vs Used including percentage)
echo -e "\n🧠 --- MEMORY USAGE ---"
free -m | awk 'NR==2{printf "Total: %s MB | Used: %s MB (%.2f%%) | Free: %s MB\n", $2, $3, $3*100/$2, $4}'

# 3. Total disk usage (Free vs Used including percentage)
echo -e "\n💾 --- DISK USAGE ---"
df -h / | awk '$NF=="/"{printf "Total: %d GB | Used: %d GB (%s) | Free: %d GB\n", $2, $3, $5, $4}'

# 4. Top 5 processes by CPU usage
echo -e "\n🔥 --- TOP 5 PROCESSES BY CPU ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# 5. Top 5 processes by memory usage
echo -e "\n💥 --- TOP 5 PROCESSES BY MEMORY ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo -e "\n=========================================="
echo "✅ Analysis Complete!"
echo "=========================================="
