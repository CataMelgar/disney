import 'package:flutter/material.dart';
import 'disney_model.dart';
import 'dart:async';


class DisneyDetailPage extends StatefulWidget {
  final Disney disney;
  const DisneyDetailPage(this.disney, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DisneyDetailPageState createState() => _DisneyDetailPageState();
}

class _DisneyDetailPageState extends State<DisneyDetailPage> {
  final double disneyAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFFAD1457),
                  inactiveColor: const Color(0xFFF8BBD0),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: const TextStyle(color: Color(0xFF880E4F), fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.disney.rating = _sliderValue.toInt();
      });
    }
  }

  @override//Para mantener rating en barra al salir y volver a entrar
  void initState() {
    super.initState();
    _sliderValue = widget.disney.rating.toDouble();
  }

  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: const Text("Come on! They're good!"),
            actions: <Widget>[
              TextButton(
                child: const Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF880E4F), // Cambia el color de fondo del botón
        foregroundColor: Colors.white, // Cambia el color del texto del botón
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Personaliza el tamaño del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
      ),
      child: const Text('Submit'),
    );
  }

  Widget get disneyImage {
    return Hero(
      tag: widget.disney,
      child: Container(
        height: disneyAvarterSize,
        width: disneyAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
              BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0xfff8bbd0)),
              BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
            ],
            image: DecorationImage(fit: BoxFit.cover, alignment: Alignment.topCenter, image: NetworkImage(widget.disney.imageUrl ?? ""))),
      ),
    );
  }

  Widget get rating {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Color(0xff880e4f),
        ),
        Text('${widget.disney.rating}/10', style: const TextStyle(color: Color(0xff880e4f), fontSize: 30.0))
      ],
    );
  }

  Widget get disneyProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color(0xfffce4ec),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          disneyImage,
          Text(widget.disney.name, style: const TextStyle(color: Color(0xff880e4f), fontSize: 32.0)),
          Text('${widget.disney.fanPage}', style: const TextStyle(color: Color(0xff880e4f), fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffce4ec),
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD1457),
        title: Text('Meet ${widget.disney.name}'),
      ),
      body: ListView(
        children: <Widget>[disneyProfile, addYourRating],
      ),
    );
  }
}
