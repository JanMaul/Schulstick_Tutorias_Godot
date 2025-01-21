# Start

Wilkommen zum ersten Tutorial für Godot. Heute werden wir einen einfachen Sidescroller Platformer erstellen.

## Einleitung

In diesem Tutorial wirst du Godot kennenlernen. Godot ist eine Open Source Game Engine, welche 2D und 3D Spiele erstellen kann. Godot benutzt eine Eigene Programmiersprache namens "GDscript", welche sich stark an Python orientiert. Als Alternative kann man auch C# benutzen. Dieses Tutorial wird sich jedoch auf GDscript fokussieren.

Zuerst werde ich dir einige hilfreiche Resourcen zeigen, welche du benutzen kannst wenn du Fragen über GDscript oder den Editor hast.

__Hilfe 1: Die Dokumentation__

um diese zu erreichen kannst du im codeeditor einfach auf einen begriff rechtsklicken, und dann im kontextmenü auf die Option "Symbol Nachschlagen" Klicken. Dann sollte sich ein neuer Tab öffnen, wo du hoffentlich eine Antwort auf deine Frage bekommst. Diese Option ist allerdings sehr spezifisch.

![Im Kontextmenü ist die Unterste Auswahl "Symbol Nachschlagen"](7c7a94f0d44c016c9a920fc1661afc9287676723.png)

Alternativ kannst du auch nach der Dokumentation googlen, da findest du jedoch oft leider nicht dass, wonach du suchst.

__Hilfe 2: Ofizielle Tutorials__

diese kannst du auf der Website der Dokumentation finden (https://docs.godotengine.org/de/4.x/getting_started/step_by_step/index.html). Diese sind garantiert funktional und zeigen viele schwere funktionalitäten besser als irgendwo sonst.

Jetzt fangen wir aber an.

# Neues Projekt erstellen

Wenn du Godot geöffnet hast, siehst du zuerst dieses Fenster.

<details>
<summary> __Bild__ </summary>

![Ein dunkelblaues fenster ist geöffnet, das Godot Logo ist in der Ecke.](b24a3f9567653e14c16d155a8733be0b7702bd77.png)

</details>

Nun drückst du auf das Weiße "+"-Symbol woraufhin sich ein neues Menü öffnen sollte. Wähle dort einen Namen und einen Projektpfad deiner Wahl.

<details>
<summary> __Bild__ </summary>

![Das "Projektname" feld ist Ausgewählt](7dbe024234406fe4b51055c4332edc1362a2d2ef.png)

</details>

Es gibt vor dem Erstellen des projektes einige Einstellungen. 

1. Renderer: Alle Renderer sollten gut funktionieren. Da der Forward+ Renderer die meisten features hat, werde ich ihn für dieses Projekt benutzen. Du kannst ihn notfalls später noch ändern.

2. Metadaten der Versionsverwaltung: Hier gibt es entweder Git oder Nichts, diese Einstellung kann man einfach auf "Git" belassen.

Wenn du noch kein Projekt erstellen kannst musst du einen anderen Ordner wählen, oder links neben dem Projektnamen auf "Ordner Erstellen" Klicken.

Wenn du dass geschafft hast, musst du jetzt nur noch auf Erstellen und Bearbeiten klicken, und du bist bereit für das Tutorial.

## Erste Schritte im Editor

![In der Mitte des Fensters ist ein 3D "grid" mit farbig hervorgehobenen Axen](060d2f6df48ec5efa9bbeef45106cefcfe8b103c.png)

Wenn du den Editor öffnest, sollte das Fenster nun so aussehen. Zuerst werde ich jetzt die einzelnen bereiche des Editors erklären. Wenn du ein Problem mit dem Editor hast, kannst du einfach hierhier zurückkehren.

<details>
<Summary> 1. Node Tree </Summary>

Hier werden sich Später alle Objekte im Spiel befinden. Godot nutzt ein Nodesystem, eine Node kann zum beispiel ein Spielercharacter, aber auch ein Bild, 3D objekt, Text und vieles andere sein. Nodes bilden quasi die Basis für den Editor

![Dieser Abschnitt befindet sich Links oben](1b2d7f9b8c2271b368f4190ed38fb3001e1835ca.png)
</details>


<details>
<summary> 2. Dateiexplorer </summary>

Dieser bereich enthält alle "Assets" des Spiels, das enthält z.B. Skripte, Sprites (Bilder), 3D Modelle, Szenen und mehr. Das wirst du noch gut kennenlernen.

![Der Dateiexplorer befindet sich direkt unter dem Node-Tree](48ac843a913b61bd473f6ce40cb0cdcde47786a3.png)

</details>


<details>
<summary> 3. Modus-Tabs </summary>

Dort kannst du zwischen 3D, 2D Bearbeitung und zudem in den eingebauten Scripteditor und Assetstore wechseln. Wichtig: Anders als bei Unity gibt es bei Godot _Keine_ eingebauten gemischten 2d und 3d szenen. Wir werden in diesem Tutorial nur die 2D ansicht un den Scripteditor benutzen

![Die Modus-Tabs befinden sich ganz oben mittig](38867d204a57053a802b7450eb2ab36f75ecb9b2.png)

</details>

<details>
<summary> 4. Inspektor </summary>

Hier kannst du direkt im Editor attribute von Nodes verändern, so dass du sie nicht über Skripte anpassen musst. Attribute sind zum beispiel die Farbe, die Position, aber auch das Sprite und die Größe einer Node.

Der Inspektor teilt sich standardmäßig einen Bereich mit den Node-Tabs, und dem Bearbeitungsverlauf.

![Der Inspektor ist der Erste tab der oberen Rechten Leiste](dcff633f9f66e793ebcca85ee96a614cc22cf77e.png)

</details>

<details>
<summary> 5. Node-Tab </summary>

Der Node-Tab enthält hauptsächlich Signale. Signale sind in godot ein Weg, um Daten zwischen Nodes auszutauschen. Es gibt eingebaute signale, du kannst aber auch deine eigenen Definieren. Signale werden oft zum beispiel dazu benutzt, um Gegner mitzuteilen dass sie vom Spieler besiegt worden sind, oder um in Menüs beim anklicken eines buttons code auszuführen. Sie sind also ein sehr Wichtiges konzept in Godot.

Der Andere inhalt - "Gruppen" kann für dieses Tutorial gänzlich ignoriert werden. Sie sind dazu da, auszuführung von Code auf mehrere Nodes einfach zu machen, was jedoch oft bessere Alternativen hat.

Der Node-Tab ist in der Rechten oberen Leiste der Zweite tab.

![Befindet sich direkt neben dem Inspektor Tab](dcff633f9f66e793ebcca85ee96a614cc22cf77e.png)

</details>

<details>
<summary> 6. Verlauf-Tab </summary>

Dieser Tab zeigt einen Verlauf kürzlicher Änderungen. Das ist z.B. nützlich, wenn du herausfinden möchtest welche Änderung am Projekt einen Fehler eingebracht hat.

Er Befindet sich in der Rechten Oberen leiste als Dritter Tab.

![Befindet sich direkt neben dem Node Tab](dcff633f9f66e793ebcca85ee96a614cc22cf77e.png)

</details>

<details>

<summary> 7. Untere Tabs </summary>

Diese unteren Tabs enthalten viele nützliche Tools, wie z.B. eine Ausgabeleiste, ein Debugger, sowie tools welche spezifisch zur momentan Ausgewählten Node gehören. Wenn du z.B. ein Animiertes Sprite auswählst, erscheint dort ein Animations tool.

![befinden sich ganz unten mittig](f8baa4698a8b58015a35fc22ce14cddd5768541f.png)

</details>


<details>

<summary> 8. Importieren Tabs </summary>

Diese Einstellungen sind nur in sehr spezifischen Situationen wichtig, zum beispiel um die Qualität von 2D Sprites oder SVGs anzupassen

</details>

<details>

<summary> </summary>

</details>

# Assets Importieren

Da niemand ein Tutorial durcharbeiten möchte, dass 2 stunden lang nur Weiße Boxen enthält, werden wir nun zuerst ein paar schöne Sprites importieren.