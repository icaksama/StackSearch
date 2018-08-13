package com.icaksama.astacksearch.utilities;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

/**
 * Created by icaksama on 13/08/18.
 */

public class SharedPreferenceHelper {

    private final SharedPreferences mPrefs;
    private final String Key = "icaksama";

    public SharedPreferenceHelper(Context context) {
        mPrefs = context.getSharedPreferences(Key, 0);
    }

    public String getString(String key) {
        String val = mPrefs.getString(key, null);
        return val == null ? "" : val;
    }

    public long getLong(String key) {
        return mPrefs.getLong(key, 0);
    }

    public void setString(String key, String val) {
        Editor mEditor = mPrefs.edit();
        mEditor.putString(key, val);
        mEditor.apply();
    }

    public void setLong(String key, long val) {
        Editor mEditor = mPrefs.edit();
        mEditor.putLong(key, val);
        mEditor.apply();
    }
}
