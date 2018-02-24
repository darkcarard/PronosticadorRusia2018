package co.pronosticador.view.delegate;

import co.pronosticador.model.entity.Equipo;
import co.pronosticador.model.facade.EquipoFacadeLocal;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;

@Stateless
@LocalBean
public class AdministracionDelegate {

    @EJB
    EquipoFacadeLocal equipoFacade;
    
    public List<Equipo> getAllEquipos(){
        return equipoFacade.findAll();
    }        
}
