#ifndef __SHARED_GCL_ALG_COUNTER_OPERATIONS_H__
#define __SHARED_GCL_ALG_COUNTER_OPERATIONS_H__

namespace GCL {

// получаем на вход плоское дерево и вызываем на нем заданную операцию,
// обходя плоское дерево как бинарное
// см. effective programming with componenets lecture 6
template<typename T, class ForwardIterator, class Operation>
T add_to_counter (ForwardIterator from, ForwardIterator to, Operation op, const T& zero, T carry)  {
	while (from != to) {
		if (*from == zero) {
			*from = carry;
			return zero;
		}

		carry = op (*from, carry);
		*from = zero;
		++from;
	}

	return carry;
}

template<typename T, class ForwardIterator, class Operation>
T reduce_counter (ForwardIterator from, ForwardIterator to, Operation op, const T& zero)  {
	while ((from != to) && (*from == zero)) {
		++from;
	}

	if (from == to) {
		return zero;
	}

	T result = *from;
	while (++from != to) {
		if (*from != zero) {
			result = op (*from, result);
		}
	}

	return result;
}

template<typename T, class Op>
class binary_counter {
public:
	binary_counter (Op op, const T& zero) : m_op (op), m_zero (zero) {
	}

	void add (T value) {
		value = add_to_counter (m_counter.begin (), m_counter.end (), m_op, m_zero, value);
		if (value != m_zero) {
			m_counter.push_back (value);
		}
	}

	T reduce () const {
		return reduce_counter (m_counter.begin (), m_counter.end (), m_op, m_zero);
	}

private:
	std::vector<T> m_counter;
	Op m_op;
	const T m_zero;
};

}

#endif
