package co.pronosticador.view.delegate;

import co.pronosticador.model.entity.Menu;
import co.pronosticador.model.entity.Rol;
import co.pronosticador.model.entity.Usuario;
import co.pronosticador.model.facade.RolFacadeLocal;
import co.pronosticador.model.facade.UsuarioFacadeLocal;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;

@Stateless
public class SeguridadDelegate {
    
    @EJB
    UsuarioFacadeLocal usuarioFacade;
    @EJB
    RolFacadeLocal rolFacade;
        
    public boolean validarUsuario(Usuario usuario){        
        return usuarioFacade.validarUsuario(usuario);        
    }
    
    public List<Menu> generarMenu(Usuario usuario){
        Rol rol = rolFacade.find(usuario.getRol().getId());
        //Lazy init para la colección
        rol.getMenuCollection().size();
        List<Menu> menus = (List<Menu>) rol.getMenuCollection();
        return menus;
    }
    
    public Usuario getUsuario(Usuario usuario){
        return usuarioFacade.find(usuario.getId());
    }
}
