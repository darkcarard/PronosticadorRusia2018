/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.pronosticador.model.facade;

import co.pronosticador.model.entity.Estadio;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author cardila
 */
@Local
public interface EstadioFacadeLocal {

    void create(Estadio estadio);

    void edit(Estadio estadio);

    void remove(Estadio estadio);

    Estadio find(Object id);

    List<Estadio> findAll();

    List<Estadio> findRange(int[] range);

    int count();
    
}
