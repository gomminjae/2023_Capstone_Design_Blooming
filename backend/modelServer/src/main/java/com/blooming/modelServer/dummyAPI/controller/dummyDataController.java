package com.blooming.modelServer.dummyAPI.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@RestController
public class dummyDataController {
    private static int decreasingVariable = 5; // Initial value

    private final String[] parkingLotName = {"IT 교수 주차장","IT 남쪽 주차장","법대 주차장","2공학관 주차장","경상대 남쪽 주차장","경상대 북쪽 주차장","본관 남쪽 주차장"};
    private final Integer[] emptySlot = {1,2,3,10,15,1};
    private final Integer[] total = {18,34,50,30,27, 17}; // empty + car
//    private final boolean[] favorite = {false, true};
    @GetMapping("/dummy")
    public ResponseEntity<Object> dummyController(){
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        ArrayList<Map<String, Object>> result = new ArrayList<>();
        Map<String, Object> dummyDatas;
        Random random = new Random();
        dummyDatas = new HashMap<>();
        dummyDatas.put("title", parkingLotName[0]);
        dummyDatas.put("total", total[0]);
        dummyDatas.put("empty", decreasingVariable);
        if (decreasingVariable >= 5) {
            decreasingVariable--;
        } else if (decreasingVariable <= 1) {
            decreasingVariable++;
        } else {
            // Randomly choose to increase or decrease by 1
            if (Math.random() < 0.5) {
                decreasingVariable++;
            } else {
                decreasingVariable--;
            }
        }
        dummyDatas.put("timeStamp", sdf.format(timestamp));
        result.add(dummyDatas);
        for(int i=1; i<6; i++) {
            dummyDatas = new HashMap<>();
            dummyDatas.put("title", parkingLotName[i]);
            dummyDatas.put("total", total[i]);
            dummyDatas.put("empty", emptySlot[i]);
            dummyDatas.put("timeStamp", sdf.format(timestamp));
            result.add(dummyDatas);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
