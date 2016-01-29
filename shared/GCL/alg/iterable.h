////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/iterable.h"
//
// реализация простейшей концепции iterable
// см. cppcon14 Artur O'Dwyer
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_ALG_ITERABLE_OP_H__
#define __SHARED_GCL_ALG_ITERABLE_OP_H__

#include "shared/Core/sys/std_inc.h"

namespace GCL {

template<class It>
class Iterable {
public:
	Iterable () {
	}

	Iterable (It begin, It end) : m_begin (begin), m_end (end) {
	}

	It begin () const {
		return m_begin;
	}

	It end () const {
		return m_end;
	}

private:
	It m_begin;
	It m_end;
};

template<class It>
inline Iterable<It> make_iterable (It begin, It end) {
	return Iterable<It> (begin, end);
}

template<class It>
inline Iterable<It> make_iterable (std::pair<It, It> range) {
	return Iterable<It> (range.first, range.second);
}

}

#endif
