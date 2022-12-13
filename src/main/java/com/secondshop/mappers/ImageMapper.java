package com.secondshop.mappers;

import com.secondshop.models.Image;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ImageMapper {
	@Select("select * from image where good_id = #{goodId};")
	List<Image> getImageByGoodId(Integer goodId);

	@Insert("insert into image(good_id, name, url) values(#{goodId}, #{name}, #{url});")
	int insertImage(Image image);

	@Delete("delete from image where good_id = #{goodId};")
	int deleteImage(Integer goodId);
}
