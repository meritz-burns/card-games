without a game you can:

- start a game
- join a game
- find a game

these gives you a gameId

## start a game

this is normal Rails. show a page with a button; clicking a button creates a
Game and redirects you to the #show action.

## join a game

normal Rails. a form with a text input and a button. the action redirects you
to that game, or 404. could be a GET, really: /games/:game_id

## find a game

a page with some JS: listen on a Websocket for new games coming in and show
them in a list. the list is normal <a> links.

---

once you have a gameId, you can visit /games/:game_id . This page requires JS.

> mutation connect(gameId: String!) : ConnectionPayload
> union ConnectionPayload = ConnectionFailure | Connection
> type ConnectionFailure {
>   gameId: String!
>   errors: [Error!]!
> }
> type Connection {
>   id: String! // secret
>   player: Player!
>   world: World!
> }
> type World {
>   deckSize: Integer!
>   topOfDiscardPile: Card
>   boards: [Board!]!
>   players: [Player!]
> }
> union PotentialCard = MaskedCard | Card
> type Player {
>   id: String! // public
>   name: String!
>   hand: [PotentialCard!]!
>   board: [Card!]!
> }

if they are the first to connect, they are player 1. generate a UUID for them
(`id`) and give them the name "Player 1". move the backend game state to
CREATED.

if they are the second to connect, they are player 2. UUID, and name "Player
2". backend gamestate is ONGOING.

subsequent connections, spectator. UUID, name "Spectator". can only connect in
ONGOING state.

this means a player cannot reconnect.

---

because the backend isn't very smart, the user needs to be able to move things
along manually. it is assumed that the players are communicating via voice or
video. these actions are the nuts and bolts.

> mutation inspect(connectionId: String!) : InspectPayload // list all the cards in the discard
> mutation destroy(connectionId: String!, cardId: String!) : ActionPayload // installed card -> discard
> mutation discardRandom(connectionId: String!) : ActionPayload // random card from hand -> discard
> mutation discard(connectionId: String!, cardId: String!) : ActionPayload // card from hand -> discard
> mutation stack(connectionId: String!, cardId: String!) : ActionPayload // card from hand -> top deck
> mutation unstack(connectionId: String!, cardId: String!) : ActionPayload // installed card -> bottom of deck
> mutation draw(connectionId: String!) : ActionPayload // card from deck -> hand
> mutation install(connectionId: String!, cardId: String!) : ActionPayload // card from hand -> board
> mutation bounce(connectionId: String!, cardId: String!) : ActionPayload // card from board -> hand
> mutation retrieve(connectionId: String!, cardId: String!) : ActionPayload // card from discard -> hand
> mutation transfer(connectionId: String!, cardId: String!) : ActionPayload // installed card -> board
> mutation disconnect(connectionId: String!) : ActionPayload // if a player, forfeit
> mutation win(connectionId: String!) : ActionPayload // end the game, winning
> type InspectPayload {
>   errors: [Error!]!
>   cards: [Card!]!
> }
> type ActionPayload {
>   errors: [Error!]!
>   world: World
> }

---

in order to make a seamless game, we use a GraphQL subscription. the client is
expected to track state based on this, but also every action mutation returns a
World.

> subscription actions(connectionId: String!) : Action
> interface Action {
>     player: Player!
>     world: World!
> }
> type DestroyAction implements Action { card: Card! }
> type DiscardAction implements Action { card: Card! }
> type StackAction implements Action // move card from hand to top of deck
> type UnstackAction implements Action // move card from hand to bottom of deck
> type DrawAction implements Action // implies a decremented deck size
> type InstallAction implements Action { card: Card! }
> type BounceAction implements Action { card: Card! } // installed card -> hand
> type RetrieveAction implements Action // discard -> hand
> type TransferAction implements Action { // installed -> installed
>   targetPlayer: Player!
>   card: Card!
> }
> type ConnectAction implements Action // a user connects
> type VictoryAction implements Action // game over
