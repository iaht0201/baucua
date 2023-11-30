import 'dart:async';

import 'package:storage_flutter/database.dart';
import 'package:storage_flutter/model.dart';

class ClientsBloc {
  ClientsBloc() {
    getClients();
  }
  final _clientController = StreamController<List<Client>>.broadcast();
  get clients => _clientController.stream;
  dispose() {
    _clientController.close();
  }

  getClients() async {
    _clientController.sink.add(await DBProvider.db.getAllClients());
  }

  Future<void> blockUnblock(Client client) async {
    await DBProvider.db.blockOrUnBlock(client);
    await getClients();
  }

  Future<void> delete(int id) async {
    await DBProvider.db.deleteClient(id);
    await getClients();
  }

  Future<void> add(Client client) async {
    await DBProvider.db.newClient(client);
    await getClients();
  }

  void disposeBloc() {
    _clientController.close();
  }
}
