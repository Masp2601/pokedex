import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';

class PokemonViewModel extends BaseViewModel {
  List<Pokemon> _pokemon = [];
  List<Pokemon> get pokemon => _pokemon;

  Future<void> getPokemonFromPokeApi() async {
    setBusy(true);

    try {
      final response = await PokeAPI.getPokemon();
      List<Map<String, dynamic>> data =
          List.from(json.decode(response.body)['results']);

      _pokemon = data.asMap().entries.map<Pokemon>((element) {
        element.value['id'] = element.key + 1;
        element.value['img'] =
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
        return Pokemon.fromJson(element.value);
      }).toList();

      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
    }

    setBusy(false);
  }
}
