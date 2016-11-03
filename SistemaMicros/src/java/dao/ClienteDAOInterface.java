/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.SQLException;
import java.util.List;
import Clases.Cliente;

/**
 *
 * @author Silvio
 */
public interface ClienteDAOInterface 
{
    public int create(Cliente cliente)throws SQLException, IllegalArgumentException;
    public boolean validate(String usuario,String contraseña) throws SQLException;
    public boolean validateUser(String usuario) throws SQLException;
}
