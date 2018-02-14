package co.pronosticador.view.mb.seguridad;

import co.pronosticador.model.entity.Menu;
import co.pronosticador.model.entity.Usuario;
import co.pronosticador.view.delegate.SeguridadDelegate;
import co.pronosticador.view.util.JSFUtils;
import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;
import org.primefaces.model.menu.DefaultMenuItem;
import org.primefaces.model.menu.DefaultMenuModel;
import org.primefaces.model.menu.DefaultSubMenu;
import org.primefaces.model.menu.MenuModel;

@Named(value = "menuBean")
@SessionScoped
public class MenuBean implements Serializable {

    @EJB
    SeguridadDelegate seguridadDelegate;
    
    private MenuModel model;
    
    
    public MenuBean() {
    }
    
    @PostConstruct
    public void init() {        

        Usuario usuarioTmp = JSFUtils.getUsuario();
        List<Menu> menu = seguridadDelegate.generarMenu(usuarioTmp);
        
        List<Menu> padres = menu.stream().filter(m -> m.getPadre() == 0).collect(Collectors.toList());
        
        model = new DefaultMenuModel();
        
        for(Menu padre : padres){
           DefaultSubMenu firstSubmenu = new DefaultSubMenu(padre.getNombre());
           List<Menu> hijos = menu.stream().filter(m -> m.getPadre() == padre.getId()).collect(Collectors.toList());
           
            System.out.println("Hijos size: " + hijos.size());
            DefaultMenuItem item = new DefaultMenuItem(hijos.get(0).getNombre());
            item.setUrl("http://www.primefaces.org");
            item.setIcon("ui-icon-home");
            firstSubmenu.addElement(item);
         
            model.addElement(firstSubmenu);
        }                
        
        
    }

    public MenuModel getModel() {
        return model;
    }

    public void setModel(MenuModel model) {
        this.model = model;
    }
            
}
