#!/bin/bash

# 1. Verifica binário
if ! command -v adb &> /dev/null; then
    echo "Erro: ADB não encontrado."
    exit 1
fi
echo "✅ ADB encontrado."

# 2. Verifica conexão
if [[ $(adb devices | wc -l) -lt 3 ]]; then
    echo "❌ Erro: Dispositivo não encontrado ou não autorizado."
    exit 1
fi
echo "✅ Dispositivo pronto para o debloat."

# Removendo apps
PACKAGES=(
    "com.miui.msa.global"
    "com.miui.analytics"
    "com.miui.daemon"
    "com.xiaomi.joyose"
    "com.miui.miwallpaper.carousel"
    "com.mi.globalminusscreen"
    "com.miui.phrase"
    "com.xiaomi.mipicks"
    "com.miui.videoplayer"
    "com.miui.player"
    "com.miui.notes"
    "com.miui.cloudservice"
    "com.miui.cloudbackup"
    "com.miui.micloudsync"
    "com.milink.itv"
    "com.xiaomi.midrop"
    "com.miui.hybrid.accessory"
    "com.xiaomi.mi_connect.service"
    "com.miui.yellowpage"
    "com.miui.vsimcore"
    "com.miui.bugreport"
    "com.miui.miservice"
    "com.miui.translation.kingsoft"
    "com.android.printspooler"
    "com.miui.maintenancemode"
    "com.mi.appfinder"
)

echo "--- Iniciando Debloat HyperOS 3 ---"
echo "Certifique-se de que o dispositivo está conectado e a Depuração USB ativa."

# Verifica se o adb está instalado
if ! command -v adb &> /dev/null; then
    echo "Erro: ADB não encontrado. Instale com 'sudo apt install adb' ou equivalente."
    exit 1
fi

# Itera sobre a lista e remove os pacotes
for package in "${PACKAGES[@]}"; do
    echo "Removendo: $package"
    adb shell pm uninstall --user 0 "$package"
done

echo "Impedindo que os aplicativos iniciem automaticamente"

echo "Impedindo início instagram"
adb shell cmd appops set com.instagram.android RUN_IN_BACKGROUND ignore
echo "Instagram parado com sucesso"
echo "..."

echo "Impedindo início Uber"
adb shell cmd appops set com.ubercab RUN_IN_BACKGROUND ignore
echo "Uber parado com sucesso"
echo "..."

echo "Impedindo início Ifood"
adb shell cmd appops set br.com.brainweb.ifood RUN_IN_BACKGROUND ignore
echo "Ifood parado com sucesso"
echo "..."

echo "Impedindo início Google Maps"
adb shell cmd appops set com.google.android.apps.maps RUN_IN_BACKGROUND ignore
echo "Google Maps parado com sucesso"
echo "..."

echo "Impedindo início   Global Minus Screen (tela -1)"
adb shell cmd appops set com.mi.globalminusscreen RUN_IN_BACKGROUND ignore
echo "Tela -1 parado com sucesso"
echo "..."

echo "Verificando se os serviços pararam (todos devem aparecer como 'Ignore')"
for app in com.instagram.android com.ubercab br.com.brainweb.ifood com.google.android.apps.maps com.mi.globalminusscreen; do
    echo -n "Status de $app: "
    adb shell cmd appops get $app RUN_IN_BACKGROUND
done



echo "Otimizando cache do sistema (DEXOPT)..."
adb shell cmd package bg-dexopt-job

echo "..."
echo "--- Processo concluído! Reinicie o celular. ---"
