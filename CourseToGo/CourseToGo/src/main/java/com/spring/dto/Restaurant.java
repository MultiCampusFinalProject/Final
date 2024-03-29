package com.spring.dto;




import lombok.Builder;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
@Setter
@Getter
public class Restaurant {
	
	  private int foodCertificationSerialNumber;
	    private String establishmentName;
	    private int districtCode;
	    private String districtName;
	    private String businessTypeCode;
	    private String businessTypeName;
	    private String mapYCoordinate;
	    private String mapXCoordinate;
	    private String phoneNumber;
//	    private String roadDetailAddress;
//	    private String roadAddressCode;
	    private String roadAddress;
	    // 생성자
	    @Builder
	    public Restaurant(int foodCertificationSerialNumber, String establishmentName, int districtCode, String districtName,
	                      String businessTypeCode, String businessTypeName, String mapYCoordinate, String mapXCoordinate,
	                      String phoneNumber, String roadDetailAddress, String roadAddressCode, String roadAddress) {
	        this.foodCertificationSerialNumber = foodCertificationSerialNumber;
	        this.establishmentName = establishmentName;
	        this.districtCode = districtCode;
	        this.districtName = districtName;
	        this.businessTypeCode = businessTypeCode;
	        this.businessTypeName = businessTypeName;
	        this.mapYCoordinate = mapYCoordinate;
	        this.mapXCoordinate = mapXCoordinate;
	        this.phoneNumber = phoneNumber;
//	        this.roadDetailAddress = roadDetailAddress;
//	        this.roadAddressCode = roadAddressCode;
	        this.roadAddress = roadAddress;
	    }

}
