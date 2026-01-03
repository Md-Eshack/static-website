const yearEl = document.getElementById("year");
yearEl.textContent = new Date().getFullYear();

const statusEl = document.getElementById("apiStatus");
const apiUrlEl = document.getElementById("apiUrl");
const checkBtn = document.getElementById("checkBtn");

function setStatus(type, text){
  statusEl.className = `status ${type}`;
  statusEl.textContent = text;
}

async function checkApi(){
  const url = apiUrlEl.value.trim();
  if(!url){
    setStatus("fail", "Please paste API URL");
    return;
  }
  setStatus("loading", "Checking...");
  try{
    const res = await fetch(url, { method: "GET" });
    if(!res.ok) throw new Error(`HTTP ${res.status}`);
    const contentType = res.headers.get("content-type") || "";
    let bodyText = "";
    if(contentType.includes("application/json")){
      const json = await res.json();
      bodyText = json.status || JSON.stringify(json);
    } else {
      bodyText = (await res.text()).slice(0, 80);
    }
    setStatus("ok", `API OK: ${bodyText}`);
  }catch(e){
    setStatus("fail", `API Failed: ${e.message}`);
  }
}

checkBtn.addEventListener("click", checkApi);
