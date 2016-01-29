////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/GDS/StackTracker.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::GDS::StackTracker
//
// класс помогающий определять глубину вхождения в стек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_GDS_STACKTRACKER_H__
#define __SHARED_CORE_GDS_STACKTRACKER_H__

#include "ace/ACE.h"
#include "shared/Core/mng/TypeSingleton.h"

//#UC START# *450E98E20232_USER_INCLUDES*
#include <map>
//#UC END# *450E98E20232_USER_INCLUDES*

namespace Core {
namespace GDS {

//#UC START# *450E98E20232_USER_DEFINITION*
class StackTraker {
public:
	typedef unsigned PointID;
	typedef std::map<PointID, unsigned> PiontMap;

	StackTraker ( PointID id ) : m_id(id) {
		(*PiontMapSingl::instance())[m_id]++;
	};

	~StackTraker () {
		(*PiontMapSingl::instance())[m_id]--;
	};

	unsigned deep () {
		return (*PiontMapSingl::instance())[m_id];
	};
private:
	typedef Core::TypeSingleton<PiontMap> PiontMapSingl;
	PointID m_id;
};

#ifdef _MSC_VER
class StackMfcTrace : public StackTraker {
public:
	StackMfcTrace  ( PointID id ) : StackTraker(id) {
		trace_buffer = 0;
	};

	char* trace () {
		if (trace_buffer) delete trace_buffer;

		unsigned d = deep();
		trace_buffer = new char [d+1];
		memset (trace_buffer, '\t', d);
		trace_buffer[d] = 0;

		return trace_buffer;
	};

protected:
	char* trace_buffer;
};
#endif
//#UC END# *450E98E20232_USER_DEFINITION*

} // namespace GDS
} // namespace Core


#endif //__SHARED_CORE_GDS_STACKTRACKER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
