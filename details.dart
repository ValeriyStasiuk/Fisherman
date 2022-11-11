import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
class DetailsPage extends StatefulWidget {
  final String image;
  final String tag;

  const DetailsPage({Key? key, required this.image, required this.tag}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          flexibleSpace: Hero(
            tag: widget.tag,
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(widget.image), fit: BoxFit.cover)),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Лайфхак",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    borderSide:
                        BorderSide(width: 3, color: Colors.blue.shade300),
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.blue.shade300,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Text("KPNU Valeriy",
                  style: TextStyle(
                    color: Colors.black54,
                  )),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                  Icon(Icons.star, color: Colors.grey, size: 20),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "4.0",
                    style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "(2460)",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "22",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      " Likes",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.message),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "14",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(" Comments",
                        style: TextStyle(fontSize: 15, color: Colors.black54)),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.share),
                    Text("  Share",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ))
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Детальніше про лайфхак",
                style: TextStyle(
                    color: Colors.black87,  
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Як правило, при заготівлі наживки у вигляді хробаків рибалки використовують невеликі пластмасові відра. Черв'яки ж у свою чергу люблять збиратися на дні відерця. Вони сплутуються в грудку, а щоб їх витягнути та розплутати, доводиться витрачати чимало часу та сил. Тому для того, щоб цього не відбувалося, можна скористатися звичайними контейнерами для їжі. Нам потрібно розрізати дно кожного контейнера та з'єднати їх за допомогою клею. У кришці одного з контейнерів необхідно зробити невеликі отвори, щоб черв'якам було чим дихати. Хробаки будуть накопичуватися на звороті кришки з отворами. Щоб їх дістати, достатньо просто перевернути контейнер та відкрити кришку.",
                style: TextStyle(color: Colors.grey, height: 1.5),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  createButton(
                      icon: Icon(
                        Icons.book,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                      text: "READ NOW"),
                  createButton(
                    icon: Icon(Icons.shopping_basket, color: Colors.white),
                    text: "PURCHASE",
                    color: Colors.pink,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createButton({icon, color, text}) {
    return ButtonTheme(
      minWidth: 160,
      height: 45,
      child: FlatButton.icon(
        onPressed: () {},
        icon: icon,
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
