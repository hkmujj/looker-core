package com.looker.core.model;

import java.io.Serializable;

public class CodeItem implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -2995863974086085596L;
	
	private Integer id;
    private String type;
    private String code;
    private String value;
    private String status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
