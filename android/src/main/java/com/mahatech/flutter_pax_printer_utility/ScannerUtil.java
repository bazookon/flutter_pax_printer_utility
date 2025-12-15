package com.mahatech.flutter_pax_printer_utility;

import android.util.Log;

import com.pax.dal.IDAL;
import com.pax.dal.IScanner;
import com.pax.dal.entity.EScannerType;
import com.pax.dal.entity.ScanResult;

import io.flutter.plugin.common.EventChannel;

public class ScannerUtil {

    static void scan(final IDAL dal, final EventChannel.EventSink scannerSink) {
        try {
            // Utiliza el tipo de escáner disponible
            IScanner scanner = dal.getScanner(EScannerType.EXTERNAL);
            if (scanner == null) {
                Log.d("SCAN", "Scanner not found");
                return;

            }

            Log.i("SCAN", "Scanner found");

            // Start scanning
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        scanner.open();
                        scanner.start(new IScanner.IScanListener() {

                            @Override
                            public void onRead(ScanResult scanResult) {
                                Log.i("SCAN",scanResult.getContent());
                                scannerSink.success(scanResult.getContent());

                            }

                            @Override
                            public void onFinish() {
                                Log.i("SCAN", "Scanner finished");
                                scannerSink.endOfStream();

                            }

                            @Override
                            public void onCancel() {
                                Log.i("SCAN", "Scanner canceled");
                                scannerSink.error("SCAN", "Scanner canceled", null);

                            }
                        });
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });

        } catch (Exception e) {
            Log.e("SCAN", e.getMessage());
            e.printStackTrace();
        }
    }

}
