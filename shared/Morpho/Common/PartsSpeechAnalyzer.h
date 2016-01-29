////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/Common/PartsSpeechAnalyzer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Common::PartsSpeechAnalyzer
//
// Анализатор частей речи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_COMMON_PARTSSPEECHANALYZER_H__
#define __SHARED_MORPHO_COMMON_PARTSSPEECHANALYZER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

//#UC START# *4D306C4201BA_CUSTOM_INCLUDES*
//#UC END# *4D306C4201BA_CUSTOM_INCLUDES*

namespace Morpho {

// Анализатор частей речи
class PartsSpeechAnalyzer {
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// установить рамочные связи между словами
	static void set_frames (const DBCore::PSDTemplates& in, std::string& req);

private:
	// позиции рамочной связи, соответствующей определенному шаблону
	static DBCore::ULongVector* get_positions (const DBCore::PSDTemplates& in, const std::string& req);

	// генерация частиречных представлений запроса
	static void get_templates (const std::string& req, DBCore::PSDTemplates& out);


//#UC START# *4D306C4201BA*
//#UC END# *4D306C4201BA*
}; // class PartsSpeechAnalyzer

} // namespace Morpho


#endif //__SHARED_MORPHO_COMMON_PARTSSPEECHANALYZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

