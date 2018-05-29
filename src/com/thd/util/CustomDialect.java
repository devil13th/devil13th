package com.thd.util;

import java.sql.Types;

import org.hibernate.Hibernate;
import org.hibernate.dialect.MySQLDialect;

public class CustomDialect extends MySQLDialect {
	 public CustomDialect() {   
		    super();   
		    registerHibernateType(Types.DECIMAL, Hibernate.BIG_DECIMAL.getName());   
		    registerHibernateType(-1, Hibernate.TEXT.getName());   
		    registerHibernateType(Types.REAL,Hibernate.BIG_INTEGER.getName()); 
			registerHibernateType(Types.REAL, Hibernate.FLOAT.getName()); 
		} 

}

