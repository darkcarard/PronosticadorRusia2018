/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.pronosticador.model.facade;

import co.pronosticador.model.entity.Marcador;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author cardila
 */
@Stateless
public class MarcadorFacade extends AbstractFacade<Marcador> implements MarcadorFacadeLocal {

    @PersistenceContext(unitName = "PronosticadorRusia2018-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MarcadorFacade() {
        super(Marcador.class);
    }
    
}
