////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MorphoAdapter_i
// �������� ���������� ������ ��������� MorphoAdapter ��� �������� MorphoAdapter_i
//
// ���������� ���������� MorphoAdapter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOADAPTER_I_FCTR_H__
#define __GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOADAPTER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/DefFactories.h"

namespace MorphoAdapterLib {
namespace Impl {

/// Interface-factory implementation for MorphoAdapter_i
class MorphoAdapter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public MorphoAdapterAbstractFactory {
public:
	MorphoAdapter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MorphoAdapter* make ();

};

typedef ::Core::Var<MorphoAdapter_i_factory> MorphoAdapter_i_factory_var;

} // namespace Impl
} // namespace MorphoAdapterLib


#endif //__GARANTCORE_MORPHOADAPTERLIB_IMPL_MORPHOADAPTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

