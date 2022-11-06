
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{}

class ShopChangeFavoritesDataState extends ShopStates{}

class ShopSuccessChangeFavoritesDataState extends ShopStates
{
   final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesDataState(this.model);
}

class ShopErrorChangeFavoritesDataState extends ShopStates{}


class ShopSuccessGetFavoritesDataState extends ShopStates{}

class ShopLoadingGetFavoritesDataState extends ShopStates{}

class ShopErrorGetFavoritesDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
   final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopLoadingUserDataState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}

