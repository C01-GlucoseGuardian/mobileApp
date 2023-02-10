[![Codemagic build status](https://api.codemagic.io/apps/63d7f375d43a04b2091796b1/63d7f375d43a04b2091796b0/status_badge.svg)](https://codemagic.io/apps/63d7f375d43a04b2091796b1/63d7f375d43a04b2091796b0/latest_build)
# Glucose Guardian

#### Introduzione
L'applicazione della piattaforma "Glucose Guardian" mira a dare un'interfaccia semplice e pulita alla stessa, essa sarà disponibile per Pazienti e Tutori.

### Installazione (Play store)
E' possibile scaricare sul proprio dispositivo l'applicaione dal play store, una volta installata essa sarà usabile al 100%

### Installazione (Compilazione)

Per compilare l'applicazione per Android è necessario avere installato i tool di compilazione di base e l'sdk di Android.
Successivamente bisognerà installare flutter seguendo le indicazioni sul [sito ufficiale](https://docs.flutter.dev/get-started/install)

Per compilare l'applicazione in modalità release bisognerà generare un keystore con il comando:
```keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000```

A questo punto rinominare il file `android/key.properties.example` in `android/key.properties` e cambiare i parametri al suo interno per fare riferimento al keystore appena generato.

Per compilare un apk per android in modalità debug sarà necessario eseguire il comando:
```flutter build apk```
Invece per compilarlo in modalità release(solo dopo aver creato e impostato il keystore) sarà necessario eseguire:
```flutter build apk --release```
L'apk compilato sarà disponibile al percorso indicato da flutter dopo la corretta esecuzione di uno dei comandi sopra, a quel punto sarà possibile spostarlo sul telefono e installarlo come un normale apk.

### Manuale d'uso (Paziente)
Una volta installata l'applicazione e avviata ci si troverà di fronte ad una introduzione di 3 pagine, cliccando sul bottone "Avanti" in basso a destra sarà possibile proseguire nell'introduzione, una volta completata ci si troverà di fronte alla pagina di login, fatto il login si arriverà alla home.
Per prima cosa bisognerà collegare un dispositivo cgm usando l'icona in alto a destra, che aprirà una schermata che cercherà un dispositivo, una volta trovato sarà necessario cliccarci sopra e attendere la connessione.

Nella pagina principale saranno mostrate le misurazioni dei livelli di glucosio del giorno corrente, usando la barra superiore sarà possibile muoversi all'interno delle misurazioni dell'ultima settimana giorno per giorno.

E' possibile muoversi all'interno delle schermate usando la barra inferiore, la prima schermata (home) è quella di cui scritto precedentemente, la seconda invece rappresenterà l'agenda ossia la lista dei farmaci da prendere, poi vi sarà la schermata delle notifiche, il profilo dottore e il profilo del paziente.

##### Agenda
Qui è mostrata la terapia attuale, per segnare un farmaco come assunto bisognerà fare un swipe verso sinistra sulla card del farmaco e poi cliccare sull'icona che comparirà.
In alto a destra sarà disponibile il tasto "Invia feedback terapia" che consentirà di interagire con il proprio dottore inviando un feedback sulla terapia in corso.

##### Notifiche
Qui sono mostrate le notifiche "salvavita", è possibile segnare una notifica come letta facendo uno swipe verso sinistra sulla card della notifica e poi cliccando sull'icona che comparirà.

##### Profilo Dottore
Qui sono mostrati i dati di riepilogo del dottore, con il bottone invia feedback terapia in basso a sinistra.

##### Profilo Paziente
Qui è mostrato un riepilogo dei dati del paziente, con un bottone per effettuare il logout.

#### Schermata Invio feedback terapia
In questa schermata saranno presenti 4 input box in cui rispondere a delle domande poste, queste domande saranno inviate al proprio dottore tramite il bottone sottostante "INVIA"

### Manuale d'uso (Tutore)
Una volta installata l'applicazione e avviata ci si troverà di fronte ad una introduzione di 3 pagine, cliccando sul bottone "Avanti" in basso a destra sarà possibile proseguire nell'introduzione, una volta completata ci si troverà di fronte alla pagina di login, fatto il login si arriverà alla home.

Qui sarà disponibile la lista dei pazienti assistiti, cliccando su uno di essi si accederà ai suoi dati personali (vedasi manuale d'uso paziente, è tutto uguale, tranne che le sue notifiche non saranno ovviamente mostrate).

In alto a destra ci sarà un icona che porterà alla schermata delle notifiche del tutore, è possibile segnare una notifica come letta facendo uno swipe verso sinistra sulla card della notifica e poi cliccando sull'icona che comparirà.