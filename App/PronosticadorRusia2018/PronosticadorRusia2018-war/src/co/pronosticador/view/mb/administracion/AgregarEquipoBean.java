package co.pronosticador.view.mb.administracion;

import co.pronosticador.model.entity.Equipo;
import co.pronosticador.view.delegate.AdministracionDelegate;
import java.io.Serializable;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.inject.Named;
import javax.faces.view.ViewScoped;

@Named(value = "agregarEquipoBean")
@ViewScoped
public class AgregarEquipoBean implements Serializable {

    @EJB
    AdministracionDelegate administracionDelegate;
    List<Equipo> equipos;
    Equipo equipo;
           
    @PostConstruct
    public void init() {
        equipos = administracionDelegate.getAllEquipos();
    }

    public AgregarEquipoBean() {
    }

    public List<Equipo> getEquipos() {
        return equipos;
    }

    public void setEquipos(List<Equipo> equipos) {
        this.equipos = equipos;
    }

    public Equipo getEquipo() {
        return equipo;
    }

    public void setEquipo(Equipo equipo) {
        this.equipo = equipo;
    }
    
    

}
