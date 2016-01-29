////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/DebugInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::RelevancyCore::DebugInfo
//
// Вывод отладочной информации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/RelevancyCore/DebugInfo.h"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// типа фабрика
void* DebugInfo::make (bool val, Relevancy::IAlgorithm* algorithm) {
	//#UC START# *4C7C932F0300*
#ifdef _DEBUG
	if (val) {
		Core::Aptr <DebugInfo> ret = new DebugInfo (algorithm);
		return reinterpret_cast <void*> (ret._retn ());
	}
#endif
	return 0;
	//#UC END# *4C7C932F0300*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
DebugInfo::DebugInfo (Relevancy::IAlgorithm* algorithm)
//#UC START# *4C7C929203AA_BASE_INIT*
//#UC END# *4C7C929203AA_BASE_INIT*
{
	//#UC START# *4C7C929203AA_BODY*
	GDS_ASSERT (algorithm);

	m_algorithm = Relevancy::IAlgorithm::_duplicate (algorithm);
	m_algorithm->set_property (Relevancy::SHOW_INFO);
	//#UC END# *4C7C929203AA_BODY*
}

DebugInfo::~DebugInfo () {
	//#UC START# *4C7C92130200_DESTR_BODY*
	m_algorithm->clear_property (Relevancy::SHOW_INFO);
	//#UC END# *4C7C92130200_DESTR_BODY*
}


} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

