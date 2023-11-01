import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/ui/screen/details/details_viewmodel.dart';
import 'package:pokedex/ui/screen/details/widgets/detail_back_button.dart';
import 'package:pokedex/ui/screen/details/widgets/detail_data.dart';
import 'package:pokedex/ui/screen/details/widgets/detail_image.dart';
import 'package:pokedex/ui/screen/details/widgets/detail_title.dart';
import 'package:stacked/stacked.dart';

class DetailsView extends StatelessWidget {
  final Pokemon pokemon;
  const DetailsView({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<DetailsViewModel>.reactive(
      viewModelBuilder: () => DetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              DetailImage(image: pokemon.img!),
              DetailTitle(id: pokemon.id!, name: pokemon.name!),
              DetailData(id: pokemon.id!),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: const DetailBackButton(),
      ),
    );
  }
}
