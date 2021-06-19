import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState>? _key;
  List<String> dynamicChipsList = [];
  late bool _isSelected;
  int _defaultIndex = 0;
  List<Company> _companies = [];
  List<String> _filters = [];
  List<String> _choices = [];

  @override
  void initState() {
    super.initState();
    _isSelected = false;
    _key = GlobalKey<ScaffoldState>();
    _filters = <String>[];
    _companies = <Company>[
      const Company('MI'),
      const Company('SAMSUNG'),
      const Company('NOKIA'),
      const Company('VIVO'),
      const Company('REALME'),
      const Company('APPLE')
    ];
    _choices = ['Choices1', 'Choices2', 'Choices3', 'Choices4'];
    dynamicChipsList = ['Android', 'Ios', 'Flutter', 'React', 'Phone Gape'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: rowChips()),
          Divider(),
          wrapWidget(),
          Divider(),
          dynamicChips(),
          Divider(),
          actionChips(),
          Divider(),
          choiceChips(),
          Divider(),
          inputChips(),
          Divider(),
          Wrap(children: companyWidget.toList()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text('Selected chips ${_filters.join(' , ')}'),
          ),
        ],
      ),
    );
  }

  rowChips() {
    return Row(
      children: [
        chipsRow("Android", Color(0xFFff8a65)),
        chipsRow("Php", Color(0xFF4fc3f7)),
        chipsRow("Ios", Color(0xFF9575cd)),
        chipsRow("Flutter", Color(0xFF4db6ac)),
        chipsRow("React", Color(0xFF5cda65)),
      ],
    );
  }

  Widget choiceChips() {
    return Expanded(
      child: ListView.builder(
          itemCount: _choices.length,
          itemBuilder: (context, item) {
            return ChoiceChip(
              label: Text(_choices[item]),
              selected: _defaultIndex == item,
              selectedColor: Colors.green,
              onSelected: (bool selected) {
                // ignore: unrelated_type_equality_checks
                setState(() {
                  _defaultIndex == selected ? item : null;
                });
              },
              backgroundColor: Colors.blue,
              labelStyle: TextStyle(color: Colors.white),
            );
          }),
    );
  }

  wrapWidget() {
    return Wrap(
      spacing: 10.5,
      runSpacing: 10.5,
      children: [
        chips("Android", Color(0xFFff8a65)),
        chips("Php", Color(0xFF4fc3f7)),
        chips("Ios", Color(0xFF9575cd)),
        chips("Flutter", Color(0xFF4db6ac)),
        chips("React", Color(0xFF5cda65)),
      ],
    );
  }

  dynamicChips() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(dynamicChipsList.length, (index) {
        return Chip(
          label: Text(dynamicChipsList[index]),
          onDeleted: () {
            setState(() {
              dynamicChipsList.removeAt(index);
            });
          },
        );
      }),
    );
  }

  Widget inputChips() {
    return InputChip(
      backgroundColor: Colors.red,
      label: Text('James Watson'),
      padding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade600,
        child: _isSelected
            ? Icon(
                Icons.done,
                color: Colors.white,
              )
            : Text(
                'SM',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
      selected: _isSelected,
      selectedColor: Colors.green,
      onSelected: (value) {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      //onPressed: () {},
      onDeleted: () {},
    );
  }

  Widget actionChips() {
    return ActionChip(
      elevation: 6.0,
      avatar: CircleAvatar(
        maxRadius: 25.0,
        backgroundColor: Colors.green[60],
        child: Icon(
          Icons.call,
          size: 16.0,
        ),
      ),
      onPressed: () {
        _key!.currentState!.showSnackBar(
          SnackBar(
            content: Text('Calling....'),
          ),
        );
      },
      backgroundColor: Colors.white,
      shape:
          StadiumBorder(side: BorderSide(width: 1, color: Colors.blueAccent)),
      label: Text('Call '),
    );
  }

  Iterable<Widget> get companyWidget sync* {
    for (Company company in _companies) {
      yield Padding(
        padding: EdgeInsets.all(5.0),
        child: FilterChip(
          avatar: CircleAvatar(
            child: Text(company.name[0].toUpperCase()),
          ),
          label: Text(company.name),
          selected: _filters.contains(company.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(company.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == company.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  Widget chipsRow(String? label, Color? color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(label![0].toString(),
            style: TextStyle(fontSize: 18.0, color: color)),
      ),
      label: Text(
        label.toString(),
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }

  Widget chips(String? label, Color? color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(label![0].toString(),
            style: TextStyle(fontSize: 18.0, color: color)),
      ),
      label: Text(
        label.toString(),
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }
}

class Company {
  const Company(this.name);
  final String name;
}
