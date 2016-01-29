////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CutToLeafCountFilter_i
//
// реализация фильтра усечения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i.h"

namespace GblAdapterLib {

CutToLeafCountFilter_i_factory::CutToLeafCountFilter_i_factory () {
}

void CutToLeafCountFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	CutToLeafCountFilterFactoryManager::register_factory (this, priority);
}

const char* CutToLeafCountFilter_i_factory::key () const {
	return "CutToLeafCountFilter_i";
}

CutToLeafCountFilter* CutToLeafCountFilter_i_factory::make (unsigned long leaf_count) {
	CutToLeafCountFilter_i_var ret = new CutToLeafCountFilter_i (leaf_count);
	return ret._retn ();
}

CutToLeafCountFilter* CutToLeafCountFilter_i_factory::make () {
	CutToLeafCountFilter_i_var ret = new CutToLeafCountFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

