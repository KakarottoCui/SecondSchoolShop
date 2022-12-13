package com.secondshop.services;

import com.secondshop.mappers.FirstTypeMapper;
import com.secondshop.mappers.SecondTypeMapper;
import com.secondshop.models.FirstType;
import com.secondshop.models.SecondType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TypeService {
	@Autowired
	private FirstTypeMapper firstTypeMapper;
	@Autowired
	private SecondTypeMapper secondTypeMapper;

	@Transactional
	public List<FirstType> getAllFirstType() {
		return firstTypeMapper.getAllFirstType();
	}

	@Transactional
	public List<SecondType> getSecondTypeByFirstTypeId(int firstTypeId) {
		return secondTypeMapper.getSecondTypeByFirstTypeId(firstTypeId);
	}

	@Transactional
	public SecondType getSecondTypeById(int secondTypeId) {
		return secondTypeMapper.getSecondTypeById(secondTypeId);
	}

	@Transactional
	public Boolean createFirstType(FirstType firstType) {
		Integer firstTypeId = firstTypeMapper.getFirstTypeLastId();
		if (firstTypeId == null) {
			firstTypeId = 1000;
		}
		firstType.setId(firstTypeId + 1);
		return firstTypeMapper.createFirstType(firstType) > 0;
	}

	@Transactional
	public Boolean createSecondType(SecondType secondType) {
		Integer firstTypeId = secondTypeMapper.getSecondTypeLastId(secondType
				.getFirstTypeId());
		if (firstTypeId == null) {
			firstTypeId = secondType.getFirstTypeId() * 1000;
		}
		secondType.setId(firstTypeId + 1);
		return secondTypeMapper.createSecondType(secondType) > 0;
	}

	@Transactional
	public Boolean deleteFirstType(Integer firstTypeId) {
		return firstTypeMapper.deleteFirstType(firstTypeId) > 0;
	}

	@Transactional
	public Boolean deleteSecondType(Integer secondTypeId) {
		return secondTypeMapper.deleteSecondType(secondTypeId) > 0;
	}
}
