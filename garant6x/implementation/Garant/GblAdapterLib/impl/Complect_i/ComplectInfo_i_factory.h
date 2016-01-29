////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfo_i
// �������� ���������� ������ ��������� ComplectInfo ��� �������� ComplectInfo_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFO_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFO_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/ComplectFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/Complect_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ComplectInfo_i
class ComplectInfo_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ComplectInfoAbstractFactory {
public:
	ComplectInfo_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ComplectInfo* make ();

};

typedef ::Core::Var<ComplectInfo_i_factory> ComplectInfo_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFO_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

