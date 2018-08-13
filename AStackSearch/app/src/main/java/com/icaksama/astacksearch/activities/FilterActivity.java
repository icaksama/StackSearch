package com.icaksama.astacksearch.activities;

import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.icaksama.astacksearch.R;
import com.icaksama.astacksearch.models.APIParams;
import com.icaksama.astacksearch.presenters.MainPresenter;
import com.icaksama.astacksearch.utilities.AStackSearchUtil;
import com.icaksama.astacksearch.utilities.ObjectWrapperForBinder;
import com.icaksama.astacksearch.utilities.SharedPreferenceHelper;

/**
 * Created by icaksama on 13/08/18.
 */

public class FilterActivity extends AppCompatActivity implements android.view.View.OnClickListener {

        private EditText tagInput, topicsInput, fromInput, toInput, sortInput, orderInput, pageSizeInput;
        private Button searchButton;
        private TextView resetLabel;
        private AStackSearchUtil util = new AStackSearchUtil();
        private MainPresenter mainPresenter;
        private SharedPreferenceHelper sPref;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.filter_layout);

             sPref = new SharedPreferenceHelper(getApplicationContext());

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                mainPresenter = (MainPresenter) ((ObjectWrapperForBinder)getIntent().getExtras().getBinder("mainPresenter")).getData();
            }

            resetLabel = (TextView) findViewById(R.id.resetLabel);
            resetLabel.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    topicsInput.setText("android");
                    tagInput.setText("");
                    fromInput.setText("");
                    toInput.setText("");
                    sortInput.setText("Activity");
                    orderInput.setText("Desc");
                    pageSizeInput.setText("10");
                }
            });

            topicsInput = (EditText) findViewById(R.id.topicInput);
            String intitle = sPref.getString("intitle").trim().isEmpty() ? "android" : sPref.getString("intitle");
            topicsInput.setText(intitle);

            tagInput = (EditText) findViewById(R.id.tagInput);
            tagInput.setText(sPref.getString("tagged"));

            fromInput = (EditText) findViewById(R.id.fromInput);
            String fromDate = sPref.getLong("fromdate") == 0 ? "" : util.getDate(sPref.getLong("fromdate"));
            fromInput.setText(fromDate);
            fromInput.setOnClickListener(this);

            toInput = (EditText) findViewById(R.id.toInput);
            String toDate = sPref.getLong("todate") == 0 ? "" : util.getDate(sPref.getLong("todate"));
            toInput.setText(toDate);
            toInput.setOnClickListener(this);

            sortInput = (EditText) findViewById(R.id.sortInput);
            String sort = sPref.getString("sort").trim().isEmpty() ? "Activity" : sPref.getString("sort");
            sortInput.setText(sort);
            sortInput.setOnClickListener(this);

            orderInput = (EditText) findViewById(R.id.orderInput);
            String order = sPref.getString("order").trim().isEmpty() ? "Desc" : sPref.getString("order");
            orderInput.setText(order);
            orderInput.setOnClickListener(this);

            pageSizeInput = (EditText) findViewById(R.id.pageSizeInput);
            String pagesize = sPref.getLong("pagesize") == 0 ? "10" :  sPref.getLong("pagesize") + "";
            pageSizeInput.setText(pagesize);
            pageSizeInput.setOnClickListener(this);

            searchButton = (Button) findViewById(R.id.searchButton);
            searchButton.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            switch (v.getId()) {
                case R.id.searchButton:
                    if (topicsInput.getText().toString().isEmpty()) {
                        Toast.makeText(this, "Please fill the topics!", Toast.LENGTH_LONG).show();
                    } else {
                        long fromDate = fromInput.getText().toString().trim().isEmpty() ? 0 : util.getMiliseconds(fromInput.getText().toString().trim());
                        long toDate = toInput.getText().toString().trim().isEmpty() ? 0 : util.getMiliseconds(toInput.getText().toString().trim());
                        APIParams apiParams = new APIParams(this, Long.parseLong(pageSizeInput.getText().toString()), fromDate, toDate,
                                orderInput.getText().toString().toLowerCase(), sortInput.getText().toString().toLowerCase(),
                                tagInput.getText().toString().toLowerCase(), topicsInput.getText().toString().toLowerCase());
                        if (mainPresenter != null) {
                            mainPresenter.filterResult(apiParams);
                        }
                        finish();
                    }
                    break;
                case R.id.fromInput:
                    util.showDatePicker(this, fromInput);
                    break;
                case R.id.toInput:
                    util.showDatePicker(this, toInput);
                    break;
                case R.id.sortInput:
                    util.showComboBox(this,
                            "Sort Type", new String[]{"Activity", "Votes", "Creation", "Relevance"}, sortInput);
                    break;
                case R.id.orderInput:
                    util.showComboBox(this,
                            "Order Type", new String[]{"Desc", "Asc"}, orderInput);
                    break;
                case R.id.pageSizeInput:
                    util.showComboBox(this,
                            "Sort Type", new String[]{"10", "20", "30", "50"}, pageSizeInput);
                    break;
                default:
                    break;
            }
        }
}
