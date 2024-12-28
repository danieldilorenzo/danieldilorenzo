# Passos para flash rom

> sudo adb reboot bootloader <br><br>
> sudo fastboot devices <br><br>
> sudo fastboot flash dtbo dtbo.img <br><br>
> sudo fastboot flash vendor_boot vendor_boot.img <br><br>
> sudo fastboot flash boot boot.img <br><br>
> sudo adb reboot recovery <br><br>
> sudo adb sideload rom.zip

<br>

# Descobrir a quanto tempo o Linux está instalado


> stat / | awk '/Birth: /{print $2 " " substr($3,1,5)}'

Ou

> stat / | awk '/Criação: /{print $2 " " substr($3,1,5)}'

<br>

# Desbloquear WiFi para instalação Arch

> rfkill unblock wlan <br><br>
> iwctl <br><br>
> device list <br><br>
> station wlan0 scan <br><br>
> station wlan0 get-networks <br><br>
> station wlan0 connect <nome_da_rede>

 <br>

 # Alterar o tempo de espera do Gnome antes de mostrar "Aplicativo X parou"<br>
 _Isso resolve um problema que tenho com a Steam, onde logo que eu abro aparece esse erro. Nunca ocorre no Plasma_

<br>

 > gsettings set org.gnome.mutter check-alive-timeout 30000

<br>

# Descobrir no Fedora em que pasta está um programa

<br>

>rpm -ql NomeDoPrograma

<br>

# NixOS

- [NixOS Learn](https://nixos.org/learn/)
- [Zero to Nix](https://zero-to-nix.com/)
- [Search Package on Nix](https://search.nixos.org/options)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [Nix.dev](https://nix.dev/)
- [Discourse Nix](https://discourse.nixos.org/)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/)

<br>

# Fonte

- https://linuxiac.com/how-to-find-linux-os-installation-date/
- https://www.freecodecamp.org/news/how-to-install-arch-linux/
- https://www.reddit.com/r/archlinux/comments/nnubzr/iwd_says_wlan0_is_off/?onetap_auto=true&one_tap=true
- https://wiki.archlinux.org/title/Network_configuration/Wireless#Rfkill_caveat
- https://www.reddit.com/r/gnome/comments/hzkuwx/how_gnome_treats_unresponsive_applications_can_i/
