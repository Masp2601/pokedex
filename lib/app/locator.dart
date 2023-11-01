import 'package:get_it/get_it.dart';
import 'package:pokedex/services/api_service.dart';


final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PokeAPI.getPokemon());
}