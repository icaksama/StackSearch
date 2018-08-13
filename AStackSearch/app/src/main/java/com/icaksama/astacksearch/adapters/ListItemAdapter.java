package com.icaksama.astacksearch.adapters;

import android.content.Context;
import android.os.Build;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.icaksama.astacksearch.R;
import com.icaksama.astacksearch.models.MasterModel;
import com.icaksama.astacksearch.models.items.Item;
import com.icaksama.astacksearch.presenters.listeners.CompletionListener;
import com.icaksama.astacksearch.utilities.AStackSearchUtil;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by icaksama on 13/08/18.
 */

public class ListItemAdapter extends ArrayAdapter<String> {

    private final Context context;
    private final List<Item> items = new ArrayList<Item>();
    private final AStackSearchUtil util = new AStackSearchUtil();
    private final List<String> profiles = new ArrayList<String>();
    private final List<String> names = new ArrayList<String>();
    private final List<Integer> answers = new ArrayList<Integer>();
    private final List<Integer> views = new ArrayList<Integer>();
    private final List<Long> dates = new ArrayList<Long>();
    private final List<String> titles = new ArrayList<String>();
    private final List<Integer> reputations = new ArrayList<Integer>();

    public ListItemAdapter(Context context, MasterModel model, List<String> titlesTemp) {
        super(context, R.layout.list_item_layout, titlesTemp);
        this.context = context;
        items.addAll(model.items);
        for (Item item : items) {
            profiles.add(item.owner.profile_image);
            names.add(item.owner.display_name);
            answers.add(item.answer_count);
            views.add(item.view_count);
            dates.add(item.creation_date);
            titles.add(item.title);
            reputations.add(item.owner.reputation);
        }
    }

    public List<Item> getItems() {
        return items;
    }

    public void addNewData(List<Item> items, CompletionListener completionListener) {
        this.items.addAll(items);
        for (Item item : items) {
            profiles.add(item.owner.profile_image);
            names.add(item.owner.display_name);
            answers.add(item.answer_count);
            views.add(item.view_count);
            dates.add(item.creation_date);
            titles.add(item.title);
            reputations.add(item.owner.reputation);
        }
        completionListener.completion(true, "success");
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View rowView = inflater.inflate(R.layout.list_item_layout, parent, false);

        ImageView prifleImage = (ImageView) rowView.findViewById(R.id.profileImage);
        TextView nameLabel = (TextView) rowView.findViewById(R.id.nameLabel);
        TextView answerLabel = (TextView) rowView.findViewById(R.id.answerLabel);
        TextView viewLabel = (TextView) rowView.findViewById(R.id.viewLabel);
        TextView dateLabel = (TextView) rowView.findViewById(R.id.dateLabel);
        TextView titleLabel = (TextView) rowView.findViewById(R.id.titleLabel);
        TextView reputationLabel = (TextView) rowView.findViewById(R.id.reputationLabel);
        LinearLayout tagsLinearLayout = (LinearLayout) rowView.findViewById(R.id.tagsLinearLayout);

        Picasso.get().load(profiles.get(position)).into(prifleImage);
        nameLabel.setText(names.get(position));
        answerLabel.setText(answers.get(position) + " answers");
        viewLabel.setText(views.get(position) + " views");
        dateLabel.setText(util.getDate(dates.get(position)));
        titleLabel.setText(titles.get(position));
        reputationLabel.setText(reputations.get(position).toString());


        RelativeLayout.LayoutParams params=new RelativeLayout.LayoutParams
                ((int) RelativeLayout.LayoutParams.WRAP_CONTENT, (int) RelativeLayout.LayoutParams.WRAP_CONTENT);
        params.leftMargin = 10;

        for (String tag : items.get(position).tags) {
            TextView textView = new TextView(context);
            textView.setText(tag);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                textView.setBackgroundColor(context.getResources().getColor(R.color.tagBackground, null));
                textView.setTextColor(context.getResources().getColor(R.color.tagColor, null));
            } else {
                textView.setBackgroundColor(context.getResources().getColor(R.color.tagBackground));
                textView.setTextColor(context.getResources().getColor(R.color.tagColor));
            }
            textView.setTextSize(9);
            textView.setPadding(10, 10, 10, 10);
            textView.setLayoutParams(params);
            tagsLinearLayout.addView(textView);
        }

        return rowView;
    }
}
