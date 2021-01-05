# Beispiele zum Kurs: [Von der Virtualisierung über Cloud und Container bis Serverless («VIRTAR»)](https://www.digicomp.ch/weiterbildung/development-trainings/software-engineering-trainings/it-architektur/softwarearchitektur/design-organisation/kurs-von-der-virtualisierung-ueber-cloud-und-container-bis-serverless)

Virtualisierung ist die Basistechnologie hinter den Cloud-Technologien und wird heute in unterschiedlichster Form in modernen ICT-Architekturen eingesetzt. Von VLAN (Virtual LAN) über VPN (Virtual Private Network) bis Cloud, Container und Serverless.

## Voraussetzungen

Der Kurs benötigt eine [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung.

Stellen Sie sich vor, Sie sind der IT-Administrator eines KMUs. Nennen wir es "Firma XYZ". 

Ihre Aufgabe ist es, ein flexibles Rechenzentrum für diese Einrichtung zu entwerfen. Sie haben beschlossen, mit MAAS als Tool Ihrer Wahl zu beginnen.
Nach dem Aufsetzen der [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung mit ein paar KVM Maschinen und VPNs können Sie beginnen.

## Übungen

* [Funktionen](#Funktionen)
* [Ressourcenpools](#Ressourcenpools)


### Verbinden mit [lernMAAS](https://github.com/mc-b/lernmaas) Umgebung


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

* **Einkauf, Verkauf, Versand**: Lieferanten, Kunden, Produkte, Bestellungen, Versandinformationen
* **Rechnungswesen**: Rechnungsstellung

