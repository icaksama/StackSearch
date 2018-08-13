package com.icaksama.astacksearch.presenters;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.icaksama.astacksearch.adapters.ListItemAdapter;
import com.icaksama.astacksearch.models.APIParams;
import com.icaksama.astacksearch.models.MasterModel;
import com.icaksama.astacksearch.models.items.Item;
import com.icaksama.astacksearch.presenters.listeners.CompletionListener;
import com.icaksama.astacksearch.presenters.listeners.HTTPCompletionListener;
import com.icaksama.astacksearch.presenters.listeners.MainListener;
import com.icaksama.astacksearch.utilities.AStackSearchUtil;

import org.json.JSONObject;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by icaksama on 13/08/18.
 */

public class MainPresenter implements Serializable {

    private AStackSearchUtil util = new AStackSearchUtil();
    private List<String> titles = new ArrayList<String>();
    private ListItemAdapter listItemAdapter;
    private APIParams apiParamObj;
    private MainListener listener;
    private MasterModel model;
    private int pagination= 2;
    private Context context;
    private Gson gson;

    public MainPresenter(Context context, final MainListener listener) {
        this.context = context;
        this.listener = listener;
        this.apiParamObj = new APIParams(context);

        // Init GSON
        GsonBuilder gsonBuilder = new GsonBuilder();
        gsonBuilder.setDateFormat("dd/MM/yyyy");
        gson = gsonBuilder.create();

        // Request items for first time
        listener.showProgress(true);
        requestItems(1, new CompletionListener() {
            @Override
            public void completion(boolean isSuccess, String message) {
                // Init list adapter
                listItemAdapter = new ListItemAdapter(MainPresenter.this.context, model, titles);
                listener.getListView().setAdapter(listItemAdapter);
                listener.showProgress(false);
                if (!isSuccess) {
                    listener.showMessage("Request data failed! Please try another topics.");
                }
            }
        });
    }

    public void requestItems(final int page, final CompletionListener completionListener) {
        String url = util.getAPI(apiParamObj, page);
        System.out.println(url);
        util.requestData(context, url, new HTTPCompletionListener() {
            @Override
            public void completion(boolean isSuccess, String message, JSONObject jsonObject) {
                if (isSuccess) {
                    model = gson.fromJson(jsonObject.toString(), MasterModel.class);
                    for (Item item: model.items) {
                        titles.add(item.title);
                    }
                    if (listItemAdapter != null) {
                        listItemAdapter.addNewData(model.items, new CompletionListener() {
                            @Override
                            public void completion(boolean isSuccess, String message) {
                                listItemAdapter.notifyDataSetChanged();
                            }
                        });
                    }
                    listener.onFinishRequest();
                }
                completionListener.completion(isSuccess, message);
            }
        });
    }

    public void requestNextPage() {
        if (model.has_more) {
            listener.loadMore(true);
            requestItems(pagination, new CompletionListener() {
                @Override
                public void completion(boolean isSuccess, String message) {
                    if (isSuccess) {
                        listener.loadMore(false);
                        pagination += 1;
                    } else {
                        listener.loadMore(false);
                        listener.showMessage(message);
                    }
                }
            });
        }
    }

    public List<Item> getItems() {
        return listItemAdapter.getItems();
    }

    /** Open stackoverflow question in browser  */
    public void openBrowser(String link) {
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(link));
        context.startActivity(browserIntent);
    }

    public void filterResult(APIParams apiParams) {
        pagination = 2;
        apiParamObj = apiParams;
        titles.clear();
        listener.showProgress(true);
        requestItems(1, new CompletionListener() {
            @Override
            public void completion(boolean isSuccess, String message) {
                // Init list adapter
                listItemAdapter = new ListItemAdapter(MainPresenter.this.context, model, titles);
                listener.getListView().setAdapter(listItemAdapter);
                MainPresenter.this.listener.showProgress(false);
                if(!isSuccess) {
                    MainPresenter.this.listener.showMessage(message);
                }
            }
        });
    }
}
