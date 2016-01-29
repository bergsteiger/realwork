////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/RelevancyTuner.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::RelevancyTuner
//
// Класс для изменения значения релевантности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_RELEVANCYTUNER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_RELEVANCYTUNER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/DB/DBCore/DBCore.h"

namespace ContextSearch {

// Класс для изменения значения релевантности
class RelevancyTuner {
	SET_OBJECT_COUNTER (RelevancyTuner)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// модификация вектора релевантных документов
	static void execute (Search::RelevancyDocuments& result, const DBCore::RelTuneData& data);

}; // class RelevancyTuner

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_RELEVANCYTUNER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

