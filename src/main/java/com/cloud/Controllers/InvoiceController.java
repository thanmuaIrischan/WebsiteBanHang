package com.cloud.Controllers;

import com.cloud.Daos.InvoiceDao;
import com.cloud.Daos.OrderProductDao;
import com.cloud.Models.Invoice;
import com.cloud.Models.OrderProduct;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.List;

@WebServlet("/admin/invoice")
public class InvoiceController extends HttpServlet {
    InvoiceDao invoiceDao;
    OrderProductDao orderProduct;
    public void init(){

        invoiceDao = new InvoiceDao();
        orderProduct = new OrderProductDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       if(request.getParameter("orderid")==null)
        getInvoice(request,response);
       else{
           getOrderProduct(request,response);
       }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        updateInvoice(request,response);
    }
    void updateInvoice(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
            int idinvoice =Integer.parseInt( request.getParameter("idinvoice"));
            int status = Integer.parseInt(request.getParameter("status"));
            if(invoiceDao.updateInvoice(idinvoice,status)){
//                response.setContentType("application/json");
//                response.getWriter().println("{\"idinvoice\":\"" + idinvoice + "\"}");
                response.setStatus(HttpServletResponse.SC_ACCEPTED);
            }else{
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }

    }
    void getInvoice(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        List<Invoice> lstData = invoiceDao.getInvoice();
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int pageSize = 5;
        int totalRows = lstData.size();
        int totalPages = (int) Math.ceil((double) totalRows / pageSize);

        List<Invoice> currentPageData = getCurrentPageData(lstData, page, pageSize);

        request.setAttribute("lstData", currentPageData);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/invoice.jsp");
        dispatcher.forward(request, response);

    }
    private List<Invoice> getCurrentPageData(List<Invoice> dataList, int page, int pageSize) {
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, dataList.size());
        return dataList.subList(startIndex, endIndex);
    }
    void getOrderProduct(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
       int orderid =  Integer.parseInt(request.getParameter("orderid"));
       List<OrderProduct> lstData = orderProduct.getOrderProduct(orderid);
        response.setCharacterEncoding("UTF-8");
        //Parse to JSON
        StringBuilder jsonString = new StringBuilder();
        jsonString.append("[");

        for (OrderProduct item : lstData) {
            jsonString.append("{");
            jsonString.append("\"productID\": \"").append(item.getProductID()).append("\",");
            jsonString.append("\"name\": \"").append(item.getName()).append("\",");
//            jsonString.append("\"image\": \"").append(Base64.getEncoder().encodeToString(item.getImage())).append("\",");
            jsonString.append("\"price\": \"").append(item.getPrice()).append("\",");
            jsonString.append("\"orderID\": \"").append(item.getOrderID()).append("\",");
            jsonString.append("\"quantity\": \"").append(item.getQuantity()).append("\"");
            jsonString.append("},");
        }

        if (!lstData.isEmpty()) {
            jsonString.deleteCharAt(jsonString.length() - 1); // Remove the last comma
        }

        jsonString.append("]");

        response.setContentType("application/json");
        response.getWriter().println(jsonString);
        response.setStatus(HttpServletResponse.SC_ACCEPTED);
//        response.setContentType("text/html");
//        PrintWriter out = response.getWriter();
//        out.println("<table class=\"table table-striped\" id=\"p-detail\">\n" +
//                "                    <thead class=\"thead-dark\">\n" +
//                "                    <tr>\n" +
//                "                        <th>ProductID</th>\n" +
//                "                        <th>Name</th>\n" +
//                "                        <th>Price</th>\n" +
//                "                        <th>Quantity</th>\n" +
//                "                    </tr>\n" +
//                "                    </thead>\n" +
//                "                    <tbody>");
//        for (OrderProduct element : lstData) {
//            out.println("        <tr class=\"row100 body\">");
//            out.println("            <td class=\"cell100 column1\">" + element.getProductID() + "</td>");
//            out.println("            <td class=\"cell100 column2\">" + element.getName() + "</td>");
//            out.println("            <td class=\"cell100 column3\">" + element.getPrice() + "</td>");
//            out.println("            <td class=\"cell100 column4\">" + element.getQuantity() + "</td>");
//            out.println("        </tr>");
//        }
//        out.println("</tbody>\n" +
//                "                </table>");
    }

}