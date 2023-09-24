import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:newtronic_banking/data/model/balance_model.dart';
import 'package:newtronic_banking/data/model/bank_model.dart';
import 'package:newtronic_banking/data/model/transaction_model.dart';
import 'package:newtronic_banking/data/model/user_model.dart';

class Repository {
  Future<List<Users>> getUsers() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/user.json');
    final data = await json.decode(response)['users'];
    final List<Users> users = [];
    for (var i = 0; i < data.length; i++) {
      users.add(Users.fromJson(data[i]));
    }
    return users;
  }

  Future<Users?> getUserById({required id}) async {
    final List<Users> users = await getUsers();
    Users? user;
    for (var i = 0; i < users.length; i++) {
      if (users[i].id == id) {
        user = users[i];
      }
    }

    return user;
  }

  Future<Users?> loginUser({
    required emailOrUsername,
    required password,
  }) async {
    final List<Users> users = await getUsers();
    Users? user;
    for (var i = 0; i < users.length; i++) {
      if (users[i].email == emailOrUsername ||
          users[i].username == emailOrUsername) {
        if (users[i].password == password) {
          user = users[i];
        }
      }
    }
    return user;
  }

  Future<List<Balances>> getBalances() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/balance.json');
    final data = await json.decode(response)['data'];
    final List<Balances> balances = [];
    for (var i = 0; i < data.length; i++) {
      balances.add(Balances.fromJson(data[i]));
    }
    return balances;
  }

  Future<List<Transactions>> getTransactions() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/transaction.json');
    final data = await json.decode(response)['transactions'];
    final List<Transactions> transactions = [];
    for (var i = 0; i < data.length; i++) {
      transactions.add(Transactions.fromJson(data[i]));
    }
    return transactions;
  }

  Future<List<Banks>> getBanks() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/bank.json');
    final data = await json.decode(response)['banks'];
    final List<Banks> banks = [];
    for (var i = 0; i < data.length; i++) {
      banks.add(Banks.fromJson(data[i]));
    }
    return banks;
  }

  Future<Banks> getBanksById({required id}) async {
    final List<Banks> banks = await getBanks();
    Banks? bank;
    for (var i = 0; i < banks.length; i++) {
      if (banks[i].id == id) {
        bank = banks[i];
      }
    }
    return bank!;
  }

  Future<List<Banks>> searchBankByName({required name}) async {
    final List<Banks> banks = await getBanks();
    final List<Banks> searchResult = [];
    for (var i = 0; i < banks.length; i++) {
      if (banks[i].name.toLowerCase().contains(name.toLowerCase())) {
        searchResult.add(banks[i]);
      }
    }
    return searchResult;
  }
}
