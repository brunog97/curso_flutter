import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_interface/modelos/usuario.dart';
import 'package:facebook_interface/uteis/responsivo.dart';
import 'package:flutter/material.dart';

class AreaCriarPostagem extends StatelessWidget {
  final Usuario usuario; //final porque esse usuario não será alterado

  const AreaCriarPostagem({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsivo.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: isDesktop ? 5 : 0),
      elevation: isDesktop ? 1 : 0,
      shape: isDesktop
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Container(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          // color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: CachedNetworkImageProvider(
                      usuario.urlImagem,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration.collapsed(
                        hintText: "No que você esta pensando?",
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10,
                thickness: 0.5,
              ),
              SizedBox(
                height: 40,
                child: Row(
                  //espaçamento "uniforme"
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.videocam,
                        color: Colors.red,
                      ),
                      label: Text('Ao vivo',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    VerticalDivider(
                      width: 8,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.photo_library,
                        color: Colors.green,
                      ),
                      label: Text('Foto',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    VerticalDivider(
                      width: 8,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.video_call,
                        color: Colors.purple,
                      ),
                      label: Text('Sala',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
