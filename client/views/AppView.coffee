class window.AppView extends Backbone.View

  className: 'poker-table'

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="newgame-button">New Game</button>
    <div class="player-stack"><h2>Current Chips: <%= playerChips %></h2></div>
    <div class="current-bet"><h2>Current Bet: <%= currentBet %></h2></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .newgame-button": -> @model.newGame()

  initialize: ->
    @render()
    @model.on 'newGame', =>
      @render()
    @model.on 'gameEnded', =>
      @render()

  render: ->
    console.log("rendering")
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
