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
private:
	typedef bool OrphanType;
	OrphanType m_orphan;
	ACE_UINT16 m_size;
	const char* m_str;

public:
	OrphanStr (char* s, OrphanType orphan) : m_str (s), m_orphan (orphan), m_size (0) {}
	OrphanStr (const char* s) : m_str (s), m_orphan (false), m_size (0) {}
	OrphanStr (const char* s, size_t len) : m_str (s), m_orphan (false) {
		GDS_ASSERT (len <= std::numeric_limits<ACE_UINT16>::max ());
		m_size = static_cast<ACE_UINT16> (len);
	}

	~OrphanStr () {
		if (m_orphan) {
			// это ошибка: мы не знаем как была выделена память, а как удалять типа знаем...
			// надо параметризовать класс DeleteDestructor'ом
			delete m_str;
		}
	}

	// There are not a real copy. It is to return OrphanStr from functions ONLY
	OrphanStr (const OrphanStr& os) {
		m_str = os.m_str;
		m_orphan = os.m_orphan;
		m_size = os.m_size;
		const_cast <OrphanStr&> (os).m_orphan = false;
	}

	OrphanStr& operator= (const OrphanStr& os); /* { GARANT_ISOCPP: is NOT used by linker
		if (m_orphan) {
			delete m_str;
		}
		m_str = os.m_str;
		m_orphan = os.m_orphan;
		const_cast <OrphanStr&> (os).m_orphan = false;
	} */

	char* release () {
		GDS_ASSERT (m_orphan == true);
		m_orphan = false;
		return const_cast <char*> (m_str);
	}

	bool is_orphan () const {
		return m_orphan;
	}

	const char* data () const {
		return m_str;
	}

	size_t size () const {
		return m_size ? m_size : (m_str ? ACE_OS::strlen (m_str) : 0);
	}
};
//#UC END# *450135E90109_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_DATA_ORPHANSTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
