package com.icaksama.astacksearch.activities;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import com.icaksama.astacksearch.R;
import com.icaksama.astacksearch.presenters.MainPresenter;
import com.icaksama.astacksearch.presenters.listeners.MainListener;
import com.icaksama.astacksearch.utilities.ObjectWrapperForBinder;

public class MainActivity extends AppCompatActivity implements MainListener, AbsListView.OnScrollListener {

    private MainPresenter presenter;
    private ListView listView;
    private ProgressDialog dialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        this.listView = (ListView) findViewById(R.id.listView);
        presenter = new MainPresenter(getApplicationContext(), this);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.search) {
            Bundle bundle = new Bundle();
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                bundle.putBinder("mainPresenter", new ObjectWrapperForBinder(presenter));
            }
            Intent filterActivity = new Intent(getApplicationContext(), FilterActivity.class);
            filterActivity.putExtras(bundle);
            startActivity(filterActivity);
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public ListView getListView() {
        return listView;
    }

    @Override
    public void loadMore(boolean show) {}

    @Override
    public void showProgress(boolean show) {
        if (show) {
            dialog = ProgressDialog.show(MainActivity.this, "",
                    "Please wait...", true);
        } else {
            dialog.dismiss();
        }
    }

    @Override
    public void showMessage(String message) {
        Toast.makeText(getBaseContext(), message, Toast.LENGTH_LONG).show();
    }

    @Override
    public void onFinishRequest() {
        listView.setOnScrollListener(this);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                presenter.openBrowser(presenter.getItems().get(i).link);
            }
        });
    }

    @Override
    public void onScrollStateChanged(AbsListView absListView, int scrollState) {
        if(scrollState == SCROLL_STATE_IDLE && listView.getLastVisiblePosition() ==
                presenter.getItems().size() - 1){
            presenter.requestNextPage();
        }
    }

    @Override
    public void onScroll(AbsListView absListView, int firstVisibleItem, int visibleItemCount, int totalItemCount) {}
}
