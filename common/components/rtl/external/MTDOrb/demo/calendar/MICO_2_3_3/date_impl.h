
/*
 * Implementation for the date valuetype and its factory
 */

#ifndef __DATE_IMPL_H__
#define __DATE_IMPL_H__

#include "date.h"

class date_impl :
  virtual public OBV_date,
  virtual public CORBA::DefaultValueRefCountBase
{
public:
  date_impl (CORBA::UShort, CORBA::UShort, CORBA::UShort);
  CORBA::Boolean equal (date *);
  CORBA::Short compare (date *);
};

class date_factory : virtual public date_init
{
public:
  CORBA::ValueBase * create_for_unmarshal ();
  date * create (CORBA::UShort, CORBA::UShort, CORBA::UShort);
};

#endif
