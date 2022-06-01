# Beispiele zum Kurs: [Von der Virtualisierung über Cloud und Container bis Serverless («VIRTAR»)](https://www.digicomp.ch/weiterbildung/development-trainings/software-engineering-trainings/it-architektur/softwarearchitektur/design-organisation/kurs-von-der-virtualisierung-ueber-cloud-und-container-bis-serverless)

Virtualisierung ist die Basistechnologie hinter den Cloud-Technologien und wird heute in unterschiedlichster Form in modernen ICT-Architekturen eingesetzt. Von VLAN (Virtual LAN) über VPN (Virtual Private Network) bis Cloud, Container und Serverless.

### Quick Start

Installiert [Git/Bash](https://git-scm.com/downloads), [Multipass](https://multipass.run/) und [Terraform](https://www.terraform.io/).

Git/Bash Kommandozeile (CLI) starten und dieses Repository clonen.

    git clone https://github.com/mc-b/virtar
    cd virtar
    
Terraform Initialisieren und VMs erstellen

    terraform init
    terraform apply
    
Terraform verwendet [Multipass](https://multipass.run/) um mehrere VMs zu erstellen.

Nach erfolgreicher Installation werden weitere Informationen für den Zugriff auf die VMs angezeigt.

### Client Umgebung

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://gitlab.com/ch-mc-b/cdi/infra/gitpod-workspace)
