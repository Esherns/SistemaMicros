/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.util.ArrayList;

/**
 *
 * @author Silvio
 */
public class Paradero 
{
   private String nombre;
   private String comuna;
   private ArrayList<Micro> micros;
   private Double[] coordenadas;
   
    public Paradero(String nombre, String comuna, ArrayList<Micro> micros, Double[] coordenadas) {
        this.nombre = nombre;
        this.comuna = comuna;
        this.micros = micros;
        this.coordenadas = coordenadas;
    }

    public Double[] getCoordenadas()
    {
        return coordenadas;
    }

    public void setCoordenadas(Double[] coordenadas)
    {
        this.coordenadas = coordenadas;
    }

   
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getComuna() {
        return comuna;
    }

    public void setComuna(String comuna) {
        this.comuna = comuna;
    }

    public ArrayList<Micro> getMicros() {
        return micros;
    }

    public void setMicros(ArrayList<Micro> micros) {
        this.micros = micros;
    }
   
   
}
