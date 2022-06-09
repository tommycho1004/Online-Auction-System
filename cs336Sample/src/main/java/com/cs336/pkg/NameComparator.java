package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Comparator;

public class NameComparator implements Comparator<Item>{
	
	
	@Override 
	
	public int compare(Item item1, Item item2) {
		return item1.name.compareToIgnoreCase(item2.name);
	}
	
}
