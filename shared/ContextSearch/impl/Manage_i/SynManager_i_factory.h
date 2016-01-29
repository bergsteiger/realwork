////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Manage_i/SynManager_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::SynManager_i
// �������� ���������� ������ ��������� ISynManager ��� �������� SynManager_i
//
// ���������� ���������� ISynManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_SYNMANAGER_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_SYNMANAGER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Manage/ManageFactories.h"

namespace ContextSearch {
namespace Manage_i {

/// Interface-factory implementation for SynManager_i
class SynManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Manage::ISynManagerAbstractFactory
{
public:
	SynManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Manage::ISynManager* make (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm);

};

typedef ::Core::Var<SynManager_i_factory> SynManager_i_factory_var;

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_SYNMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

