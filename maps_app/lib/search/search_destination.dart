import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/search_response.dart';
import 'package:maps_app/models/search_result.dart';
import 'package:maps_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;
  final List<SearchResult> history;

  SearchDestination(this.proximity, this.history)
      : this.searchFieldLabel = 'Buscar...',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        splashRadius: 25,
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () => this.query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      splashRadius: 25,
      icon: Icon(Icons.arrow_back),
      onPressed: () => this.close(context, SearchResult(cancel: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildEmergenceResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicación manualmente'),
            onTap: () {
              // need return  //
              print('Manualmente');
              this.close(context, SearchResult(cancel: false, manual: true));
            },
          ),
          ...this
              .history
              .map((result) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(result.nameDestination ?? ''),
                    subtitle: Text(result.description ?? ''),
                    onTap: () {
                      this.close(context, result);
                    },
                  ))
              .toList()
        ],
      );
    }
    return _buildEmergenceResults();
  }

  Widget _buildEmergenceResults() {
    if (this.query.length == 0) {
      return Container();
    }

    this
        ._trafficService
        .getSugerenciasPorQuery(this.query.trim(), this.proximity);

    return StreamBuilder(
      // (this.query.trim(), proximity)
      stream: this._trafficService.emergenceStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final places = snapshot.data!.features;

        if (places?.length == 0) {
          return ListTile(
            title: Text('No hay resultados con $query'),
          );
        }

        return ListView.separated(
          separatorBuilder: (_, i) => Divider(),
          itemCount: places!.length,
          itemBuilder: (_, i) {
            final placer = places[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(placer.textEs),
              subtitle: Text(placer.placeNameEs),
              onTap: () {
                this.close(
                  context,
                  SearchResult(
                    cancel: false,
                    manual: false,
                    position: LatLng(
                      placer.center[1],
                      placer.center[0],
                    ),
                    nameDestination: placer.textEs,
                    description: placer.placeNameEs,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
