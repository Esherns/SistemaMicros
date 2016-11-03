/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Clases.MicroBD;
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
public class MicroDAO implements MicroDAOInterface 
{
    private static final String FIND_MICROS = "SELECT * FROM micro";
    
    @Override
    public List<MicroBD> findAll()
    {
            try {
                DBAccess acceso = DBAccess.getInstance();

                PreparedStatement op = acceso.getConnection().prepareStatement(FIND_MICROS);
                List<MicroBD> lista = new ArrayList<>();
                
                try {

                    ResultSet rs = op.executeQuery();
                    while (rs.next()) 
                    {
                       MicroBD a = new MicroBD();
                       a.setHorario(rs.getString("horario"));
                       a.setIdMicro(rs.getInt("idMicro"));
                       a.setLatitud(rs.getDouble("latitud"));
                       a.setLongitud(rs.getDouble("longitud"));
                       a.setRecorrido_codigoRecorrido(rs.getString("Recorrido_codigoRecorrido"));
                       lista.add(a);
                    }

                    return lista;
                    
                    
                } catch (SQLException ex) {
                    
                    Logger.getLogger(MicroDAO.class.getName()).log(Level.SEVERE, null, ex);
                    return lista;
                    
                }
            } catch (SQLException ex) {
                List<MicroBD> lista = new ArrayList<>();
                Logger.getLogger(MicroDAO.class.getName()).log(Level.SEVERE, null, ex);
                return lista;
                
            }
    } 
}
