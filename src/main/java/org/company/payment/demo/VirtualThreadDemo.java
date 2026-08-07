package org.company.payment.demo;

public class VirtualThreadDemo {

    public static void main(String[] args) throws Exception{
        for(int i=1; i<=100; i++)
        {
            int taskId = i;
            Thread.startVirtualThread(() ->
            {
                System.out.println("Task "+taskId+" running on "+Thread.currentThread());

                try
                {
                    Thread.sleep(3000);
                }
                catch (InterruptedException e)
                {
                    throw new RuntimeException(e);
                }
                System.out.println("Task "+taskId+" completed");
            });
        }
        Thread.sleep(5000);
    }
}
