import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp();
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ANALYSE VOYELLE",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
              fontSize: 25, 
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String word = '';
  Map<String,int> nbreVoyelle= { 'a': 0, 'e': 0, 'i': 0,'o': 0,'u': 0,'y': 0, 
  };

  int consonnesCompteur = 0;

  void countVowelsAndConsonants() {
    setState(() {
     List<String> Voyelles = ['a', 'e', 'i', 'o', 'u', 'y'];
      consonnesCompteur = 0;
       String lowercaseWord = word.toLowerCase(); 
      String uppercaseWord = word.toUpperCase(); 
      
      for (int i = 0; i < lowercaseWord.length; i++) {
        String letter = lowercaseWord[i];
        if (nbreVoyelle.containsKey(letter)) {
         nbreVoyelle[letter] = (nbreVoyelle[letter] ?? 0) + 1;
        } else if (RegExp('[A-Z]').hasMatch(letter)) {
          consonnesCompteur++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("ANALYSE VOYELLE"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  word = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Entrez un mot",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  countVowelsAndConsonants();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text(
                  'Analyser',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  OccurrenceTile(letter: 'a', occurrences: nbreVoyelle['a'] ?? 0),
                  const SizedBox(height: 10),
                  OccurrenceTile(letter: 'e', occurrences: nbreVoyelle['e'] ?? 0),
                  const SizedBox(height: 10),
                  OccurrenceTile(letter: 'i', occurrences: nbreVoyelle['i'] ?? 0),
                  const SizedBox(height: 10),
                  OccurrenceTile(letter: 'o', occurrences: nbreVoyelle['o'] ?? 0),
                  const SizedBox(height: 10),
                  OccurrenceTile(letter: 'u', occurrences: nbreVoyelle ['u'] ?? 0),
                  const SizedBox(height: 10),
                  OccurrenceTile(letter: 'y', occurrences: nbreVoyelle['y'] ?? 0),
                  const SizedBox(height: 10),
                  OccurrenceTile(letter: 'Consonnes', occurrences: consonnesCompteur),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OccurrenceTile extends StatelessWidget {
  final String letter;
  final int occurrences;

  const OccurrenceTile({
    required this.letter,
    required this.occurrences,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getColor(letter),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: ' $letter ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Dancing Script',
              ),
            ),
            TextSpan(
              text: ' : $occurrences Occurrences',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Dancing Script',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String letter) {
    switch (letter) {
      case 'a':
        return Colors.red;
      case 'e':
        return Colors.pink;
      case 'i':
        return Colors.orange;
      case 'o':
        return Colors.yellow;
      case 'u':
        return Colors.green;
      case 'y':
        return Color.fromARGB(255, 57, 201, 177);
      default:
        return Colors.black;
    }
  }
}
