/*
 *  MICO --- a free CORBA implementation
 *  Copyright (C) 1997-98 Kay Roemer & Arno Puder
 *
 *  This file was automatically generated. DO NOT EDIT!
 */

#include "date.h"

//--------------------------------------------------------
//  Implementation of stubs
//--------------------------------------------------------

// valuetype date
date::date ()
{
}

date::~date ()
{
}

void *
date::_narrow_helper (const char * repoid)
{
  if (strcmp (repoid, "IDL:date:1.0") == 0) {
    return (void *) this;
  }
  return NULL;
}

date *
date::_downcast (CORBA::ValueBase * vb) 
{
  void * p;
  if (vb && ((p = vb->_narrow_helper ("IDL:date:1.0")))) {
    return (date *) p;
  }
  return 0;
}

date *
date::_downcast (CORBA::AbstractBase * vb) 
{
  return _downcast (vb->_to_value());
}

CORBA::ValueDef_ptr
date::get_value_def () 
{
  CORBA::ORB_var orb = CORBA::ORB_instance ("mico-local-orb");
  CORBA::Object_var irobj = 
    orb->resolve_initial_references ("InterfaceRepository");
  CORBA::Repository_var ifr = CORBA::Repository::_narrow (irobj);
  assert (!CORBA::is_nil (ifr));

  CORBA::Contained_var cv = ifr->lookup_id ("IDL:date:1.0");
  CORBA::ValueDef_ptr val = CORBA::ValueDef::_narrow (cv);
  return val;
}

void
date::_copy_members (const date& other)
{
  day (other.day());
  month (other.month());
  year (other.year());
}

CORBA::ValueBase *
date::_copy_value ()
{
  vector<string> _dummy;
  string _repo_id = "IDL:date:1.0";
  date * _res = _downcast (_create (_dummy, _repo_id));
  assert (_res != 0);
  _res->_copy_members (*this);
  return _res;
}

void
date::_get_marshal_info (vector<string> & repoids, CORBA::Boolean & chunked)
{
  repoids.push_back ("IDL:date:1.0");
  chunked = FALSE;
}

void
date::_marshal_members (CORBA::DataEncoder &ec)
{
  CORBA::UShort _day = day ();
  CORBA::_stc_ushort->marshal (ec, &_day);
  CORBA::UShort _month = month ();
  CORBA::_stc_ushort->marshal (ec, &_month);
  CORBA::UShort _year = year ();
  CORBA::_stc_ushort->marshal (ec, &_year);
}

CORBA::Boolean
date::_demarshal_members (CORBA::DataDecoder &dc)
{
  CORBA::UShort _day;
  if (!CORBA::_stc_ushort->demarshal (dc, &_day)) {
      return FALSE;
  }
  day (_day);
  CORBA::UShort _month;
  if (!CORBA::_stc_ushort->demarshal (dc, &_month)) {
      return FALSE;
  }
  month (_month);
  CORBA::UShort _year;
  if (!CORBA::_stc_ushort->demarshal (dc, &_year)) {
      return FALSE;
  }
  year (_year);
  return TRUE;
}

date_init::date_init ()
{
}

date_init::~date_init ()
{
}

void *
date_init::_narrow_helper (const char * repoid)
{
  if (strcmp (repoid, "IDL:date:1.0") == 0) {
    return (void *) this;
  }
  return NULL;
}

date_init *
date_init::_downcast (CORBA::ValueFactory vf) 
{
  void * p;
  if (vf && ((p = vf->_narrow_helper ("IDL:date:1.0")))) {
    return (date_init *) p;
  }
  return 0;
}

class _Marshaller_date : public CORBA::StaticTypeInfo {
    typedef date* _MICO_T;
  public:
    StaticValueType create () const;
    void assign (StaticValueType dst, const StaticValueType src) const;
    void free (StaticValueType) const;
    CORBA::Boolean demarshal (CORBA::DataDecoder&, StaticValueType) const;
    void marshal (CORBA::DataEncoder &, StaticValueType) const;
};


CORBA::StaticValueType _Marshaller_date::create() const
{
  return (StaticValueType) new _MICO_T( 0 );
}

void _Marshaller_date::assign( StaticValueType d, const StaticValueType s ) const
{
  CORBA::remove_ref (*(_MICO_T*)d);
  CORBA::add_ref (*(_MICO_T*)s);
  *(_MICO_T*) d = *(_MICO_T*) s;
}

void _Marshaller_date::free( StaticValueType v ) const
{
  CORBA::remove_ref (*(_MICO_T*)v);
  delete (_MICO_T*) v;
}

CORBA::Boolean _Marshaller_date::demarshal( CORBA::DataDecoder &dc, StaticValueType v ) const
{
  CORBA::ValueBase* vb;
  if (!CORBA::ValueBase::_demarshal (dc, vb, "IDL:date:1.0")) {
    return FALSE;
  }
  *(_MICO_T *)v = ::date::_downcast (vb);
  if (vb && !*(_MICO_T *)v) {
    CORBA::remove_ref (vb);
    return FALSE;
  }
  return TRUE;
}

void _Marshaller_date::marshal( CORBA::DataEncoder &ec, StaticValueType v ) const
{
  CORBA::ValueBase::_marshal (ec, *(_MICO_T *)v);
}

CORBA::StaticTypeInfo *_marshaller_date;



// OBV class for valuetype date
OBV_date::OBV_date ()
{
}

OBV_date::OBV_date (CORBA::UShort _day, CORBA::UShort _month, CORBA::UShort _year)
{
  _m.day = _day;
  _m.month = _month;
  _m.year = _year;
}

OBV_date::~OBV_date ()
{
}

void OBV_date::day( CORBA::UShort _p )
{
  _m.day = _p;
}

CORBA::UShort OBV_date::day() const
{
  return (CORBA::UShort)_m.day;
}

void OBV_date::month( CORBA::UShort _p )
{
  _m.month = _p;
}

CORBA::UShort OBV_date::month() const
{
  return (CORBA::UShort)_m.month;
}

void OBV_date::year( CORBA::UShort _p )
{
  _m.year = _p;
}

CORBA::UShort OBV_date::year() const
{
  return (CORBA::UShort)_m.year;
}

struct __tc_init_DATE {
  __tc_init_DATE()
  {
    _marshaller_date = new _Marshaller_date;
  }
};

static __tc_init_DATE __init_DATE;

//--------------------------------------------------------
//  Implementation of skeletons
//--------------------------------------------------------
