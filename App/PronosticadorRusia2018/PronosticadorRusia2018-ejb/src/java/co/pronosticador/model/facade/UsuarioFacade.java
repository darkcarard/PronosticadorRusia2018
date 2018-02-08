/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.pronosticador.model.facade;

import co.pronosticador.model.entity.Usuario;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NamedQuery;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author cardila
 */
@Stateless
public class UsuarioFacade extends AbstractFacade<Usuario> implements UsuarioFacadeLocal {

    @PersistenceContext(unitName = "PronosticadorRusia2018-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioFacade() {
        super(Usuario.class);
    }
    
    public boolean validarUsuario(Usuario usuario){
        Boolean resultado = false;
        
        Query query = em.createNamedQuery("Usuario.findByUsarioClave");
        query.setParameter("id", usuario.getId());
        query.setParameter("clave", usuario.getClave());
        try{
            query.getSingleResult();
            resultado = true;
        }catch(NoResultException nre){
            resultado = false;
            nre.printStackTrace();
        }catch(Exception e){
            resultado = false;
            e.printStackTrace();
        }
                        
        return resultado;
    }
}
