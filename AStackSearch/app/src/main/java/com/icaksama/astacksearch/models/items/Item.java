package com.icaksama.astacksearch.models.items;

import com.google.gson.annotations.SerializedName;

import java.util.List;

/**
 * Created by icaksama on 13/08/18.
 */

public class Item {

    @SerializedName("tags")
    public List<String> tags;
    @SerializedName("owner")
    public Owner owner;
    @SerializedName("is_answered")
    public boolean is_answered;
    @SerializedName("view_count")
    public int view_count;
    @SerializedName("answer_count")
    public int answer_count;
    @SerializedName("score")
    public int score;
    @SerializedName("last_activity_date")
    public long last_activity_date;
    @SerializedName("creation_date")
    public long creation_date;
    @SerializedName("last_edit_date")
    public long last_edit_date;
    @SerializedName("question_id")
    public int question_id;
    @SerializedName("link")
    public String link;
    @SerializedName("title")
    public String title;
}