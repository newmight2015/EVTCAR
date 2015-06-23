package myTools;

import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class Scheduler
{
	private static final int SCHEDULER_CORE_THREAD_SIZE = 4;
	private static final Scheduler _instance;
	
	static
	{
		_instance = new Scheduler();
	}
	
	public static Scheduler getInstance()
	{
		return _instance;
	}
	
	private ScheduledThreadPoolExecutor	_executor;
	
	private Scheduler()
	{
		//构造一个ScheduledThreadPoolExecutor对象，并且设置它的容量为4个 
		_executor = new ScheduledThreadPoolExecutor(SCHEDULER_CORE_THREAD_SIZE);
	}
	/**
	 * 运行指定延迟的操作，只执行一次
	 * @param command 下一步指令的对象，继承Runnable接口，为多线程运行
	 * @param delay 启动延迟
	 * @param unit	延迟单位 , TimeUnit.Seconds(以秒为单位)
	 * @return a ScheduledFuture representing pending completion of the task and whose get() method will return null upon completion
	 */
	public ScheduledFuture<?> schedule(Runnable command, long delay, TimeUnit unit)
	{
		return _executor.schedule(command, delay, unit);
	}
	/**
	 * 运行指定次数指定延迟的操作
	 * @param command 下一步指令的对象，继承Runnable接口，为多线程运行
	 * @param delay 启动延迟
	 * @param period 运行下一步指令的时间延迟
	 * @param unit 延迟单位 , TimeUnit.Seconds(以秒为单位)
	 * @return
	 */
	public ScheduledFuture<?> scheduleAtFixedRate(Runnable command, long delay, long period, TimeUnit unit)
	{
		return _executor.scheduleAtFixedRate(command, delay, period, unit);
	}
	/**
	 * 关闭ScheduledThreadPoolExecutor运行中的线程
	 */
	public void shutdown()
	{
		_executor.shutdownNow();
	}
}
