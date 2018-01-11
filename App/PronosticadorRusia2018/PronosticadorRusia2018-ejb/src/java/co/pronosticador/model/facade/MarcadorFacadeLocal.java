/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.pronosticador.model.facade;

import co.pronosticador.model.entity.Marcador;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author cardila
 */
@Local
public interface MarcadorFacadeLocal {

    void create(Marcador marcador);

    void edit(Marcador marcador);

    void remove(Marcador marcador);

    Marcador find(Object id);

    List<Marcador> findAll();

    List<Marcador> findRange(int[] range);

    int count();
    
}
