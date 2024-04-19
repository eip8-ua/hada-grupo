using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENTestimonial
    {
        int _id;
        String _message;

        int Id { set { _id = value;  } get { return _id;  } }
        String Message { set { _message = value; } get { return _message; } }

        public ENTestimonial() { }
        public ENTestimonial(int id, String message)
        {
            Id = id;
            Message = message;
        }

        public bool create() 
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.create(this);
        }
        public bool update()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.update(this);
        }
        public bool read()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.read(this);
        }
        public bool delete()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.delete(this);
        }
    }
}
