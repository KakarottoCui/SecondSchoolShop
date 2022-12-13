package com.secondshop.controllers;

import com.secondshop.models.User;
import com.secondshop.services.UserService;
import com.secondshop.utils.InfoCheck;
import com.secondshop.utils.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class HomeController {
    private final UserService userService;

    @Autowired
    public HomeController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(ModelMap mode, HttpServletRequest request) {
        String preURL = request.getHeader("Referer");
        mode.addAttribute("preURL", preURL);
        return "home/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginSubmit(ModelMap model,
                              @RequestParam(value = "preURL", required = false, defaultValue = "") String preURL,
                              @RequestParam(value = "email", required = false) String email,
                              @RequestParam(value = "password", required = false) String password,
                              HttpSession session) {
        User user = userService.getUserByEmail(email);
        String message;
        if (user != null){
            String mdsPass = DigestUtils.md5DigestAsHex((password + user.getCode()).getBytes());
            if (!mdsPass .equals(user.getPassword())){
                message = "用户密码错误！";
            } else {
                if (user.getStatusId() == 4){
                    session.setAttribute("user",user);
                    if (preURL.equals("")){
                        return "redirect:/";
                    } else {
                        return "redirect:" + preURL;
                    }
                } else {
                    message = "用户已失效！";
                }
            }
        } else {
            message = "用户不存在！";
        }
        model.addAttribute("message", message);
        return "home/login";
    }


    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(@RequestParam(required = false, defaultValue = "false" )String logout, HttpSession session){
        if (logout.equals("true")){
            session.removeAttribute("user");
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(ModelMap model) {
        User user = new User();
        model.addAttribute("user", user);
        return "home/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerSuccess(ModelMap model,
                                  @Valid User user) {
        String status;
        Boolean insertSuccess;
        InfoCheck infoCheck = new InfoCheck();
        if (!infoCheck.isMobile(user.getMobile())){
            status = "请输入正确的手机号！";
        } else if (!infoCheck.isEmail(user.getEmail())){
            status = "请输入正确的邮箱！";
        } else if (userService.getUserByMobile(user.getMobile()) != null) {
            status = "此手机号码已使用！";
        } else if (userService.getUserByEmail(user.getEmail()) != null) {
            status = "此邮箱已使用！";
        } else if (user.getPassword2() == null){
            status = "请确认密码！";
        } else {
            RandomString randomString = new RandomString();
            user.setCode(randomString.getRandomString(5));
            String md5Pass = DigestUtils.md5DigestAsHex((user.getPassword() + user.getCode()).getBytes());
            user.setPassword(md5Pass);
            insertSuccess = userService.registerUser(user);
            if (insertSuccess){
                return "home/login";
            } else {
                status = "注册失败！";
                model.addAttribute("user", user);
                model.addAttribute("status", status);
                return "home/register";
            }
        }
        System.out.println(user.getMobile());
        System.out.println(status);
        model.addAttribute("user", user);
        model.addAttribute("status", status);
        return "home/register";
    }
}