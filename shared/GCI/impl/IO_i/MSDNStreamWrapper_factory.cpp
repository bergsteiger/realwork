////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/IO_i/MSDNStreamWrapper_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::MSDNStreamWrapper
//
// ������ ������ msdn-������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/IO_i/MSDNStreamWrapper_factory.h"
#include "shared/GCI/impl/IO_i/MSDNStreamWrapper.h"

namespace GCI {
namespace IO_i {

MSDNStreamWrapper_factory::MSDNStreamWrapper_factory () {
}

void MSDNStreamWrapper_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IO::StreamFactoryManager::register_factory (this, priority);
}

const char* MSDNStreamWrapper_factory::key () const {
	return "MSDNStreamWrapper";
}

// ������� ������ �����
IO::Stream* MSDNStreamWrapper_factory::make () {
	//#UC START# *4423FB5903D8476263570115_442807A00138_IMPL*
	GDS_ASSERT (false && "Don't use this factory for create MSDNStreamWrapper");
	throw Core::Root::NoActiveFactory ("Don't use this factory for create MSDNStreamWrapper");
	//#UC END# *4423FB5903D8476263570115_442807A00138_IMPL*
}

// ������� ����� ��������� � ������
IO::Stream* MSDNStreamWrapper_factory::make (const char* path) {
	//#UC START# *4423FB5903D8476263570115_44312A6F0128_IMPL*
	GDS_ASSERT (false && "Don't use this factory for create MSDNStreamWrapper");
	throw Core::Root::NoActiveFactory ("Don't use this factory for create MSDNStreamWrapper");
	//#UC END# *4423FB5903D8476263570115_44312A6F0128_IMPL*
}

} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

