// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// The AIModelMarketplace contract facilitates listing, purchasing, and rating AI models.
contract AIModelMarketplace {
    // Struct to store details of each AI model
    struct Model {
        string name;              // Name of the AI model
        string description;       // Description of the AI model
        uint256 price;            // Price of the AI model in wei
        address payable creator;  // Address of the creator (model owner)
        uint8 ratingCount;        // Total number of ratings received
        uint256 totalRating;      // Cumulative rating value (used to calculate average rating)
    }

    // Mapping to store models by their unique ID
    mapping(uint256 => Model) public models;

    // Counter to keep track of the total number of models listed
    uint256 public modelCount;

    // Address of the contract owner
    address public owner;

    // Total funds held by the contract (accumulated from purchases)
    uint256 public funds;

    // Modifier to restrict certain functions to only the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    // Constructor to initialize the contract
    constructor() payable {
        owner = msg.sender; // Set the contract deployer as the owner
        modelCount = 0;     // Initialize model count
        funds = 0;          // Initialize funds
    }

    // Function to list a new AI model on the marketplace
    function listModel(string memory _name, string memory _description, uint256 _price) public {
        modelCount++; // Increment model count
        models[modelCount] = Model({
            name: _name,              // Name of the model
            description: _description, // Description of the model
            price: _price,             // Price in wei
            creator: payable(msg.sender), // Creator's address
            ratingCount: 0,            // Initialize rating count to 0
            totalRating: 0             // Initialize total rating to 0
        });
    }

    // Function to purchase a model by its ID
    function purchaseModel(uint256 _modelId) public payable {
        Model storage model = models[_modelId]; // Fetch the model
        require(msg.value == model.price, "Incorrect payment amount"); // Validate payment amount

        // Transfer payment to the model creator
        model.creator.transfer(msg.value);

        // Update the contract's funds (for owner withdrawal)
        funds += msg.value;
    }

    // Function to rate a purchased model
    function rateModel(uint256 _modelId, uint8 _rating) public {
        require(_rating >= 1 && _rating <= 5, "Rating must be between 1 and 5"); // Ensure valid rating range

        Model storage model = models[_modelId]; // Fetch the model
        model.ratingCount++; // Increment the rating count
        model.totalRating += _rating; // Add the rating to the total
    }

    // Function to retrieve details of a specific model
    function getModelDetails(uint256 _modelId) 
        public 
        view 
        returns (string memory, string memory, uint256, address, uint8, uint256) 
    {
        Model memory model = models[_modelId]; // Fetch the model
        return (
            model.name,          // Name of the model
            model.description,   // Description of the model
            model.price,         // Price of the model
            model.creator,       // Creator's address
            model.ratingCount,   // Number of ratings received
            model.totalRating    // Total cumulative rating
        );
    }

    // Function for the contract owner to withdraw accumulated funds
    function withdrawFunds() public onlyOwner {
        uint256 amount = funds; // Store the current funds
        funds = 0;              // Reset funds to 0
        payable(owner).transfer(amount); // Transfer the funds to the owner
    }
}
