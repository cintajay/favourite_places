import 'package:favourite_places/providers/places.dart';
import 'package:favourite_places/screens/add_place.dart';
import 'package:favourite_places/screens/place_details.dart';
import 'package:favourite_places/widgets/place_list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    _placesFuture = ref.read(placesListProvider.notifier).loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(placesListProvider);

    final noContentView = Center(
        child: Text(
          "No places added yet",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );

    final contentView = ListView.builder(
      itemCount: placesList.length,
      itemBuilder: (context, index) {        
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => PlaceDetailsScreen(place: placesList[index],))),
          child: PlaceItem(place: placesList[index])
        );
      },
    );

    void addNew() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddPlaceScreen()),
      );
    }
    return Scaffold (
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(onPressed: addNew, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: _placesFuture, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return placesList.isEmpty ? noContentView : contentView;
          }
        },
      )
    );
  }
}
