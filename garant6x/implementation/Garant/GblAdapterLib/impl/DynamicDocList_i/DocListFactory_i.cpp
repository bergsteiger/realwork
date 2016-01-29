////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DocListFactory_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i.h"
// by <<uses>> dependencies
#include <fstream>
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

//#UC START# *4D95C9DD0174_CUSTOM_INCLUDES*
#include <boost/regex.hpp>
#include <boost/lexical_cast.hpp>
//#UC END# *4D95C9DD0174_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4D95C9DD0174*
void DocListFactory_i::create_docs_container (std::ifstream& data, GblPilotDef::DocPointContainer& docs) const {
	unsigned line_num = 0;
	std::string next_line;
	boost::regex expression ("^(\\d+)($|\\s|\\.(\\d+)($|\\s))");
	boost::smatch what; 
	GblPilotDef::DocPoint point;
	while (!data.eof ()) {
		std::getline (data, next_line);
		++line_num;

		if (next_line.empty ()) {
			LOG_W (("%s: empty line (line %d)", GDS_CURRENT_FUNCTION, line_num));
			continue;
		}
		if (boost::regex_search (next_line, what, expression)) {
			CORBA::ULong doc = 0;
			CORBA::ULong sub = 0;
			try {
				doc = boost::lexical_cast<CORBA::ULong> (what[1]);
				sub = boost::lexical_cast<CORBA::ULong> (what[3]);
			} catch (boost::bad_lexical_cast&) {
				GDS_ASSERT (doc);
				if (!doc) {
					LOG_E (("%s: error in string %s (line %d)", GDS_CURRENT_FUNCTION, next_line, line_num));
					throw InvalidType ();
				}
			}
			point.doc = doc;
			point.sub = sub;
			docs.length (docs.length () + 1);
			docs[docs.length () - 1] = point;
		} else {
			LOG_E (("%s: bad string %s (line %d)", GDS_CURRENT_FUNCTION, next_line.c_str (), line_num));
			throw InvalidType ();
		}
	}
}
//#UC END# *4D95C9DD0174*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocListFactory_i::DocListFactory_i ()
//#UC START# *4D95C6D200AD_4D95C73000CF_4D95C9DD0174_BASE_INIT*
//#UC END# *4D95C6D200AD_4D95C73000CF_4D95C9DD0174_BASE_INIT*
{
	//#UC START# *4D95C6D200AD_4D95C73000CF_4D95C9DD0174_BODY*
	//#UC END# *4D95C6D200AD_4D95C73000CF_4D95C9DD0174_BODY*
}

DocListFactory_i::~DocListFactory_i () {
	//#UC START# *4D95C9DD0174_DESTR_BODY*
	//#UC END# *4D95C9DD0174_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocListFactory
// построить список по данным из файла file_name.
// inner_numbers - флаг указывающий какие номера документов используются (если inner_numbers=true -
// внутренние)
// 
// Формат файла (К195757811):
// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
// ...
// 
// Исключения:
// AccessDenied - не смогли прочитать данные из файла
// InvalidType - в файле некорректные данные
DynList* DocListFactory_i::make_list (
	const char* file_name
	, bool inner_numbers
) const /*throw (
	AccessDenied
	, InvalidType
)*/ {
	//#UC START# *4D95C74A035E_4D95C9DD0174*
	std::ifstream data (file_name);
	if (!data) {
		throw AccessDenied ();
	}
	GblPilotDef::DocPointContainer docs;
	this->create_docs_container (data, docs);

	if (docs.length ()) {
		if (inner_numbers) {
			for (size_t i = 0; i < docs.length (); ++i) {
				docs[i].doc += GblPilotDef::GEMMOROI_IZ_ZA_100000;
			}
		}

		try {
			GblDocList::DocListTree_var server_doclist_tree = 
				ApplicationHelper::instance ()->get_cached_function_manager ()->get_list (docs);
			return DynListFactory::make (server_doclist_tree.in ());			
		} catch (CORBA::Exception&) {
			LOG_E (("%s: can't create list from data file %s", GDS_CURRENT_FUNCTION, file_name));
		}
	} else {
		LOG_E (("%s: empty file %s", GDS_CURRENT_FUNCTION, file_name));
	}

	throw InvalidType ();
	//#UC END# *4D95C74A035E_4D95C9DD0174*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

