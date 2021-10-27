import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  String total='0';


  void CountPlus(int a){
    if(count3==null) count3=0;

    count3 = count3 + a;

    update();
  }
  void CountMinus(int a){
    if(count3==null) count3=0;
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

class CalculateGetx extends GetxController{

  var f = NumberFormat('###,###,###,###.##');

  double totalPurchase=0;
  double totalFee=0;
  double extimatedMoney=0;
  double extimatedRate=0;
  double interestTotal=0;
  double baseMoney=0;
  bool isRoll=false;
  double totalSales=0;
  double tax;
  double avgpurchase=0;

  double avgvolume=0;
  double avgtotal=0;
  double avgtotal2=0;
  double avgtotal3=0;
  double totalcal=0;
  double totalvolume=0;


  AvgPurchase(m1,m2,m3,v1,v2,v3){
    avgtotal = m1*v1;
    avgtotal2 = m2*v2;
    avgtotal3 = m3*v3;
    totalcal = avgtotal+avgtotal2+avgtotal3;
    totalvolume=v1+v2+v3;
    avgpurchase = totalcal/totalvolume;

    update();
  }

  TotalPurchase(double money,double target,int volume){
    totalPurchase = money * volume;
    update();
  }
  TotalFee(double money,double target,int volume){
    totalFee = (money * volume) * 0.05;
    update();
  }
  ExtimatedMoney(double money,double target,int volume){
    extimatedMoney = (money*target)-((money * volume)*0.05);
    update();
  }
  ExtimatedRate(double money,double target,int volume){
    extimatedRate = ((money*target)/(money * volume))*100;
    update();
  }
  TotalSales(double target,double volume){
    totalSales = volume * target;
    update();
  }

}

