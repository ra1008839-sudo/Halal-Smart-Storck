// Dummy data for demo (API integrate karna padega later)

// GPT Power
document.getElementById("gptPower").innerHTML = `
  1. Reliance - Buy<br>
  2. TCS - Buy<br>
  3. Infosys - Wait
`;

// Stop Loss
document.getElementById("stopLoss").innerText = "Active on Reliance @ ₹2400 (Trail Mode)";

// News
document.getElementById("news").innerText = "Breaking: Market opening strong due to US cues.";

// Index Data
document.getElementById("indices").innerHTML = `
  Nifty 50: 24,300 ▲<br>
  Sensex: 81,000 ▲<br>
  Bank Nifty: 52,100 ▼
`;

// Halal Stocks
document.getElementById("halalStocks").innerHTML = `
  TCS, Infosys, Wipro, HCL Tech, Tech Mahindra
`;

// World Market
document.getElementById("usMarket").innerText = "Dow Jones +150 pts";
document.getElementById("crudeOil").innerText = "$82/barrel";
document.getElementById("worldMarket").innerText = "Global markets stable";
document.getElementById("giftNifty").innerText = "24,400 (+100)";
document.getElementById("dollar").innerText = "₹83.20";

// Share button
function shareApp() {
  let url = "https://yourapp.com";
  let text = "Check out Halal Smart Stock App 📊: " + url;
  window.open(https://wa.me/?text=${encodeURIComponent(text)}, "_blank");
}

// Logout
function logout() {
  window.location.href = "login.html";
}
