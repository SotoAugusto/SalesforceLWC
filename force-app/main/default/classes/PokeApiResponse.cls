public class PokeApiResponse {
    public List<Abilities> abilitiesList;

    public class Abilities {
        Ability ability;
        // Map<String, Object> mapName;
        Boolean isHidden;
        Integer slot;
    }

    public class Ability {
        String name;
        String url;
    }
//       "abilities": [
//     {
//       "ability": {
//         "name": "limber",
//         "url": "https://pokeapi.co/api/v2/ability/7/"
//       },
//       "is_hidden": false,
//       "slot": 1
//     },
//     {
//       "ability": {
//         "name": "imposter",
//         "url": "https://pokeapi.co/api/v2/ability/150/"
//       },
//       "is_hidden": true,
//       "slot": 3
//     }
//   ],
    Integer baseExperience;
//  "base_experience": 101,

    Cries cry;

    public class Cries{
        String latest;
        String legacy;
    }

//   "cries": {
//     "latest": "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/132.ogg",
//     "legacy": "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/132.ogg"
//   },


    public List<Forms> formsList;

    public class Forms{
        String name;
        String url;
    }

//   "forms": [
//     {
//       "name": "ditto",
//       "url": "https://pokeapi.co/api/v2/pokemon-form/132/"
//     }
//   ],

    public    List<GameIndices> gameIndicesList;

    public class GameIndices{
        Integer gameIndex;
        Version version;

    }

    public class Version{
        String name;
        String url;
    }

// "game_indices": [
//     {
//       "game_index": 76,
//       "version": {
//         "name": "red",
//         "url": "https://pokeapi.co/api/v2/version/1/"
//       }
//     },
//     {
//       "game_index": 76,
//       "version": {
//         "name": "blue",
//         "url": "https://pokeapi.co/api/v2/version/2/"
//       }
//     },
//   ],

    Double height;
    //   "height": 3,


    public List<HeldItems> heldItemsList;

    public class HeldItems{
        Item item;
        List<VersionDetails> versionDetailsList;
    }

    public class Item{
        String name;
        String url;
    }

    public class VersionDetails{
        Integer rarity;
        Version version;
    }
    // "held_items": [
    // {
    //   "item": {
    //     "name": "metal-powder",
    //     "url": "https://pokeapi.co/api/v2/item/234/"
    //   },
    //   "version_details": [
    //     {
    //       "rarity": 5,
    //       "version": {
    //         "name": "ruby",
    //         "url": "https://pokeapi.co/api/v2/version/7/"
    //       }
    //     },
    //     {
    //       "rarity": 5,
    //       "version": {
    //         "name": "sapphire",
    //         "url": "https://pokeapi.co/api/v2/version/8/"
    //       }
    //     },
    //     {
    //       "rarity": 5,
    //       "version": {
    //         "name": "emerald",
    //         "url": "https://pokeapi.co/api/v2/version/9/"
    //       }
    //     },
    //   ]


    public Integer id;
    public Boolean isDefault;
    public String locationAreaEncounters;

//     "id": 132,
//   "is_default": true,
//   "location_area_encounters": "https://pokeapi.co/api/v2/pokemon/132/encounters",


    public List<Moves> movesList;
    public class Moves{
        Move move;
        List<VersionGroupDetails> versionGroupDetailsList;
    }

    public class Move{
        String name;
        String url;
    }

    public class VersionGroupDetails{
        Integer levelLearnedAt;
        MoveLearnMethod moveLearnMethod;
        VersionGroup versionGroup;

    }

    public class MoveLearnMethod{
        String name;
        String url;
    }

    public class VersionGroup{
        String name;
        String url;
    }

// "moves": [
//     {
//       "move": {
//         "name": "transform",
//         "url": "https://pokeapi.co/api/v2/move/144/"
//       },
//       "version_group_details": [
//         {
//           "level_learned_at": 1,
//           "move_learn_method": {
//             "name": "level-up",
//             "url": "https://pokeapi.co/api/v2/move-learn-method/1/"
//           },
//           "version_group": {
//             "name": "red-blue",
//             "url": "https://pokeapi.co/api/v2/version-group/1/"
//           }
//         },
//         {
//           "level_learned_at": 1,
//           "move_learn_method": {
//             "name": "level-up",
//             "url": "https://pokeapi.co/api/v2/move-learn-method/1/"
//           },
//           "version_group": {
//             "name": "yellow",
//             "url": "https://pokeapi.co/api/v2/version-group/2/"
//           }
//         },
//         {
//           "level_learned_at": 1,
//           "move_learn_method": {
//             "name": "level-up",
//             "url": "https://pokeapi.co/api/v2/move-learn-method/1/"
//           },
//           "version_group": {
//             "name": "gold-silver",
//             "url": "https://pokeapi.co/api/v2/version-group/3/"
//           }
//         },
//         {
//           "level_learned_at": 1,
//           "move_learn_method": {
//             "name": "level-up",
//             "url": "https://pokeapi.co/api/v2/move-learn-method/1/"
//           },
//           "version_group": {
//             "name": "crystal",
//             "url": "https://pokeapi.co/api/v2/version-group/4/"
//           }
//         },



public     String name;
public     Integer order;
public     List<PastAbilities> pastAbilitiesList;

    public class PastAbilities{

    }

    public List<PastTypes> pastTypesList;

    public class PastTypes{
    }

    public Species species;
    public class Species{
        String name;
        String url;
    }

//   "name": "ditto",
//   "order": 214,
//   "past_abilities": [],
//   "past_types": [],
//   "species": {
//     "name": "ditto",
//     "url": "https://pokeapi.co/api/v2/pokemon-species/132/"
//   },


    public class Sprites{
        String backDefault;
        String backFemale;
        String backShiny;
        String backShinyFemale;
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }
// "sprites": {
//     "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png",
//     "back_female": null,
//     "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/132.png",
//     "back_shiny_female": null,
//     "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
//     "front_female": null,
//     "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png",
//     "front_shiny_female": null,

// !

    public class Other{
        DreamWorld dreamWorld;
        Home home;
        OfficialArtwork officialArtwork;
        Showdown showdown;
        // genericexample dreamWorld;
        // genericexample officialArtwork;
    }

    public // class genericexample{
    //     String frontDefault;
    //     String frontFemale;
    // }

    public class DreamWorld{
        String frontDefault;
        String frontFemale;
    }

    public class Home{
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

     public class OfficialArtwork {
        String frontDefault;
        String frontShiny;
    }

    public class Showdown{
        String backDefault;
        String backFemale;
        String backShiny;
        String backShinyFemale;
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class Versions{
        GenerationI generationI;
        GenerationII generationII;
        GenerationIII generationIII;
        GenerationIV generationIV;
        GenerationV generationV;
        GenerationVI generationVI;
        GenerationVII generationVII;
        GenerationVIII generationVIII;
    }

    public class GenerationI{
        RedBlue redBlue;
        Yellow yellow;
    }

// generic with the most fields possible crystal?
    public class RedBlue{
        String backDefault;
        String backGray;
        String backTransparent;
        String frontDefault;
        String frontGray;
        String frontTransparent;
    }

    public class Yellow{
        String backDefault;
        String backGray;
        String backTransparent;
        String frontDefault;
        String frontGray;
        String frontTransparent;
    }

    public class GenerationII{
        Crystal crystal;
        Gold gold;
        Silver silver;
    }

    public class Crystal{
        String backDefault;
        String backShiny;
        String backShinyTransparent;
        String backTransparent;
        String frontDefault;
        String frontShiny;
        String frontShinyTransparent;
        String frontTransparent;
    }

    public class Gold{
        String backDefault;
        String backShiny;
        String frontDefault;
        String frontShiny;
        String frontTransparent;
    }

    public class Silver{
        String backDefault;
        String backShiny;
        String frontDefault;
        String frontShiny;
        String frontTransparent;
    }

    public class GenerationIII{
        Emerald emerald;
        FireRedLeafGreen fireRedLeafGreen;
        RubySapphire rubySapphire;
    }

    public class Emerald{
        String frontDefault;
        String frontShiny;
    }

    public class FireRedLeafGreen{
        String backDefault;
        String backShiny;
        String frontDefault;
        String frontShiny;
    }

    public class RubySapphire{
        String backDefault;
        String backShiny;
        String frontDefault;
        String frontShiny;
    }

    public class GenerationIV{
        DiamondPearl diamondPearl;
        HeartgoldSoulsilver heartgoldSoulsilver;
        Platinum platinum;
    }

    public class DiamondPearl{
        String backDefault;
        String backFemale;
        String backShiny;
        String backShinyFemale;
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class HeartgoldSoulsilver{
        String backDefault;
        String backFemale;
        String backShiny;
        String backShinyFemale;
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class Platinum{
        String backDefault;
        String backFemale;
        String backShiny;
        String backShinyFemale;
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class GenerationV{
        BlackWhite blackWhite;
    }

    public class BlackWhite{
        Animated animated;
        String backDefault;
        String backFemale;
        String backShiny;
        String backShinyFemale;
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class Animated{
        String backDefault;
        String backFemale;
        String backShiny;
        String backShinyFemale;
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }
//   "generation-v": {
//         "black-white": {
//           "animated": {
//             "back_default":
//             "back_female": null,
//             "back_shiny":
//             "back_shiny_female": null,
//             "front_default":
//             "front_female": null,
//             "front_shiny":
//             "front_shiny_female": null
//           },
//           "back_default":
//           "back_female": null,
//           "back_shiny":
//           "back_shiny_female": null,
//           "front_default":
//           "front_female": null,
//           "front_shiny":
//           "front_shiny_female": null
//         }

    public class GenerationVI{
        OmegarubyAlphasapphire omegarubyAlphasapphire;
        XY xY;
    }

    public class OmegarubyAlphasapphire{
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class XY{
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class GenerationVII{
        Icons icons;
        UltrasunUltramoon ultrasunUltramoon;
    }

    public class Icons{
        String frontDefault;
        String frontFemale;
    }

    public class UltrasunUltramoon{
        String frontDefault;
        String frontFemale;
        String frontShiny;
        String frontShinyFemale;
    }

    public class GenerationVIII{
        Icons icons;
    }

List<Stats> statsList;

    public class Stats{
        Integer baseStat;
        Stat stat;
    }

    public class Stat{
        String name;
        String url;
    }

// "stats": [
//     {
//       "base_stat": 48,
//       "effort": 1,
//       "stat": {
//         "name": "hp",
//         "url": "https://pokeapi.co/api/v2/stat/1/"
//       }
//     },
//     {
//       "base_stat": 48,
//       "effort": 0,
//       "stat": {
//         "name": "attack",
//         "url": "https://pokeapi.co/api/v2/stat/2/"
//       }
//     },

    List<Types> typesList = new List<Types>();

    public class Types{
        Integer slot;
        Type type;
    }

    public class Type{
        String name;
        String url;
    }
// "types": [
//     {
//       "slot": 1,
//       "type": {
//         "name": "normal",
//         "url": "https://pokeapi.co/api/v2/type/1/"
//       }
//     }
//   ],
//   "weight": 40

    Integer weight;

}