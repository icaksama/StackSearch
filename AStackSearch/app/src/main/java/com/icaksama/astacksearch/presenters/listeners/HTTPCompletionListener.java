package com.icaksama.astacksearch.presenters.listeners;


import org.json.JSONObject;

/**
 * Created by icaksama on 13/08/18.
 */

public interface HTTPCompletionListener {

    public void completion(boolean isSuccess, String message, JSONObject jsonObject);
}
