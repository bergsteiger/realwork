
/*
 * Implementation for the date valuetype and its factory
 */

#include "date.h"
#include "date_impl.h"

date_impl::date_impl (CORBA::UShort dd, CORBA::UShort mm,
		      CORBA::UShort yyyy)
{
  day (dd);
  month (mm);
  year (yyyy);
}

CORBA::Boolean
date_impl::equal (date * other)
{
  return (compare (other) == 0);
}

CORBA::Short
date_impl::compare (date * other)
{
  if (year() != other->year())
    return year() - other->year();

  if (month() != other->month())
    return month() - other->month();

  if (day() != other->day())
    return day() - other->day();

  return 0;
}

CORBA::ValueBase *
date_factory::create_for_unmarshal ()
{
  return new date_impl (0, 0, 0);
}

date *
date_factory::create (CORBA::UShort dd, CORBA::UShort mm,
		      CORBA::UShort yyyy)
{
  return new date_impl (dd, mm, yyyy);
}
