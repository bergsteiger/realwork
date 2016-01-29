////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> garant6x::UsersImportLib::UsersImport_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"


namespace UsersImport_i {


const char* CantFindDelimiter::uid () const /*throw ()*/ {
	return "1918F843-CDB0-4297-9A6C-2F2A9D46CB1F";
}

const char* CantFindDelimiter::what () const throw () {
	//#UC START# *481D95E402F0_WHAT_IMPL*
	return "CantFindDelimiter (в первой строке нет ни одного символа-разделителя)";
	//#UC END# *481D95E402F0_WHAT_IMPL*
}




const char* BadLoginValue::uid () const /*throw ()*/ {
	return "31152680-1180-4746-959D-8F9CCE5A34AC";
}

const char* BadLoginValue::what () const throw () {
	//#UC START# *481DA0D4005F_WHAT_IMPL*
	return "BadLoginValue (плохое значение для login-а пользователя)";
	//#UC END# *481DA0D4005F_WHAT_IMPL*
}




const char* BadNameValue::uid () const /*throw ()*/ {
	return "F9A41FAD-5786-418B-B11E-A79991095BAE";
}

const char* BadNameValue::what () const throw () {
	//#UC START# *481DA0F80096_WHAT_IMPL*
	return "BadNameValue (плохое значение имени пользователя)";
	//#UC END# *481DA0F80096_WHAT_IMPL*
}




const char* BadPasswordValue::uid () const /*throw ()*/ {
	return "9FFEAE59-C276-47F3-824A-A98C661F791D";
}

const char* BadPasswordValue::what () const throw () {
	//#UC START# *481DA134011E_WHAT_IMPL*
	return "BadPasswordValue (плохое значение пароля)";
	//#UC END# *481DA134011E_WHAT_IMPL*
}




const char* BadEmailValue::uid () const /*throw ()*/ {
	return "29B44345-520C-4B59-86AC-728E1DBE7D13";
}

const char* BadEmailValue::what () const throw () {
	//#UC START# *481DA1AD01A4_WHAT_IMPL*
	return "BadEmailValue (плохое значение email)";
	//#UC END# *481DA1AD01A4_WHAT_IMPL*
}




const char* BadConsultingValue::uid () const /*throw ()*/ {
	return "B5F87B25-E650-4378-86DD-C460224D9186";
}

const char* BadConsultingValue::what () const throw () {
	//#UC START# *481DA2300275_WHAT_IMPL*
	return "BadConsultingValue (плохое значение разрешения консалтинга)";
	//#UC END# *481DA2300275_WHAT_IMPL*
}




const char* BadPrivilegedValue::uid () const /*throw ()*/ {
	return "0D0FE0F8-654D-44E8-AC7F-4D4811BC5DCA";
}

const char* BadPrivilegedValue::what () const throw () {
	//#UC START# *481DAF1C033C_WHAT_IMPL*
	return "BadPrivilegedValue (плохое значение свойства привилегированности)";
	//#UC END# *481DAF1C033C_WHAT_IMPL*
}




const char* BadGroupValue::uid () const /*throw ()*/ {
	return "2BFF5C2A-9BBD-451C-B263-F94A3A7ED2B6";
}

const char* BadGroupValue::what () const throw () {
	//#UC START# *49EC586903BA_WHAT_IMPL*
	return "BadGroupValue (некорректное имя группы)";
	//#UC END# *49EC586903BA_WHAT_IMPL*
}




const char* CantFindUserManager::uid () const /*throw ()*/ {
	return "D8B78C71-AF81-477E-9D46-835037AFF4D0";
}

const char* CantFindUserManager::what () const throw () {
	//#UC START# *482032880109_WHAT_IMPL*
	return "CantFindUserManager (не смогли получить ссылку на соответствующую серверную компоненту)";
	//#UC END# *482032880109_WHAT_IMPL*
}




const char* BadSourceFile::uid () const /*throw ()*/ {
	return "2D824795-9007-4DA4-BAE3-80ADA3A65D0F";
}

const char* BadSourceFile::what () const throw () {
	//#UC START# *4821974A00EB_WHAT_IMPL*
	return "BadSourceFile (не смогли открыть файл с данными)";
	//#UC END# *4821974A00EB_WHAT_IMPL*
}




const char* AdminAlreadyLogged::uid () const /*throw ()*/ {
	return "265264AD-2A02-4124-8B7F-89B078D04F69";
}

const char* AdminAlreadyLogged::what () const throw () {
	//#UC START# *4821A09902BE_WHAT_IMPL*
	return "AdminAlreadyLogged (администратор уже залогирован на сервере)";
	//#UC END# *4821A09902BE_WHAT_IMPL*
}




const char* CantFindName::uid () const /*throw ()*/ {
	return "D48AB416-72F3-4229-BE7D-C0BCF9A7C7CE";
}

const char* CantFindName::what () const throw () {
	//#UC START# *4C2DA59E00F2_WHAT_IMPL*
	return "CantFindName (не заданы ФИО)";
	//#UC END# *4C2DA59E00F2_WHAT_IMPL*
}




const char* ErasedUserNotExists::uid () const /*throw ()*/ {
	return "E23E5110-6E11-4E66-B470-01B33C25D902";
}

const char* ErasedUserNotExists::what () const throw () {
	//#UC START# *4C3193D9029C_WHAT_IMPL*
	return "ErasedUserNotExists (нет удаляемого пользователя)";
	//#UC END# *4C3193D9029C_WHAT_IMPL*
}



} //namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

