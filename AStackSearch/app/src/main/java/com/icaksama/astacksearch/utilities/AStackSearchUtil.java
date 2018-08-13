package com.icaksama.astacksearch.utilities;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.widget.DatePicker;
import android.widget.EditText;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.icaksama.astacksearch.models.APIParams;
import com.icaksama.astacksearch.presenters.listeners.HTTPCompletionListener;

import org.json.JSONObject;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 * Created by icaksama on 13/08/18.
 */

public class AStackSearchUtil {

    public String getAPI(APIParams apiParams, int page) {
        return Config.BASE_DOMAIN + Config.SEARCH + "?page=" + page +
                "&pagesize=" + apiParams.pagesize +
                (apiParams.fromdate != 0 ? "&fromdate=" + apiParams.fromdate : "") +
                (apiParams.todate != 0 ? "&todate=" + apiParams.todate : "") +
                "&order=" + apiParams.order +
                "&sort=" + apiParams.sort +
                (apiParams.tagged.trim().isEmpty() ? "" : "&tagged=" + apiParams.tagged) +
                (apiParams.intitle.trim().isEmpty()? "" : "&intitle=" + apiParams.intitle) +
                "&site=stackoverflow";
    }

    public void requestData(Context context, String url, final HTTPCompletionListener listener) {
        RequestQueue requestQueue = Volley.newRequestQueue(context);
        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, url, null,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject jsonObject) {
                        listener.completion(true, "Success!", jsonObject);
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                listener.completion(true, volleyError.getMessage(), null);
            }
        });
        requestQueue.add(jsonObjectRequest);
    }

    public String getDate(long unixtime) {
        Date date = new java.util.Date(unixtime * 1000L);
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyy");
        sdf.setTimeZone(java.util.TimeZone.getTimeZone("GMT-4"));
        return sdf.format(date);
    }

    public long getMiliseconds(String date) {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        long unixTime = 0;
        dateFormat.setTimeZone(TimeZone.getTimeZone("GMT-4")); //Specify your timezone
        try {
            unixTime = dateFormat.parse(date).getTime();
            unixTime = unixTime / 1000;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return unixTime;
    }

    public void showDatePicker(Activity activity, final EditText editText) {
        final Calendar calendar = Calendar.getInstance();
        int yy = calendar.get(Calendar.YEAR);
        int mm = calendar.get(Calendar.MONTH);
        int dd = calendar.get(Calendar.DAY_OF_MONTH);
        DatePickerDialog datePicker = new DatePickerDialog(activity, new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                String date = String.valueOf(dayOfMonth) + "/" + String.valueOf(monthOfYear+1)
                        + "/" + String.valueOf(year);
                editText.setText(date);
            }
        }, yy, mm, dd);
        datePicker.show();
    }

    public void showComboBox(Activity activity, String title, final String[] data, final EditText editText) {
        AlertDialog.Builder b = new AlertDialog.Builder(activity);
        b.setTitle(title);
        b.setItems(data, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                editText.setText(data[which]);
                dialog.dismiss();
            }

        });
        b.show();
    }
}
