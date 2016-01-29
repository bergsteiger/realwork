////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::KPageToolLib::ActionsImpl::SourceFileHelper
//
// Для чтения и записи данных в файл обмена
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"
// by <<uses>> dependencies
#include <fstream>
#include <fstream>
#include "MDProcess/KPageToolLib/Settings.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// читает данные как вектор
int SourceFileHelper::read_as_char_vector (CharVector& str) {
	//#UC START# *4BF3D42002EB*
	std::string file = Settings::get_file ();
	std::ifstream in_file (file.c_str (), std::ios::in|std::ios::binary);
	if (!in_file) {
		LOG_E (("Can't open file: %s", file.c_str ()));
		return 1;
	}

	std::copy (
		std::istreambuf_iterator<char>(in_file)
		, std::istreambuf_iterator<char>()
		, std::back_inserter(str)
	);
	return 0;
	//#UC END# *4BF3D42002EB*
}

// читает из файла из настроек, в случае ошибки возвращает не ноль
int SourceFileHelper::read_as_string (std::string& str) {
	//#UC START# *4BF3C2D301ED*
	std::string file = Settings::get_file ();
	std::ifstream in_file (file.c_str (), std::ios::in|std::ios::binary);
	if (!in_file) {
		LOG_E (("Can't open file: %s", file.c_str ()));
		return 1;
	}

	std::copy (
		std::istreambuf_iterator<char>(in_file)
		, std::istreambuf_iterator<char>()
		, std::back_inserter(str)
	);
	return 0;
	//#UC END# *4BF3C2D301ED*
}

// пишет str в файл из настроек, в случае ошибки возвращает не ноль.
int SourceFileHelper::write (const char* str) {
	//#UC START# *4BF3C1AA00D7*
	std::string file = Settings::get_file ();
	std::ofstream out (file.c_str ());
	if (!out) {
		LOG_E (("Can't create file: %s", file.c_str ()));
		return 1;
	}
	out << str;
	return 0;
	//#UC END# *4BF3C1AA00D7*
}

} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

