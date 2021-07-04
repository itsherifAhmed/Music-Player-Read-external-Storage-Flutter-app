
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/widget.dart';
import 'main.dart';

class SongWidget extends StatelessWidget {
  final List<SongInfo> songList;
  SongWidget({@required this.songList});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context,songIndex)
        {
          SongInfo song = songList[songIndex];
          if(song.displayName.contains(".mp3"))
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*.5,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*.4,
                                child: Text(song.title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                              ),
                              Text("Realse year ${song.year}",style: TextStyle(
                                fontSize: 11,color: Colors.grey,fontWeight: FontWeight.w500
                              ),),
                              Text("Artist ${song.artist}",style: TextStyle(
                                fontSize: 11,color: Colors.grey,fontWeight: FontWeight.w500
                              ),),
                              Text("Duration ${Parsetominsec(int.parse(song.duration))}",style: TextStyle(
                                fontSize: 11,color: Colors.grey,fontWeight: FontWeight.w500
                              ),),
                            ],
                          ),
                          InkWell(

                            onTap: (){
                              audioManagerInstance.start("file://${song.filePath}", song.title).then((value) => print(value));
                            },
                            child: IconText(textColor: Colors.blue, iconColor: Colors.blue, string: "play", iconSize: 25, iconData: Icons.volume_up),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          return SizedBox(height: 0,);
        });
  }


  static String Parsetominsec(int ms){
    String data;
    Duration duration = Duration(milliseconds: ms);
    int min=duration.inMinutes;
    int sec = (duration.inSeconds)-(min*60);
    data= min.toString()+"0";
    if(sec<=9)data+="0";
    data+=sec.toString();
    return data;
  }


}
