////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/RelevancyCore_DebugInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::RelevancyCore::RelevancyCore::DebugInfo
//
// Класс для вывода данных на консоль (для отладочных целей)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyCore.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "boost/bind.hpp"

namespace ContextSearch {
class RelevancyCore;
//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// печать вектора фрагментов
void RelevancyCore::DebugInfo::print (const Relevancy::Fragments& data) {
	//#UC START# *4B4DE1820301*
	std::cout << "\nfragments:\n";

	for (Relevancy::Fragments::const_iterator it = data.begin (); it != data.end () ; ++it) {
		std::cout << "r:" << it->info.relevancy_value << "  p:" << it->info.position << "  { ";
		std::for_each (it->data.begin (), it->data.end (), boost::bind (&print_position, _1));
		std::cout << "}\n";
	}

	std::cout << std::endl;
	//#UC END# *4B4DE1820301*
}

// печать вектора перестановок
void RelevancyCore::DebugInfo::print (const Chains& data, const char* text) {
	//#UC START# *4B4DE21002DF*
	if (text) {
		std::cout << std::endl << text << std::endl;
	}

	std::for_each (data.begin (), data.end (), boost::bind (&print_positions, _1));
	std::cout << std::endl;

	if (text) {
		std::cout << text << " : ";
	}

	std::cout << " size: " << data.size () << std::endl;
	//#UC END# *4B4DE21002DF*
}

// печать позиции
void RelevancyCore::DebugInfo::print_position (unsigned long val) {
	//#UC START# *4CC5955401C3*
	std::cout << (val & POS_TEXT);

	switch (val & POS_FLAGS) {
		case POS_HEADER:
			std::cout << "_" << val << "(h)";
			break;
		case POS_INVISIBLE:
			std::cout << "_" << val << "(i)";
			break;
		case POS_INVISIBLE_BLOCK:
			std::cout << "_" << val << "(ib)";
			break;
	}

	std::cout << " ";
	//#UC END# *4CC5955401C3*
}

// печать вектора с позициями
void RelevancyCore::DebugInfo::print_positions (const Relevancy::Positions& data) {
	//#UC START# *4B4DE1B90314*
	std::for_each (data.begin (), data.end (), boost::bind (&print_position, _1));
	std::cout << std::endl;
	//#UC END# *4B4DE1B90314*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

