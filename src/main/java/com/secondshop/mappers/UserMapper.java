package com.secondshop.mappers;

import com.secondshop.models.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface UserMapper {

    @Select("select * from user;")
    List<User> getAllUser();

    @Select("select * from user where id = #{id}")
    User getUserById(int id);

    @Select("select * from user where email = #{email}")
    User getUserByEmail(String email);

    @Select("select * from user where mobile = #{mobile}")
    User getUserByMobile(String mobile);

    @Insert("insert into user (name, mobile, email, password, code, photo_url, role_id, gender, register_date, status_id) " +
            "values (#{name}, #{mobile}, #{email}, #{password}, #{code}, '/statics/image/photos/default/default.png', 102, #{gender}, now(), 4);")
    int insertUser(User user);

    @Update("UPDATE user SET name = #{name}, mobile = #{mobile}, email = #{email}, gender = #{gender}, photo_url = #{photoUrl} where id = #{id};")
    int updateUser(User user);

    @Delete("delete from user where id = #{userId};")
    int deleteUser(Integer userId);

    @Update("update user set status_id = #{0} where id = #{1};")
    int updateUserStatus(Integer statusId, Integer userId);

    @Update("update user set password = #{0}, code = #{1} where id = #{2};")
    int updatePassword(String newPassword, String code, Integer userId);
}
