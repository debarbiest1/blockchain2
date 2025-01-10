// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract marketplace {
    struct Model {
        uint256 id;
        string name;
        string description;
        uint256 price;
        address payable creator;
        uint256 ratingSum;
        uint256 ratingCount;
        string[] tags;
        address[] buyers;
        uint256 fundsWithdrawn;
    }

    uint256 public nextModelId;
    mapping(uint256 => Model) public models;

    event ModelListed(
        uint256 id,
        string name,
        string description,
        uint256 price,
        address creator,
        string[] tags
    );
    event ModelPurchased(uint256 id, address buyer);
    event ModelRated(uint256 id, uint8 rating, address rater);
    event ModelUpdated(uint256 id, string name, string description, uint256 price);
    event FundsWithdrawn(address creator, uint256 amount);

    /**
     * @notice List a new AI model
     * @param name Name of the model
     * @param description Description of the model
     * @param price Price of the model in wei
     * @param tags Tags for categorizing the model
     */
    function listModel(
        string memory name,
        string memory description,
        uint256 price,
        string[] memory tags
    ) public {
        require(price > 0, "Price must be greater than 0");

        models[nextModelId] = Model({
            id: nextModelId,
            name: name,
            description: description,
            price: price,
            creator: payable(msg.sender),
            ratingSum: 0,
            ratingCount: 0,
            tags: tags,
            buyers: new address          fundsWithdrawn: 0
        });

        emit ModelListed(nextModelId, name, description, price, msg.sender, tags);
        nextModelId++;
    }

    /**
     * @notice Purchase an AI model
     * @param modelId ID of the model to purchase
     */
    function purchaseModel(uint256 modelId) public payable {
        Model storage model = models[modelId];

        require(model.id == modelId, "Model does not exist");
        require(msg.value == model.price, "Incorrect payment amount");

        model.buyers.push(msg.sender);
        emit ModelPurchased(modelId, msg.sender);
    }

    /**
     * @notice Rate an AI model
     * @param modelId ID of the model to rate
     * @param rating Rating (1-5)
     */
    function rateModel(uint256 modelId, uint8 rating) public {
        require(rating >= 1 && rating <= 5, "Rating must be between 1 and 5");
        Model storage model = models[modelId];
        require(model.id == modelId, "Model does not exist");

        model.ratingSum += rating;
        model.ratingCount++;

        emit ModelRated(modelId, rating, msg.sender);
    }

    /**
     * @notice Get details of an AI model
     * @param modelId ID of the model to retrieve
     */
    function getModelDetails(uint256 modelId)
        public
        view
        returns (
            string memory name,
            string memory description,
            uint256 price,
            address creator,
            uint256 averageRating,
            string[] memory tags,
            address[] memory buyers
        )
    {
        Model storage model = models[modelId];
        require(model.id == modelId, "Model does not exist");

        uint256 avgRating = model.ratingCount == 0
            ? 0
            : model.ratingSum / model.ratingCount;

        return (
            model.name,
            model.description,
            model.price,
            model.creator,
            avgRating,
            model.tags,
            model.buyers
        );
    }

    /**
     * @notice Update an AI model's details
     * @param modelId ID of the model to update
     * @param name New name of the model
     * @param description New description of the model
     * @param price New price of the model
     */
    function updateModel(
        uint256 modelId,
        string memory name,
        string memory description,
        uint256 price
    ) public {
        Model storage model = models[modelId];
        require(model.id == modelId, "Model does not exist");
        require(msg.sender == model.creator, "Only the creator can update the model");
        require(price > 0, "Price must be greater than 0");

        model.name = name;
        model.description = description;
        model.price = price;

        emit ModelUpdated(modelId, name, description, price);
    }

    /**
     * @notice Withdraw funds by the creator
     * @param modelId ID of the model
     */
    function withdrawFunds(uint256 modelId) public {
        Model storage model = models[modelId];
        require(model.id == modelId, "Model does not exist");
        require(msg.sender == model.creator, "Only the creator can withdraw funds");

        uint256 availableFunds = address(this).balance - model.fundsWithdrawn;
        require(availableFunds > 0, "No funds available to withdraw");

        model.creator.transfer(availableFunds);
        model.fundsWithdrawn += availableFunds;

        emit FundsWithdrawn(msg.sender, availableFunds);
    }
}
