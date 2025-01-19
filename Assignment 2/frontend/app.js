// Initialize Web3
const web3 = new Web3(Web3.givenProvider || "http://localhost:8545");

// Replace this with the contract ABI and address after deployment
const contractABI = [] // ABI goes here
const contractAddress = ""; // here goes contactAdress

const contract = new web3.eth.Contract(contractABI, contractAddress);

// Connect to MetaMask
async function connectMetaMask() {
    await window.ethereum.request({ method: 'eth_requestAccounts' });
    loadModels();
}

// Function to List a New Model
document.getElementById("listForm").onsubmit = async (event) => {
    event.preventDefault();

    const name = document.getElementById("name").value;
    const description = document.getElementById("description").value;
    const price = web3.utils.toWei(document.getElementById("price").value, 'ether');

    const accounts = await web3.eth.getAccounts();
    await contract.methods.listModel(name, description, price).send({ from: accounts[0] });
    alert('Model listed successfully!');
    loadModels();
};

// Function to Load Models
async function loadModels() {
    const modelList = document.getElementById("modelList");
    const modelCount = await contract.methods.modelCount().call();

    modelList.innerHTML = '';  // Clear current list
    for (let i = 1; i <= modelCount; i++) {
        const model = await contract.methods.getModelDetails(i).call();

        const li = document.createElement("li");
        li.innerHTML = `
            <strong>${model[0]}</strong><br>
            Description: ${model[1]}<br>
            Price: ${web3.utils.fromWei(model[2], 'ether')} ETH<br>
            Creator: ${model[3]}<br>
            Rating: ${model[4]} ratings, Avg: ${model[5] / (model[4] || 1)}<br>
            <button onclick="viewModelDetails(${i})">View Details</button>
            <button onclick="purchaseModel(${i})">Purchase</button>
        `;
        modelList.appendChild(li);
    }
}

// Function to View Model Details
async function viewModelDetails(modelId) {
    try {
        const model = await contract.methods.getModelDetails(modelId).call();
        alert(`
            Model Name: ${model[0]}
            Description: ${model[1]}
            Price: ${web3.utils.fromWei(model[2], 'ether')} ETH
            Creator: ${model[3]}
            Total Ratings: ${model[4]}
            Total Rating Points: ${model[5]}
            Average Rating: ${model[5] / (model[4] || 1)}
        `);
    } catch (error) {
        console.error("Error fetching model details:", error);
        alert('Failed to fetch model details.');
    }
}

// Function to Purchase a Model
async function purchaseModel(modelId) {
    const accounts = await web3.eth.getAccounts();
    const price = await contract.methods.models(modelId).call().then(model => model.price);

    await contract.methods.purchaseModel(modelId).send({ from: accounts[0], value: price });
    alert('Model purchased successfully!');
    loadModels();
}

// Function to Rate a Model
document.getElementById("rateForm").onsubmit = async (event) => {
    event.preventDefault();

    const modelId = document.getElementById("rateModelId").value;
    const rating = document.getElementById("rating").value;

    const accounts = await web3.eth.getAccounts();
    await contract.methods.rateModel(modelId, rating).send({ from: accounts[0] });
    alert('Model rated successfully!');
    loadModels();
};

//Debug
document.getElementById("listForm").onsubmit = async (event) => {
    event.preventDefault();
    try {
        const name = document.getElementById("name").value;
        const description = document.getElementById("description").value;
        const price = web3.utils.toWei(document.getElementById("price").value, 'ether');

        console.log("Listing Model:", { name, description, price });

        const accounts = await web3.eth.getAccounts();
        console.log("Using Account:", accounts[0]);

        await contract.methods.listModel(name, description, price).send({ from: accounts[0] });
        alert('Model listed successfully!');
        loadModels();
    } catch (error) {
        console.error("Error Listing Model:", error);
        alert("Failed to list the model. Check console for details.");
    }
};

// Function to display the funds in the contract
async function displayFunds() {
    const funds = await contract.methods.funds().call();
    const fundsInfo = document.getElementById("fundsInfo");
    fundsInfo.innerText = `Contract Funds: ${web3.utils.fromWei(funds, 'ether')} ETH`;
}

// Function to withdraw funds
document.getElementById("withdrawFundsButton").onclick = async () => {
    try {
        const accounts = await web3.eth.getAccounts();
        await contract.methods.withdrawFunds().send({ from: accounts[0] });
        alert('Funds withdrawn successfully!');
        displayFunds();
    } catch (error) {
        console.error("Error withdrawing funds:", error);
        alert('Failed to withdraw funds. Ensure you are the contract owner.');
    }
};

// Call displayFunds on page load
displayFunds();

connectMetaMask();
