### 01. Criar a tabela de partição (Cuidado para não selecionar o /dev/sda do Windows!)
```cfdisk /dev/nvme0n1```
#### Selecione "gpt"
#### Crie uma partição de 512M (Tipo: EFI System)
#### Crie uma partição com o resto do espaço (Tipo: Linux Root x86-64)
#### Selecione [Write] e depois [Quit]

___

### 02. Formatação
```mkfs.fat -F 32 /dev/nvme0n1p1```

```mkfs.ext4 /dev/nvme0n1p2```

___

### 03. Montagem
```mount /dev/nvme0n1p2 /mnt```

```mount --mkdir /dev/nvme0n1p1 /mnt/boot```

___

### 04. Instala o sistema base com o microcode da Intel
```pacstrap -K /mnt base linux linux-firmware intel-ucode nano vi sudo```

___

### 05. Gerar tabela de partições
```genfstab -U /mnt >> /mnt/etc/fstab```

___

### 06. Entrar no sistema instalado
```arch-chroot /mnt```

___

### 07. Horário e Local
```ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime```

```hwclock --systohc```

___

### 08. Idioma 
```nano /etc/locale.gen```

Descomente pt_BR.UTF-8 e en_US.UTF-8 no arquivo

```locale-gen```

```echo "LANG=pt_BR.UTF-8" > /etc/locale.conf```
___

### 09. Rede e Senha Root
```echo "dell-arch" > /etc/hostname```

```passwd```
___

### 10. Criar seu usuário 
```useradd -m -G wheel -s /bin/bash daniel```

```passwd daniel```
___

### 11. Dê permissão de admin 
```EDITOR=nano visudo```

Descomente a linha %wheel ALL=(ALL:ALL) ALL
___

### 12. Ativar Multilib 
```nano /etc/pacman.conf```

Descomentar as duas linhas
>[multilib]
>Include = /etc/pacman.d/mirrorlist

___

### 13. Atualize e instale o KDE + Drivers Intel + Pipewire
```pacman -Syu mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber alsa-firmware alsa-utils networkmanager bluez bluez-utils sof-firmware plasma-pa pavucontrol plasma-desktop plasma-nm sddm sddm-kcm konsole dolphin ark spectacle kcalc gwenview thermald  # Essencial para controle térmico do i5-13gen```


___

### 14. Instalar GRUB
```pacman -S grub efibootmgr```

```grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH```

```grub-mkconfig -o /boot/grub/grub.cfg```
___

### 15. Habilitar serviços para o próximo boot
```systemctl enable sddm```

```systemctl enable NetworkManager```

```systemctl enable bluetooth```

```systemctl enable thermald```
___

### 16. Sair e Reiniciar
```exit```

```umount -R /mnt```

```reboot```


___

### Pós instalação

### 17. Instalar e configurar ZRAM
```sudo pacman -S zram-generator```

```sudo nano /etc/systemd/zram-generator.conf```

### Colar

>[zram0]
>
>zram-size = ram / 4
>
>compression-algorithm = zstd

<br>


```sudo systemctl daemon-reload```

___

### 18. Instalar Yay

#### 1. Instale as ferramentas de compilação e o git
```sudo pacman -S --needed base-devel git```

#### 2. Clone o repositório do yay
```git clone https://aur.archlinux.org/yay.git```

#### 3. Entre na pasta e instale
```cd yay```
```makepkg -si```

#### 4. Saia da pasta e pode até apagá-la se quiser
```cd ..```
```rm -rf yay```

#### instalar Timeshift por ele
```yay -S timeshift timeshift-autosnap```



### Configurar o Rollback (Interface Gráfica)

<br>
Abra o Timeshift no menu do seu KDE Plasma e siga este checklist:

>    Tipo: Selecione RSYNC (o ideal para o seu SSD/NVMe em EXT4).
>
>    Local: Escolha o seu NVMe.
>
>    Agendamento (Schedule):
>
>    Daily (Diário): Deixe 5 (guarda os últimos 5 dias).
>
>   Boot (Inicialização): Deixe 3 (se o PC não ligar após uma alteração, você tem 3 chances de voltar).
>
>    Usuários (Users): Deixe como está (o padrão é não fazer backup da /home, apenas do sistema, que é o que queremos para o rollback).


```sudo nano /etc/timeshift-autosnap.conf```

Podemos alterar a opção abaixo para um número maior ou menor 

minHoursTetweenSnapshots


<br>

### O resumo do seu novo fluxo de trabalho:

>    Para atualizar tudo: Digite yay.
>
>    Para instalar algo oficial: sudo pacman -S pacote (ou use o yay -S pacote, dá no mesmo).
>
>    Para instalar algo do AUR: yay -S pacote.
>
>    Para pesquisar algo: yay termo-de-busca



### 1. Remove pacotes que não são mais necessários (órfãos)
```sudo pacman -Rs $(pacman -Qdtq)```

### 2. Limpa todo o cache do yay e pacman
```yay -Scc```
