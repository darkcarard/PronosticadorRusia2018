package co.pronosticador.view.util;

import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

public class JSFUtils {
    
    public static HttpSession GetSession(){
        return (HttpSession)FacesContext.getCurrentInstance().
                getExternalContext().getSession(false);
    }
    
}
