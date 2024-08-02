package com.mahatech.flutter_pax_printer_utility;

import android.util.Log;

import com.pax.dal.IDAL;
import com.pax.dal.IScanner;
import com.pax.dal.entity.EScannerType;

import io.flutter.plugin.common.MethodChannel;

public class ScannerUtil {

    static void scan(final IDAL dal, final MethodChannel.Result result) {
        try {
            // Utiliza el tipo de escáner disponible
            IScanner scanner = dal.getScanner(EScannerType.LEFT);
            if (scanner == null) {
                result.error("SCAN_ERROR", "Scanner not found", null);
                Log.d("SCAN", "Scanner not found");
                return;
            }



            // Start scanning
            scanner.start(new IScanner.IScanListener() {
                @Override
                public void onRead(String s) {

                    Log.i("SCAN", s);
                    result.success(s);
                }

                @Override
                public void onFinish() {

                }

                @Override
                public void onCancel() {

                }
            });

        } catch (Exception e) {
            result.error("SCAN_ERROR", e.getMessage(), null);
            e.printStackTrace();
        }
    }

}
