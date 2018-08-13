package com.icaksama.astacksearch.models;

import android.content.Context;

import com.icaksama.astacksearch.utilities.SharedPreferenceHelper;

/**
 * Created by icaksama on 13/08/18.
 */

public class APIParams {

    private SharedPreferenceHelper mPrefs = null;
    public long pagesize = 10;
    public long fromdate = 0;
    public long todate = 0;
    public String order = "desc";
    public String sort = "activity";
    public String tagged = "";
    public String intitle = "ios";

    public APIParams(Context context) {
        mPrefs = new SharedPreferenceHelper(context);
        this.pagesize = mPrefs.getLong("pagesize") == 0 ? 10 : mPrefs.getLong("pagesize");
        this.fromdate = mPrefs.getLong("fromdate");
        this.todate = mPrefs.getLong("todate");
        this.order = mPrefs.getString("order").trim().isEmpty() ? "desc" : mPrefs.getString("order");
        this.sort = mPrefs.getString("sort").trim().isEmpty() ? "activity" : mPrefs.getString("sort");
        this.tagged = mPrefs.getString("tagged").trim().isEmpty() ? "" : mPrefs.getString("tagged");
        this.intitle = mPrefs.getString("intitle").trim().isEmpty() ? "android" : mPrefs.getString("intitle");
    }

    public APIParams(Context context, long pagesize, long fromdate, long todate, String order, String sort, String tagged, String intitle) {
        mPrefs = new SharedPreferenceHelper(context);
        this.pagesize = pagesize;
        mPrefs.setLong("pagesize", pagesize);
        this.fromdate = fromdate;
        mPrefs.setLong("fromdate", fromdate);
        this.todate = todate;
        mPrefs.setLong("todate",todate);
        this.order = order;
        mPrefs.setString("order", order);
        this.sort = sort;
        mPrefs.setString("sort", sort);
        this.tagged = tagged;
        mPrefs.setString("tagged", tagged);
        this.intitle = intitle;
        mPrefs.setString("intitle", intitle);
    }
}
