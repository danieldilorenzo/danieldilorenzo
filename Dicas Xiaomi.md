# 🚀 Guia de Otimização e Debloat: HyperOS (Xiaomi/POCO)

Este guia contém o processo completo de limpeza e o script de automação para otimizar o HyperOS via Linux.

## 🛠 Pré-requisitos
* **Sistema:** Linux.
* **Ferramentas:** `adb` instalado.
* **Celular:** Depuração USB ativa e autorizado no PC.
  
<br>

---

<br>

## ⚡ Script de Automação Consolidado (HyperOS_Full_Clean.sh)

Este script realiza três ações em sequência:
1. **Debloat:** Remove telemetria, anúncios e apps inúteis.
2. **AppOps:** Restringe o início automático de apps pesados (Instagram, Uber, etc).
3. **Otimização:** Força o `dexopt` para melhorar a fluidez imediata.



Serviços a serem desinstalados no poco

## Verifica se o dispositivo está autorizado

```bash

if [[ $(adb devices | wc -l) -lt 3 ]]; then
    echo "Erro: Dispositivo não encontrado ou não autorizado. Verifique o cabo e a tela do celular."
    exit 1
fi
```

## 1. Publicidade e Telemetria (Os mais importantes)

```bash
adb shell pm uninstall --user 0 com.miui.msa.global    # Remove o MSA (responsável pelos anúncios do sistema)
adb shell pm uninstall --user 0 com.miui.analytics     # Remove o Analytics (coleta de dados de uso e comportamento)
adb shell pm uninstall --user 0 com.miui.daemon        # Remove o MiuiDaemon (coleta estatísticas e logs em segundo plano)
adb shell pm uninstall --user 0 com.xiaomi.joyose      # Remove o Joyose (gerencia telemetria e pode limitar performance em jogos)
```
## 2. Interface e Personalização

```bash

adb shell pm uninstall --user 0 com.miui.miwallpaper.carousel    # Remove o Carrossel de Planos de Fundo (evita anúncios na tela de bloqueio)
adb shell pm uninstall --user 0 com.mi.globalminusscreen         # Remove o App Vault (tela de atalhos à esquerda da home)
adb shell pm uninstall --user 0 com.miui.phrase                  # Remove o recurso de frases frequentes do teclado
```

## 3. Aplicativos Nativos (Bloatware comum)

```bash

adb shell pm uninstall --user 0 com.xiaomi.mipicks      # Remove o GetApps (loja de apps da Xiaomi que envia muitas notificações)
adb shell pm uninstall --user 0 com.miui.videoplayer    # Remove o Mi Video (player de vídeo nativo com propagandas)
adb shell pm uninstall --user 0 com.miui.player         # Remove o Mi Music (player de música nativo)
adb shell pm uninstall --user 0 com.miui.notes          # Remove o app de Notas da Xiaomi
```
## 4. Serviços de Nuvem e Conectividade

```bash

adb shell pm uninstall --user 0 com.miui.cloudservice          # Remove o Mi Cloud (serviço principal de nuvem da Xiaomi)
adb shell pm uninstall --user 0 com.miui.cloudbackup           # Remove o Backup na nuvem da Xiaomi
adb shell pm uninstall --user 0 com.miui.micloudsync           # Remove a sincronização de SMS e chamadas com a nuvem
adb shell pm uninstall --user 0 com.milink.itv                 # Remove o Screencast (transmissão de tela)
adb shell pm uninstall --user 0 com.xiaomi.midrop              # Remove o ShareMe (compartilhamento de arquivos estilo AirDrop)
adb shell pm uninstall --user 0 com.miui.hybrid.accessory      # Remove o Mi Linker (integração entre dispositivos Xiaomi)
adb shell pm uninstall --user 0 com.xiaomi.mi_connect.service  # Remove conectividade avançada com tablets/laptops da marca
```
## 5. Utilitários Obsoletos ou de Regiões Estrangeiras

```bash

adb shell pm uninstall --user 0 com.miui.yellowpage            # Remove o Páginas Amarelas (identificador de chamadas inútil no Brasil)
adb shell pm uninstall --user 0 com.miui.vsimcore              # Remove o chip virtual para roaming internacional (V-SIM)
adb shell pm uninstall --user 0 com.miui.bugreport             # Remove o Mi Feedback (ferramenta de reporte de erros)
adb shell pm uninstall --user 0 com.miui.miservice             # Remove o app de Serviços e Suporte da Xiaomi
adb shell pm uninstall --user 0 com.miui.translation.kingsoft  # Remove o motor de tradução embutido Kingsoft
adb shell pm uninstall --user 0 com.android.printspooler       # Remove o serviço de impressão (se você não usa o celular para imprimir)
adb shell pm uninstall --user 0 com.miui.maintenancemode       # Remove o Modo de Manutenção
```



Dica Pro: Se após remover algo você se arrepender (por exemplo, o App de Notas), você pode reinstalar o serviço sem formatar o celular usando o comando: 


```adb shell cmd package install-existing [nome.do.pacote]```


## Script para Linux com todos os serviços listados acima

VERIFICAR para não tirar algum importante

Criar um arquivo .sh, dar permissões de execução e executar.



```
#!/bin/bash

# Lista de pacotes para remover
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
    com.mi.appfinder
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

echo "Otimizando cache do sistema (DEXOPT)..."
adb shell cmd package bg-dexopt-job
echo "--- Processo concluído! Reinicie o celular. ---"

```


## 🛑 Impedir que os apps ignorem o "não iniciar automaticamente"

<br>

__Nota:__

O AppOps (Application Operations) abaixo é uma camada mais profunda e silenciosa. Ele controla como o app se comporta enquanto está rodando. Ele monitora ações como:

- "Este app pode acordar o processador agora?"

- "Este app pode rodar em segundo plano?"

- "Este app pode ler a área de transferência?"
  
```bash
# Para o Instagram
adb shell cmd appops set com.instagram.android RUN_IN_BACKGROUND ignore

# Para o Uber
adb shell cmd appops set com.ubercab RUN_IN_BACKGROUND ignore

# Para o iFood
adb shell cmd appops set br.com.brainweb.ifood RUN_IN_BACKGROUND ignore

# Para o Google Maps
adb shell cmd appops set com.google.android.apps.maps RUN_IN_BACKGROUND ignore

# Para o Global Minus Screen (tela -1)
adb shell cmd appops set com.mi.globalminusscreen RUN_IN_BACKGROUND ignore

```

## 📱 Reinicie o celular. Agora rode o comando abaixo para se certificar que os serviços não estão rodando

```bash

for app in com.instagram.android com.ubercab br.com.brainweb.ifood com.google.android.apps.maps com.mi.globalminusscreen; do
    echo -n "Status de $app: "
    adb shell cmd appops get $app RUN_IN_BACKGROUND
done


```

## 🤔 Resultados esperados

>
>Status de com.instagram.android: RUN_IN_BACKGROUND: ignore <br>
>Status de com.ubercab: RUN_IN_BACKGROUND: ignore <br>
>Status de br.com.brainweb.ifood: RUN_IN_BACKGROUND: ignore <br>
>Status de com.google.android.apps.maps: RUN_IN_BACKGROUND: ignore <br>
>Status de com.mi.globalminusscreen: RUN_IN_BACKGROUND: ignore <br>
>Status de com.xiaomi.wearable: RUN_IN_BACKGROUND: allow <br>
>



## 🧹 Fazer uma limpeza de arquivos e lixo depois de remover tudo

```adb shell cmd package bg-dexopt-job```
