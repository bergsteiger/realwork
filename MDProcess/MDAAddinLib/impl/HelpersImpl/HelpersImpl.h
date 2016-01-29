////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAAddinLib::HelpersImpl
//
// пакет реализации вспомогательных интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"


namespace HelpersImpl {

// функтор для сортировки стереотипов по использованию
struct SortStereotypeByUse : public std::binary_function<AbstractDumperBase::StereotypeID, AbstractDumperBase::StereotypeID, bool> {
	bool operator () (const AbstractDumperBase::StereotypeID& first_param_, const AbstractDumperBase::StereotypeID& second_param_) const;

	SortStereotypeByUse (const Helpers::StereotypeUseMap& use_map_);

private:
	// мапа частоты использования стереотипов - по ней будет выполняться сортировка.
	const Helpers::StereotypeUseMap* use_map;
};

} //namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

