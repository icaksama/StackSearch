package com.icaksama.astacksearch.presenters.listeners;

import android.widget.ListView;

/**
 * Created by icaksama on 13/08/18.
 */

public interface MainListener {

    public ListView getListView();
    public void loadMore(boolean show);
    public void showProgress(boolean show);
    public void showMessage(String message);
    public void onFinishRequest();
}
