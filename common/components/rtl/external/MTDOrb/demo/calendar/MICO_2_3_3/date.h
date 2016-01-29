/*
 *  MICO --- a free CORBA implementation
 *  Copyright (C) 1997-98 Kay Roemer & Arno Puder
 *
 *  This file was automatically generated. DO NOT EDIT!
 */

#if !defined(__DATE_H__) || defined(MICO_NO_TOPLEVEL_MODULES)
#define __DATE_H__

#ifndef MICO_NO_TOPLEVEL_MODULES
#include <CORBA.h>
#include <mico/throw.h>
#endif

class date;
typedef date *date_ptr;
typedef date_ptr dateRef;
typedef ValueVar<date> date_var;
typedef date_var date_out;


// Common definitions for valuetype date
class date : 
  virtual public CORBA::ValueBase
{
  public:
    static date* _downcast (CORBA::ValueBase *);
    static date* _downcast (CORBA::AbstractBase *);

    virtual CORBA::Boolean equal( date* other ) = 0;
    virtual CORBA::Short compare( date* other ) = 0;

    virtual void day( CORBA::UShort _p ) = 0;
    virtual CORBA::UShort day() const = 0;

    virtual void month( CORBA::UShort _p ) = 0;
    virtual CORBA::UShort month() const = 0;

    virtual void year( CORBA::UShort _p ) = 0;
    virtual CORBA::UShort year() const = 0;


  public:
    CORBA::ValueBase * _copy_value ();
    CORBA::ValueDef_ptr get_value_def ();
    virtual void * _narrow_helper (const char *);
    void _get_marshal_info (vector<string> &, CORBA::Boolean &);
    void _marshal_members (CORBA::DataEncoder &);
    CORBA::Boolean _demarshal_members (CORBA::DataDecoder &);

  protected:
    date ();
    virtual ~date ();
    void _copy_members (const date&);

  private:
    date (const date &);
    void operator= (const date &);
};

class date_init : public CORBA::ValueFactoryBase
{
  public:
    virtual ~date_init ();
    static date_init * _downcast (CORBA::ValueFactory);
    void * _narrow_helper (const char *);

    virtual date * create (CORBA::UShort dd, CORBA::UShort mm, CORBA::UShort yyyy) = 0;

  protected:
    date_init ();
};

#ifndef MICO_CONF_NO_POA

#endif // MICO_CONF_NO_POA


// OBV class for valuetype date
class OBV_date : virtual public date
{
  protected:
    OBV_date ();
    OBV_date (CORBA::UShort _day, CORBA::UShort _month, CORBA::UShort _year);
    virtual ~OBV_date();

  public:
    void day( CORBA::UShort _p );
    CORBA::UShort day() const;

    void month( CORBA::UShort _p );
    CORBA::UShort month() const;

    void year( CORBA::UShort _p );
    CORBA::UShort year() const;


  private:
    struct {
      CORBA::UShort day;
      CORBA::UShort month;
      CORBA::UShort year;
    } _m;
};

#if !defined(MICO_NO_TOPLEVEL_MODULES) || defined(MICO_MODULE__GLOBAL)

extern CORBA::StaticTypeInfo *_marshaller_date;

#endif // !defined(MICO_NO_TOPLEVEL_MODULES) || defined(MICO_MODULE__GLOBAL)


#if !defined(MICO_NO_TOPLEVEL_MODULES) && !defined(MICO_IN_GENERATED_CODE)
#include <mico/template_impl.h>
#endif

#endif
