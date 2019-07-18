package servlet;

import bean.UserEntry;
import dao.UserDaoImpl;
import factory.DaoFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 16:01
 */
@WebServlet(name = "LoginServlet",value = "/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        System.out.println(account);
        System.out.println(password);
        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            UserEntry userEntry = userDao.findByAccount(account);
            if(userEntry == null){
                //用户不存在
                System.out.println("not exist");
            }else if(!userEntry.getPassword().equals(password)){
                //错误的密码
                System.out.println("wrong password");
            }else {
                //正确的登录
                HttpSession session = request.getSession();
                session.setAttribute("user",userEntry);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                dispatcher.forward(request,response);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}