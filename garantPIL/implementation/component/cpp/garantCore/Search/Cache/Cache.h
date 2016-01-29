////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Cache/Cache.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Cache::Cache
//
// Кэш
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CACHE_CACHE_H__
#define __GARANTCORE_SEARCH_CACHE_CACHE_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <vector>
#include "ace/Singleton.h"
#include "shared/GCL/data/std_defs.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"

//#UC START# *50AE53480198_CUSTOM_INCLUDES*
#include "shared/DB/DBCore/DBCore.h"
//#UC END# *50AE53480198_CUSTOM_INCLUDES*

namespace Search {

// Кэш
class Cache {

	// singleton declaration
	typedef ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static Cache* instance () {
		return Singleton::instance();
	}

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// Типы
	typedef std::map < std::string, GCL::StrVector > TypesMap;

	// Вектор целых чисел
	typedef std::vector < long > LongVector;

private:
	// Информер
	struct InformerNode {
		// ключ
		std::string key;
		//#UC START# *53F0C96C03BB*
		DBCore::RelTuneData data;

		bool operator < (const InformerNode& val) const {
			if (key.size () == val.key.size ()) {
				return key [0] < val.key [0];
			}
			return key.size () > val.key.size ();
		}

		bool operator == (const InformerNode& val) const {
			return key == val.key;
		}
		//#UC END# *53F0C96C03BB*
	};

	// Информеры
	typedef std::vector < InformerNode > Informers;

	// Сортировочные атрибуты
	struct SortAttr {
		// символ
		char ch;
		// позиция
		size_t i;
		// длина
		size_t len;
		//#UC START# *5450DDDB0250*
		bool operator < (const SortAttr& val) const {
			if (len == val.len) {
				return ch < val.ch;
			}
			return len > val.len;
		}
		//#UC END# *5450DDDB0250*
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Cache ();

	~Cache ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// "плохие" документы
	const LongVector& get_bad_docs ();

	// расширения запроса для поиска в заголовках
	const GCL::StrVector& get_ext_request (SearchBase* base);

	// очистить
	void reset ();

private:
	// добавить информер
	void add (const std::string& in, Informers& data);

	// чтение из Aux
	char* load_aux (SearchBase* base, const void* key, long& size);

	// загрузка типов документа
	void load_doc_types (SearchBase* base);

	// загрузка информеров
	void load_informers (SearchBase* base);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	LongVector m_bad_docs;

	GCL::StrVector m_ext_request;

	Informers m_informers;

	Core::Mutex m_mutex;

	TypesMap m_types;

//#UC START# *50AE53480198*
public:
	DBCore::RelTuneData* get_informers (SearchBase* base, const std::string& in);

	void get_type_data (SearchBase* base, const std::string& in, std::vector <unsigned long>& out);
	void get_code_data (SearchBase* base, const std::string& in, std::vector <unsigned long>& out);
//#UC END# *50AE53480198*
}; // class Cache

} // namespace Search


#endif //__GARANTCORE_SEARCH_CACHE_CACHE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

