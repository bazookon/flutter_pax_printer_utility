package com.mahatech.flutter_pax_printer_utility;

import com.pax.dal.IDAL;
import com.pax.dal.IScanner;
import com.pax.dal.IScannerHw;
import com.pax.dal.entity.EScannerType;

import io.flutter.plugin.common.MethodChannel;

public class ScannerUtil {

    static void scan(final IDAL dal, final MethodChannel.Result result) {

        try {
            final IScanner scannerHw = dal.getScanner();
            scannerHw.open();
            scannerHw.read(1);


        } catch (Exception e) {
            result.error("SCAN_ERROR", e.getMessage(), null);
            e.printStackTrace();
        }
    }

}
