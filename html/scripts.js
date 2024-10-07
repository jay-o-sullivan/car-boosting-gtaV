let tabletVisible = false;

function toggleTablet() {
    const tabletContainer = document.getElementById('tablet-container');
    tabletVisible = !tabletVisible;
    tabletContainer.classList.toggle('hidden', !tabletVisible);
}

// Close tablet on button click
document.getElementById('close-tablet').addEventListener('click', toggleTablet);

// Populate boosts
function populateBoosts(boosts) {
    const boostList = document.getElementById('boost-list');
    boostList.innerHTML = ''; // Clear existing boosts

    boosts.forEach(boost => {
        const boostItem = document.createElement('div');
        boostItem.classList.add('boost-item');
        boostItem.innerHTML = `
            <h4>${boost.tier} Tier - ${boost.vehicle}</h4>
            <p>Reward: $${boost.reward}</p>
            <button onclick="startBoost('${boost.id}')">Start Boost</button>
        `;
        boostList.appendChild(boostItem);
    });
}

// Function to start a boost
function startBoost(boostId) {
    toggleTablet();
    fetch(`https://${GetParentResourceName()}/startBoost`, {
        method: 'POST',
        body: JSON.stringify({ boostId: boostId })
    });
}

// Show tablet with Boosting Coins and boosts
window.addEventListener('message', function(event) {
    if (event.data.action === 'showTablet') {
        document.getElementById('boosting-coins').innerText = event.data.coins;
        populateBoosts(event.data.boosts);
        toggleTablet();
    }
});
