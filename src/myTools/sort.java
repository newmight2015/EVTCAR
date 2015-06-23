package myTools;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

public class sort {
	public List<Entry<String, Double>> mapSortAsce(Map<String,Double> map){
		List<Map.Entry<String,Double>> mappingList = null; 
		  //通过ArrayList构造函数把map.entrySet()转换成list 
		  mappingList = new ArrayList<Map.Entry<String,Double>>(map.entrySet()); 
		  //通过比较器实现比较排序 
		  Collections.sort(mappingList, new Comparator<Map.Entry<String,Double>>(){ 
		   public int compare(Map.Entry<String,Double> mapping1,Map.Entry<String,Double> mapping2){ 
		    return mapping1.getValue().compareTo(mapping2.getValue()); 
		   } 
		  }); 
		  
		  for(Map.Entry<String,Double> mapping:mappingList){ 
		   System.out.println(mapping.getKey()+":"+mapping.getValue()); 
		  } 
		  return mappingList;
	}
	
}
