import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:intellibox/src/modules/apis/ninja.dart';
import 'package:intellibox/src/utils/theme.dart';
import 'package:translator/translator.dart';

import '../../../widgets/btns.dart';
import 'model.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  Mood? mood;

  var message = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Ecris ce qui te vient à l'esprit ici",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: message,
              decoration: InputDecoration(
                hintText: "J'ai faim... blabla..",
                border: const OutlineInputBorder(),
                fillColor: Scolors.primary.withOpacity(0.6),
                filled: true,
              ),
              minLines: 4,
              maxLines: null,
            ),
          ),
          if (mood != null)
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mood!.sentiment,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${((mood!.score * 100).abs()).toStringAsFixed(2)}% ",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AsyncButtonBuilder(
              child: const MainButton(
                text: 'Deviner mon humeur',
              ),
              onPressed: () async {
                await _genMood();
              },
              builder: (context, child, callback, buttonState) {
                return GestureDetector(
                  onTap: callback,
                  child: child,
                );
              },
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Future<void> _genMood() async {
    Mood? m = await Ninja.getMood(
      (await (message.text.translate())).text,
    );
    await Mood.translated(m!).then((value) {
      setState(() {
        mood = value;
      });
      return null;
    });
  }
}
