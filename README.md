# Decentralized AI Model Hub
**Created by Kumissay Zhalmagambetova SE-2315**

## Introduction
The **Decentralized AI Model Hub** is a blockchain-powered decentralized application (dApp) designed for Assignment 2 of the Blockchain Technologies course. It facilitates the listing, purchase, and review of AI models in a secure, transparent environment.

### Key Features
- **Model Listing**: Users can list AI models with details such as title, description, and price.
- **Model Purchase**: Users can securely purchase AI models, with payments routed directly to the model owner.
- **Model Reviews**: Users can review purchased AI models, influencing their public ratings.
- **Earnings Management**: Model creators can withdraw their earnings from the platform.
- **Detailed Model Information**: Users can access comprehensive details about any listed AI model.

## Smart Contract Overview
The project includes a Solidity smart contract with the following core functionalities:

### Contract Methods
1. `addModel(string memory title, string memory details, uint256 price)`
   - Allows users to list their AI models.
2. `buyModel(uint256 modelId)`
   - Enables the purchase of an AI model via its unique ID.
3. `reviewModel(uint256 modelId, uint8 rating)`
   - Lets users provide ratings (1-5 stars) for models they have purchased.
4. `withdrawEarnings()`
   - Allows model owners to withdraw their earnings.
5. `fetchModelDetails(uint256 modelId)`
   - Provides detailed information about a specific AI model.

## User Interface Integration
The dApp frontend, built with JavaScript and **Web3.js**, offers:

- A form to submit AI models for listing.
- A catalog of available models with purchase options.
- A rating submission interface for purchased models.
- A withdrawal functionality for model earnings.
- A detailed view of each model's attributes.

## How to Use the Application

### Requirements
- **Node.js**
- **Ganache**
- **MetaMask**
- **Remix IDE**
- **Visual Studio Code**

### Installation Guide

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Install dependencies**:
   ```bash
   npm install
   npm install -g truffle
   ```

3. **Install Web3.js**:
   ```bash
   npm install web3
   ```

4. **Compile and deploy contracts**:
   ```bash
   truffle compile
   truffle migrate
   ```

5. **Run the application**:
   ```bash
   npm start
   ```

## Project Layout
```plaintext
DecentralizedAIHub/
├── contracts/
│   └── AIHubContract.sol
├── frontend/
│   ├── main.js
│   └── index.html
├── README.md
└── LICENSE
```

## Example Workflow
1. **List an AI Model**:
   - Use the form on the dApp to provide the model's name, description, and price.
2. **Purchase a Model**:
   - Browse the model list and select "Buy" for the desired model.
3. **Review a Model**:
   - After purchasing, submit a review for the model via the rating form.
4. **Withdraw Earnings**:
   - Model creators can withdraw accumulated earnings from sales.

## Screenshots
Explore the screenshots in the repository folder to understand the UI and features better. **Viewable in file order 1-14**.

## Licensing
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Resources
1. [Web3.js Official Docs](https://docs.web3js.org/)
2. [Blockchain for Developers](https://docs.web3js.org/guides/smart_contracts/smart_contracts_guide)
3. [Ganache Setup](https://trufflesuite.com/ganache/)
4. [Remix and MetaMask Integration Guide](https://medium.com/@kacharlabhargav21/using-ganache-with-remix-and-metamask-446fe5748ccf)
