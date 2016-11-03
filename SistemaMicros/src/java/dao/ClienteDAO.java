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
public class ClienteDAO implements ClienteDAOInterface
{
    private static final String INSERT_CLIENTE = "INSERT INTO cliente(rutCliente,nombre,numero,email,contraseña) VALUES(?,?,?,?,?)";
    private static final String VALIDATE_LOGIN = "SELECT COUNT(*) FROM cliente WHERE nombre=? AND contraseña=?";
    private static final String VALIDATE_USER = "SELECT COUNT(*) FROM cliente WHERE nombre=?";
   
    @Override
    public int create(Cliente cliente)
    {
            try {
                DBAccess acceso = DBAccess.getInstance();

                PreparedStatement op = acceso.getConnection().prepareStatement(INSERT_CLIENTE);
                
                try {
                    
                    op.setString(1, cliente.getRut());
                    op.setString(2, cliente.getNombre());
                    op.setInt(3, Integer.parseInt(cliente.getNumero()));
                    op.setString(4, cliente.getMail());
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
    @Override
    public boolean validate(String usuario, String contraseña) {
        if (usuario == null || contraseña == null) {
            return false;
        } else {
            try {
                DBAccess acceso = DBAccess.getInstance();

                PreparedStatement op = acceso.getConnection().prepareStatement(VALIDATE_LOGIN);
                try {
                    op.setString(1, usuario);
                    op.setString(2, contraseña);

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
    @Override
    public boolean validateUser(String usuario) {
        if (usuario == null ) {
            return false;
        } else {
            try {
                DBAccess acceso = DBAccess.getInstance();

                PreparedStatement op = acceso.getConnection().prepareStatement(VALIDATE_USER);
                try {
                    op.setString(1, usuario);

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
