////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/OrphanStr.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::data::OrphanStr
//
// менеджер строки позволяющие при возврате результата указывать нужно ли освобождать буфер или
// нет, за счет чего можно экономит кол-во реаллокаций памяти
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_ORPHANSTR_H__
#define __SHARED_GCL_DATA_ORPHANSTR_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450135E90109_USER_INCLUDES*
//#UC END# *450135E90109_USER_INCLUDES*

namespace GCL {

//#UC START# *450135E90109_USER_DEFINITION*
struct OrphanStr {
	typedef unsigned OrphanType;
	const char* str;
	OrphanStr (char* s, OrphanType orphan) : str (s), m_orphan (orphan) {}
	OrphanStr (const char* s) : str (s), m_orphan (false) {}
	~OrphanStr () {
		if (m_orphan) {
			// это ошибка: мы не знаем как была выделена память, а как удалять типа знаем...
			// надо параметризовать класс DeleteDestructor'ом
			delete str;
		}
	}
	// There are not a real copy. It is to return OrphanStr from functions ONLY
	OrphanStr (const OrphanStr& os) {
		str = os.str;
		m_orphan = os.m_orphan;
		const_cast <OrphanStr&> (os).m_orphan = false;
	}
	OrphanStr& operator= (const OrphanStr& os); /* { GARANT_ISOCPP: is NOT used by linker
		if (m_orphan) {
			delete str;
		}
		str = os.str;
		m_orphan = os.m_orphan;
		const_cast <OrphanStr&> (os).m_orphan = false;
	} */
	// It is DANGEROUSLY to use because of temporary objects.
	/*inline operator const char* () const;*/
	inline char* get (OrphanType orphan) {
		m_orphan = orphan;
		return const_cast <char*> (str);
	}
	inline bool is_orphan () const {
		return m_orphan != 0;
	}
private:
	OrphanType m_orphan;
};
//#UC END# *450135E90109_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_DATA_ORPHANSTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
