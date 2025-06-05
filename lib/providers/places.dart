import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier()
  :super([]); //initialising the List<Place>

  void addPlace(Place place) { //method to change the List<Place>
    state = [
      ...state,
      place
    ];
  }
}

final placesListProvider = StateNotifierProvider((ref) { //is <StateNotifier, List<Place>> needed here?
  return PlacesNotifier();
});