import 'package:flutter/cupertino.dart';
import 'package:shoes_app/data/repository/transaction_repository.dart';
import 'package:shoes_app/utils/state_enum.dart';

import '../../../data/models/transaction_model.dart';

class TransactionProviders extends ChangeNotifier{
  final TransactionRepository transactionRepository;

  TransactionProviders(this.transactionRepository);

  ResultState _state = ResultState.Initial;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  List<TransactiontModel> _transationList = [];
  List<TransactiontModel> get transationList => _transationList;

  Future<void> getTransaction() async{
    _state = ResultState.Loading;
    notifyListeners();

    final result = await transactionRepository.getTransaction();
    result.fold(
      (error) {
        _state = ResultState.Error;
        _message = error.message;
        notifyListeners();
      },
      (items) {
        _state = ResultState.Success;
        _transationList = items;
        notifyListeners();
      },
    );
  }
}