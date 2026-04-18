let currentCard = null

window.addEventListener('message', function(event) {
    const data = event.data

    document.getElementById('main-ui').style.display = 'block'

    if (data.action === 'openCard') {
        currentCard = data.card

        document.getElementById('card-view').style.display = 'block'
        document.getElementById('binder-view').style.display = 'none'
        document.getElementById('booster-view').style.display = 'none'

        document.getElementById('card-image').src = '../images/' + data.card.image
        document.getElementById('card-name').innerText = data.card.label

        document.getElementById('binderButton').style.display = data.hasBinder ? 'inline-block' : 'none'
    }

    if (data.action === 'openBinder') {
        document.getElementById('card-view').style.display = 'none'
        document.getElementById('binder-view').style.display = 'grid'

        const binder = document.getElementById('binder-view')
        binder.innerHTML = ''

        data.binder.allCards.forEach(card => {
            const slot = document.createElement('div')
            slot.className = 'binder-slot'

            const img = document.createElement('img')

            const owned = data.binder.cards && data.binder.cards[card.name]

            if (owned) {
                img.src = '../images/' + card.image
            } else {
                img.src = 'missing.png'
            }

            slot.appendChild(img)
            binder.appendChild(slot)
        })
    }
})

function closeUI() {
    document.getElementById('main-ui').style.display = 'none'

    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: 'POST'
    })
}

function insertIntoBinder() {
    if (!currentCard) return

    fetch(`https://${GetParentResourceName()}/insertIntoBinder`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            card: currentCard.name
        })
    })

    closeUI()
}

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeUI()
    }
})