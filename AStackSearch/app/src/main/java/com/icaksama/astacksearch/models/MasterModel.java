package com.icaksama.astacksearch.models;

import com.google.gson.annotations.SerializedName;
import com.icaksama.astacksearch.models.items.Item;

import java.util.List;

/**
 * Created by icaksama on 13/08/18.
 */

public class MasterModel {

    @SerializedName("items")
    public List<Item> items;

    @SerializedName("has_more")
    public boolean has_more;

    @SerializedName("quota_max")
    public int quota_max;

    @SerializedName("quota_remaining")
    public int quota_remaining;
}
