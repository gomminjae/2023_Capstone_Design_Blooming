package com.blooming.modelServer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@EnableFeignClients
@SpringBootApplication
public class ModelServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ModelServerApplication.class, args);
	}
}
