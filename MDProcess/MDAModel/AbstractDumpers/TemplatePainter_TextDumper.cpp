////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplatePainter_TextDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplatePainter::TextDumper
//
// Дампер для работы со строками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

//#UC START# *47836F7C0343_CUSTOM_INCLUDES*
//#UC END# *47836F7C0343_CUSTOM_INCLUDES*

class TemplatePainter;
//#UC START# *47836F7C0343*
bool TemplatePainter::TextDumper::operator == (const AbstractDumperBase& c) const {
#if (defined(ZombieEnabled) && (ZombieEnabled == 1))
	GDS_ASSERT(!m_deleted);
#endif
	bool ret = false;
	const TextDumper* td = dynamic_cast<const TextDumper*>(&c);
	if (td) {
#if (defined(ZombieEnabled) && (ZombieEnabled == 1))
		GDS_ASSERT(!td->m_deleted);
#endif
		ret = (m_name == td->m_name);
	}
	return ret;
}
//#UC END# *47836F7C0343*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
TemplatePainter::TextDumper::TextDumper (const char* str)
//#UC START# *47836FA1021E_BASE_INIT*
: m_name (str)
#if (defined(ZombieEnabled) && (ZombieEnabled == 1))
, m_deleted (false)
#endif
//#UC END# *47836FA1021E_BASE_INIT*
{
	//#UC START# *47836FA1021E_BODY*
	//#UC END# *47836FA1021E_BODY*
}

TemplatePainter::TextDumper::~TextDumper () {
	//#UC START# *47836F7C0343_DESTR_BODY*
	//#UC END# *47836F7C0343_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает имя
const std::string TemplatePainter::TextDumper::get_name_str () const {
	//#UC START# *466554D9006D_47836F7C0343*
#if (defined(ZombieEnabled) && (ZombieEnabled == 1))
	GDS_ASSERT(!m_deleted);
#endif
	return m_name;
	//#UC END# *466554D9006D_47836F7C0343*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Base::NamedElement
// возвращает полное имя элемента
const std::string TemplatePainter::TextDumper::get_full_name () const {
	//#UC START# *4AF93E9E0166_47836F7C0343*
#if (defined(ZombieEnabled) && (ZombieEnabled == 1))
	GDS_ASSERT(!m_deleted);
#endif
	return m_name;
	//#UC END# *4AF93E9E0166_47836F7C0343*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

