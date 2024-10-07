# Boosting Tablet Script for QBCore

## Overview

The **Boosting Tablet** script is an interactive feature designed for QBCore-based GTA V servers, allowing players to engage in vehicle boosting activities. Players can manage cryptocurrency-like coins, perform various hacks on vehicles, and trigger police alerts for scratched VINs, enhancing the roleplay experience.

## Features

- **Sleek User Interface**: A modern tablet UI that provides players with easy access to boosting missions and their cryptocurrency balance.
- **Boosting Coins System**: Players earn and spend "Boosting Coins," which serve as an in-game cryptocurrency, promoting an immersive gameplay experience.
- **VIN Scratching**: Enables players to scratch vehicle VINs, triggering notifications for police players.
- **Hacking Tools**: Includes physical items like GPS Hacking Tools and Engine Hacking Tools for players to use in the boosting process.
- **Dynamic Boosts**: Offers a variety of boosts with different tiers and rewards, allowing players to choose their desired mission.
- **Police Alerts**: Automatically alerts police when a VIN is scratched, prompting an investigation.

## Installation

### Prerequisites

- Ensure you have a **QBCore** framework set up on your GTA V server.

### Step-by-Step Installation

1. **Download the Script**: Clone or download this repository to your local machine.
2. **Add to Resources**: Move the entire boosting-tablet directory into your resources folder.
3. **Update server.cfg**: Add the following line to your server.cfg to ensure the resource starts with your server:
        start boosting-tablet
4. **Database Setup**:

    Run the following SQL command to create the necessary table for storing boosting coins:

    CREATE TABLE `boosting_coins` (
    `citizenid` VARCHAR(255) NOT NULL,
    `coins` INT DEFAULT 0,
    PRIMARY KEY (`citizenid`)
);
5. **Ensure Dependencies**: Verify that your fxmanifest.lua includes all required files and dependencies.

### Accessing the Boosting Tablet

    Players can access the Boosting Tablet via a specific command or by using an in-game item (this depends on how you configure it in your server).
    Once opened, the tablet displays the player’s Boosting Coins balance and a list of available boosts.

### Starting a Boost

    Select a boost from the list on the tablet.
    Confirm the selection, which deducts the required amount of Boosting Coins from the player's balance.
    Players will receive instructions on completing the boost, including any hacking steps.

### Hacking Process

    Players can utilize physical items (like the GPS Hacking Tool and Engine Hacking Tool) to initiate the hack.
    The process includes multiple stages, such as:
        Hacking the engine.
        Scratching the VIN.
        Completing the mission and receiving Boosting Coins as a reward.

### Police Notification

    When a player successfully scratches a VIN, all police officers online will receive a notification prompting them to investigate.

## Customization

    Boost Configurations: Modify available boosts in server/main.lua by adding or removing entries in the availableBoosts table. Example:

    lua

    local availableBoosts = {
        { id = "boost1", tier = "S", vehicle = "Lamborghini Aventador", reward = 5000 },
        { id = "boost2", tier = "A", vehicle = "Dodge Challenger", reward = 3500 },
        { id = "boost3", tier = "B", vehicle = "BMW M4", reward = 2500 }
    }

    Coin System: Adjust coin costs and rewards as necessary to balance gameplay within your server.

    User Interface: Customize the tablet's UI by modifying html/styles.css and html/boosting_tablet.html.

### Troubleshooting

    Common Issues:
        - Ensure your database is properly set up and the script is correctly installed.
        - Check server logs for any error messages related to the script.
        - Make sure the police job is correctly configured in the notification system.

    Debugging:
        - If players are not receiving alerts, verify the job name and ensure  - the alert system is correctly integrated.
        - Test all functionalities in a controlled environment before deploying them on a live server.

### Issues and Support

- For support or to report issues, please open an issue on this repository. Be sure to include details about your server setup, any error messages you encounter, and steps to reproduce the issue.

### License

- This project is licensed under the MIT License. See the LICENSE file for more details.

### Additional Notes

- Feel free to modify the content based on your server's unique features or additional configurations.

Let me know if you need any further modifications or additions!
