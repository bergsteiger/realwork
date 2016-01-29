////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DeletedContentFromLink
// �������� ���������� ������ ���������  ��� �������� DeletedContentFromLink
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DELETEDCONTENTFROMLINK_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DELETEDCONTENTFROMLINK_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DeletedContentFromLink
class DeletedContentFromLink_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ObjectFromLinkAbstractFactory
{
public:
	DeletedContentFromLink_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const LinkedObjectType key () const;

	ObjectFromLink* make (GblPilot::Link* server_link);

};

typedef ::Core::Var<DeletedContentFromLink_factory> DeletedContentFromLink_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DELETEDCONTENTFROMLINK_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

