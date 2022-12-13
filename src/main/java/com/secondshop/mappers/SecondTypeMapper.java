package com.secondshop.mappers;

import com.secondshop.models.SecondType;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SecondTypeMapper {

	@Select("select * from second_type where first_type_id = #{firstTypeId}")
	List<SecondType> getSecondTypeByFirstTypeId(int firstTypeId);

	@Select("select id from second_type where first_type_id = #{firstTypeId} ORDER BY id desc limit 0, 1;")
	Integer getSecondTypeLastId(Integer firstTypeId);

	@Select("select * from second_type where id = #{secondTypeId}")
	SecondType getSecondTypeById(int secondTypeId);

	@Delete("delete from second_type where id = #{secondTypeId};")
	int deleteSecondType(Integer secondTypeId);

	@Insert("insert into second_type(id, first_type_id, name) values(#{id}, #{firstTypeId}, #{name});")
	int createSecondType(SecondType secondType);
}
