<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Item" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 21:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>他人主页</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>

<%
    if (session.getAttribute("user")==null){
        response.sendRedirect("/index.jsp");
    }
    String friendID = request.getParameter("friendId");
    List<Item> friendCollections = new ArrayList<>();
    if(request.getAttribute("friendInformation") == null){
        request.getRequestDispatcher("/friendInfo?friendId="+friendID).forward(request,response);
    }else {
        friendCollections = (List<Item>)request.getAttribute("friendCollections");
    }
    UserEntry friendEntry = (UserEntry)request.getAttribute("friendInformation");
    int relation = (Integer)request.getAttribute("relation");
%>

<div id="nav-back">
    <div id="navitems-row">
        <div class="container">
            <div class="row">
                <div class="col-2">
                    <a href="index.jsp" class="nav-link text-dark"><span class="h3">Logo</span></a>
                </div>
                <div class="col-10 text-right">
                    <ul class="nav justify-content-end">
                        <li class="nav-item">
                            <a href="index.jsp" class="nav-link text-dark navitems">
                                <span class=""> 主页 </span></a>
                        </li>
                        <%
                            if(session.getAttribute("user")!=null){
                        %>
                        <li class="nav-item dropdown">
                            <a href="#" class="nav-link text-dark navitems dropdown-toggle" data-toggle="dropdown">
                                <span class="">${user.name}</span></a>
                            <b class="caret"></b>
                            <ul class="dropdown-menu text-center">
                                <li><a class="dropdown-item" href="userInformation.jsp">个人信息</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="friendList.jsp">好友列表</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="collection.jsp">我的收藏</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/LoginOutServlet">登    出</a></li>
                            </ul>
                        </li>
                        <%  UserEntry userEntry = (UserEntry)session.getAttribute("user");
                            if(userEntry.isAdmin()){%>
                        <li class="nav-item dropdown">
                            <a href="" class="nav-link text-dark navitems dropdown-toggle" data-toggle="dropdown">
                                <span class=""> 管    理 </span></a>
                            <b class="caret"></b>
                            <ul class="dropdown-menu text-center">
                                <li><a class="dropdown-item" href="userManage.jsp">用户管理</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="uploadItem.jsp">上传展品</a></li>
                            </ul>
                        </li>
                        <%}}%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <br><br><br>
    <div class="container">
        <div class="row">
            <div class="col-8"></div>
            <div class="col-3">
                <form method="get" id="search-form" action="/search">
                    <input type="text" class="form-control" id="search-input" placeholder="想要找什么展品呢" name="keyword">
                </form>
            </div>
            <div class="col-1">
                <button class="btn btn-default" id="search-button">搜索</button>
            </div>
        </div>
    </div>
</div>
<br>
<div class="container">
    <div class="row">
        <div class="col-4">
            <br>

            <div class="card">
                <div class="card-header">
                    <h4><%=friendEntry.getName()%></h4>
                </div>
                <div class="card-body">
                    <h5>个性签名:</h5>
                    <p><%=friendEntry.getSignature()%></p>
                    <h5>邮箱:</h5>
                    <p><%=friendEntry.getEmail()%></p>
                </div>
                <div class="card-footer">
                    <form action="/friendInfo" method="post">
                        <div class="form-group">
                            <input value="<%=friendEntry.getId()%>" name="friend-id" hidden>
                            <%if(relation==0){%>
                            <a class="btn btn-info" href="message.jsp?friend=<%=friendEntry.getId()%>">发送消息</a>
                            <button class="btn btn-danger" type="submit" name="opt" value="delete">删除好友</button>
                            <%}else if(relation==1){%>
                            <input type="button" class="btn" value="已申请">
                            <%}else if(relation==2){%>
                            <button class="btn btn-info" type="submit" name="opt" value="agree">接受请求</button>
                            <button class="btn btn-info" type="submit" name="opt" value="reject">拒绝请求</button>
                            <%}else{%>
                            <button class="btn btn-info" type="submit" name="opt" value="send">申请好友</button>
                            <%}%>
                        </div>
                    </form>
                </div>
            </div>

        </div>
        <div class="col-8">
            <div class="container">
                <div class="row">
                    <h4>TA的近期收藏</h4>
                </div>
                <%
                    for(Item item : friendCollections){
                        %>
                <a href="detail.jsp?id=<%=item.getItemId()%>" class="card-link">
                    <div class="card">
                        <div class="row">
                            <div class="col-3">
                                <img class="card-img" src="<%=item.getImagePath()%>">
                            </div>
                            <div class="col-9">
                                <div class="container">
                                    <br>
                                    <h5 class="text-dark"><%=item.getName()%></h5>
                                    <p class="text-dark"><%=item.getDescription().substring(0,70<item.getDescription().length()?70:item.getDescription().length()-1)%>...</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>




<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">
    /*下拉菜单*/
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });

    var btSearch = document.getElementById("search-button");
    btSearch.onclick = function () {
        var keyword = document.getElementById("search-input").value;
        var form =  document.getElementById("search-form");
        form.submit();
    }
</script>

</body>
</html>
