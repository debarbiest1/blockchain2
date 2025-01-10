## Blockchain Task 2
Collaborators: Kumissay Zhalmagambetova (SE-2315)

This project is a unique implementation of a decentralized application (dApp) for an AI Model Marketplace. The platform enables users to browse, purchase, and review AI models using the Ethereum blockchain.

blockchain2/<br>
├── contracts/<br>
│   └── marketplace.sol  <br>
├── scripts/<br>
│   └── deploy.js <br>
├── frontend/<br>
│   ├── index.html <br>
│   ├── app.js       <br>
│   ├── styles.css        <br>
├── artifacts/            <br>
├── hardhat.config.js      <br>
├── package.json          <br>
└── README.md          <br>


1. Write in terminal
   ```
   git clone https://github.com/debarbiest1/blockchain2/
   ```
2. In new terminal write this code
   ```
   npm install
   npm init -y
   npx hardhat compile
   npx hardhat node
   npx hardhat run scripts/deploy.js
   ```
3. Update frontend/app.js with your contract address and ABI:
   ```
   const contractAddress = "YOUR_CONTRACT_ADDRESS"; const contractABI = [ // Contract ABI goes here ];
   ```
4. Open it in local server using: python -m http.server Visit http://localhost:8000


## Usage

Listing AI Models

Creators can list AI models using the addModel function via the smart contract. Each listing requires the model name, description, price, and a downloadable file link.

Purchasing AI Models

Users purchase models using the purchaseModel function. The Ethereum transaction must match the listed price.

Rating AI Models

After purchase, users can leave feedback using the rateModel function, specifying a rating and optional comment.

Withdraw Earnings

Creators can use the withdrawEarnings function to claim their earnings securely

## License

This project is licensed under the MIT License.
