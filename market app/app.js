// app.js - Dashboard logic (copy-paste safe demo)
document.getElementById('year').textContent = new Date().getFullYear();

// hide splash after 3s
setTimeout(()=>{ const s=document.getElementById('splash'); if(s) s.style.display='none'; }, 3000);

// Auth UI: read local user saved by login
(function authUI(){
  // try localStorage first
  const stored = localStorage.getItem('hss_user');
  const slot = document.getElementById('auth-slot');
  if (stored) {
    const u = JSON.parse(stored);
    slot.innerHTML = `<div style="display:flex;align-items:center;gap:8px">
      <img src="${u.photo||''}" style="width:34px;height:34px;border-radius:6px"/>
      <div>${u.name||u.email}</div>
      <button class="btn ghost" onclick="signOutUI()">Logout</button>
    </div>`;
  } else {
    slot.innerHTML = <button class="btn" onclick="window.location='login.html'">Login</button>;
  }

  // If firebase auth present, also watch state
  if (window.firebase && firebase.auth) {
    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        const info = { uid:user.uid, name:user.displayName, email:user.email, photo:user.photoURL };
        localStorage.setItem('hss_user', JSON.stringify(info));
        slot.innerHTML = `<div style="display:flex;align-items:center;gap:8px">
          <img src="${info.photo||''}" style="width:34px;height:34px;border-radius:6px"/>
          <div>${info.name||info.email}</div>
          <button class="btn ghost" onclick="signOutUI()">Logout</button>
        </div>`;
      }
    });
  }
})();

// Demo data load (replace with real API fetch later)
function loadDemoData(){
  document.getElementById('gptPower').innerHTML = '<ol><li>INFY — 78</li><li>TCS — 73</li><li>HDFCBANK — 69</li></ol>';
  document.getElementById('tslBox').textContent = 'Demo trailing SL: INFY ₹1450';
  document.getElementById('halalList').innerHTML = '<li>TCS</li><li>INFY</li><li>HDFCBANK</li><li>ITC</li>';
  document.getElementById('indices').textContent = 'NIFTY: 24,500 • BANKNIFTY: 52,450 • SENSEX: 80,780';
  document.getElementById('news').innerHTML = '<div>Demo: Market opens positive.</div>';
  document.getElementById('usMarket').textContent = 'Dow +120';
  document.getElementById('crude').textContent = '$83.50';
  document.getElementById('gift').textContent = '24,420';
  document.getElementById('dxy').textContent = '₹83.10';
}
loadDemoData();

document.getElementById('refreshBtn').addEventListener('click', ()=> {
  // placeholder: re-run demo load (later replace with API calls)
  loadDemoData();
  alert('Demo refreshed — replace with live API calls later');
});

// WhatsApp share
document.getElementById('shareBtn').addEventListener('click', ()=> {
  const text = Halal Smart Stock - try this demo app: ${location.href};
  const url = 'https://wa.me/?text=' + encodeURIComponent(text);
  window.open(url, '_blank');
});
