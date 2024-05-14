﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace Library
{
    class CADProducto
    {
        public string constring;
        public SqlConnection connection;

        public CADProducto()
        {

        }
        public bool Create(ENProducto prod)
        {
            SqlConnection conn = null;
            string consu = "Insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values (" + prod.nombre + "," + prod.pvp + "," + prod.url_image + "," + prod.descripcion + "," + prod.stock + "," + prod.popularidad + "," + prod.promocion + "," + prod.categoria + ")";

            SqlCommand comm = new SqlCommand(consu, conn);

            try
            {
                conn = new SqlConnection(constring);
                conn.Open();

                if (comm.ExecuteNonQuery() == 0)
                {
                    return false;
                }
            }
            catch (SqlException)
            {
                //error
                return false;

            }
            finally
            {
                conn.Close();
            }

            return true;
        }

        public bool Delete(ENProducto prod)
        {
            SqlConnection conn = null;


            string consu = "Delete from Producto where id =" + prod.id;

            SqlCommand comm = new SqlCommand(consu, conn);



            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                if (comm.ExecuteNonQuery() == 0)
                {
                    return false;
                }


            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                conn.Close();
            }
            return true;
        }
        public bool Update(ENProducto prod)
        {
            SqlConnection conn = null;


            string consu = "Update Producto set nombre =" + prod.nombre + ",pvp =" + prod.pvp + ",url_image=" + prod.url_image + ",descripcion=" + prod.descripcion + ",stock=" + prod.stock + ",popularidad=" + prod.popularidad + ",promocion=" + prod.promocion + ",categoria=" + prod.categoria + "where id =" + prod.id;

            SqlCommand comm = new SqlCommand(consu, conn);



            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                if (comm.ExecuteNonQuery() == 0)
                {
                    return false;
                }


            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                conn.Close();
            }
            return true;

        }
        public bool Read(ENProducto prod)
        {
            SqlConnection conn = null;

            string com = "Select * from Producto where id = " + prod.id;

            SqlCommand command = new SqlCommand(com, conn);

            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    prod.nombre = reader["nombre"].ToString();
                    prod.popularidad = Convert.ToInt32(reader["popularidad"]);
                    prod.pvp = (float)reader["pvp"];
                    int ordinal = reader.GetOrdinal("url_image");
                    prod.url_image = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                    ordinal = reader.GetOrdinal("descripcion");
                    prod.descripcion = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                    prod.stock = Convert.ToInt32(reader["stock"]);
                    ordinal = reader.GetOrdinal("promocion");
                    
                    if (reader.IsDBNull(ordinal))
                    {
                        prod.promocion = null;
                    }
                    else
                    {
                        prod.promocion = ENPromociones.getPromocion(reader.GetInt32(ordinal));
                    }

                    ordinal = reader.GetOrdinal("categoria");

                    if (reader.IsDBNull(ordinal))
                    {
                        prod.categoria = null;
                    }
                    else
                    {   

                        prod.categoria = ENCategoria.getCategoria(reader.GetString(ordinal));

                    }
                    return true;
                }
            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                conn.Close();
            }
            return false;

        }

        public List<ENProducto> ProductosPorCategoria(string categ) //devolvera una lista vacia si no se puede hacer la consulta o si no ha encontrado ninngun producto de la categoria indicada
        {
            SqlConnection conn = null;

            List<ENProducto> productos = new List<ENProducto>();

            string com = "Select * from Producto where categoria=" + categ;

            SqlCommand command = new SqlCommand(com, conn);

            ENProducto prod = new ENProducto();

            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    prod.nombre = reader["nombre"].ToString();
                    prod.popularidad = Convert.ToInt32(reader["popularidad"]);
                    prod.pvp = (float)reader["pvp"];
                    int ordinal = reader.GetOrdinal("url_image");
                    prod.url_image = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                    ordinal = reader.GetOrdinal("descripcion");
                    prod.descripcion = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                    prod.stock = Convert.ToInt32(reader["stock"]);

                    prod.promocion = new ENPromociones();
                    if (reader["promocion"] != null)
                    {
                        prod.promocion.MiId = Convert.ToInt32(reader["promocion"]);
                        //TODO
                        //prod.promocion.Read();
                    }
                    prod.categoria = new ENCategoria();
                    if (reader["categoria"] != null)
                    {
                        prod.categoria.tipo = Convert.ToString(reader["categoria"]);
                        prod.categoria.Read();
                    }

                    productos.Add(prod);

                }
            }
            catch (SqlException)
            {
                //ERROR
                return productos;
            }
            finally
            {
                conn.Close();
            }
            return productos;

        }

        public bool isCorrect(string cat, int prom)
        {
            if(ENPromociones.getPromocion(prom).MiId == null || ENCategoria.getCategoria(cat) == null)
            {
                return false;
            }

            return true;
        }
    }

}
