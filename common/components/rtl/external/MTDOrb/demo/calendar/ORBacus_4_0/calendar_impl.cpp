#include <OB/CORBA.h>
#include "calendar_impl.h"

//
// IDL:date:1.0
//
date_impl::date_impl()
{
}

date_impl::~date_impl()
{
}

CORBA::ValueBase*
date_impl::_copy_value()
{
    date_impl* _r = new date_impl;
    // TODO: Implementation
    return _r;
}

//
// IDL:date/equal:1.0
//
CORBA::Boolean
date_impl::equal(date* other)
{
    // TODO: Implementation
    CORBA::Boolean _r = false;
    return _r;
}

//
// IDL:date/compare:1.0
//
CORBA::Short
date_impl::compare(date* other)
{
    // TODO: Implementation
    CORBA::Short _r = 0;
    return _r;
}

dateFactory_impl::dateFactory_impl()
{
}

dateFactory_impl::~dateFactory_impl()
{
}

CORBA::ValueBase*
dateFactory_impl::create_for_unmarshal()
{
    // TODO: Implementation
    return new date_impl;
}

date*
dateFactory_impl::create(CORBA::UShort dd,
                         CORBA::UShort mm,
                         CORBA::UShort yyyy)
{
    // TODO: Implementation
	date_impl* impl = new date_impl;	
	impl->day(dd);
	impl->month(mm);
	impl->year(yyyy);
    return impl;
}

//
// IDL:Calendar:1.0
//
Calendar_impl::Calendar_impl()
{
}

Calendar_impl::~Calendar_impl()
{
}

//
// IDL:Calendar/insert:1.0
//
void
Calendar_impl::insert(date* when,
                      const char* what)
    throw(CORBA::SystemException)
{
    // TODO: Implementation
}

//
// IDL:Calendar/find_date:1.0
//
CORBA::Boolean
Calendar_impl::find_date(date* when,
                         CORBA::String_out what)
    throw(CORBA::SystemException)
{
    // TODO: Implementation
    CORBA::Boolean _r = false;
    what = CORBA::string_dup("");
    return _r;
}

//
// IDL:Calendar/find_note:1.0
//
CORBA::Boolean
Calendar_impl::find_note(const char* what,
                         date*& when)
    throw(CORBA::SystemException)
{
    // TODO: Implementation
    CORBA::Boolean _r = false;
    when = 0;
    return _r;
}
