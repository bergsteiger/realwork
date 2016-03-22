////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/Progress_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::Progress_i
//
// Прогресс-индикатор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/ContextSearch/Progress_i.h"

//#UC START# *5640BC81017E_CUSTOM_INCLUDES*
//#UC END# *5640BC81017E_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *5640BC81017E*
//#UC END# *5640BC81017E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Progress_i::Progress_i (Base* base)
//#UC START# *5640C45200F6_BASE_INIT*
	: m_base (base)
	, m_canceled (0)
	, m_max_val (100)
	, m_div (1)
	, m_plus (0)
	, m_offset (0)
	, m_prev_value (0)
//#UC END# *5640C45200F6_BASE_INIT*
{
	//#UC START# *5640C45200F6_BODY*
	try {
		m_base->InitProgress (m_max_val, &m_canceled);
	} catch (...) {
		LOG_E ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *5640C45200F6_BODY*
}

Progress_i::~Progress_i () {
	//#UC START# *5640BC81017E_DESTR_BODY*
	try {
		m_base->DoneProgress ();
	} catch (...) {
		LOG_E ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *5640BC81017E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DBCore::IProgress
// проверка, остановлен ли процесс пользователем
bool Progress_i::canceled_by_user () {
	//#UC START# *4CA4B7600042_5640BC81017E*
	return m_canceled != 0;
	//#UC END# *4CA4B7600042_5640BC81017E*
}

// implemented method from DBCore::IProgress
// инициализация
void Progress_i::init (size_t div, size_t pos) {
	//#UC START# *4CA4B721027B_5640BC81017E*
	m_div = div;
	m_plus = (size_t) (double (m_max_val * pos) / double (m_div));
	//#UC END# *4CA4B721027B_5640BC81017E*
}

// implemented method from DBCore::IProgress
// пауза
void Progress_i::pause (bool pause) {
	//#UC START# *4CA4B7B5014B_5640BC81017E*
	if (pause) {
		m_saved_div = m_div;
		m_div = 0;
	} else {
		m_div = m_saved_div;
	}
	//#UC END# *4CA4B7B5014B_5640BC81017E*
}

// implemented method from DBCore::IProgress
// set
void Progress_i::plus () {
	//#UC START# *527D092B0153_5640BC81017E*
	m_offset += m_max_val;
	m_prev_value = 0;
	//#UC END# *527D092B0153_5640BC81017E*
}

// implemented method from DBCore::IProgress
// позиционирование
void Progress_i::set (size_t value) {
	//#UC START# *4CA4B7D70118_5640BC81017E*
	if (m_div) {
		long cur = (long) (m_offset + m_plus + (long)((value * m_max_val) / (100. * m_div)));

		try {
			if (cur != m_prev_value) {
				m_base->ShowCheckedProgress (cur);
			}
		} catch (...) {
			LOG_E ((GDS_CURRENT_FUNCTION));
		}

		m_prev_value = cur;
	}
	//#UC END# *4CA4B7D70118_5640BC81017E*
}

// implemented method from DBCore::IProgress
// установить максимальное значение
void Progress_i::set_border (size_t value) {
	//#UC START# *527D09030329_5640BC81017E*
	m_max_val = value;
	//#UC END# *527D09030329_5640BC81017E*
}
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

