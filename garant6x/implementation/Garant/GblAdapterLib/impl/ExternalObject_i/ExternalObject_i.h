////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalObject_i
// ��������� ���������� ������ �������� ��� ��������� ExternalObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"

//#UC START# *45EE7EE90046_CUSTOM_INCLUDES*
//#UC END# *45EE7EE90046_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class ExternalObject_i; // self forward Var
typedef ::Core::Var<ExternalObject_i> ExternalObject_i_var;
typedef ::Core::Var<const ExternalObject_i> ExternalObject_i_cvar;

class ExternalObject_i_factory;

class ExternalObject_i:
	virtual public ExternalObject
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ExternalObject_i)
	friend class ExternalObject_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExternalObject_i ();

	ExternalObject_i (GblPilot::InternalObj* obj);

	virtual ~ExternalObject_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GblPilotDef::Blob_var m_blob;

	mutable GCI::IO::String_var m_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ExternalObject
	// ��������� �� ����� � �������.
	virtual const void* get_data_pointer () const;
	virtual void* get_data_pointer ();

	// implemented method from ExternalObject
	// ����� ������ ������������ ������.
	virtual unsigned long get_data_size () const;

	// implemented method from ExternalObject
	virtual ExternalObjectType get_data_type () const;

	// implemented method from ExternalObject
	// ���������� ��� ����� (������ � ���������� ������) �� �����
	virtual const GCI::IO::String* get_extension () const;

	// implemented method from ExternalObject
	// ��� �������� �������.
	virtual const GCI::IO::String* get_name () const;

//#UC START# *45EE7EE90046*
//#UC END# *45EE7EE90046*
}; // class ExternalObject_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
