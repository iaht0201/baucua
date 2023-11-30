import 'package:flutter/material.dart';
import 'package:storage_flutter/Blocs/db_bloc.dart';
import 'package:storage_flutter/database.dart';
import 'package:storage_flutter/model.dart';
import 'dart:math' as math;

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final bloc = ClientsBloc();
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  List<Client> testClients = [
    Client(
      firtsName: "Raouf",
      lastName: "Rahiche",
      blocked: false,
    ),
    Client(
      firtsName: "Zaki",
      lastName: "oun",
      blocked: true,
    ),
    Client(
      firtsName: "oussama",
      lastName: "ali",
      blocked: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<Client>>(
          stream: bloc.clients,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Client item = snapshot.data![index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.green,
                    ),
                    onDismissed: (direction) {
                      bloc.delete(item.id!.toInt());
                    },
                    child: ListTile(
                      title: Text("${item.lastName}"),
                      leading: Text("${item.id.toString()}"),
                      trailing: Checkbox(
                        value: item.blocked,
                        onChanged: (value) {
                          DBProvider.db.blockOrUnBlock(item);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),

        // FutureBuilder<List<Client>>(
        //   future: DBProvider.db.getAllClients(),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: snapshot.data?.length,
        //         itemBuilder: (context, index) {
        //           Client item = snapshot.data![index];
        //           return Dismissible(
        //             key: UniqueKey(),
        //             background: Container(
        //               color: Colors.green,
        //             ),
        //             onDismissed: (direction) {
        //               DBProvider.db.deleteClient(item.id!.toInt());
        //             },
        //             child: ListTile(
        //               title: Text("${item.lastName}"),
        //               leading: Text("${item.id.toString()}"),
        //               trailing: Checkbox(
        //                 value: item.blocked,
        //                 onChanged: (value) {
        //                   DBProvider.db.blockOrUnBlock(item);
        //                   setState(() {});
        //                 },
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     } else {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Client rnd = testClients[math.Random().nextInt(testClients.length)];
            bloc.add(rnd);
            setState(() {});
          },
        ),
      ),
    );
  }
}
