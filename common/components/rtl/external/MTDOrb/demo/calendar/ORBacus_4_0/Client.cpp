// **********************************************************************
//
// Copyright (c) 1999
// Object Oriented Concepts, Inc.
// Billerica, MA, USA
//
// All Rights Reserved
//
// **********************************************************************

#include <OB/CORBA.h>

#include "calendar.h"
#include "calendar_impl.h"

#include <stdlib.h>

#ifdef HAVE_STD_IOSTREAM
using namespace std;
#endif

int
main(int argc, char* argv[])
{
    try
    {
        //
        // Create ORB
        //
        CORBA::ORB_var orb = CORBA::ORB_init(argc, argv);

        //
        // Instantiate value factory
        //
        
        dateFactory_impl* factory = new dateFactory_impl();
        CORBA::ValueFactoryBase_var factoryVar = factory;

        //
        // Obtain the server's object reference from a file
        //
        CORBA::Object_var obj =
            orb -> string_to_object("relfile:d:/calendar.ref");
	if(CORBA::is_nil(obj))
	{      
	    cerr << argv[0] << ": cannot read IOR from calendar.ref" << endl;
	    return EXIT_FAILURE;
	}        

        Calendar_var calendar = Calendar::_narrow(obj);
        assert(!CORBA::is_nil(calendar));

        
        //
        // Test with real value
        //
        date_var d1 = factory -> create(10,10,2000);
		calendar->insert(d1,"Test date from ORBacus");        
		date_var d2 = factory -> create(31,01,2001);
		calendar->insert(d2,"Millenium (ORBacus)");        
    }
    catch(const CORBA::Exception& ex)
    {
        cerr << ex << endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
