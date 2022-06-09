package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Item{
	
	public int itemID;
	public int aID;
	public String name;
	public String type;
	public double curr_price;
	public double initial_price;
	public java.sql.Time close_time;
	public java.sql.Date close_date;
	public String buyer_email;
	public String seller_email;
	
	
	public Item(){
		
	}
	
}
