



import 'dart:math';

import 'package:testt/modal_class/LoanInfo.dart';
import 'package:testt/utils/utils.dart';

LoandInfo calcRate(double money,double rateMoney){

  LoandInfo info=new LoandInfo();

  info.baseMoney=money;


  return info;


}



 calcRateHight(double totalMoney,double avaMoney,int time) async{


  double avaLocalMoney=avaMoney-totalMoney/time;

  LoandInfo info=calcRate(totalMoney, avaLocalMoney);

  double rateYear=0.0;




  return rateYear;

}

//in thread
 calcRateImpl(double totalMoney,double avaMoney,int number,double startRate) async{



  int t1=Utils.currentTimeMillis();
//  var rate=(startRate-3)<0?0:(startRate-3);
   double rate=startRate;
  double temp=0.0;
   double stage=0.0001;

  do{
    temp=caclAverageMoney(totalMoney, rate, number);
    if(temp>avaMoney){
      break;
    }
    rate+=stage;
  }while(((temp-avaMoney).abs()>0.5));

   int t2=Utils.currentTimeMillis();

   print("eat time:"+(t2-t1).toString());
  return rate;

}



LoandInfo calc(double money,double target,int volume){

  LoandInfo info=new LoandInfo();

  info.baseMoney=money;

  double total=money*volume;

  info.totalPurchase = total;
  info.totalFee=total*0.05;
  info.extimatedMoney=(money*target)-(total*0.05);
  info.extimatedRate = ((money*target)/total)*100;
  info.totalSales=money*target;
  info.tax;

  return info;


}


double caclAverageMoney(double totalMoney,double rate,int number){
  double result= 0.0;

  result = (totalMoney * (rate * pow((1 + rate), number.toDouble()))) / (pow((1 + rate), number.toDouble()) - 1);

  return result;
}