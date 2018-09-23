package teavs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class TimerTask {

    
    /**
     * 每个月一号凌晨一点执行test1
     */
    //                   秒分时日 月周
     /* @Scheduled(cron = "0 0 1 1 * ?")
      public void test1()
      {
          System.out.println("开始执行数据库备份。。。。。。。。。。。。。。。。。。");
      } 
      
      @Scheduled(cron = "0/2 * * * * ?")//每隔5秒隔行一次 
      public void  test2(){
         System.out.println("job2 开始执行");

      }*/
}