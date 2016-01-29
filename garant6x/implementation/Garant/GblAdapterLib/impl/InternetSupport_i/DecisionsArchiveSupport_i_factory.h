////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::DecisionsArchiveSupport_i
// �������� ���������� ������ ��������� DecisionsArchiveSupport ��� �������� DecisionsArchiveSupport_i
//
// ��������� ������� � ������� �������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_DECISIONSARCHIVESUPPORT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_DECISIONSARCHIVESUPPORT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupportFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DecisionsArchiveSupport_i
class DecisionsArchiveSupport_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DecisionsArchiveSupportAbstractFactory
{
public:
	DecisionsArchiveSupport_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DecisionsArchiveSupport* make ();

};

typedef ::Core::Var<DecisionsArchiveSupport_i_factory> DecisionsArchiveSupport_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_DECISIONSARCHIVESUPPORT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

