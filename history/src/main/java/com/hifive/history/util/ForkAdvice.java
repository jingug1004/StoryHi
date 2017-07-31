package com.hifive.history.util;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ForkAdvice {
   
	Logger logger = LoggerFactory.getLogger(this.getClass());
    
    public void fork(final ProceedingJoinPoint pjp) {
        new Thread(new Runnable() {
            public void run() {
            	logger.info("Forking method execution: " + pjp);
                try {
                    pjp.proceed();
                } catch (Throwable t) {
                    // All we can do is log the error.
                	logger.error("" + t);
                }
            }
        }).start();
    }
}
