package com.looker.core.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created with IntelliJ IDEA.
 * User: Yang Guang
 * Date: 2015/4/16 13:21
 * Description:数据库连接占用的资源 包含 Connection, Statement, ResultSet，便于close
 */
public class DBConnectionResource {
	
	public DBConnectionResource(Connection connection, Statement statement, ResultSet resultSet) {
		this.connection = connection;
		this.statement = statement;
		this.resultSet = resultSet;
	}
	
	public Connection connection;
	public Statement statement;
	public ResultSet	resultSet;
}
