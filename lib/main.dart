import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Startup name Gen',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RandomWords(),
      );
  }
}

class Box extends StatelessWidget {
  const Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("asdfasdf")),
      padding: const EdgeInsets.all(2),
    );
  }
}



class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();

}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {

          final tiles = _saved.map(
                  (pair) {
                return ListTile(
                  title: Text(pair.asPascalCase,
                  style: _biggerFont,
                ),
                );
              },
          );

          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(tiles: tiles,
              context: context
          ).toList() : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return
        ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if(i.isOdd) return const Divider();
          final index = i ~/2;
          if(index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
          setState(() {
          if(alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Gen'),
        actions: [
          IconButton (
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          )
        ]
      ),
      body: _buildSuggestions(),
    );
  }
}

