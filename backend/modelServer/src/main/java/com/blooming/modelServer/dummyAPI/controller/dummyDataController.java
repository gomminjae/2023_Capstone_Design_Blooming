package com.blooming.modelServer.dummyAPI.controller;

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

    private final String[] parkingLotName = {"IT 교수 주차장","IT 남쪽 주차장","법대 주차장","2공학관 주차장","경상대 남쪽 주차장","경상대 북쪽 주차장","본관 남쪽 주차장"};
    private final String[] status = {"Full","Free"};
    private final boolean[] favorite = {false, true};
    private final Object[] dummy1 = {};
    @GetMapping("/dummy")
    public ArrayList<Map<String, Object>> dummyController(){
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        ArrayList<Map<String,Object>> result = new ArrayList<>();
        Map<String, Object> dummyDatas;
        Random random = new Random();
        for(int i=0; i<6; i++){
            dummyDatas = new HashMap<>();
            dummyDatas.put("parkingLotName", parkingLotName[i]);
            dummyDatas.put("status", status[random.nextInt(status.length)]);
            dummyDatas.put("favorite", favorite[random.nextInt(favorite.length)]);
            dummyDatas.put("timeStamp", sdf.format(timestamp));
            result.add(dummyDatas);
        }
        return result;
    }
}
