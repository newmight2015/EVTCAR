package myTools;

import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.locks.ReentrantLock;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ckc.dao.UniqueIdDAO;
import myBean.UniqueId;

/**
 * 
 * @author STerOtto
 * 
 */

public class IdGenerator
{
	/**
	 * The priority of log level increases from top to bottom, a log priority is
	 * set to filter the logs with less priority than the setting one.
	 * logger.debug(""); logger.info(""); logger.warn(""); logger.error("");
	 * logger.fatal("");
	 */
	private static final Log logger = LogFactory.getLog(IdGenerator.class);
	private static final String SEED_NAME = "seed";
	private static final long PERSIST_INTERVAL = 600000; // persist every 10 mins

	private class PersistTask implements Runnable
	{
		@Override
		public void run()
		{
			update();
		}
	}

	private static final IdGenerator _instance;

	static
	{
		_instance = new IdGenerator();
	}

	public static IdGenerator getInstance()
	{
		return _instance;
	}

	private AtomicLong _idSeed;
	private ReentrantLock _mapLock;

	private UniqueIdDAO _uniqueIdDAO; // Ψһid
	private ScheduledFuture<?> _future;

	/**
	 * 构�?�函�?
	 */
	private IdGenerator()
	{
		_mapLock = new ReentrantLock();
	}

	/**
	 * 初始化_idSeed和_appIdSeedMap
	 */
	public void initialize(Object uniqueIdDAO)
	{
		_uniqueIdDAO = (UniqueIdDAO) uniqueIdDAO;

		UniqueId seedEntity = _uniqueIdDAO.findByName(SEED_NAME);
		if (seedEntity == null)
		{
			seedEntity = new UniqueId();
			seedEntity.setName(SEED_NAME);
			seedEntity.setValue(0);
			_uniqueIdDAO.save(seedEntity);
		}
		_idSeed = new AtomicLong(seedEntity.getValue());
		logger.info(String.format("Initialize idSeed to %d", _idSeed.get()));
		_future = Scheduler.getInstance().scheduleAtFixedRate(
				new PersistTask(), PERSIST_INTERVAL, PERSIST_INTERVAL,
				TimeUnit.MILLISECONDS);
	}

	/**
	 * 获取下一个cp_id 并且为新的cp存入�?个初始化种子 并且将cp_id的种子跟�?
	 * 
	 * @return
	 */
	public String getNextArticleId()
	{
		long idSeed = _idSeed.incrementAndGet();
		return String.format("%08d", idSeed);
	}

	/**
	 * 更新数据库中的种子
	 */
	public void destroy()
	{
		_future.cancel(false);
		update();
	}

	private void update()
	{
		try
		{
			_mapLock.lock();
			UniqueId seedEntity = _uniqueIdDAO.findByName(SEED_NAME);
			if (seedEntity == null)
			{
				seedEntity = new UniqueId();
				seedEntity.setName(SEED_NAME);
				seedEntity.setValue((int)_idSeed.get());
				_uniqueIdDAO.save(seedEntity);
				logger.info(String.format("Save idSeed=%d", _idSeed.get()));
			} else
			{
				seedEntity.setValue((int)_idSeed.get());
				_uniqueIdDAO.update(seedEntity);
				logger.info(String.format("Update idSeed=%d", _idSeed.get()));
			}
		} finally
		{
			_mapLock.unlock();
		}
	}
}
