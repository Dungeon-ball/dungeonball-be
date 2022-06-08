# Dungeonball
An API for retrieving the theoretical D&D statistics of your favorite NFL players, and forming parties of NFL players!

## Requirements
This API requires Ruby version 2.7.4 or later.

### Schema
![DB Schema](https://github.com/Dungeon-ball/dungeonball-be/blob/zel-readme-update/db/DB%20Schema.png "DB Schema")

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
Requires a query parameter ```name``` for a player's name.  This search is case-insensitive, and finds all players containing the name.
- Example Response, query parameters - `name: 'timmy'`:

```
{
  "data": [
    {
      "id": "1",
        "type": "player",
        "attributes": {
          "name": "Timmy Jones",
          [...]
        }
    },
    {
      "id": "2",
      "type": "player",
      "attributes": {
        "name": "Jones Timmy",
        [...]
      }
    },
    {
      "id": "3",
      "type": "player",
      "attributes": {
        "name": "ghgtimmyhghdkjs",
        [...]
      }
    }
  ]
}
```

* ` GET /api/v1/players/:id ` - Retrieves the individual player statistics of the requested player, based on their ID within the database.
- Example Response:

```
{
  "data": {
    "id": "1",
    "type": "player",
    "attributes": {
      "name": "Gerald",
      "strength": 15,
      "dexterity": 14,
      "constitution": 13,
      "intelligence": 8,
      "wisdom": 15,
      "charisma": 12
      "class": { 
        "name": "wizard", 
        "description": "fireballs and stuff"
        "hitpoints": 9, 
        "proficiencies": [ 
           'thing1', 
           'thing2', 
           'thing3' 
        ]
      } 
    }
  }
}
```

* ` GET /api/v1/party ` - Retrieves the currently authenticated user's party.  Requires a `user_id` query parameter.
- Example Response, query parameters - `user_id: 8`:

```
{
  "data": {
    "id": "16",
    "type": "party",
    "attributes": {
      "name": "Awesome party",
      "user_id: "8"
      "relationships":  [
        "players": {
          "data": [
            {
              "type": 'player',
              "id": 10,
              "name": 'billy'
            },
            {
              "type": 'player',
              "id": 12,
              "name": 'billy'
            }
          ]
        },
        "user" : {
          "data": {
            "type": "user",
            "id": 8
          }
        }
      ]
    }
  }
}
```

* ` POST /api/v1/party/players ` - Adds a player to the currently authenticated user's party, taking in `player_id` and `user_id` query parameters to assign the player.
- Example Response, query parameters - `user_id: 123456789, player_id: 1`:

```
{
  "data": {
    "id": 123456789,
    "type": "party",
    "attributes": {
      "name": "Awesome party",
      "relationships":  {
        "players": {
          "data": [
            {
              "type": "player",
              "id": 1,
              "name": "Gerald"
            }
          ]
        },
        "user" : {
          "data": {
          "type": "user",
          "id": 123456789
          }
        }
      }
    }
  }
}
```

### Questions
If you have questions or concerns, please open an issue here on GitHub!

### Contributing
If you wish to contribute, please do the following:
1. Create an issue for the new contribution.
2. Write your code.
3. Submit a pull request to merge your code into the `staging` branch, **NOT** `main`.
4. Your code will be reviewed and either merged, or rejected with feedback.
