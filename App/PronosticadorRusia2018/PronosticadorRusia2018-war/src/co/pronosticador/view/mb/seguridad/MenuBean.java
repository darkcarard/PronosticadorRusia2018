package co.pronosticador.view.mb.seguridad;

import co.pronosticador.model.entity.Menu;
import co.pronosticador.model.entity.Usuario;
import co.pronosticador.view.delegate.SeguridadDelegate;
import co.pronosticador.view.util.JSFUtils;
import java.io.Serializable;
import java.util.List;
import java.util.Objects;
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
        List<Menu> padres;
        
        if (menu != null){
            padres = menu.stream()
                    .filter(m -> m.getPadre() == null).collect(Collectors.toList());
            model = new DefaultMenuModel();
        
            for(Menu padre : padres){
               DefaultSubMenu subMenu = new DefaultSubMenu(padre.getNombre());
               subMenu.setIcon(padre.getIcono());
               List<Menu> hijos = menu.stream().filter(m -> Objects.equals(m.getPadre(), 
                       padre.getId())).collect(Collectors.toList());

               hijos.stream().map((menuHijo) -> {
                   DefaultMenuItem item = new DefaultMenuItem(menuHijo.getNombre());
                   if (menuHijo.getOutcome() != null && !menuHijo.getOutcome().isEmpty())
                       item.setOutcome(menuHijo.getOutcome());
                   item.setIcon(menuHijo.getIcono());
                    return item;
                }).forEachOrdered((item) -> {
                    subMenu.addElement(item);
                });
                model.addElement(subMenu);
            }            
        }
    }

    public MenuModel getModel() {
        return model;
    }

    public void setModel(MenuModel model) {
        this.model = model;
    }
            
}
