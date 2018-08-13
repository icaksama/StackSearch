package com.icaksama.astacksearch.models.items;

import com.google.gson.annotations.SerializedName;

/**
 * Created by icaksama on 13/08/18.
 */

public class Owner {

    @SerializedName("reputation")
    public int reputation;
    @SerializedName("user_id")
    public int user_id;
    @SerializedName("user_type")
    public String user_type;
    @SerializedName("profile_image")
    public String profile_image;
    @SerializedName("display_name")
    public String display_name;
    @SerializedName("link")
    public String link;
}
