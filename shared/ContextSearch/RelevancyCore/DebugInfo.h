////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/DebugInfo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::RelevancyCore::DebugInfo
//
// Вывод отладочной информации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCYCORE_DEBUGINFO_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCYCORE_DEBUGINFO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

namespace ContextSearch {

// Вывод отладочной информации
class DebugInfo {
	SET_OBJECT_COUNTER (DebugInfo)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// типа фабрика
	static void* make (bool val, Relevancy::IAlgorithm* algorithm);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор
	explicit DebugInfo (Relevancy::IAlgorithm* algorithm);

public:
	~DebugInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Relevancy::IAlgorithm_var m_algorithm;
}; // class DebugInfo

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCYCORE_DEBUGINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

