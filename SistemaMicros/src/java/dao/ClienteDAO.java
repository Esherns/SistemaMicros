/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Clases.Cliente;
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
public class ClienteDAO 
{
    private static final String INSERT_CLIENTE = "INSERT INTO cliente(nombre,email,rut,numero,contraseña) VALUES (?,?,?,?,?)";
    private static final String VALIDATE_LOGIN = "SELECT COUNT(*) FROM cliente WHERE nombre=? AND contraseña=?";
   
    
    public int create(Cliente cliente)
    {
            try {
                DBAccess acceso = DBAccess.getInstance();

                PreparedStatement op = acceso.getConnection().prepareStatement(INSERT_CLIENTE,Statement.RETURN_GENERATED_KEYS);
                
                try {
                    
                    op.setString(1, cliente.getNombre());
                    op.setString(2, cliente.getMail());
                    op.setString(3, cliente.getRut());
                    op.setString(4, cliente.getNumero());
                    op.setString(5, cliente.getContraseña());

                    return op.executeUpdate();
                } catch (SQLException ex) {
                    
                    Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null, ex);
                    return -1;
                }
            } catch (SQLException ex) {
                Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null, ex);
                return -1;
            }
    }
    
        public boolean validate(Cliente cliente){
        if (cliente == null) {
            return false;
        } else {
            try {
                DBAccess acceso = DBAccess.getInstance();

                PreparedStatement op = acceso.getConnection().prepareStatement(VALIDATE_LOGIN);
                try {
                    op.setString(1, cliente.getNombre());
                    op.setString(2, cliente.getContraseña());

                    ResultSet rs = op.executeQuery();

                    if (rs.next()) {
                        return (rs.getInt(1) == 1);
                    }
                    return false;
                } catch (SQLException ex) {
                    Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            } catch (SQLException ex) {
                Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            return false;
        }
    }
}
