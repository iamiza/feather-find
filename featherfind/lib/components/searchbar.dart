import 'package:flutter/material.dart';

class SearchBarComp extends StatelessWidget {
  const SearchBarComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          child: SearchBar(
            trailing:[
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              const SizedBox(
                width: 10,
              )
            ],
            hintText: "Search for birds",
            onSubmitted: (value){
              // send value for searching 
            },
          ),
        ),
      ),
    );
  }
}
