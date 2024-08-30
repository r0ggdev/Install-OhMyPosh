Clear-Host

# Continuar con la instalación de Oh My Posh
Write-Host "Instalar Oh My Posh" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "--------------------------------------------------"

winget install JanDeDobbeleer.OhMyPosh -s winget

# Preguntar al usuario si desea instalar la fuente por defecto o elegir una fuente personalizada
$choice = Read-Host "¿Deseas instalar la fuente por defecto (FiraMono) o elegir otra fuente? (D/O)"

if ($choice -eq "D" ) {
    # Instalar la fuente por defecto (FiraMono)
    oh-my-posh font install FiraMono
} else {
    # Instalar la fuente personalizada
    oh-my-posh font install
}

# Verificar si el archivo $PROFILE de PowerShell existe
if (-not (Test-Path $PROFILE)) {
    # Crear el archivo de perfil si no existe
    New-Item -Path $PROFILE -Type File -Force
    Write-Host "Archivo $PROFILE creado" -ForegroundColor Green
} else {
    Write-Host "El archivo $PROFILE ya existe en $PROFILE" -ForegroundColor Yellow
}
   
# Preguntar al usuario si desea instalar un tema por defecto o elegir otro tema
$choice = Read-Host "¿Deseas instalar tema por defecto (amro) o elegir otro tema? (D/O)"
   
$themeName = if ($choice -eq "D") { "amro" } else {
    Start-Process "https://ohmyposh.dev/docs/themes"
    Read-Host "Ingresa el nombre del tema personalizado"
}
   
# Aplicar el tema
$theme = (@(& "$env:USERPROFILE/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe" init pwsh --config="$env:USERPROFILE/AppData/Local/Programs/oh-my-posh/themes/$themeName.omp.json" --print) -join "`n") | Invoke-Expression
   
# Configuración adicional
$config = @("
$theme
Set-PSReadLineOption -PredictionViewStyle ListView
Install-Module -Name Terminal-Icons -Force -Scope CurrentUser
Import-Module Terminal-Icons
")
    
Add-Content -Path $PROFILE -Value $config
   
# Limpia la consola
Clear-Host

# Recargar el perfil
. $PROFILE