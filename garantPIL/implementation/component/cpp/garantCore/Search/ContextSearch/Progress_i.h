////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/Progress_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::Progress_i
//
// Прогресс-индикатор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CONTEXTSEARCH_PROGRESS_I_H__
#define __GARANTCORE_SEARCH_CONTEXTSEARCH_PROGRESS_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/Base.h"

//#UC START# *5640BC81017E_CUSTOM_INCLUDES*
//#UC END# *5640BC81017E_CUSTOM_INCLUDES*

namespace Search {

// Прогресс-индикатор
class Progress_i;
typedef Core::Var<Progress_i> Progress_i_var;
typedef Core::Var<const Progress_i> Progress_i_cvar;

class Progress_i :
	virtual public DBCore::IProgress
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Progress_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit Progress_i (Base* base);

public:
	~Progress_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Base* m_base;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DBCore::IProgress
	// проверка, остановлен ли процесс пользователем
	bool canceled_by_user ();

	// implemented method from DBCore::IProgress
	// инициализация
	void init (size_t div, size_t pos);

	// implemented method from DBCore::IProgress
	// пауза
	void pause (bool pause);

	// implemented method from DBCore::IProgress
	// set
	void plus ();

	// implemented method from DBCore::IProgress
	// позиционирование
	void set (size_t value);

	// implemented method from DBCore::IProgress
	// установить максимальное значение
	void set_border (size_t value);

//#UC START# *5640BC81017E*
private:
	int m_canceled;

	size_t m_max_val;
	size_t m_div;
	size_t m_plus;
	size_t m_saved_div;
	size_t m_offset;
	size_t m_prev_value;
//#UC END# *5640BC81017E*
}; // class Progress_i

} // namespace Search


#endif //__GARANTCORE_SEARCH_CONTEXTSEARCH_PROGRESS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

