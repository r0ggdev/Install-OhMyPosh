Write-Host "Instalar Oh My Posh" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "--------------------------------------------------"

# Ejecutar la instalación de Oh My Posh
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
   
# Recargar el perfil
. $PROFILE



##winget install JanDeDobbeleer.OhMyPosh -s winget
##oh-my-posh font install FiraMono
##New-Item -Path $PROFILE -Type File -Force

# oh-my-posh init pwsh | Invoke-Expression
# $text = oh-my-posh init pwsh | Invoke-Expression

##Start-Process "https://ohmyposh.dev/docs/themes"

#$text = oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/amro.omp.json" | Invoke-Expression

##$text2 = (@(& "$env:USERPROFILE/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe" init pwsh 
##--config="$env:USERPROFILE/AppData/Local/Programs/oh-my-posh/themes/amro.omp.json" --print) -join "`n") | Invoke-Expression

#$text3 = Write-Host "  roggerShell~ $(Get-Date -Format 'dddd, MMMM dd, yyyy HH:mm:ss') " -ForegroundColor white -BackgroundColor DarkCyan

##Add-Content -Path $PROFILE -Value $text2
##Add-Content -Path $PROFILE -Value $text3

##. $PROFILE

##Set-PSReadLineOption -PredictionViewStyle ListView
##Install-Module -Name Terminal-Icons
##Import-Module Terminal-Icons

##. $PROFILE