/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.SQLException;
import java.util.List;
import Clases.Cliente;
import Clases.MicroBD;
/**
 *
 * @author Silvio
 */
public interface MicroDAOInterface 
{
    public List<MicroBD> findAll() throws SQLException;
}
