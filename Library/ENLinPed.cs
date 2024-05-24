using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;

namespace Library
{
    public class ENLinPed
    {
        private int? idLinPedido;
        private int? idPedido;
        private int idProducto;
        private int cantidad;

        public int? IdLinPedido
        {
            get { return idLinPedido; }
            set { idLinPedido = value; }
        }

        public int? IdPedido
        {
            get { return idPedido; }
            set { idPedido = value; }
        }

        public int IdProducto
        {
            get { return idProducto; }
            set { idProducto = value; }
        }

        public int Cantidad
        {
            get { return cantidad; }
            set { cantidad = value; }
        }

        public ENLinPed(int? idLinPedido, int? idPedido, int idProducto, int cantidad)
        {
            IdLinPedido = idLinPedido;
            IdPedido = idPedido;
            IdProducto = idProducto;
            Cantidad = cantidad;
        }

        public bool Create()
        {
            CADLinPed con = new CADLinPed();
            return con.Create(this);
        }

        public bool Delete()
        {
            CADLinPed con = new CADLinPed();
            return con.Delete(this);
        }

        public bool Update()
        {
            CADLinPed con = new CADLinPed();
            return con.Update(this);
        }

        public bool Read()
        {
            CADLinPed con = new CADLinPed();
            return con.Read(this);
        }

        public bool is_correct()
        {
            return idPedido != null && idLinPedido != null;
        }

        public static List<ENLinPed> GetLinesByPedidoId(int pedidoId)
        {
            List<ENLinPed> lineasPedido = new List<ENLinPed>();
            string constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    string query = "SELECT id, cantidad, pedido, producto FROM Linea_pedido WHERE pedido = @pedidoId";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@pedidoId", pedidoId);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ENLinPed lineaPedido = new ENLinPed(
                            reader.GetInt32(0), // id
                            reader.GetInt32(2), // pedido
                            reader.GetInt32(3), // producto
                            reader.GetInt32(1)  // cantidad
                        );
                        lineasPedido.Add(lineaPedido);
                    }
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error al obtener las líneas de pedido: " + e.Message);
            }

            return lineasPedido;
        }
    }
}
