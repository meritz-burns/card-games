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

show the list of games, as normal <a> links.

## show a game

once you hit /games/:game_id, you can join a game. the controller joins you
automatically.

if you are the first to connect, you are player 1. move the backend game state
to WAITING.

if you are the second to connect, you are player 2. backend gamestate is
ONGOING.

subsequent connections, spectator. can only connect in ONGOING state.

this means a player cannot reconnect.

initial game state is rendered from ERb. a bunch of piles:

- deck size
- top of discard
- player 1 installed
- player 1 hand
- player 2 installed
- player 2 hand

all of the HTTP requests need to pass a connection_secret param to identify the
user.

user can click and also drag+drop to send off PUT to
/games/:game_id/movement?source_card=:source_card_id&source_pile=:source_pile_id&dest_pile=:dest_pile_id

clicking on the discard pile offers the action to inspect it

GET /games/:game_id/discard

because the backend isn't very smart, the user needs to be able to move things
along manually. it is assumed that the players are communicating via voice or
video. these actions are the nuts and bolts.

this means they have to win or lose manually. there are buttons labeled "win"
and "surrender".

POST /games/:game_id/win
POST /games/:game_id/lose

So all together:

PUT /games/:game_id/movement
GET /games/:game_id/discard
POST /games/:game_id/win
POST /games/:game_id/lose

---

in order to make a seamless game, we use an ActionCable subscription. the
client is expected to track state based on this.

the following actions can occur:

- card movement: source_pile, source_player, dest_pile, dest_player
- player connected: their public player ID, the IDs of their hand and installed
  piles
- game over: who won
