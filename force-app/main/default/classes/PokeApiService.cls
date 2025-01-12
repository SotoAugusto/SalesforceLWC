public class PokeApiService {
    public static PokeApiResponse2 getPokemon(){
// PokeApiResponse2 myPokemon = PokeApiService.getPokemon();
// System.debug(myPokemon.moves);
        Http httpObject = new Http();
        HttpRequest request = new HttpRequest();
        // can use Named credentials with 'callout:' after adding it to SF
        // in this case callout is an alias for 'https://pokeapi.co/api/v2/'
        // callout:pokemon/ditto
        request.setEndpoint('callout:pokeapi/pokemon/ditto');
        // request.setEndpoint('https://pokeapi.co/api/v2/pokemon/ditto');
        request.setMethod('GET');
        HttpResponse response = httpObject.send(request);
        Integer responseCode = response.getStatusCode();
        if (responseCode == 200) {
            System.debug('Successs');
            // System.debug(response.getBody());
            return (PokeApiResponse2) JSON.deserialize(response.getBody(), PokeApiResponse2.class);
        }
        else {
            System.debug('Code different than 200');
            System.debug(response.getStatusCode());
        }

        return null;

    }
}
