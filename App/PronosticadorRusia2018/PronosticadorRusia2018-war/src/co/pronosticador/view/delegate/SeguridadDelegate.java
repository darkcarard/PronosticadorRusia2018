package co.pronosticador.view.delegate;

import co.pronosticador.model.entity.Usuario;
import co.pronosticador.model.facade.UsuarioFacadeLocal;
import javax.ejb.EJB;
import javax.ejb.Stateless;

@Stateless
public class SeguridadDelegate {
    
    @EJB
    UsuarioFacadeLocal usuarioFacade;    
        
    public boolean validarUsuario(Usuario usuario){        
        //return usuarioFacade.validarUsuario(usuario);
        return true;
    }
}
