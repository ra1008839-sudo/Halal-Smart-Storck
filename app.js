async function getSignal() {
  const res = await fetch("/get-signal");
  const data = await res.json();
  document.getElementById("result").innerHTML = `
    <p>🕒 Date: ${data.date}</p>
    <p>🔔 Signal: <b>${data.signal}</b></p>
    <p>📊 Volume: ${data.volume}</p>
  `;

  // 🔔 Beep sound on signal
  const beep = new Audio('https://actions.google.com/sounds/v1/alarms/beep_short.ogg');
  beep.play();
}
