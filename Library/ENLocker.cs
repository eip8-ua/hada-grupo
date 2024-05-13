﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENLocker
    {
        private int _id;
        private string _nombre;
        private ENDireccion dir;

        public int id
        {
            get { return _id; }
            set { _id = value; }
        }
        public string nombre
        {
            get { return _nombre; }
            set { _nombre = value; }
        }

        public ENLocker()
        {

        }
        public ENLocker(int id, string nombre = "",ENDireccion dir = null)
        {
            this.id = id;
            if (nombre != "")
                this.nombre = nombre;
            if (dir != null)
                this.dir = new ENDireccion(dir);
        }

        public bool Create()
        {
            return false;
        }
        public bool Delete()
        {
            return false;
        }
        public bool Update()
        {
            return false;
        }
        public bool Read()
        {
            return false;
        }
    }
}
