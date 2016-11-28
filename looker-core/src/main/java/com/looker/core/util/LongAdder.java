package com.looker.core.util;

import org.apache.http.annotation.NotThreadSafe;

/**
 * 
 * @author zhouzhiwei
 *
 */
@NotThreadSafe
public class LongAdder extends Number implements Comparable<LongAdder> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -553789282752579627L;
	private long value;
	
	public LongAdder() {
		this.value = 0;
	}

	public LongAdder(long value) {
		this.value = value;
	}

	/**
	 * Constructs a newly allocated {@code Long} object that represents the
	 * {@code long} value indicated by the {@code String} parameter. The string
	 * is converted to a {@code long} value in exactly the manner used by the
	 * {@code parseLong} method for radix 10.
	 * 
	 * @param s
	 *            the {@code String} to be converted to a {@code Long}.
	 * @throws NumberFormatException
	 *             if the {@code String} does not contain a parsable
	 *             {@code long}.
	 * @see Long#parseLong(String, int)
	 */
	public LongAdder(String s) throws NumberFormatException {
		this.value = Long.parseLong(s, 10);
	}

	@Override
	public int compareTo(LongAdder o) {
		return Long.compare(this.value, o.value);
	}

	/**
	 * Returns the value of this {@code Long} as a {@code byte}.
	 */
	public byte byteValue() {
		return (byte) value;
	}

	/**
	 * Returns the value of this {@code Long} as a {@code short}.
	 */
	public short shortValue() {
		return (short) value;
	}

	/**
	 * Returns the value of this {@code Long} as an {@code int}.
	 */
	public int intValue() {
		return (int) value;
	}

	/**
	 * Returns the value of this {@code Long} as a {@code long} value.
	 */
	public long longValue() {
		return (long) value;
	}

	/**
	 * Returns the value of this {@code Long} as a {@code float}.
	 */
	public float floatValue() {
		return (float) value;
	}

	/**
	 * Returns the value of this {@code Long} as a {@code double}.
	 */
	public double doubleValue() {
		return (double) value;
	}

	@Override
	public String toString() {
		return Long.toString(value);
	}

	/**
	 * Atomically sets to the given value and returns the old value.
	 *
	 * @param newValue
	 *            the new value
	 * @return the previous value
	 */
	public final long getAndSet(long newValue) {
		long r = value;
		value = newValue;
		return r;
	}

	/**
	 * Atomically increments by one the current value.
	 *
	 * @return the previous value
	 */
	public final long getAndIncrement() {
		return value++;
	}

	/**
	 * Atomically decrements by one the current value.
	 *
	 * @return the previous value
	 */
	public final long getAndDecrement() {
		return value--;
	}

	/**
	 * Atomically adds the given value to the current value.
	 *
	 * @param delta
	 *            the value to add
	 * @return the previous value
	 */
	public final long getAndAdd(long delta) {
		long r = value;
		value += delta;
		return r;
	}

	/**
	 * Atomically increments by one the current value.
	 *
	 * @return the updated value
	 */
	public final long incrementAndGet() {
		return ++value;
	}

	/**
	 * Atomically decrements by one the current value.
	 *
	 * @return the updated value
	 */
	public final long decrementAndGet() {
		return --value;
	}

	/**
	 * Atomically adds the given value to the current value.
	 *
	 * @param delta
	 *            the value to add
	 * @return the updated value
	 */
	public final long addAndGet(long delta) {
		return value += delta;
	}

	public long getValue() {
		return value;
	}

}
