////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalObjectFromLink.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalObjectFromLink
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALOBJECTFROMLINK_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALOBJECTFROMLINK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

class ExternalObjectFromLink; // self forward Var
typedef ::Core::Var<ExternalObjectFromLink> ExternalObjectFromLink_var;
typedef ::Core::Var<const ExternalObjectFromLink> ExternalObjectFromLink_cvar;

class ExternalObjectFromLink_factory;

class ExternalObjectFromLink:
	virtual public ObjectFromLink_i
{
	SET_OBJECT_COUNTER (ExternalObjectFromLink)
	friend class ExternalObjectFromLink_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExternalObjectFromLink (GblPilot::Link* server_link);

	virtual ~ExternalObjectFromLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ObjectFromLink
	virtual Core::IObject* get_object () const;

	// implemented method from ObjectFromLink
	virtual LinkedObjectType get_object_type () const;
}; // class ExternalObjectFromLink

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_EXTERNALOBJECTFROMLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
