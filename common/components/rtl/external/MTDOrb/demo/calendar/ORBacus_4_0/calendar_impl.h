#ifndef ___calendar_impl_h__
#define ___calendar_impl_h__

#include "calendar_skel.h"

//
// IDL:date:1.0
//
class date_impl : virtual public OBV_date,
                  virtual public CORBA::DefaultValueRefCountBase
{
    date_impl(const date_impl&);
    void operator=(const date_impl&);

public:

    date_impl();
    ~date_impl();

    virtual CORBA::ValueBase* _copy_value();

    //
    // IDL:date/equal:1.0
    //
    virtual CORBA::Boolean equal(date* other);

    //
    // IDL:date/compare:1.0
    //
    virtual CORBA::Short compare(date* other);
};

class dateFactory_impl : virtual public date_init
{
    virtual CORBA::ValueBase* create_for_unmarshal();

public:
    dateFactory_impl();
    virtual ~dateFactory_impl();

    virtual date* create(CORBA::UShort dd,
                         CORBA::UShort mm,
                         CORBA::UShort yyyy);
};

//
// IDL:Calendar:1.0
//
class Calendar_impl : virtual public POA_Calendar
{
    Calendar_impl(const Calendar_impl&);
    void operator=(const Calendar_impl&);

public:

    Calendar_impl();
    ~Calendar_impl();

    //
    // IDL:Calendar/insert:1.0
    //
    virtual void insert(date* when,
                        const char* what)
        throw(CORBA::SystemException);

    //
    // IDL:Calendar/find_date:1.0
    //
    virtual CORBA::Boolean find_date(date* when,
                                     CORBA::String_out what)
        throw(CORBA::SystemException);

    //
    // IDL:Calendar/find_note:1.0
    //
    virtual CORBA::Boolean find_note(const char* what,
                                     date*& when)
        throw(CORBA::SystemException);
};

#endif
