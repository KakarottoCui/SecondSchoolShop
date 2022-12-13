package com.secondshop.services;

import com.secondshop.mappers.ReviewMapper;
import com.secondshop.models.Reply;
import com.secondshop.models.Review;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReviewService {
	@Autowired
	private ReviewMapper reviewMapper;

	@Transactional
	public List<Review> gerReviewByGoodId(Integer goodId) {
		return reviewMapper.getReviewByGoodId(goodId);
	}

	@Transactional
	public List<Reply> gerReplyByReviewId(Integer reviewId) {
		return reviewMapper.getReplyByReviewId(reviewId);
	}

	@Transactional
	public int insertReview(Review review) {
		return reviewMapper.insertReview(review);
	}

	@Transactional
	public int insertReply(Reply reply) {
		return reviewMapper.insertReply(reply);
	}

	@Transactional
	public List<Review> gerReviewByToUserId(Integer toUserId) {
		return reviewMapper.getReviewByToUserId(toUserId);
	}

	@Transactional
	public List<Reply> gerReplyByToUserId(Integer toUserId) {
		return reviewMapper.getReplyByToUserId(toUserId);
	}

	@Transactional
	public int updateReviewStatus(int status, Integer reviewId) {
		return reviewMapper.updateReviewStatus(status, reviewId);
	}

	@Transactional
	public int updateReplyStatus(int status, Integer replyId) {
		return reviewMapper.updateReplyStatus(status, replyId);
	}

	@Transactional
	public Integer getGoodIdByReviewId(Integer reviewId) {
		return reviewMapper.getGoodIdByReviewId(reviewId);
	}
}
