import { dbank_backend } from "../../declarations/dbank_backend";


window.addEventListener("load", async ()=>{
    update();
});

document.querySelector("form").addEventListener("submit", async (event)=>{
    event.preventDefault()
    await dbank_backend.compound();
    const inputAmount = parseFloat(document.getElementById("input-amount").value);
    const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);
    const button = event.target.querySelector("#submit-btn");

    button.setAttribute("disabled", true);
    if (document.getElementById("input-amount").value.length !== 0){
        await dbank_backend.topUp(inputAmount);
    } else if (document.getElementById("withdrawal-amount").value.length !== 0){
        await dbank_backend.withDraw(outputAmount);
    }
    
    update();
    button.removeAttribute("disabled");
    document.getElementById("input-amount").value = "";
    document.getElementById("withdrawal-amount").value = "";
});

async function update(){
    const currentAmount = await dbank_backend.checkBalance();
    document.getElementById("value").innerText = currentAmount.toFixed(2);
}