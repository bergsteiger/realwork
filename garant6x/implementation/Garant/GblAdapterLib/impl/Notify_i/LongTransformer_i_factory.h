////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::LongTransformer_i
// �������� ���������� ������ ��������� DataTransformer ��� �������� LongTransformer_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_LONGTRANSFORMER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_LONGTRANSFORMER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocalFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for LongTransformer_i
class LongTransformer_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DataTransformerAbstractFactory
{
public:
	LongTransformer_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DataTransformer* make ();

};

typedef ::Core::Var<LongTransformer_i_factory> LongTransformer_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_LONGTRANSFORMER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

