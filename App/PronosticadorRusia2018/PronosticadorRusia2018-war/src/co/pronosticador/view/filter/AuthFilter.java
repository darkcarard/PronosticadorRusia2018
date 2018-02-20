package co.pronosticador.view.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"*.xhtml"})
public class AuthFilter implements Filter {

    public AuthFilter() {
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            HttpSession ses = req.getSession(false);
            String reqURI = req.getRequestURI();
            if (reqURI.contains("javax.faces.resource") || reqURI.contains("/login.xhtml")
                    || (ses != null && ses.getAttribute("usuario") != null)) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + "/login.xhtml");
            }
        } catch (IOException | ServletException t) {
            System.out.println(t.getMessage());
        }
    }

    @Override
    public void destroy() {

    }
}
