
class TransactionCategory {
  TransactionCategory({required this.categoryName, required this.icon,});
  String categoryName;
  String icon;
  double? confidence;


  Map<String, dynamic> toFirestore() {
    return {'categoryName': categoryName, 'icon': icon.toString()};
  }
  TransactionCategory updateTransactionCategory({String? newCategoryName, String? newIcon, double? newConfidence}){
    categoryName = newCategoryName?? categoryName;
    icon = newIcon?? icon;
    confidence = newConfidence?? confidence;
    return this;
  }
}

//Dummy data.
List<TransactionCategory> expenseCategories = [
  TransactionCategory(categoryName: 'Clothing', icon: 'assets/imgs_category/clothes.png'),
  TransactionCategory(categoryName: 'Car', icon: 'assets/imgs_category/car.png'),
  TransactionCategory(categoryName: 'House', icon: 'assets/imgs_category/house.png'),
  TransactionCategory(categoryName: 'Food', icon: 'assets/imgs_category/food.png'),
  TransactionCategory(categoryName: 'Miscellaneous', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Health', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Entertainment', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Utilities', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Travel', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Education', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Pets', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Gifts', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Subscriptions', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Groceries', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Personal Care', icon: 'assets/imgs_category/miscellaneous.png'),
];

List<TransactionCategory> incomeCategories = [
  TransactionCategory(categoryName: 'Salary', icon: 'assets/imgs_category/salary.png'),
  TransactionCategory(categoryName: 'Dividend Yield', icon: 'assets/imgs_category/dividend.png'),
  TransactionCategory(categoryName: 'Investment', icon: 'assets/imgs_category/investment.png'),
  TransactionCategory(categoryName: 'Miscellaneous', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Freelance', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Rental Income', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Bonus', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Tax Return', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Royalties', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Side Hustle', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Grants', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Cashback', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Gift', icon: 'assets/imgs_category/miscellaneous.png'),
  TransactionCategory(categoryName: 'Crowdfunding', icon: 'assets/imgs_category/miscellaneous.png'),
];

