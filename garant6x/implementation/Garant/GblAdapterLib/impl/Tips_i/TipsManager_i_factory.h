////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsManager_i
// �������� ���������� ������ ��������� TipsManager ��� �������� TipsManager_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/TipsFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for TipsManager_i
class TipsManager_i_factory: virtual public ::Core::RefCountObjectBase, virtual public TipsManagerAbstractFactory {
public:
	TipsManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	TipsManager* make ();

};

typedef ::Core::Var<TipsManager_i_factory> TipsManager_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

