
import 'package:testt/utils/utils.dart';

class LoandInfo{

   double totalPurchase;
   double totalFee;
   double extimatedMoney;
   double extimatedRate;
   double interestTotal;
   double baseMoney;
   bool isRoll=false;
   double totalSales;
   double tax;



    String toString() {

      StringBuffer sb=new StringBuffer();
     sb.write("총 매수금 : "+Utils.formatNumber(totalPurchase)+"원");
     if(totalPurchase!=0){
       sb.write("\n총 매도금 : "+Utils.formatNumber(totalSales)+"원");
     }
     if(totalFee!=0){
       sb.write("\n수수료계 : "+Utils.formatNumber(totalFee)+"원");
     }
     if(extimatedMoney!=0){
       sb.write("\n예상손익 : "+Utils.formatNumber(extimatedMoney)+"원");
     }
      if(extimatedRate!=0){
        sb.write("\n예상수익률 : "+Utils.formatNumber(extimatedRate)+"%");
      }



     return sb.toString();
   }

}

