/*
 * Calendar server
 */

#include "date.h"
#include "date_impl.h"
#include "calendar.h"
#include <string.h>

class Calendar_impl : virtual public POA_Calendar
{
public:
  void insert (date *, const char *);
  CORBA::Boolean find_date (date *, char *&);
  CORBA::Boolean find_note (const char *, date *&);

private:
  struct entry {
    date_var d;
    string s;
  };
  vector<entry> data;
};

void
Calendar_impl::insert (date * when, const char * what)
{
  entry e;
  CORBA::add_ref (when);
  e.d = when;
  e.s = what;
  data.push_back (e);
}

CORBA::Boolean
Calendar_impl::find_date (date * when, char *& what)
{
  for (CORBA::ULong i=0; i<data.size(); i++) {
    if (data[i].d->equal (when)) {
      what = CORBA::string_dup (data[i].s.c_str());
      return TRUE;
    }
  }

  what = CORBA::string_dup ("not found");
  return FALSE;
}

CORBA::Boolean
Calendar_impl::find_note (const char * what, date *& when)
{
  for (CORBA::ULong i=0; i<data.size(); i++) {
    if (strstr (data[i].s.c_str(), what) != NULL) {
      CORBA::add_ref (data[i].d);
      when = (date *)data[i].d;
      return TRUE;
    }
  }

  when = 0;
  return FALSE;
}

int
main (int argc, char *argv[])
{
  CORBA::ORB_var orb = CORBA::ORB_init (argc, argv, "mico-local-orb");

  /*
   * Register factories
   */

  date_factory * df = new date_factory;
  orb->register_value_factory ("IDL:date:1.0", df);

  /*
   * Initialize POA, and activate our calendar server
   */

  CORBA::Object_var po = orb->resolve_initial_references ("RootPOA");
  PortableServer::POA_var poa = PortableServer::POA::_narrow (po);
  PortableServer::POAManager_var mgr = poa->the_POAManager ();

  //PortableServer::ServantBase_var cal = new Calendar_impl;
  //CORBA::Object_var obj = cal->_this ();
  poa->activate_object(new Calendar_impl);

  printf ("Running.\n");
  mgr->activate ();
  orb->run ();

  /*
   * Shutdown (never reached)
   */

  poa->destroy (TRUE, TRUE);
  df->_remove_ref ();
  return 0;
}


