package co.pronosticador.view.mb.seguridad;

import co.pronosticador.model.entity.Usuario;
import co.pronosticador.view.delegate.SeguridadDelegate;
import co.pronosticador.view.util.JSFUtils;
import java.io.Serializable;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

@Named(value = "loginBean")
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
            usuarioTmp = seguridadDelegate.getUsuario(usuarioTmp);
            JSFUtils.setSessionAttribute(usuarioTmp, "usuario");
            return "loginOK";  
        }else{
            JSFUtils.showWarningMessage("¡Error ingresando a la aplicación!",
                    "El usuario o la clave no coinciden");
            return "";
        }
    }
    
    public String logout(){
        JSFUtils.invalidateSession();
        return "logout";
    }
}
