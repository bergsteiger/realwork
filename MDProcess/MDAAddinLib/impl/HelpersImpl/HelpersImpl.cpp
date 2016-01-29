////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAAddinLib::HelpersImpl
//
// пакет реализации вспомогательных интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"


namespace HelpersImpl {

bool SortStereotypeByUse::operator () (const AbstractDumperBase::StereotypeID& first_param_, const AbstractDumperBase::StereotypeID& second_param_) const {
	//#UC START# *4907F21C0342_IMPL*
	if (use_map && !use_map->empty ()) {
		Helpers::StereotypeUseMap::const_iterator x_it = use_map->find (first_param_);
		Helpers::StereotypeUseMap::const_iterator y_it = use_map->find (second_param_);
		
		int x_used = x_it != use_map->end () ? x_it->second : 0;
		int y_used = y_it != use_map->end () ? y_it->second : 0;
		
		//сортируем по-использованию, если использование одинаковое - сортируем по алфавиту
		return x_used == y_used ? first_param_ < second_param_ : x_used > y_used;
	}
	
	return first_param_ < second_param_;
	//#UC END# *4907F21C0342_IMPL*
}


SortStereotypeByUse::SortStereotypeByUse (const Helpers::StereotypeUseMap& use_map_) : use_map(&use_map_) {
	//#UC START# *4907F21C0342_INIT_CTOR*
	//#UC END# *4907F21C0342_INIT_CTOR*
}


} //namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

