package co.pronosticador.view.util;

import co.pronosticador.model.entity.Usuario;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

public class JSFUtils {

    public static HttpSession GetSession() {
        return (HttpSession) FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
    }

    public static Usuario getUsuario() {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
        return (Usuario) session.getAttribute("usuario");
    }

    public static void setSessionAttribute(Object valor, String nombre) {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
        session.setAttribute(nombre, valor);
    }

    public static void removeSessionAttribute(String nombre) {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
        session.removeAttribute(nombre);
    }

    public static void invalidateSession() {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance()
                .getExternalContext().getSession(false);
        session.invalidate();

    }

    public static void showWarningMessage(String resumen, String detalle) {
        FacesContext.getCurrentInstance()
                .addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                        resumen,
                        detalle));
    }
}
