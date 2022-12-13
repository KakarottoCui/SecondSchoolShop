package com.secondshop.mappers;

import com.secondshop.models.Reply;
import com.secondshop.models.Review;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface ReviewMapper {
    @Select("select * from review where good_id = #{goodId} ORDER BY upload_date DESC;")
    List<Review> getReviewByGoodId(Integer goodId);

    @Select("select * from reply where review_id = #{reviewId} ORDER BY upload_date;")
    List<Reply> getReplyByReviewId(Integer reviewId);

    @Insert("insert into review(good_id, from_user, from_user_id, to_user_id, text, upload_date, status) values(#{goodId}, #{fromUser}, #{fromUserId}, #{toUserId}, #{text}, now(), 0);")
    int insertReview(Review review);

    @Insert("insert into reply (review_id, from_user, from_user_id, to_user, to_user_id, text, upload_date, status) values(#{reviewId}, #{fromUser}, #{fromUserId}, #{toUser}, #{toUserId}, #{text}, now(), 0);")
    int insertReply(Reply reply);

    @Select("select * from review where to_user_id = #{toUserId} ORDER BY upload_date DESC;")
    List<Review> getReviewByToUserId(Integer toUserId);

    @Select("select * from reply where to_user_id = #{toUserId} ORDER BY upload_date DESC;")
    List<Reply> getReplyByToUserId(Integer toUserId);

    @Select("select good_id from review where id = #{reviewId}")
    Integer getGoodIdByReviewId(Integer reviewId);

    @Update("UPDATE review SET status = #{0} WHERE id = #{1};")
    int updateReviewStatus(int status, Integer reviewId);

    @Update("UPDATE reply SET status = #{0} WHERE id = #{1};")
    int updateReplyStatus(int status, Integer replyId);
}
