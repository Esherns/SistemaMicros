/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author Silvio
 */
public class Micro 
{
    private String codigo;
    private String horario;
    private String comuna;
    private Paradero paraderoActual;
    
    public Micro(String codigo, String horario, String comuna,Paradero paraderoActual)
    {
        this.codigo = codigo;
        this.horario = horario;
        this.comuna = comuna;
        this.paraderoActual = paraderoActual;
    }

    public Micro(String codigo, String horario, String comuna)
    {
        this.codigo = codigo;
        this.horario = horario;
        this.comuna = comuna;
    }

    
    
    public Paradero getParaderoActual()
    {
        return paraderoActual;
    }

    public void setParaderoActual(Paradero paraderoActual)
    {
        this.paraderoActual = paraderoActual;
    }

    
    
    

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getComuna() {
        return comuna;
    }

    public void setComuna(String comuna) {
        this.comuna = comuna;
    }
    
    
    
}
