package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Comparator;

public class PriceLowToHighComparator implements Comparator<Item>{
	
	
	@Override 
	
	public int compare(Item item1, Item item2) {
		return (int)(item1.curr_price - item2.curr_price);
	}
	
}
