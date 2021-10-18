import 'package:get/get.dart';
import 'package:testt/common/Constants.dart';



class CounterController extends GetxController{
  int price = 0;
  int volume = 0;
  int result ;
  void calculate(String a,String b){
    price = int.parse(a);
    volume = int.parse(b);
    result = price*volume;
    update();
  }
}

class Money extends GetxController{

  int count3 = 0;

  String total='0';


  void CountPlus(int a){
   count3 = box.read('money');
    count3 = count3 + a;

    update();
  }
  void CountMinus(int a){
    count3 = box.read('money');
    count3 = count3 - a;

    update();
  }

  void RateReturn(int a, int b){
    if(a==null || b==null) total = '0';
    else total = (a/b*100).toStringAsFixed(1);

    update();
  }
}

class BuilderController extends GetxController {
  double su;

  double count = 0;
  double total=0;

  increment() {
    count++;
    update();
  }

  increment2() {
    count= count +10;
    update();
  }

  decrease() {
    count--;
    update();
  }

  decrease2() {
    count= count -10;
    update();
  }

  ten() {
    count = su * 0.1;
    update();
  }

  fifty() {
    count = su * 0.5;
    update();
  }

  one_hundred() {
    count = su;
    update();
  }

  movedata(String volume) {
    count = double.parse(volume);
    su = double.parse(volume);
    update();
  }

  resultdata(double volume,int price){
    if(price==0){
      total=0;
      update();
    }else
      total = count*price;
    update();
  }
}



