package com.icaksama.astacksearch.utilities;

import android.os.Binder;

/**
 * Created by icaksama on 13/08/18.
 */

public class ObjectWrapperForBinder extends Binder {

    private final Object mData;

    public ObjectWrapperForBinder(Object data) {
        mData = data;
    }

    public Object getData() {
        return mData;
    }
}
