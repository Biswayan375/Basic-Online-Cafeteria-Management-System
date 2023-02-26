package ApplicationFilters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "LoginFilter", urlPatterns = {
		"/home",
		"/logout",
		"/book-seat",
		"/cancel-booking",
		"/order",
		"/my-orders",
		"/cancel-order",
		"/Static/ProtectedPages"
})
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("username") != null) {
			chain.doFilter(req, res);
		} else {
			session.setAttribute("flash-message", "Please login first");
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}

}
