/*
 *  MICO --- a free CORBA implementation
 *  Copyright (C) 1997-98 Kay Roemer & Arno Puder
 *
 *  This file was automatically generated. DO NOT EDIT!
 */

#if !defined(__CALENDAR_H__) || defined(MICO_NO_TOPLEVEL_MODULES)
#define __CALENDAR_H__

#ifndef MICO_NO_TOPLEVEL_MODULES
#include <CORBA.h>
#include <mico/throw.h>
#endif

#ifdef MICO_IN_GENERATED_CODE
#include "date.h"
#else
#define MICO_IN_GENERATED_CODE
#include "date.h"
#undef MICO_IN_GENERATED_CODE
#endif

class Calendar;
typedef Calendar *Calendar_ptr;
typedef Calendar_ptr CalendarRef;
typedef ObjVar<Calendar> Calendar_var;
typedef Calendar_var Calendar_out;


// Common definitions for interface Calendar
class Calendar : 
  virtual public CORBA::Object
{
  public:
    virtual ~Calendar();

    #ifdef HAVE_TYPEDEF_OVERLOAD
    typedef Calendar_ptr _ptr_type;
    typedef Calendar_var _var_type;
    #endif

    static Calendar_ptr _narrow( CORBA::Object_ptr obj );
    static Calendar_ptr _narrow( CORBA::AbstractBase_ptr obj );
    static Calendar_ptr _duplicate( Calendar_ptr _obj )
    {
      CORBA::Object::_duplicate (_obj);
      return _obj;
    }

    static Calendar_ptr _nil()
    {
      return 0;
    }

    virtual void *_narrow_helper( const char *repoid );
    static vector<CORBA::Narrow_proto> *_narrow_helpers;
    static bool _narrow_helper2( CORBA::Object_ptr obj );

    virtual void insert( date* when, const char* what ) = 0;
    virtual CORBA::Boolean find_date( date* when, char*& what ) = 0;
    virtual CORBA::Boolean find_note( const char* what, date*& when ) = 0;

  protected:
    Calendar() {};
  private:
    Calendar( const Calendar& );
    void operator=( const Calendar& );
};

// Stub for interface Calendar
class Calendar_stub:
  virtual public Calendar
{
  public:
    virtual ~Calendar_stub();
    void insert( date* when, const char* what );
    CORBA::Boolean find_date( date* when, char*& what );
    CORBA::Boolean find_note( const char* what, date*& when );

  private:
    void operator=( const Calendar_stub& );
};

#ifndef MICO_CONF_NO_POA

class Calendar_stub_clp :
  virtual public Calendar_stub,
  virtual public PortableServer::StubBase
{
  public:
    Calendar_stub_clp (PortableServer::POA_ptr, CORBA::Object_ptr);
    virtual ~Calendar_stub_clp ();
    void insert( date* when, const char* what );
    CORBA::Boolean find_date( date* when, char*& what );
    CORBA::Boolean find_note( const char* what, date*& when );

  protected:
    Calendar_stub_clp ();
  private:
    void operator=( const Calendar_stub_clp & );
};

#endif // MICO_CONF_NO_POA

class Calendar_skel :
  virtual public StaticMethodDispatcher,
  virtual public Calendar
{
  public:
    Calendar_skel( const CORBA::BOA::ReferenceData & = CORBA::BOA::ReferenceData() );
    virtual ~Calendar_skel();
    Calendar_skel( CORBA::Object_ptr obj );
    virtual bool dispatch( CORBA::StaticServerRequest_ptr _req, CORBA::Environment &_env );
    Calendar_ptr _this();

};

#ifndef MICO_CONF_NO_POA

class POA_Calendar : virtual public PortableServer::StaticImplementation
{
  public:
    virtual ~POA_Calendar ();
    Calendar_ptr _this ();
    bool dispatch (CORBA::StaticServerRequest_ptr);
    virtual void invoke (CORBA::StaticServerRequest_ptr);
    virtual CORBA::Boolean _is_a (const char *);
    virtual CORBA::InterfaceDef_ptr _get_interface ();
    virtual CORBA::RepositoryId _primary_interface (const PortableServer::ObjectId &, PortableServer::POA_ptr);

    virtual void * _narrow_helper (const char *);
    static POA_Calendar * _narrow (PortableServer::Servant);
    virtual CORBA::Object_ptr _make_stub (PortableServer::POA_ptr, CORBA::Object_ptr);

    virtual void insert( date* when, const char* what ) = 0;
    virtual CORBA::Boolean find_date( date* when, char*& what ) = 0;
    virtual CORBA::Boolean find_note( const char* what, date*& when ) = 0;

  protected:
    POA_Calendar () {};

  private:
    POA_Calendar (const POA_Calendar &);
    void operator= (const POA_Calendar &);
};

template<class T>
class POA_Calendar_tie : 
  virtual public POA_Tie_Base<T>,
  virtual public POA_Calendar
{
  public:
    POA_Calendar_tie (T &t)
      : POA_Tie_Base<T> (&t, PortableServer::POA::_nil(), FALSE)
    {}
    POA_Calendar_tie (T &t, PortableServer::POA_ptr _poa)
      : POA_Tie_Base<T> (&t, _poa, FALSE)
    {}
    POA_Calendar_tie (T *t, CORBA::Boolean _rel = TRUE)
      : POA_Tie_Base<T> (t, PortableServer::POA::_nil(), _rel)
    {}
    POA_Calendar_tie (T *t, PortableServer::POA_ptr _poa, CORBA::Boolean _rel = TRUE)
      : POA_Tie_Base<T> (t, _poa, _rel)
    {}
    virtual ~POA_Calendar_tie ();

    PortableServer::POA_ptr _default_POA ();

    void insert( date* when, const char* what );
    CORBA::Boolean find_date( date* when, char*& what );
    CORBA::Boolean find_note( const char* what, date*& when );

  protected:
    POA_Calendar_tie () {};

  private:
    POA_Calendar_tie (const POA_Calendar_tie<T> &);
    void operator= (const POA_Calendar_tie<T> &);
};

template<class T>
POA_Calendar_tie<T>::~POA_Calendar_tie ()
{
}

template<class T>
PortableServer::POA_ptr
POA_Calendar_tie<T>::_default_POA ()
{
  if (!CORBA::is_nil (POA_Tie_Base<T>::poa)) {
    return PortableServer::POA::_duplicate (POA_Tie_Base<T>::poa);
  }
  typedef PortableServer::ServantBase _VCHACK__PortableServer__ServantBase;
  return _VCHACK__PortableServer__ServantBase::_default_POA ();
}

template<class T>
void
POA_Calendar_tie<T>::insert (date* when, const char* what)
{
  POA_Tie_Base<T>::ptr->insert (when, what);
}

template<class T>
CORBA::Boolean
POA_Calendar_tie<T>::find_date (date* when, char*& what)
{
  return POA_Tie_Base<T>::ptr->find_date (when, what);
}

template<class T>
CORBA::Boolean
POA_Calendar_tie<T>::find_note (const char* what, date*& when)
{
  return POA_Tie_Base<T>::ptr->find_note (what, when);
}

#endif // MICO_CONF_NO_POA

#if !defined(MICO_NO_TOPLEVEL_MODULES) || defined(MICO_MODULE__GLOBAL)

extern CORBA::StaticTypeInfo *_marshaller_Calendar;

#endif // !defined(MICO_NO_TOPLEVEL_MODULES) || defined(MICO_MODULE__GLOBAL)


#if !defined(MICO_NO_TOPLEVEL_MODULES) && !defined(MICO_IN_GENERATED_CODE)
#include <mico/template_impl.h>
#endif

#endif
