////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::FileReader_i
//
// реализация чтения данных из заданного файла
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/LibHome.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i.h"
// by <<uses>> dependencies
#include <fstream>
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"

namespace UsersImport_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FileReader_i::FileReader_i (const std::string& source, UsersImport::DataParser* parser)
//#UC START# *481D6ED302D2_481D6F65009B_481D79380033_BASE_INIT*
//#UC END# *481D6ED302D2_481D6F65009B_481D79380033_BASE_INIT*
{
	//#UC START# *481D6ED302D2_481D6F65009B_481D79380033_BODY*
	this->read (source.c_str (), parser);
	//#UC END# *481D6ED302D2_481D6F65009B_481D79380033_BODY*
}

FileReader_i::FileReader_i (const std::string& source)
//#UC START# *481D6ED302D2_481D8BBE028C_481D79380033_BASE_INIT*
//#UC END# *481D6ED302D2_481D8BBE028C_481D79380033_BASE_INIT*
{
	//#UC START# *481D6ED302D2_481D8BBE028C_481D79380033_BODY*
	UsersImport::DataParser_var parser (UsersImport::DataParserFactory::make (0));
	this->read (source.c_str (), parser.in ());
	//#UC END# *481D6ED302D2_481D8BBE028C_481D79380033_BODY*
}

FileReader_i::~FileReader_i () {
	//#UC START# *481D79380033_DESTR_BODY*
	//#UC END# *481D79380033_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// прочитать данные из заданного фалй и передать их в разборщик
void FileReader_i::read (const char* source, UsersImport::DataParser* parser) {
	//#UC START# *481D90A7002D*
	std::ifstream data (source);
	if (!data) {
		throw BadSourceFile ();
	}
	std::string next_line;
	size_t string_number = 0;
	while (!data.eof ()) {
		std::getline (data, next_line);
		++string_number;

		if (next_line.empty ()) {
			LOG_W (("CSV String (%d): string is empty", string_number));
			continue;
		}

		try {
			parser->parse (next_line, string_number);
			LOG_I (("CSV String (%d) successfully processed", string_number));
		} catch (CantFindDelimiter&) {
			LOG_E (("CSV String (%d): can't find delimiter", string_number));
		} catch (CantFindName&) {
			LOG_E (("CSV String (%d): can't find name", string_number));
		} catch (ErasedUserNotExists&) {
			LOG_E (("CSV String (%d): can't find erased user", string_number));
		} catch (BadLoginValue&) {
			LOG_E (("CSV String (%d) skipped: incorrect login", string_number));
		} catch (BadNameValue&) {
			LOG_E (("CSV String (%d) skipped: incorrect name", string_number));
		} catch (BadPasswordValue&) {
			LOG_E (("CSV String (%d) skipped: incorrect password", string_number));
		} catch (GslUserManager::LicenceViolation&) {
			LOG_E (("CSV String (%d) skipped: license violation, application stopped", string_number));
			break;
		} catch (GCD::InvalidArgs&) {
			LOG_E (("CSV String (%d) skipped: invalid string, user not added", string_number));
		} catch (GslUserManager::LoginDuplicate&) {
			// обрабатывается уровнем ниже
		} catch (TimeStampSync::InvalidTimeStamp&) {
			LOG_D (("%s: InvalidTimeStamp", GDS_CURRENT_FUNCTION));
		}
	}
	//#UC END# *481D90A7002D*
}

} // namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

