# Beispiele zum Kurs: [Von der Virtualisierung über Cloud und Container bis Serverless («VIRTAR»)](https://www.digicomp.ch/weiterbildung/development-trainings/software-engineering-trainings/it-architektur/softwarearchitektur/design-organisation/kurs-von-der-virtualisierung-ueber-cloud-und-container-bis-serverless)

Virtualisierung ist die Basistechnologie hinter den Cloud-Technologien und wird heute in unterschiedlichster Form in modernen ICT-Architekturen eingesetzt. Von VLAN (Virtual LAN) über VPN (Virtual Private Network) bis Cloud, Container und Serverless.

## Voraussetzungen

Der Kurs benötigt eine [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung mit [MAAS](https://maas.io) ab Version 2.9.

Stellen Sie sich vor, Sie sind der IT-Administrator eines KMUs. Nennen wir es "Firma XYZ". 

Ihre Aufgabe ist es, ein flexibles Rechenzentrum für diese Einrichtung zu entwerfen. Sie haben beschlossen, mit MAAS als Tool Ihrer Wahl zu beginnen.
Nach dem Aufsetzen der [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung mit ein paar KVM Maschinen und VPNs können Sie beginnen.

## Übungen

* [Infrastruktur](#Infrastruktur)
* [Funktionen](#Funktionen)
* [Ressourcenpools](#Ressourcenpools)
* [VLANs](#VLANs)
* [VPNs](#VPNs)
* [Infrastruktur als Code](#Infrastruktur-als-Code)
* [Linux Namespaces und Container](https://github.com/mc-b/duk/tree/master/linuxns)
* [Microservices mit Kubernetes](https://github.com/mc-b/duk/blob/master/data/jupyter/demo/Microservices-REST.ipynb)
* [Serverless](https://github.com/mc-b/duk-demo/blob/master/data/jupyter/demo/Serverless-kubeless.ipynb)

### Infrastruktur

Als Infrastruktur wird die [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung verwendet. 

Diese Implementiert eine Private Cloud und ist mittels VPNs (WireGuard) erreichbar.

**Das Vorgehen ist wie folgt:**

VPN [WireGuard](https://www.wireguard.com/install/) auf dem lokalen Notebook/PC installieren.

Vervollständigen der WireGuard Template Datei, z.B. `wg1-template.conf` mit Ihrer WireGuard IP-Adresse und dem privaten Key.

Dazu sind die Einträge <replace IP> und <replace Key> durch Ihre Werte, laut der Liste in den Unterlagen, zu ersetzen.

Die Konfigurationsdatei sieht in etwa so aus:

    [Interface]
    Address = <replace IP>/24
    PrivateKey = <replace Key>
    
    [Peer]
    PublicKey = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    Endpoint  = yyyyyyyyyyyyyyyyyy:518zz
    
    AllowedIPs = 192.168.xx.0/24

Starten Sie die WireGuard Software und fügen Sie die ergänzte WireGuard Vorlage als Tunnel hinzu:

![](images/wireguard-add.png)

Und aktivieren Sie den Tunnel:

![](images/wireguard-activate.png)

Nun befinden wir uns im VPN, wo sich auch die [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung befindet und können diese mittels [http://w.x.y.z:5240](http://w.x.y.z:5240) anwählen.

### Funktionen
***

> [⇧ **Nach oben**](#Übungen)

![](images/vms.png)

Die erstellten VMs pro Funktion
- - -

Wenn Sie mit den Mitarbeitern über die Anforderungen sprechen, erhalten Sie eine zufällige Liste von Funktionen bzw. Systemen:

* Lieferanten, Kunden, Produkte, Bestellungen, Rechnungsstellung, Versand

Sie beschliessen, für jede Funktion eine VM zu erstellen, jeweils mit Namen der Firma, der Funktion und einer fortlaufende Nummer.

Dabei verwenden Sie folgenden Aufbau:
* XYZ-10-Lieferanten
* XYZ-11-Kunden
* XYZ-12-Produkte
* XYZ-13-Bestellungen
* XYZ-14-Rechnungsstellung
* XYZ-15-Versand

Beim Aufsetzen der [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung haben wir auch gleichzeitig [VM Hosts](https://maas.io/docs/snap/2.9/ui/adding-a-vm-host) erstellt.

Ein [VM Hosts](https://maas.io/docs/snap/2.9/ui/adding-a-vm-host) ist eine Maschine, auf der virtuelle Maschinen (VMs) ausgeführt werden. Standardmässig verwendet MAAS dazu [KVM](https://www.linux-kvm.org/).

Über den Tab `KVM` im MAAS UI ist zuerst ein VM Host auszuwählen und dort die VMs zu [erstellen](https://maas.io/docs/snap/2.9/ui/creating-and-deleting-vms#heading--add-vm-from-ui).

**Hinweis**: bei mehreren Mandanten verwenden Sie einen anderen Prefix als "XYZ" und beginnen die Nummerierung bei 20.

### Ressourcenpools
***
> [⇧ **Nach oben**](#Übungen)

![](images/resourcepools.png)

Die Resourcenpools
- - -

Wenn Sie sich die Liste der von Ihnen erstellten Funktionen ansehen und mehr mit den Mitarbeitern sprechen, stellen Sie fest, dass einige dieser Funktionen enger zusammenpassen als andere. Mit etwas Aufwand erarbeiten Sie das folgende Update für Ihr Netzwerkdesign:

* **Einkauf**: Lieferanten
* **Verkauf**: Kunden, Produkte, Bestellungen
* **Rechnungswesen**: Rechnungsstellung
* **Versand**: Versandinformationen

Sie wissen, dass die Anzahl der Maschinen, die Sie für jede der einzelnen Funktionen benötigen, je nach den tatsächlichen Anforderungen der KMU variiert. 
Sie möchten jedoch lieber Maschinen für diese verschiedenen Funktionen budgetieren, damit Sie wissen, dass Sie die Anforderungen der einzelnen Funktionen erfüllen können. Der einfachste Weg, damit umzugehen? Erstellen Sie Ressourcenpools und benennen Sie sie nach den (neuen) Abteilungen (**fett**) in Ihrer Gliederung. Auf diese Weise können Sie eine bestimmte Anzahl von Maschinen für diese Funktionen reservieren und im Laufe der Zeit die richtige Anzahl von Maschinen bestimmen, die jeder Aktivität zugewiesen werden sollen.

Über den Tab `Machines` kommen wir zu den `Resource Pools`. Dort legen Sie die "**fett** markierten Abteilungen als [Resource Pools](https://maas.io/docs/snap/2.9/ui/resource-pools#heading--add-a-resource-pool) an.

Der `Resource Pool` kann anschliessend via `Pulldownmenu`, Spalte `Pool/Note` der VM zugewiesen werden.

**Tip**: bei mehreren Mandanten, lohnt es sich, dass Mandantenkürzel als `Tag` in den VM zu hinterlegen. Mit diesem `Tag` können dann alle VM eines Mandanten selektioniert werden.

### VLANs
***
> [⇧ **Nach oben**](#Übungen)

![](images/vlans.png)

Getrennte Netzwerke mittels VLANs
- - -

Von der Geschäftsleitung, ist der Wunsch gekommen, die Netzwerke für des Rechnungswesen vom Rest zu trennen.

Die traditionelle Art, diese Netzwerke zu trennen (ausser vollständig separate Netzwerke zu erstellen ), wäre ein VLAN. Glücklicherweise unterstützt MAAS mehrere VLANs. Wenn Sie Ihrem Design eine höhere Ebene hinzufügen, finden Sie sich mit dieser aktualisierten Netzwerktopologie wieder:

* **Einkauf, Verkauf, Versand**: Lieferanten, Kunden, Produkte, Bestellungen
* **Rechnungswesen**: Rechnungsstellung, Versandinformationen

### VPNs
***
> [⇧ **Nach oben**](#Übungen)

![](images/vpns.png)

Getrennte Netzwerke mittels VPNs
- - -

*Das konventionelle VPN bezeichnet ein virtuelles privates (in sich geschlossenes) Kommunikationsnetz. Virtuell in dem Sinne, dass es sich nicht um eine eigene physische Verbindung handelt, sondern um ein bestehendes Kommunikationsnetz, das als Transportmedium verwendet wird. Das VPN dient dazu, Teilnehmer des bestehenden Kommunikationsnetzes an ein anderes Netz zu binden.*

In der [lernMAAS](https://github.com/mc-b/lernmaas) werden die VPN Informationen in [Availability zones (AZs)](https://maas.io/docs/snap/2.9/ui/availability-zones) hinterlegt.

Durch die Verwendung von mehreren VPNs können wir, wie bei VLANs, die Netzwerke trennen.

* AZ: **EinkaufVerkaufVersand**: Lieferanten, Kunden, Produkte, Bestellungen
* AZ: **Rechnungswesen**: Rechnungsstellung, Versandinformationen

Die `Availability zone` kann via `Pulldownmenu`, Spalte `Zone/Spaces` der VM zugewiesen werden.

Die Konfiguration der Notebooks/PCs erfolgt wie unter Punkt [Infrastruktur](#Infrastruktur) beschrieben.

Die Abteilung Rechnungswesen möchte zusätzlich Zugriff auf die VMs der anderen Abteilungen haben.

Das können wir durch eine Erweiterung der lokalen WireGuard Konfigurationsdatei erreichen, in dem wir eine zweite IP-Adresse (Interface) und einen zweiten Peer hinzufügen.

Die Konfigurationsdatei sieht in etwa so aus:

    [Interface]
    Address = 192.168.10.xx/24,192.168.11.xx/24
    PrivateKey = <replace Key>
    
    # 1tes VPN
    [Peer]
    PublicKey = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    Endpoint  = yyyyyyyyyyyyyyyyyy:518zz
    AllowedIPs = 192.168.10.0/24
    
    # 2tes VPN
    [Peer]
    PublicKey = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    Endpoint  = yyyyyyyyyyyyyyyyyy:518zz
    AllowedIPs = 192.168.11.0/24    
    
**Hinweis**: Auf dem WireGuard Gateway müssen die IP-Adressen den gleichen Public Key verwenden.  

### Infrastruktur als Code
***

> [⇧ **Nach oben**](#Übungen)

![](images/cloud-init.png)

- - -

Infrastruktur als Code ist ein Paradigma (grundsätzliche Denkweise) zur Infrastruktur-Automation.

Es basiert auf konsistenten und wiederholbaren Definitionen (Code) für die Bereitstellung von Systemen und deren Konfiguration.

Produkte sind u.a. Puppet, Chef, Cloud-init, Vagrant, etc.

MAAS Unterstützt dieses Paradigma mittels [Cloud-init](https://cloudinit.readthedocs.io/en/latest/). Mittels selektionieren einer oder mehrere VMs erscheint obiger [Dialog](https://maas.io/docs/snap/2.9/ui/custom-machine-setup#heading--cloud-init), wo ein Cloud-init Script angegeben werden kann.

Beispiel für Scripts sind:

    #cloud-config - Installiert den nginx Web Server
    packages:
     - nginx



    #cloud-config - Erstellt eine Intro Seite und installiert den Apache Web Server
    packages:
     - git
    runcmd:
     - git clone https://github.com/mc-b/lernmaas /home/ubuntu/lernmaas
     - git clone https://github.com/mc-b/virtar /home/ubuntu/virtar
     - cd /home/ubuntu/virtar
     - sudo bash -x /home/ubuntu/lernmaas/helper/intro
     - sudo cp -rp images /var/www/html/ 

**Links**

* [Offizielle Cloud-init Beispiele](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)
* [lernMAAS und Cloud-init in der Public Cloud](https://github.com/mc-b/lernmaas/tree/master/doc/Cloud)
