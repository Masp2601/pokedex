import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/ui/screen/details/details_view.dart';
import 'package:pokedex/ui/screen/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PokemonViewModel>.reactive(
      viewModelBuilder: () => PokemonViewModel(),
      onViewModelReady: (model) => model.getPokemonFromPokeApi(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: PokemonSearchDelegate(model.pokemon),
                );
              },
            ),
          ],
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: model.pokemon.length,
                itemBuilder: (context, index) {
                  final pokemon = model.pokemon[index];
                  return ListTile(
                    title: Text(pokemon.name!),
                    subtitle: Text('ID: ${pokemon.id}'),
                    leading: Image.network(pokemon.img!),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsView(pokemon: pokemon),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class PokemonSearchDelegate extends SearchDelegate<Pokemon> {
  final List<Pokemon> pokemonList;

  PokemonSearchDelegate(this.pokemonList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, pokemonList.first);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Mostrar los resultados basados en la query
    final results = pokemonList
        .where((pokemon) =>
            pokemon.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final pokemon = results[index];
        return ListTile(
          title: Text(pokemon.name!),
          subtitle: Text('ID: ${pokemon.id}'),
          leading: Image.network(pokemon.img!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsView(pokemon: pokemon),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Mostrar sugerencias basadas en la query
    return Container(); // Por defecto, no se muestran sugerencias
  }
}
