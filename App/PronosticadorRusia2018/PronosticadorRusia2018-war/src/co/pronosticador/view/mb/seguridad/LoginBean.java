package co.pronosticador.view.mb.seguridad;

import co.pronosticador.model.entity.Usuario;
import co.pronosticador.model.facade.UsuarioFacade;
import co.pronosticador.model.facade.UsuarioFacadeLocal;
import co.pronosticador.view.util.JSFUtils;
import java.io.Serializable;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpSession;

@Named(value = "loginBean")
@SessionScoped
public class LoginBean implements Serializable {

    private String usuario;
    private String clave;
    
    @Inject            
    UsuarioFacadeLocal usuarioFacade;
              
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
        
        HttpSession session = JSFUtils.GetSession();
        session.setAttribute("usuario", usuario);   
        Usuario usuario = new Usuario();
        usuario.setId(this.usuario);
        usuario.setClave(this.clave);
        if (((UsuarioFacade)usuarioFacade).validarUsuario(usuario))
            return "loginOK";        
        else{
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                    "Invalid Login!",
                    "Please Try Again!"));
            return "";
        }
    }
    
}
