// eg1.cc - This example is identical to that found in:
//             <top>/src/examples/echo/eg1.cc
//          except that implicit activation is used to activate
//          the echo object.
//
// Usage: eg1
//

#include <stdlib.h>
#include <fstream.h>
#include <iostream.h>
#include <helloworld.h>


class HelloWorld_i : public POA_HelloWorld,
	       public PortableServer::RefCountServantBase
{
public:
  inline HelloWorld_i() {}
  virtual ~HelloWorld_i() {}
  virtual void hello();;
};


void HelloWorld_i::hello()
{
  cout << "Hello world." << endl;
}

//////////////////////////////////////////////////////////////////////

/*static void hello(Echo_ptr e)
{
  if( CORBA::is_nil(e) ) {
    cerr << "hello: The object reference is nil!\n" << endl;
    return;
  }

  CORBA::String_var src = (const char*) "Hello!";

  CORBA::String_var dest = e->echoString(src);

  cerr << "I said, \"" << (char*)src << "\"." << endl
       << "The Echo object replied, \"" << (char*)dest <<"\"." << endl;
}*/

//////////////////////////////////////////////////////////////////////

int main(int argc, char** argv)
{
  try {
    CORBA::ORB_var orb = CORBA::ORB_init(argc, argv, "omniORB3");

    CORBA::Object_var obj = orb->resolve_initial_references("RootPOA");
    PortableServer::POA_var poa = PortableServer::POA::_narrow(obj);

    HelloWorld_i* myhello = new HelloWorld_i();
    PortableServer::ObjectId_var myhelloid = poa->activate_object(myhello);
    
    obj = myhello->_this();
    CORBA::String_var sior(orb->object_to_string(obj));
    
    const char* myRef = argv[1];
    ofstream out(myRef);
    if(out.fail())
    {
      cerr << argv[0] << ": can't open `" << myRef << "': "
           << strerror(errno) << endl;
      return EXIT_FAILURE;
    }
    out << sior << endl;
    out.close();
    
    myhello->_remove_ref();

    PortableServer::POAManager_var pman = poa->the_POAManager();
    pman->activate();

    orb->run();
    	
    orb->destroy();
  }
  catch(CORBA::COMM_FAILURE& ex) {
    cerr << "Caught system exception COMM_FAILURE -- unable to contact the "
         << "object." << endl;
  }
  catch(CORBA::SystemException&) {
    cerr << "Caught CORBA::SystemException." << endl;
  }
  catch(CORBA::Exception&) {
    cerr << "Caught CORBA::Exception." << endl;
  }
  catch(omniORB::fatalException& fe) {
    cerr << "Caught omniORB::fatalException:" << endl;
    cerr << "  file: " << fe.file() << endl;
    cerr << "  line: " << fe.line() << endl;
    cerr << "  mesg: " << fe.errmsg() << endl;
  }
  catch(...) {
    cerr << "Caught unknown exception." << endl;
  }

  return 0;
}
