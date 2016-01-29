////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/Dumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::Dumper
//
// Дампер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DUMPER_H__
#define __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DUMPER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4ED6475702A1_CUSTOM_INCLUDES*
#include "shared/ContextSearch/Manage/Manage.h"

#include <iterator>
#include <fstream>
//#UC END# *4ED6475702A1_CUSTOM_INCLUDES*

namespace SearchAdapterLib {
namespace DBComm_i {

// Дампер
class Dumper {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

//#UC START# *4ED6475702A1*
public:
	Dumper (const char* file_name);
	virtual ~Dumper ();

public:
	void out (const ContextSearch::Relevancy::Fragments& data);
	void out (const ContextSearch::DBComm::StrPairVector& data);
	void out (const ContextSearch::DBComm::Synonyms& data);
	void out (const ContextSearch::Defs::InvisibleBlocks& map);
	void out (const ContextSearch::Defs::InvisibleRel& map);
	void out (const Morpho::Def::StrStrMap& map);
	void out (const DBCore::PSDTemplates& data);
	void out (const DBCore::DocVector& data);
	void out (const DBCore::RelTuneData& data);
	void out (const GCL::StrVector& vect, bool is_format);
	void out (const GCL::StrVector& data);

private:
	std::ofstream ofs;
//#UC END# *4ED6475702A1*
}; // class Dumper

} // namespace DBComm_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

