using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Library
{
    public class ENPedido
    {
        private int numpedido;
        private DateTime fechaPedido;
        private int idUsuario;

        public int Numpedido
        {
            get { return numpedido; }
            set { numpedido = value; }
        }

        public DateTime FechaPedido
        {
            get { return fechaPedido; }
            set { fechaPedido = value; }
        }

        public int IdUsuario
        {
            get { return idUsuario; }
            set { idUsuario = value; }
        }

        public ENPedido() { }


        public ENPedido(int numpedido, DateTime fechaPedido, int idUsuario)
        {
            Numpedido = numpedido;
            FechaPedido = fechaPedido;
            IdUsuario = idUsuario;
        }

        public bool Create()
        {
            CADPedido con = new CADPedido();
            return con.Create(this);
        }
        public bool Update()
        {
            CADPedido con = new CADPedido();
            return con.Update(this);
        }
        public bool Read()
        {
            CADPedido con = new CADPedido();
            return con.Read(this);
        }
        public bool Delete()
        {
            CADPedido con = new CADPedido();
            return con.Delete(this);
        }

        public bool is_correct()
        {
            return Numpedido > 0 && IdUsuario > 0;
        }

        public static List<ENPedido> ReadAll()
        {
            List<ENPedido> pedidos = new List<ENPedido>();
            string constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();

            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    string query = "SELECT num_pedido, fecha, usuario FROM Pedido";
                    SqlCommand cmd = new SqlCommand(query, connection);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ENPedido pedido = new ENPedido
                        {
                            Numpedido = reader.GetInt32(0),
                            FechaPedido = reader.GetDateTime(1),
                            IdUsuario = reader.GetInt32(2)
                        };
                        pedidos.Add(pedido);
                    }
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error al obtener los pedidos: " + e.Message);
            }

            return pedidos;
        }

    }
}
