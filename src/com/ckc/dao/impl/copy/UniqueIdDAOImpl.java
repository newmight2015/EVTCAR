package com.ckc.dao.impl.copy;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;





import com.ckc.dao.UniqueIdDAO;

import myBean.UniqueId;
import myBean.dbEntity;


public class UniqueIdDAOImpl implements UniqueIdDAO{
	

	private dbEntity dbentity;
	
	

	@Override
	public List<UniqueId> findAll() {
		dbentity = new dbEntity();
		ResultSet rs = dbentity.findIdByAll();//在此实现查找
		List<UniqueId> idList = null;
		UniqueId uid = new UniqueId();
		try {
			while(rs.next()){
				uid.setId(rs.getInt(1));
				uid.setName(rs.getString(2));
				uid.setValue(rs.getInt(3));
				idList.add(uid);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return idList;
	}

	@Override
	public UniqueId findByName(String name) {
		dbentity = new dbEntity();
		ResultSet rs = dbentity.findIdByName(name);
		UniqueId uid = new UniqueId();
		try {
			while(rs.next()){
				uid.setId(rs.getInt(1));
				uid.setName(rs.getString(2));
				uid.setValue(rs.getInt(3));
				return uid;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return null;
		}
		return null;
	}

	@Override
	public void save(UniqueId uniqueId) {
		
	}

	@Override
	public void update(UniqueId uniqueId) {
		
	}

}
