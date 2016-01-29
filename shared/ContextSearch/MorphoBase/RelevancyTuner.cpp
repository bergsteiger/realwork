////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/RelevancyTuner.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::RelevancyTuner
//
// Класс для изменения значения релевантности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/RelevancyTuner.h"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// модификация вектора релевантных документов
void RelevancyTuner::execute (Search::RelevancyDocuments& result, const DBCore::RelTuneData& data) {
	//#UC START# *5385FA48031D*
	DBCore::RelTuneData::const_iterator it = data.begin (), it_end = data.end ();
	Search::RelevancyDocuments::iterator cur = result.begin (), end = result.end ();

	for (; cur != end && it != it_end;) {
		if (cur->doc_id > it->id) {
			++it;
		} else if (cur->doc_id < it->id) {
			++cur;
		} else {
			long value = cur->info.relevancy_value;
			value += it->rel;

			if (value < 0) {
				cur->info.relevancy_value = 0;
			} else {
				cur->info.relevancy_value = (Defs::RelevancyType) value;
			}

			++it;
			++cur;
		}
	}
	//#UC END# *5385FA48031D*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

