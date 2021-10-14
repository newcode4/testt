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
  int count3 = box.read('money');

  String total;




  void CountPlus(int a){
    if(count3 ==  null) count3=0;
    count3 = count3 + a;

    update();
  }
  void CountMinus(int a){
    if(count3 ==  null) count3=0;
    count3 = count3 - a;

    update();
  }

  void RateReturn(int a, int b){
    total = (a/b*100).toStringAsFixed(1);

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



