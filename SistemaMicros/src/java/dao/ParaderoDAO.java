/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Clases.ParaderoBD;
import Visual.DBAccess;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Silvio
 */
public class ParaderoDAO 
{
    private static final String FIND_MICROS = "SELECT * FROM paradero";
    
    public List<ParaderoBD> findAll()
    {
            try {
                DBAccess acceso = DBAccess.getInstance();

                PreparedStatement op = acceso.getConnection().prepareStatement(FIND_MICROS);
                List<ParaderoBD> lista = new ArrayList<>();
                
                try {

                    ResultSet rs = op.executeQuery();
                    while (rs.next()) 
                    {
                       ParaderoBD a = new ParaderoBD();
                       a.setComuna(rs.getString("comuna"));
                       a.setIdParadero(rs.getInt("idParadero"));
                       a.setLatitud(rs.getDouble("latitud"));
                       a.setLongitud(rs.getDouble("longitud"));
                       a.setNombre(rs.getString("nombre"));
                       lista.add(a);
                    }

                    return lista;
                    
                    
                } catch (SQLException ex) {
                    
                    Logger.getLogger(ParaderoDAO.class.getName()).log(Level.SEVERE, null, ex);
                    return lista;
                    
                }
            } catch (SQLException ex) {
                List<ParaderoBD> lista = new ArrayList<>();
                Logger.getLogger(ParaderoDAO.class.getName()).log(Level.SEVERE, null, ex);
                return lista;
                
            }
    } 
}
