# Limpia la consola
Clear-Host

# Mensaje inicial
Write-Host "Verificar e instalar Windows Terminal" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "--------------------------------------------------"

# Verifica si Windows Terminal está instalado
if (Get-Command "wt" -ErrorAction SilentlyContinue) {
    Write-Output "Windows Terminal ya está instalado."
} else {
    Write-Output "Windows Terminal no está instalado. Procediendo con la instalación..."
    try {
        # Intenta instalar Windows Terminal
        winget install -e --id Microsoft.WindowsTerminal
        Write-Output "Instalación de Windows Terminal completada."
    } catch {
        Write-Error "Hubo un problema al intentar instalar Windows Terminal. Asegúrate de que winget esté instalado y funcionando correctamente."
        exit
    }
}

# Espera para dar tiempo a que Windows Terminal se instale completamente
Start-Sleep -Seconds 2

# Define la ruta al script de configuración
$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "InstallOhMyPosh.ps1"

# Abre Windows Terminal y ejecuta el script de configuración
Start-Process "wt" -ArgumentList "powershell -NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""

# Mensaje final
Write-Host "Windows Terminal debería abrirse y ejecutar el script de configuración." -ForegroundColor Green