package com.secondshop.controllers;

import com.secondshop.models.FirstType;
import com.secondshop.models.SecondType;
import com.secondshop.services.GoodService;
import com.secondshop.services.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("type")
public class TypeController {
	private final TypeService typeService;
	private final GoodService goodService;

	@Autowired
	public TypeController(TypeService typeService, GoodService goodService) {
		this.typeService = typeService;
		this.goodService = goodService;
	}

	@RequestMapping(value = "/secondType/{firstTypeId}", method = RequestMethod.GET)
	public ResponseEntity getSecondTypeId(@PathVariable Integer firstTypeId) {
		List<SecondType> secondTypes = typeService
				.getSecondTypeByFirstTypeId(firstTypeId);
		if (secondTypes == null) {
			return ResponseEntity.ok("isNull");
		}
		return ResponseEntity.ok(secondTypes);
	}

	@RequestMapping(value = "/secondType/delete/{secondTypeId}", method = RequestMethod.GET)
	public ResponseEntity deleteSecondType(@PathVariable Integer secondTypeId) {
		Boolean success = goodService.getGoodsAdminByType(secondTypeId)
				.isEmpty();
		System.out.println(goodService.getGoodsAdminByType(secondTypeId));
		if (success) {
			Integer thisFirstTypeId = typeService.getSecondTypeById(
					secondTypeId).getFirstTypeId();
			success = typeService.deleteSecondType(secondTypeId);
			if (success) {
				List<SecondType> secondTypeList = typeService
						.getSecondTypeByFirstTypeId(thisFirstTypeId);
				if (secondTypeList == null) {
					return ResponseEntity.ok("isNull");
				}
				return ResponseEntity.ok(secondTypeList);
			}
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/firstType/delete/{firstTypeId}", method = RequestMethod.GET)
	public ResponseEntity deleteFirstType(@PathVariable Integer firstTypeId) {
		Boolean success = typeService.getSecondTypeByFirstTypeId(firstTypeId)
				.isEmpty();
		if (success) {
			success = typeService.deleteFirstType(firstTypeId);
			if (success) {
				List<FirstType> firstTypeList = typeService.getAllFirstType();
				if (firstTypeList == null) {
					return ResponseEntity.ok("isNull");
				}
				return ResponseEntity.ok(firstTypeList);
			}
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/secondType/create", method = RequestMethod.POST)
	public ResponseEntity createSecondType(@RequestBody SecondType secondType) {
		Integer thisFirstTypeId = secondType.getFirstTypeId();
		Boolean success = typeService.createSecondType(secondType);
		if (success) {
			List<SecondType> secondTypeList = typeService
					.getSecondTypeByFirstTypeId(thisFirstTypeId);
			return ResponseEntity.ok(secondTypeList);
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/firstType/create", method = RequestMethod.POST)
	public ResponseEntity createSecondType(@RequestBody FirstType firstType) {
		Boolean success = typeService.createFirstType(firstType);
		if (success) {
			List<FirstType> firstTypeList = typeService.getAllFirstType();
			return ResponseEntity.ok(firstTypeList);
		}
		return ResponseEntity.ok(success);
	}
}
