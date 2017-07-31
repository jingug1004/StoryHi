package com.hifive.history.portal;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Rss {
	private Channel channel;
	 
	 public Rss(){
		 channel = new Channel();
	 }

	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}
}
