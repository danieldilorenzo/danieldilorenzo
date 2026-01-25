# 1. Criar a tabela de partição (Cuidado para não selecionar o /dev/sda do Windows!)
cfdisk /dev/nvme0n1
# Selecione "gpt"
# Crie uma partição de 512M (Tipo: EFI System)
# Crie uma partição com o resto do espaço (Tipo: Linux Root x86-64)
# Selecione [Write] e depois [Quit]

# 2. Formatação
mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2

# 3. Montagem
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot

# Instala o sistema base com o microcode da Intel
pacstrap -K /mnt base linux linux-firmware intel-ucode nano vi sudo

# Gerar tabela de partições
genfstab -U /mnt >> /mnt/etc/fstab

# Entrar no sistema instalado
arch-chroot /mnt

# Horário e Local
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc

# Idioma (Descomente pt_BR.UTF-8 e en_US.UTF-8 no arquivo)
nano /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf

# Rede e Senha Root
echo "dell-arch" > /etc/hostname
passwd

# Criar seu usuário (Troque 'usuario' pelo seu nome)
useradd -m -G wheel -s /bin/bash usuario
passwd usuario
# Dê permissão de admin (Descomente a linha %wheel ALL=(ALL:ALL) ALL)
EDITOR=nano visudo

# Ativar Multilib 
nano /etc/pacman.conf

# Descomentar as duas linhas
[multilib]
Include = /etc/pacman.d/mirrorlist


# Atualize e instale o KDE + Drivers Intel + Pipewire
pacman -Syu mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver \
pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber alsa-firmware alsa-utils \
networkmanager bluez bluez-utils sof-firmware plasma-pa pavucontrol \
plasma-desktop plasma-nm sddm sddm-kcm konsole dolphin ark spectacle kcalc gwenview \
thermald  # Essencial para controle térmico do i5-13gen


pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg

# Habilitar serviços para o próximo boot
systemctl enable sddm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable thermald

# Sair e Reiniciar
exit
umount -R /mnt
reboot



# Pós instalação

sudo pacman -S zram-generator

sudo nano /etc/systemd/zram-generator.conf

# Colar

[zram0]
zram-size = ram / 4
compression-algorithm = zstd


sudo systemctl daemon-reload


# Instalar Yay

# 1. Instale as ferramentas de compilação e o git
sudo pacman -S --needed base-devel git

# 2. Clone o repositório do yay
git clone https://aur.archlinux.org/yay.git

# 3. Entre na pasta e instale
cd yay
makepkg -si

# 4. Saia da pasta e pode até apagá-la se quiser
cd ..
rm -rf yay

# instalar Timeshift por ele
yay -S timeshift timeshift-autosnap



# Configurar o Rollback (Interface Gráfica)

Abra o Timeshift no menu do seu KDE Plasma e siga este checklist:

    Tipo: Selecione RSYNC (o ideal para o seu SSD/NVMe em EXT4).

    Local: Escolha o seu NVMe.

    Agendamento (Schedule):

        Daily (Diário): Deixe 5 (guarda os últimos 5 dias).

        Boot (Inicialização): Deixe 3 (se o PC não ligar após uma alteração, você tem 3 chances de voltar).

    Usuários (Users): Deixe como está (o padrão é não fazer backup da /home, apenas do sistema, que é o que queremos para o rollback).


sudo nano /etc/timeshift-autosnap.conf

Podemos alterar a opção abaixo para um número maior ou menor 

minHoursTetweenSnapshots




O resumo do seu novo fluxo de trabalho:

    Para atualizar tudo: Digite yay.

    Para instalar algo oficial: sudo pacman -S pacote (ou use o yay -S pacote, dá no mesmo).

    Para instalar algo do AUR: yay -S pacote.

    Para pesquisar algo: yay termo-de-busca



# 1. Remove pacotes que não são mais necessários (órfãos)
sudo pacman -Rs $(pacman -Qdtq)

# 2. Limpa todo o cache do yay e pacman
yay -Scc
