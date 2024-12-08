import 'package:disney/disney_model.dart';
import 'disney_detail_page.dart';
import 'package:flutter/material.dart';


class DisneyCard extends StatefulWidget {
  final Disney disney;

  const DisneyCard(this.disney, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _DisneyCardState createState() => _DisneyCardState(disney);
}

class _DisneyCardState extends State<DisneyCard> {
  Disney disney;
  String? renderUrl;

  _DisneyCardState(this.disney);

  @override
  void initState() {
    super.initState();
    renderDisneyPic();
  }

  Widget get disneyImage {
    var disneyAvatar = Hero(
      tag: disney,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration:
            BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, alignment: Alignment.topCenter, image: NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.black54, Colors.black, Color(0xfff06292)])),
      alignment: Alignment.center,
      child: const Text(
        'Princess',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: disneyAvatar,
      // ignore: unnecessary_null_comparison
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderDisneyPic() async {
    await disney.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = disney.imageUrl;
      });
    }
  }

  Widget get disneyCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 290,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: const Color(0xFFF8bbd0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  widget.disney.name,
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 27.0),
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Color(0xFF000600)),
                    Text(': ${widget.disney.rating}/10', style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDisneyDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DisneyDetailPage(disney);
    })).then((value) => setState(() {}));//Linea para recaragar y actualizar rating
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDisneyDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              disneyCard,
              Positioned(top: 7.5, child: disneyImage),
            ],
          ),
        ),
      ),
    );
  }
}
