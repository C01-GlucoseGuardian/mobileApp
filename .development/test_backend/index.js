const express = require("express")
const app = express();
const port = 3000;

const ALWAYS_ERR = false;

app.post("/notifica/get", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    id: 0,
    messaggio: "",
    data: "2022-10-30",
    ora: "22:10:15",
    stato: 0,
    pazienteOggetto: "AAABB",
  });
});

app.post("/notifica/getByPaziente", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    list: [
      {
        id: 0,
        messaggio: "",
        data: "2022-10-30",
        ora: "22:10:15",
        stato: 0,
        pazienteOggetto: "AAABB",
        pazienteDestinatario: "CCBB",
        tutoreDestinatario: "CCBB",
        adminDestinatario: "CCBB",
        dottoreDestinatario: "CCBB",
      },
    ],
  });
});

app.post("/auth/login", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    idUtente: "AABBCC",
    tipoUtente: 0,
    token: "XXXXX",
  });
});

app.post("/terapia/get", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    id: 0,
    idPaziente: "ABABABAB",
    idDottore: "ABABABAB",
    dataInizio: "2022-10-30",
    farmaci: [
      {
        idFarmaco: 0,
        dosaggio: 0,
        orarioAssunzione: "22:10",
        viaDiSomministrazione: "via orale",
        noteAggiuntive: "Caso caso",
      },
    ],
  });
});

app.post("/terapia/getByPaziente", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    id: 0,
    idPaziente: "ABABABAB",
    idDottore: "ABABABAB",
    dataInizio: "2022-10-30",
    farmaci: [
      {
        idFarmaco: 0,
        dosaggio: 0,
        orarioAssunzione: "22:10",
        viaDiSomministrazione: "via orale",
        noteAggiuntive: "Caso caso",
      },
    ],
  });
});

app.post("/feedback/send", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    msg: "ok",
  });
});

app.post("/assunzioneFarmaco/get", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    id: 0,
    idFarmaco: 0,
    dosaggio: 0,
    orarioAssunzione: "22:15",
    viaDiSomministrazione: "orale",
    noteAggiuntive: "...",
  });
});

app.post("/assunzioneFarmaco/getByPaziente", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    list: [
      {
        idFarmaco: 0,
        dosaggio: 0,
        orarioAssunzione: "22:15",
        viaDiSomministrazione: "orale",
        noteAggiuntive: "...",
        terapiaId: 0,
      },
    ],
  });
});

app.get("/paziente/get", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    codiceFiscale: "AABBCC",
    nome: "",
    cognome: "",
    dataNascita: "2022-12-31",
    indirizzo: "...",
    telefono: "+39xxxx",
    email: "XXX@yyy.zzz",
    sesso: "M",
    tipoDiabete: "XXX",
    comorbilita: "XXX",
    farmaciAssunti: "XXX",
    periodoDiMonitoraggio: 0,
    numeriUtili: [
      {
        numero: "XXX",
      },
    ],
  });
});

app.post("/dottore/getByPaziente", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    codiceFiscale: "AABBCC",
    nome: "",
    cognome: "",
    dataNascita: "2022-12-31",
    indirizzo: "...",
    telefono: "+39xxxx",
    email: "XXX@yyy.zzz",
    sesso: "M",
    specializzazione: "XXX",
    codiceAlbo: "XXX",
    nomeStruttura: "XXX",
    indirizzoStruttura: "XXX",
    stato: 0,
  });
});

app.post("/farmaco/get", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    id: 0,
    nomeFarmaco: "blabla",
    principioAttivo: "blabla",
    confezione: "blabla",
  });
});

app.post("/glicemia/getLast", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  res.status(200).json({
    livelloGlucosio: 300,
    timestamp: 1675164427,
  });
});

app.post("/glicemia/getRange", (req, res) => {
  console.log(req.body);

  if (ALWAYS_ERR) {
    return res.status(500).json({
      msg: "errore critico",
    });
  }

  function rn(min, max) {  
    return Math.floor(
      Math.random() * (max - min) + min
    )
  }
  
  
  var l = [];
  var random = rn(10, 80);

  for (var i = 0; i < random; i++) {
    var randomValue = rn(80, 170);
    l.push({
      livelloGlucosio: randomValue,
      timestamp: 1675164427,
    });
  }

  res.status(200).json({
    list: l
  });
});

app.listen(port, () => {
  console.log("running");
});
