package com.ssm.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用返回类型
 */
public class Msg {
    //状态码 2333成功 5555失败
    private Integer code;
    //提示信息
    private String msg;
    //用户返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<>();

    //增加两个静态方法，一个成功，一个失败，再加一个添加数据的方法
    public static Msg success() {
        Msg result = new Msg();
        result.setCode(2333);
        result.setMsg("ʅ（´◔౪◔）ʃ");
        return result;
    }
    public static Msg fail() {
        Msg result = new Msg();
        result.setCode(5555);
        result.setMsg("o(ﾟДﾟ)っ啥！");
        return result;
    }
    //添加查询出来的数据,
    public Msg add(String key,Object value) {
        // getExtend()就是Map的get方法，用于获取当前类的属性，然后再返回当前类，可以链式调用
        this.getExtend().put(key, value);
        return this;
    }
    public Integer getCode() {
        return code;
    }
    public void setCode(Integer code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Map<String, Object> getExtend() {
        return extend;
    }
    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
