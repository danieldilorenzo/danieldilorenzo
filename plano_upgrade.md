# 🚀 Projeto Upgrade AM5: "Trabalho & Dev"
![Upgrade Status](https://img.shields.io/badge/Status-Em%20Progresso-bd93f9?style=for-the-badge)

<br>

Documentação técnica do upgrade de plataforma focado em desenvolvimento Python, Virtualização (KVM/QEMU) e Gaming em Linux (openSUSE/Fedora).

### 🚀 Status do Hardware

| Componente | Setup Atual (Xeon) | Upgrade Alvo (AM5) |
| :--- | :--- | :--- |
| **CPU** | ![Xeon](https://img.shields.io/badge/E5--2650%20V4-8be9fd?style=for-the-badge&logo=intel&logoColor=black) | ![Ryzen 7](https://img.shields.io/badge/RYZEN%207%207700-6272a4?style=for-the-badge&logo=amd&logoColor=white) |
| **RAM** | ![DDR4](https://img.shields.io/badge/32GB%20DDR4-8be9fd?style=for-the-badge&logo=speedtest&logoColor=black) | ![DDR5](https://img.shields.io/badge/32GB%20DDR5-6272a4?style=for-the-badge&logo=speedtest&logoColor=white) |
| **GPU** | ![RX 6600](https://img.shields.io/badge/RX%206600-8be9fd?style=for-the-badge&logo=amd&logoColor=black) | ![RX 7700 XT](https://img.shields.io/badge/RX%207700%20XT-6272a4?style=for-the-badge&logo=amd&logoColor=white) |



## 🏗️ Configuração Base (Itens Obrigatórios)

| Componente | Especificação Exata | Preço Justo (Base Mar/2026) |
| :--- | :--- | :--- |
| **Processador** | AMD Ryzen 7 7700 (8C/16T, c/ Cooler Wraith Prism) | R$ 1.850 - R$ 1.950 |
| **Placa-mãe** | ASUS TUF Gaming B650-Plus WIFI (ATX) | R$ 1.450 - R$ 1.550 |
| **Memória RAM** | 32GB (2x16GB) G.Skill Flare X5 DDR5-6000 CL30 (EXPO) | R$ 950 - R$ 1.050 |
| **Gabinete** | Montech Air 903 Base (Preto, c/ 3x Fans 140mm) | R$ 330 - R$ 380 |
| **SUBTOTAL BASE** | | **R$ 4.580 - R$ 4.930** |

---

<br>

## ⚡ Opções de Alimentação (Tier A - Essencial para Zen 4)

| Modelo | Preço Justo | Diferencial |
| :--- | :--- | :--- |
| **XPG Core Reactor 750W Gold** | R$ 580 - R$ 630 | 10 anos de garantia / Componentes Premium. |
| **Corsair RM750e Gold** | R$ 620 - R$ 680 | Padrão ATX 3.0 / Silêncio absoluto. |

---

<br>

## 🎮 Opções de GPU (Ecossistema AMD)

| Modelo | Preço Justo | Status |
| :--- | :--- | :--- |
| **ASRock RX 6600 8GB** | R$ 0,00 | **Reutilizada do setup atual.** |
| **RX 6750 XT 12GB** | R$ 2.100 - R$ 2.300 | Próximo passo (Melhor custo-benefício). |
| **RX 7700 XT 12GB** | R$ 2.850 - R$ 3.100 | Próximo passo (Foco em IA/ROCm). |

---

<br>

## 💾 Storage 

| Armazenamento  | Uso atual | Uso futuro | Já comprado?|
| :--- | :--- | :--- | :---: |
| 1TB NVMe Kingston NV2 |  Unidade de Boot e Workspace Python. | Sistema operacional | :white_check_mark:  |
| NVMe |  |  Games | :x: |
| NVMe |  |  Projetos / desenvolvimento | :x: |
| 1TB SSD SanDisk Plus (SATA) | Biblioteca de Jogos e Backup Local | Outros projetos | :white_check_mark: |

---

<br>

## 🛠️ Checklist de Implementação (Post-Install)

1.  **BIOS:** Ativar perfil **AMD EXPO** para atingir 6000MHz.
2.  **BIOS:** Verificar se o **PBO (Precision Boost Overdrive)** está ativo.
3.  **Linux:** Garantir Kernel **6.5+** para suporte nativo ao Wi-Fi e Áudio.
4.  **Storage:** Atualizar `/etc/fstab` com os UUIDs dos discos SATA remanescentes.
5.  **Verificar suporte fwupd:** fwupdmgr get-devices (Validar se a ASUS B650-Plus está na lista de dispositivos gerenciáveis).

---

<br>

## 💰 Estimativa de Investimento Total (Preços à Vista)

* **Cenário "Pé no Chão" (Mantendo sua RX 6600):** ~ R$ 5.200,00 a R$ 5.500,00.
* **Cenário "Upgrade Equilibrado" (Com RX 6750 XT):** ~ R$ 7.400,00 a R$ 7.800,00.
* **Cenário "Nave Completa" (Com RX 7700 XT):** ~ R$ 8.100,00 a R$ 8.600,00.

---
*Documentação gerada para o Lab do Dani. Revisado em 24/03/2026.*


