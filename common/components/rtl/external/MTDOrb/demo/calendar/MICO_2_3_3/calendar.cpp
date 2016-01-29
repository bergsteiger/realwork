/*
 *  MICO --- a free CORBA implementation
 *  Copyright (C) 1997-98 Kay Roemer & Arno Puder
 *
 *  This file was automatically generated. DO NOT EDIT!
 */

#include "calendar.h"

//--------------------------------------------------------
//  Implementation of stubs
//--------------------------------------------------------

// Stub interface Calendar
Calendar::~Calendar()
{
}

void *Calendar::_narrow_helper( const char *_repoid )
{
  if( strcmp( _repoid, "IDL:Calendar:1.0" ) == 0 )
    return (void *)this;
  return NULL;
}

bool Calendar::_narrow_helper2( CORBA::Object_ptr _obj )
{
  if( strcmp( _obj->_repoid(), "IDL:Calendar:1.0" ) == 0) {
    return true;
  }
  for( vector<CORBA::Narrow_proto>::size_type _i = 0;
       _narrow_helpers && _i < _narrow_helpers->size(); _i++ ) {
    bool _res = (*(*_narrow_helpers)[ _i ])( _obj );
    if( _res )
      return true;
  }
  return false;
}

Calendar_ptr Calendar::_narrow( CORBA::Object_ptr _obj )
{
  Calendar_ptr _o;
  if( !CORBA::is_nil( _obj ) ) {
    void *_p;
    if( (_p = _obj->_narrow_helper( "IDL:Calendar:1.0" )))
      return _duplicate( (Calendar_ptr) _p );
    if( _narrow_helper2( _obj ) ||
       ( _obj->_is_a_remote( "IDL:Calendar:1.0" ) ) ) {
      _o = new Calendar_stub;
      _o->MICO_SCOPE(CORBA,Object::operator=)( *_obj );
      return _o;
    }
  }
  return _nil();
}

Calendar_ptr
Calendar::_narrow( CORBA::AbstractBase_ptr _obj )
{
  return _narrow (_obj->_to_object());
}

Calendar_stub::~Calendar_stub()
{
}

#ifndef MICO_CONF_NO_POA

void *
POA_Calendar::_narrow_helper (const char * repoid)
{
  if (strcmp (repoid, "IDL:Calendar:1.0") == 0) {
    return (void *) this;
  }
  return NULL;
}

POA_Calendar *
POA_Calendar::_narrow (PortableServer::Servant serv) 
{
  void * p;
  if ((p = serv->_narrow_helper ("IDL:Calendar:1.0")) != NULL) {
    serv->_add_ref ();
    return (POA_Calendar *) p;
  }
  return NULL;
}

Calendar_stub_clp::Calendar_stub_clp ()
{
}

Calendar_stub_clp::Calendar_stub_clp (PortableServer::POA_ptr poa, CORBA::Object_ptr obj)
  : MICO_SCOPE(PortableServer,StubBase) (poa), MICO_SCOPE(CORBA,Object) (*obj)
{
}

Calendar_stub_clp::~Calendar_stub_clp ()
{
}

#endif // MICO_CONF_NO_POA

void Calendar_stub::insert( date* when, const char* what )
{
  CORBA::StaticAny _when( _marshaller_date, &when );
  CORBA::StaticAny _what( CORBA::_stc_string, &what );
  CORBA::StaticRequest __req( this, "insert" );
  __req.add_in_arg( &_when );
  __req.add_in_arg( &_what );

  __req.invoke();

  mico_sii_throw( &__req, 
    0);
}


#ifndef MICO_CONF_NO_POA

void
Calendar_stub_clp::insert( date* when, const char* what )
{
  PortableServer::Servant _serv = _preinvoke ();
  if (_serv) {
    POA_Calendar * _myserv = POA_Calendar::_narrow (_serv);
    if (_myserv) {
      date* _when;
      _when = date::_downcast (when->_copy_value());
      #ifdef HAVE_EXCEPTIONS
      try {
      #endif
        _myserv->insert(_when, what);
      #ifdef HAVE_EXCEPTIONS
      }
      catch (...) {
        _myserv->_remove_ref();
        _postinvoke();
        throw;
      }
      #endif

      _myserv->_remove_ref();
      _postinvoke ();
      CORBA::remove_ref (_when);
      return;
    }
    _postinvoke ();
  }

  typedef Calendar_stub _VCHACK__classname;
  _VCHACK__classname::insert(when, what);
}

#endif // MICO_CONF_NO_POA

CORBA::Boolean Calendar_stub::find_date( date* when, char*& what )
{
  CORBA::StaticAny _when( _marshaller_date, &when );
  CORBA::StaticAny _what( CORBA::_stc_string, &what );
  CORBA::Boolean _res;
  CORBA::StaticAny __res( CORBA::_stc_boolean, &_res );

  CORBA::StaticRequest __req( this, "find_date" );
  __req.add_in_arg( &_when );
  __req.add_out_arg( &_what );
  __req.set_result( &__res );

  __req.invoke();

  mico_sii_throw( &__req, 
    0);
  return _res;
}


#ifndef MICO_CONF_NO_POA

CORBA::Boolean
Calendar_stub_clp::find_date( date* when, char*& what )
{
  PortableServer::Servant _serv = _preinvoke ();
  if (_serv) {
    POA_Calendar * _myserv = POA_Calendar::_narrow (_serv);
    if (_myserv) {
      CORBA::Boolean __res;

      date* _when;
      _when = date::_downcast (when->_copy_value());
      #ifdef HAVE_EXCEPTIONS
      try {
      #endif
        __res = _myserv->find_date(_when, what);
      #ifdef HAVE_EXCEPTIONS
      }
      catch (...) {
        _myserv->_remove_ref();
        _postinvoke();
        throw;
      }
      #endif

      _myserv->_remove_ref();
      _postinvoke ();
      CORBA::remove_ref (_when);
      return __res;
    }
    _postinvoke ();
  }

  typedef Calendar_stub _VCHACK__classname;
  return _VCHACK__classname::find_date(when, what);
}

#endif // MICO_CONF_NO_POA

CORBA::Boolean Calendar_stub::find_note( const char* what, date*& when )
{
  CORBA::StaticAny _what( CORBA::_stc_string, &what );
  CORBA::StaticAny _when( _marshaller_date, &when );
  CORBA::Boolean _res;
  CORBA::StaticAny __res( CORBA::_stc_boolean, &_res );

  CORBA::StaticRequest __req( this, "find_note" );
  __req.add_in_arg( &_what );
  __req.add_out_arg( &_when );
  __req.set_result( &__res );

  __req.invoke();

  mico_sii_throw( &__req, 
    0);
  return _res;
}


#ifndef MICO_CONF_NO_POA

CORBA::Boolean
Calendar_stub_clp::find_note( const char* what, date*& when )
{
  PortableServer::Servant _serv = _preinvoke ();
  if (_serv) {
    POA_Calendar * _myserv = POA_Calendar::_narrow (_serv);
    if (_myserv) {
      CORBA::Boolean __res;

      date* _when;
      #ifdef HAVE_EXCEPTIONS
      try {
      #endif
        __res = _myserv->find_note(what, _when);
      #ifdef HAVE_EXCEPTIONS
      }
      catch (...) {
        _myserv->_remove_ref();
        _postinvoke();
        throw;
      }
      #endif

      _myserv->_remove_ref();
      _postinvoke ();
      when = date::_downcast (_when->_copy_value());
      CORBA::remove_ref (_when);
      return __res;
    }
    _postinvoke ();
  }

  typedef Calendar_stub _VCHACK__classname;
  return _VCHACK__classname::find_note(what, when);
}

#endif // MICO_CONF_NO_POA

vector<CORBA::Narrow_proto> * Calendar::_narrow_helpers;

class _Marshaller_Calendar : public CORBA::StaticTypeInfo {
    typedef Calendar_ptr _MICO_T;
  public:
    StaticValueType create () const;
    void assign (StaticValueType dst, const StaticValueType src) const;
    void free (StaticValueType) const;
    CORBA::Boolean demarshal (CORBA::DataDecoder&, StaticValueType) const;
    void marshal (CORBA::DataEncoder &, StaticValueType) const;
};


CORBA::StaticValueType _Marshaller_Calendar::create() const
{
  return (StaticValueType) new _MICO_T( 0 );
}

void _Marshaller_Calendar::assign( StaticValueType d, const StaticValueType s ) const
{
  *(_MICO_T*) d = ::Calendar::_duplicate( *(_MICO_T*) s );
}

void _Marshaller_Calendar::free( StaticValueType v ) const
{
  CORBA::release( *(_MICO_T *) v );
  delete (_MICO_T*) v;
}

CORBA::Boolean _Marshaller_Calendar::demarshal( CORBA::DataDecoder &dc, StaticValueType v ) const
{
  CORBA::Object_ptr obj;
  if (!CORBA::_stc_Object->demarshal(dc, &obj))
    return FALSE;
  *(_MICO_T *) v = ::Calendar::_narrow( obj );
  CORBA::Boolean ret = CORBA::is_nil (obj) || !CORBA::is_nil (*(_MICO_T *)v);
  CORBA::release (obj);
  return ret;
}

void _Marshaller_Calendar::marshal( CORBA::DataEncoder &ec, StaticValueType v ) const
{
  CORBA::Object_ptr obj = *(_MICO_T *) v;
  CORBA::_stc_Object->marshal( ec, &obj );
}

CORBA::StaticTypeInfo *_marshaller_Calendar;

struct __tc_init_CALENDAR {
  __tc_init_CALENDAR()
  {
    _marshaller_Calendar = new _Marshaller_Calendar;
  }
};

static __tc_init_CALENDAR __init_CALENDAR;

//--------------------------------------------------------
//  Implementation of skeletons
//--------------------------------------------------------

Calendar_skel::Calendar_skel( const CORBA::BOA::ReferenceData &_id )
{
  CORBA::ImplementationDef_var _impl =
    _find_impl( "IDL:Calendar:1.0", "Calendar" );
  assert( !CORBA::is_nil( _impl ) );
  _create_ref( _id,
    0,
    _impl,
    "IDL:Calendar:1.0" );
  register_dispatcher( new StaticInterfaceDispatcherWrapper<Calendar_skel>( this ) );
}

Calendar_skel::Calendar_skel( CORBA::Object_ptr _obj )
{
  CORBA::ImplementationDef_var _impl =
    _find_impl( "IDL:Calendar:1.0", "Calendar" );
  assert( !CORBA::is_nil( _impl ) );
  _restore_ref( _obj,
    CORBA::BOA::ReferenceData(),
    0,
    _impl );
  register_dispatcher( new StaticInterfaceDispatcherWrapper<Calendar_skel>( this ) );
}

Calendar_skel::~Calendar_skel()
{
}

bool Calendar_skel::dispatch( CORBA::StaticServerRequest_ptr _req, CORBA::Environment & /*_env*/ )
{
  #ifdef HAVE_EXCEPTIONS
  try {
  #endif
    if( strcmp( _req->op_name(), "insert" ) == 0 ) {
      date_var when;
      CORBA::StaticAny _when( _marshaller_date, &when.inout() );
      CORBA::String_var what;
      CORBA::StaticAny _what( CORBA::_stc_string, &what.inout() );

      _req->add_in_arg( &_when );
      _req->add_in_arg( &_what );

      if( !_req->read_args() )
        return true;

      insert( when, what );
      _req->write_results();
      return true;
    }
    if( strcmp( _req->op_name(), "find_date" ) == 0 ) {
      date_var when;
      CORBA::StaticAny _when( _marshaller_date, &when.inout() );
      char* what;
      CORBA::StaticAny _what( CORBA::_stc_string, &what );

      CORBA::Boolean _res;
      CORBA::StaticAny __res( CORBA::_stc_boolean, &_res );
      _req->add_in_arg( &_when );
      _req->add_out_arg( &_what );
      _req->set_result( &__res );

      if( !_req->read_args() )
        return true;

      _res = find_date( when, what );
      _req->write_results();
      CORBA::string_free( what );
      return true;
    }
    if( strcmp( _req->op_name(), "find_note" ) == 0 ) {
      CORBA::String_var what;
      CORBA::StaticAny _what( CORBA::_stc_string, &what.inout() );
      date* when;
      CORBA::StaticAny _when( _marshaller_date, &when );

      CORBA::Boolean _res;
      CORBA::StaticAny __res( CORBA::_stc_boolean, &_res );
      _req->add_in_arg( &_what );
      _req->add_out_arg( &_when );
      _req->set_result( &__res );

      if( !_req->read_args() )
        return true;

      _res = find_note( what, when );
      _req->write_results();
      CORBA::remove_ref( when );
      return true;
    }
  #ifdef HAVE_EXCEPTIONS
  } catch( CORBA::SystemException_catch &_ex ) {
    _req->set_exception( _ex->_clone() );
    _req->write_results();
    return true;
  } catch( ... ) {
    assert( 0 );
    return true;
  }
  #endif
  return false;
}

Calendar_ptr Calendar_skel::_this()
{
  return Calendar::_duplicate( this );
}


// PortableServer Skeleton Class for interface Calendar
POA_Calendar::~POA_Calendar()
{
}

Calendar_ptr
POA_Calendar::_this ()
{
  CORBA::Object_var obj = MICO_SCOPE(PortableServer,ServantBase::_this) ();
  return Calendar::_narrow (obj);
}

CORBA::Boolean
POA_Calendar::_is_a (const char * repoid)
{
  if (strcmp (repoid, "IDL:Calendar:1.0") == 0) {
    return TRUE;
  }
  return FALSE;
}

CORBA::InterfaceDef_ptr
POA_Calendar::_get_interface ()
{
  CORBA::InterfaceDef_ptr ifd = MICO_SCOPE(PortableServer,ServantBase)::_get_interface ("IDL:Calendar:1.0");

  if (CORBA::is_nil (ifd)) {
    mico_throw (CORBA::OBJ_ADAPTER (0, CORBA::COMPLETED_NO));
  }

  return ifd;
}

CORBA::RepositoryId
POA_Calendar::_primary_interface (const PortableServer::ObjectId &, PortableServer::POA_ptr)
{
  return CORBA::string_dup ("IDL:Calendar:1.0");
}

CORBA::Object_ptr
POA_Calendar::_make_stub (PortableServer::POA_ptr poa, CORBA::Object_ptr obj)
{
  return new Calendar_stub_clp (poa, obj);
}

bool
POA_Calendar::dispatch (CORBA::StaticServerRequest_ptr _req)
{
  #ifdef HAVE_EXCEPTIONS
  try {
  #endif
    if( strcmp( _req->op_name(), "insert" ) == 0 ) {
      date_var when;
      CORBA::StaticAny _when( _marshaller_date, &when.inout() );
      CORBA::String_var what;
      CORBA::StaticAny _what( CORBA::_stc_string, &what.inout() );

      _req->add_in_arg( &_when );
      _req->add_in_arg( &_what );

      if( !_req->read_args() )
        return true;

      insert( when, what );
      _req->write_results();
      return true;
    }
    if( strcmp( _req->op_name(), "find_date" ) == 0 ) {
      date_var when;
      CORBA::StaticAny _when( _marshaller_date, &when.inout() );
      char* what;
      CORBA::StaticAny _what( CORBA::_stc_string, &what );

      CORBA::Boolean _res;
      CORBA::StaticAny __res( CORBA::_stc_boolean, &_res );
      _req->add_in_arg( &_when );
      _req->add_out_arg( &_what );
      _req->set_result( &__res );

      if( !_req->read_args() )
        return true;

      _res = find_date( when, what );
      _req->write_results();
      CORBA::string_free( what );
      return true;
    }
    if( strcmp( _req->op_name(), "find_note" ) == 0 ) {
      CORBA::String_var what;
      CORBA::StaticAny _what( CORBA::_stc_string, &what.inout() );
      date* when;
      CORBA::StaticAny _when( _marshaller_date, &when );

      CORBA::Boolean _res;
      CORBA::StaticAny __res( CORBA::_stc_boolean, &_res );
      _req->add_in_arg( &_what );
      _req->add_out_arg( &_when );
      _req->set_result( &__res );

      if( !_req->read_args() )
        return true;

      _res = find_note( what, when );
      _req->write_results();
      CORBA::remove_ref( when );
      return true;
    }
  #ifdef HAVE_EXCEPTIONS
  } catch( CORBA::SystemException_catch &_ex ) {
    _req->set_exception( _ex->_clone() );
    _req->write_results();
    return true;
  } catch( ... ) {
    assert( 0 );
    return true;
  }
  #endif

  return false;
}

void
POA_Calendar::invoke (CORBA::StaticServerRequest_ptr _req)
{
  if (dispatch (_req)) {
      return;
  }

  CORBA::Exception * ex = 
    new CORBA::BAD_OPERATION (0, CORBA::COMPLETED_NO);
  _req->set_exception (ex);
  _req->write_results();
}

