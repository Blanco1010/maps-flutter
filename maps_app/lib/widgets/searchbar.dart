part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            print('Buscando...');
            final result = await showSearch(
                context: context, delegate: SearchDestination());
            this.returnSearch(result!);
          },
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            width: width,
            height: 50,
            child: Text(
              '¿Dónde quieres ir?',
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 10),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  void returnSearch(SearchResult result) {
    if (result.cancel) {
      print('Prueba');
    }
  }
}
