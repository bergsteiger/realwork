/*
 * Client that uses some dates and the calendar server
 */

#include "date.h"
#include "date_impl.h"
#include "calendar.h"

int
main (int argc, char *argv[])
{
  CORBA::ORB_var orb = CORBA::ORB_init (argc, argv, "mico-local-orb");

  /*
   * Register factories
   */

  date_factory * df = new date_factory;
  orb->register_value_factory ("IDL:date:1.0", df);

  CORBA::Object_var obj = orb->bind ("IDL:Calendar:1.0");

  if (CORBA::is_nil (obj)) {
    printf ("oops: bind to Calendar failed\n");
    exit (1);
  }

  Calendar_var cal = Calendar::_narrow (obj);
  assert (!CORBA::is_nil (cal));

  /*
   * Insert some important dates
   */

  date_var d1 = df->create (1, 1, 2001);
  cal->insert (d1.in(), "Celebrate new Millenium");

  d1 = df->create (11, 8, 1999);
  cal->insert (d1.in(), "Total solar eclipse in central Europe");

  /*
   * Retrieve them
   */

  CORBA::String_var se;
  d1 = df->create (1, 1, 2001);
  if (cal->find_date (d1.in(), se.out())) {
    printf ("Appointment for Jan 1, 2001: %s.\n", se.in());
  }
  else {
    assert (0);
  }

  if (cal->find_note ("solar eclipse", d1.out())) {
    printf ("The solar eclipse is on %d/%d/%d.\n",
	    (int) d1->month(), (int) d1->day(),
	    (int) d1->year());
  }
  else {
    assert (0);
  }

  d1 = df->create (31, 3, 1999);
  if (cal->find_date (d1.in(), se)) {
    assert (0);
  }
  else {
    printf ("Nothing to do on Mar 31, 1999.\n");
  }

  if (cal->find_note ("graduate", d1.out())) {
    assert (0);
  }
  else {
    assert (d1 == 0);
    printf ("Graduation date is unknown.\n");
  }

  return 0;
}
