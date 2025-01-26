import 'dart:math';

class CryptoAccount {
  final String id;
  final String owner;
  double balance;

  CryptoAccount({required this.id, required this.owner, required this.balance});

  void credit(double amount) {
    balance += amount;
  }

  void debit(double amount) {
    if (amount > balance) {
      throw Exception("Insufficient balance");
    }
    balance -= amount;
  }
}

class Transaction {
  final String id;
  final String senderId;
  final String receiverId;
  final double amount;
  final DateTime timestamp;
  bool isValid;

  Transaction({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.amount,
  })  : timestamp = DateTime.now(),
        isValid = false;
}

class SmartContract {
  final List<CryptoAccount> accounts;
  final List<Transaction> transactionHistory = [];
  final double transactionFeeRate;

  SmartContract({required this.accounts, this.transactionFeeRate = 0.01});

  String generateId() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(
        12, (index) => characters[random.nextInt(characters.length)]).join();
  }

  CryptoAccount? getAccountById(String id) {
    return accounts.firstWhere((account) => account.id == id);
  }

  void validateTransaction(Transaction transaction) {
    final sender = getAccountById(transaction.senderId);
    final receiver = getAccountById(transaction.receiverId);
    if (sender == null || receiver == null) {
      throw Exception("Sender or receiver account does not exist");
    }
    if (transaction.amount <= 0) {
      throw Exception("Transaction amount must be greater than zero");
    }
    if (transaction.amount + transaction.amount * transactionFeeRate >
        sender.balance) {
      throw Exception("Insufficient balance for transaction");
    }
    transaction.isValid = true;
  }

  void processTransaction(Transaction transaction) {
    validateTransaction(transaction);
    if (transaction.isValid) {
      final sender = getAccountById(transaction.senderId)!;
      final receiver = getAccountById(transaction.receiverId)!;
      final fee = transaction.amount * transactionFeeRate;
      sender.debit(transaction.amount + fee);
      receiver.credit(transaction.amount);
      transactionHistory.add(transaction);
    }
  }

  List<Transaction> getTransactionsByAccount(String accountId) {
    return transactionHistory
        .where((transaction) =>
            transaction.senderId == accountId ||
            transaction.receiverId == accountId)
        .toList();
  }

  double getAccountBalance(String accountId) {
    final account = getAccountById(accountId);
    if (account == null) {
      throw Exception("Account not found");
    }
    return account.balance;
  }

  double getTotalTransactionFees() {
    return transactionHistory.fold(
        0.0,
        (total, transaction) =>
            total + transaction.amount * transactionFeeRate);
  }
}

// void main() {
//   final account1 = CryptoAccount(id: 'acc1', owner: 'Alice', balance: 1000.0);
//   final account2 = CryptoAccount(id: 'acc2', owner: 'Bob', balance: 500.0);
//   final contract = SmartContract(accounts: [account1, account2]);

//   try {
//     final transaction = Transaction(
//       id: contract.generateId(),
//       senderId: 'acc1',
//       receiverId: 'acc2',
//       amount: 200.0,
//     );

//     contract.processTransaction(transaction);

//     print('Transaction processed successfully');
//     print('Alice balance: ${contract.getAccountBalance('acc1')}');
//     print('Bob balance: ${contract.getAccountBalance('acc2')}');
//     print('Total fees collected: ${contract.getTotalTransactionFees()}');
//   } catch (e) {
//     print('Error: $e');
//   }
// }
