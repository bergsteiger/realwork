////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/IObject_tie.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::IObject_tie
// Файл реализации утилитного набора IObject_tie
//
// TIE-врапер для экспорта С++ интерфейсов в Дельфи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/mng/IObject_tie.h"

//#UC START# *450036090128_CUSTOM_INCLUDES*
//#UC END# *450036090128_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *450036090128*
const ComIID IObject_tie::s_com_iid = {0x00000000, 0x0000, 0x0000, {0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46}};

IObject_tie::IidRegistrator IObject_tie::s_iid_registrator;
//#UC END# *450036090128*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation


const char* IndexOutOfBounds_tie::uid () const /*throw ()*/ {
	return "4DDEBC97-3F88-4811-9423-8BDEE07A9C21";
}

const char* IndexOutOfBounds_tie::what () const throw () {
	//#UC START# *461500C9003E_WHAT_IMPL*
	return "IndexOutOfBounds_tie (Системное для Дельфи исключение о выходи за границы массива)";
	//#UC END# *461500C9003E_WHAT_IMPL*
}



} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

