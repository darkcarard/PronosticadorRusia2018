package co.pronosticador.view.util;

import co.pronosticador.model.entity.Usuario;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

public class JSFUtils {
    
    public static HttpSession GetSession(){
        return (HttpSession)FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
    }
    
    public static Usuario getUsuario(){
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
        return  (Usuario)session.getAttribute("usuario");
    }
    
}
