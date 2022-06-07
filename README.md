# Dungeonball
An API for retrieving the theoretical D&D statistics of your favorite NFL players, and forming parties of NFL players!

### Setting Up
To use this API for your own personal use, please follow the proceeding steps:

1. Fork this repository.
2. Clone this repository.
3. Run `bundle install`.
4. Run `bundle exec rails db:{drop,create,migrate}`.
5. Run `rails csv_load:players`.
6. Run `rails s`.
7. Enjoy!

### Endpoints
* ` GET /api/v1/players ` - This endpoint searches through a list of all available players, and returns a list of all players with the queryed name.
Requires a query parameter ```name``` for a player's name.
* ` GET /api/v1/players/:id ` - Retrieves the individual player statistics of the requested player, based on their ID within the database.
* ` GET /api/v1/parties/:id ` - Retrieves the requested user party, assuming it has received both a valid party ID and a valid query parameter `user_id` for the user who owns the party.
* ` POST /api/v1/parties/:id/players ` - Adds a player to a selected party, assuming the current user is the owner of the party.  Requires a `user_id` query parameter and a `player_id` query parameter.

### Questions
If you have questions or concerns, please open an issue here on GitHub!

### Contributing
If you wish to contribute, please do the following:
1. Create an issue for the new contribution.
2. Write your code.
3. Submit a pull request to merge your code into the `staging` branch, **NOT** `main`.
4. Your code will be reviewed and either merged, or rejected with feedback.
