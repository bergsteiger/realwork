////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Common/ContextUtility.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::Common::ContextUtility
//
// Функции для анализа контекста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_COMMON_CONTEXTUTILITY_H__
#define __SHARED_CONTEXTSEARCH_COMMON_CONTEXTUTILITY_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/GCL/data/std_defs.h"

namespace ContextSearch {

// Функции для анализа контекста
class ContextUtility {
	SET_OBJECT_COUNTER (ContextUtility)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Список названий месяцев в родительном падеже
	static const std::string MONTHS_GEN [];

	// Список названий месяцев
	static const std::string MONTHS [];

public:
	// StrStrMap
	typedef std::map < std::string, std::string > StrStrMap;

	// Константы для дат
	static const short MIN_DATE; // минимальная дата
	static const short MAX_DATE; // максимальная дата

	// Счетчики
	struct MarkupCounters {
		// пробелы
		size_t space;
		// строгость
		size_t strong;
		// рамки
		size_t frame;
		MarkupCounters () : space(0), strong(0), frame(0) {
			//#UC START# *56D818E70165_DEF_INIT_CTOR*
			//#UC END# *56D818E70165_DEF_INIT_CTOR**cpp*
		}
	};

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возвратить первое слово и смещение на второе  в исходной строке
	static size_t get_first_word (std::string& out, const char* src);

	// счетчики разметки
	static void get_markup_counters (const std::string& in, MarkupCounters& out);

	// месяц как строка
	static const char* get_month (size_t num);

	// номер месяца
	static size_t get_month_num (const std::string& str);

	// получить количество слов во фразе
	static size_t get_words_count (const std::string& str);

	// проверка на наличие в строке кириллических символов
	static bool has_cyrillic (const std::string& str);

	// проверка на наличие в строке цифр
	static bool has_digit (const std::string& str);

	// проверка на буквоцифры
	static bool is_alnum (const std::string& str);

	// проверка на дату
	static bool is_date (const std::string& str);

	// проверка на дату
	static bool is_date (const GCL::StrVector& in);

	// проверка на дату
	static bool is_date (const std::string& d, const std::string& m, const std::string& y);

	// проверка на то, что строка состоит только из цифр
	static bool is_digit (const std::string& str);

	// сравнение дат
	static bool is_equal_date (const GCL::StrVector& x, const GCL::StrVector& y);

	// проверка строки на название месяца
	static bool is_month (const std::string& str);

	// проверка символа на валидность
	static bool is_valid_char (char ch);

	// замена лексем на их соответствие
	static void replace (std::string& out, const StrStrMap& in);

	// распил строки на отдельные слова с валидацией контекста
	static void split (GCL::StrVector& out, const std::string& str, bool is_ext);

private:
	// проверка на наличие значения в заданном диапазоне
	static bool in_range (short value, short first, short last);

	// проверка значения дня на валидность
	static bool is_day_valid (short day, short month);

	// проверка на специальный символ
	static bool is_special_char (char ch);

}; // class ContextUtility

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_COMMON_CONTEXTUTILITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

