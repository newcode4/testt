import 'package:get/get.dart';



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

class AxisCount extends GetxController{
  int count3;


  void count(int a){
    count3 = a == 2 ? 2 : 4;
    print(count3);
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



