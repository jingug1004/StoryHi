package com.hifive.history.portal;

import java.util.ArrayList;
import java.util.Collection;

import javax.xml.bind.annotation.XmlElement;

public class Channel {
	private Collection<Item> item;
	
	public Collection<Item> getItem() {
		return item;
	}
	
	@XmlElement
	public void setItem(Collection<Item> item) {
		this.item = item;
	}

	public Channel()
	{
		item = new ArrayList<Item>();
	}
}
