package com.looker.core.util;

public interface ValueExecutor<T> {

	/**
	 * 如果返回false，跳出循环
	 * @param value
	 * @return
	 */
	public boolean exe(T value);
}
