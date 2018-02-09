package co.pronosticador.view.mb.seguridad;

import co.pronosticador.model.entity.Usuario;
import co.pronosticador.view.delegate.SeguridadDelegate;
import co.pronosticador.view.util.JSFUtils;
import java.io.Serializable;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

@ManagedBean(name = "loginBean")
@SessionScoped
public class LoginBean implements Serializable {
    
    @EJB
    SeguridadDelegate seguridadDelegate;
    String usuario;
    String clave;
        
    public LoginBean() {       
    }   

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }
    
    public String login(){        
        Usuario usuarioTmp = new Usuario();
        usuarioTmp.setId(this.usuario);
        usuarioTmp.setClave(this.clave);
        
        if(seguridadDelegate.validarUsuario(usuarioTmp)){
             HttpSession session = JSFUtils.GetSession();
        session.setAttribute("usuario", usuarioTmp); 
            return "loginOK";  
        }else{
            FacesContext.getCurrentInstance()
                    .addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                    "Invalid Login!",
                    "Please Try Again!"));
            return "";
        }
    }
    
}
