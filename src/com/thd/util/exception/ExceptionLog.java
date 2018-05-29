package com.thd.util.exception;

import java.lang.reflect.Method;

import org.apache.log4j.Logger;
import org.springframework.aop.ThrowsAdvice;

public class ExceptionLog implements ThrowsAdvice {
	public ExceptionLog() {
	};
	
	private Logger log = Logger.getLogger(this.getClass());

	public void afterThrowing(Method method, Object args[], Object target,Throwable subclass) throws Throwable {
		log.error(target+"." + method + "() err !!!",subclass);
	}
}
