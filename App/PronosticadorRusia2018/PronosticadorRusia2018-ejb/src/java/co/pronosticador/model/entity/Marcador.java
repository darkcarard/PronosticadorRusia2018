/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.pronosticador.model.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author cardila
 */
@Entity
@Table(name = "marcador")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Marcador.findAll", query = "SELECT m FROM Marcador m")
    , @NamedQuery(name = "Marcador.findById", query = "SELECT m FROM Marcador m WHERE m.id = :id")
    , @NamedQuery(name = "Marcador.findByGolesEquipoLocal", query = "SELECT m FROM Marcador m WHERE m.golesEquipoLocal = :golesEquipoLocal")
    , @NamedQuery(name = "Marcador.findByGolesEquipoVisitante", query = "SELECT m FROM Marcador m WHERE m.golesEquipoVisitante = :golesEquipoVisitante")
    , @NamedQuery(name = "Marcador.findByTipo", query = "SELECT m FROM Marcador m WHERE m.tipo = :tipo")
    , @NamedQuery(name = "Marcador.findByFechaIngreso", query = "SELECT m FROM Marcador m WHERE m.fechaIngreso = :fechaIngreso")
    , @NamedQuery(name = "Marcador.findByHoraIngreso", query = "SELECT m FROM Marcador m WHERE m.horaIngreso = :horaIngreso")
    , @NamedQuery(name = "Marcador.findByFechaModificacion", query = "SELECT m FROM Marcador m WHERE m.fechaModificacion = :fechaModificacion")
    , @NamedQuery(name = "Marcador.findByHoraModificacion", query = "SELECT m FROM Marcador m WHERE m.horaModificacion = :horaModificacion")})
public class Marcador implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "goles_equipo_local")
    private short golesEquipoLocal;
    @Basic(optional = false)
    @NotNull
    @Column(name = "goles_equipo_visitante")
    private short golesEquipoVisitante;
    @Basic(optional = false)
    @NotNull
    @Column(name = "tipo")
    private boolean tipo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_ingreso")
    @Temporal(TemporalType.DATE)
    private Date fechaIngreso;
    @Basic(optional = false)
    @NotNull
    @Column(name = "hora_ingreso")
    @Temporal(TemporalType.TIME)
    private Date horaIngreso;
    @Column(name = "fecha_modificacion")
    @Temporal(TemporalType.DATE)
    private Date fechaModificacion;
    @Column(name = "hora_modificacion")
    @Temporal(TemporalType.TIME)
    private Date horaModificacion;
    @JoinColumn(name = "equipo_local", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Equipo equipoLocal;
    @JoinColumn(name = "equipo_visitante", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Equipo equipoVisitante;
    @JoinColumn(name = "usuario", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Usuario usuario;

    public Marcador() {
    }

    public Marcador(Integer id) {
        this.id = id;
    }

    public Marcador(Integer id, short golesEquipoLocal, short golesEquipoVisitante, boolean tipo, Date fechaIngreso, Date horaIngreso) {
        this.id = id;
        this.golesEquipoLocal = golesEquipoLocal;
        this.golesEquipoVisitante = golesEquipoVisitante;
        this.tipo = tipo;
        this.fechaIngreso = fechaIngreso;
        this.horaIngreso = horaIngreso;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public short getGolesEquipoLocal() {
        return golesEquipoLocal;
    }

    public void setGolesEquipoLocal(short golesEquipoLocal) {
        this.golesEquipoLocal = golesEquipoLocal;
    }

    public short getGolesEquipoVisitante() {
        return golesEquipoVisitante;
    }

    public void setGolesEquipoVisitante(short golesEquipoVisitante) {
        this.golesEquipoVisitante = golesEquipoVisitante;
    }

    public boolean getTipo() {
        return tipo;
    }

    public void setTipo(boolean tipo) {
        this.tipo = tipo;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public Date getHoraIngreso() {
        return horaIngreso;
    }

    public void setHoraIngreso(Date horaIngreso) {
        this.horaIngreso = horaIngreso;
    }

    public Date getFechaModificacion() {
        return fechaModificacion;
    }

    public void setFechaModificacion(Date fechaModificacion) {
        this.fechaModificacion = fechaModificacion;
    }

    public Date getHoraModificacion() {
        return horaModificacion;
    }

    public void setHoraModificacion(Date horaModificacion) {
        this.horaModificacion = horaModificacion;
    }

    public Equipo getEquipoLocal() {
        return equipoLocal;
    }

    public void setEquipoLocal(Equipo equipoLocal) {
        this.equipoLocal = equipoLocal;
    }

    public Equipo getEquipoVisitante() {
        return equipoVisitante;
    }

    public void setEquipoVisitante(Equipo equipoVisitante) {
        this.equipoVisitante = equipoVisitante;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Marcador)) {
            return false;
        }
        Marcador other = (Marcador) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "co.pronosticador.model.entities.Marcador[ id=" + id + " ]";
    }
    
}
