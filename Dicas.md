# Passos para flash rom

> sudo adb reboot bootloader <br><br>
> sudo fastboot devices <br><br>
> sudo fastboot flash dtbo dtbo.img <br><br>
> sudo fastboot flash vendor_boot vendor_boot.img <br><br>
> sudo fastboot flash boot boot.img <br><br>
> sudo adb reboot recovery <br><br>
> sudo adb sideload rom.zip

# Descobrir a quanto tempo o Linux está instalado


> stat / | awk '/Birth: /{print $2 " " substr($3,1,5)}'

Ou

> stat / | awk '/Criação: /{print $2 " " substr($3,1,5)}'

<br>

# Fonte

- https://linuxiac.com/how-to-find-linux-os-installation-date/