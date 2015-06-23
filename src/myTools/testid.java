package myTools;

import com.ckc.dao.UniqueIdDAO;
import com.ckc.dao.impl.copy.UniqueIdDAOImpl;

public class testid {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UniqueIdDAOImpl uidDao = new UniqueIdDAOImpl();
		IdGenerator idGen = IdGenerator.getInstance();
		idGen.initialize(uidDao);
		String id = idGen.getNextArticleId();
		System.out.println(id);
	}

}
