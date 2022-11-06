

//POST
//UPDATE
//DELETE

//GET
// base url: https://newsapi.org/
// method (url) : v2/everything?
// queries : q=apple&from=2022-09-19&to=2022-09-19&sortBy=popularity&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4

//Apple
//https://newsapi.org/v2/everything?q=apple&from=2022-09-19&to=2022-09-19&sortBy=popularity&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4

//Tesla
//https://newsapi.org/v2/everything?q=tesla&from=2022-08-21&sortBy=publishedAt&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4

//Business
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2319d6a0cd504cc58d3cd95187fc0fa4


import 'package:shop_app/modules/shop_app/login/shop_login_secreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value){
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}
//To print all text
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token = '';