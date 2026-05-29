# ==========================================================
# NOME DO ARQUIVO: Instalar_Maquinas_Global.ps1
# EXECUTAR COMO ADMINISTRADOR (Obrigatório para Global Scope)
# ==========================================================

function Mostrar-Menu {
    Clear-Host
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "    AUTOMACAO DE INSTALACAO - DANI        " -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "1) Somente Geral"
    Write-Host "2) Geral + FrontEnd"
    Write-Host "3) Geral + BackEnd"
    Write-Host "4) Geral + PO"
    Write-Host "5) Geral + Design"
    Write-Host "6) Sair"
    Write-Host "=========================================="
}

# Definição das listas
$apps_gerais = @("Google.Chrome", "SlackTechnologies.Slack", "Google.GoogleDrive", "Zoom.Zoom.EXE", "Adobe.Acrobat.Reader.64-bit", "ShareX.ShareX", "JGraph.Draw", "AnyDesk.AnyDesk")
$apps_frontend = @("Postman.Postman", "HeidiSQL.HeidiSQL", "Microsoft.VisualStudioCode", "Figma.Figma", "CoreyButler.NVMforWindows", "Canonical.Ubuntu.2404", "WinSCP.WinSCP")
$apps_backend = @("Postman.Postman", "HeidiSQL.HeidiSQL", "Microsoft.VisualStudioCode", "AgileBits.1Password", "Canonical.Ubuntu.2404", "WinSCP.WinSCP")
$apps_po = @("Miro.Miro", "Cisco.Webex", "Microsoft.Office")
$apps_design = @("Figma.Figma", "Canva.Canva", "Microsoft.Office")

Mostrar-Menu
$escolha = Read-Host "Selecione a area desejada"

$listaFinal = @()
$listaFinal += $apps_gerais
$isDesign = $false
$perfil = "Geral"

switch ($escolha) {
    "1" { $perfil = "Geral" }
    "2" { $listaFinal += $apps_frontend; $perfil = "FrontEnd" }
    "3" { $listaFinal += $apps_backend; $perfil = "BackEnd" }
    "4" { $listaFinal += $apps_po; $perfil = "PO" }
    "5" { $listaFinal += $apps_design; $perfil = "Design"; $isDesign = $true }
    "6" { exit }
    Default { Write-Host "Opção inválida!" -ForegroundColor Red; exit }
}

# Alertas
Write-Host "`n[!] AVISO: Favor instalar Cosmos manualmente." -ForegroundColor Red
if ($isDesign) {
    Write-Host "[!] AVISO DESIGN: Instalar Adobe Illustrator, Photoshop e Creative Cloud manualmente." -ForegroundColor Red
}

Write-Host "`nIniciando instalação Global (Machine) do Perfil: $perfil..." -ForegroundColor Green

foreach ($app in $listaFinal) {
    Write-Host "Tentando instalar: $app" -ForegroundColor Yellow
    # Aqui a mágica acontece: escopo de máquina + modo silencioso
    winget install --id $app --scope machine --silent --accept-package-agreements --accept-source-agreements
}

Write-Host "`nProcesso finalizado!" -ForegroundColor Green
pause