import 'package:flutter/material.dart';

class AllEventsPage extends StatefulWidget {
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('All Events'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          new Expanded(
            flex: 0,
            child: new Text("All Events"),
          ),
          new Expanded(
            child: _buildListView(),
          ),
        ],
      )),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) {
        return ListTile(
            title: Text('Event $index'),
            subtitle: Text('Event Notes'),
            leading: Icon(Icons.check_box),
            trailing: IconButton(
              onPressed: null,
              icon: Icon(Icons.arrow_forward_ios_sharp),
            ));
      },
    );
  }
}
