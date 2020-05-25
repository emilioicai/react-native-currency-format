package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import java.text.NumberFormat;
import java.util.Currency;
import java.util.Locale;

public class CurrencyFormatModule extends ReactContextBaseJavaModule {
    private static final String E_FORMAT_ERROR = "E_FORMAT_ERROR";
    public CurrencyFormatModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }
    @Override
    public String getName() {
        return "CurrencyFormat";
    }
    @ReactMethod
    public void format(double amount, String currencyCode, Promise promise) {
        try {
            Currency currency = Currency.getInstance(currencyCode);
            NumberFormat format = NumberFormat.getCurrencyInstance(Locale.getDefault());
            format.setMaximumFractionDigits(currency.getDefaultFractionDigits());
            format.setCurrency(currency);
            promise.resolve(format.format(amount));
        } catch (Exception e) {
            promise.reject(E_FORMAT_ERROR, e);
        }
    }
}
