package com.cs336.pkg;
public class Auction {
	public int aID;
	public String item_name;
	public String item_type;
	public double price;
	public String buyer_email;
	public String seller_email;
	
	public Auction(int aID, String item_name, String item_type, double price, String buyer_email, String seller_email) {
		this.aID = aID;
		this.item_name = item_name;
		this.item_type = item_type;
		this.price = price;
		this.buyer_email = buyer_email;
		this.seller_email = seller_email;
	}
	
	@Override
	public String toString() {
		return "aID: " + this.aID + "; item_name: " + this.item_name + "; item_type: " + this.item_type + "; price: " + this.price + "; buyer_email: " + this.buyer_email + "; seller_email: " + this.seller_email;
	}
}