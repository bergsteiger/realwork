////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::MDACmdManager
// �������� ���������� ������ ��������� CmdManager ��� �������� MDACmdManager
//
// �������� MDA-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

namespace MDACommands {

/// Interface-factory implementation for MDACmdManager
class MDACmdManager_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Commands::CmdManagerAbstractFactory
{
public:
	MDACmdManager_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Commands::CmdManager* get ();

};

typedef ::Core::Var<MDACmdManager_factory> MDACmdManager_factory_var;

} // namespace MDACommands


#endif //__MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

