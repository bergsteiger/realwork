////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/CycleChecker.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::CycleChecker
//
// позволяет выявлять рекурсивные вызовы - может быть полезен для различного рода расчетов путей и
// т.д.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_ALG_CYCLECHECKER_H__
#define __SHARED_GCL_ALG_CYCLECHECKER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4501338B00FA_USER_INCLUDES*
#include <algorithm>
#include <vector>
//#UC END# *4501338B00FA_USER_INCLUDES*

namespace GCL {

//#UC START# *4501338B00FA_USER_DEFINITION*
template <class _IterationId>
class CycleChecker {
public:
	class InvalidIterationSequence : public Core::Exception {
		virtual const char* what () const throw () {
			return "InvalidIterationSequence (pop stack sequens is differ then push stack sequence)";
		}

		virtual const char* uid () const /*throw ()*/ {
			return "GCL::CycleChecker::InvalidIterationSequence";
		}
	};

	class Iteration {
	public:
		Iteration (CycleChecker& cc, _IterationId id) : m_cc (cc), m_id(id) {
			m_is_cycled = !m_cc.start_iteration(m_id);
		}

		~Iteration () {
			if (!m_is_cycled) {
				m_cc.end_iteration(m_id);
			}
		}

		bool is_cycled () {
			return m_is_cycled;
		}

	private:
		CycleChecker& m_cc;
		_IterationId m_id;
		bool m_is_cycled;
	};

protected:
	friend Iteration;
	bool start_iteration (_IterationId id) {
		if (std::find(m_iterations.begin(), m_iterations.end(), id) != m_iterations.end()) {
		//if (m_iterations.find(id) != m_iteration.end()) {
			return false;
		} else {
			m_iterations.push_back(id);
			return true;
		}
	}

	void end_iteration (_IterationId id) /*throw (InvalidIterationSequence)*/ {
		if (id != m_iterations.back()) {
		//if (m_iterations.find(id) != m_iterations.back()) {
			throw InvalidIterationSequence();
		}
		m_iterations.pop_back();
	}

private:
	std::vector<_IterationId> m_iterations;
};
//#UC END# *4501338B00FA_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_ALG_CYCLECHECKER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
