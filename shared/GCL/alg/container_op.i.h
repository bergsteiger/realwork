////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/alg/container_op.i.h"
// ��������� inline ������ ���������� C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::container_op
// ���� inline ���������� ���������� ������ container_op
//
// ���������� ����������� ���������� ��� ������������: normolize; merge, difference, intersect ��
// ����� ���������� (���� ���� ��� std::set)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *450130B00213_CUSTOM_INCLUDES*
#include <functional>
#include <ace/OS_String.h>
//#UC END# *450130B00213_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *450130B00213*
// template classes for octet sequence comparision operators
// for use in STL containers such as std::map
template<class T> 
bool OctetSeqLess<T>::operator() (T a, T b) const {
	if(a->length() < b->length()) {
		return true;
	}
	else if(a->length() > b->length()) {
		return false;
	}
	return (ACE_OS_String::memcmp(a->get_buffer(), b->get_buffer(),	a->length()) < 0);
}

template<class T> 
bool OctetSeqGreater<T>::operator() (T a, T b) const {
	if(a->length() < b->length()) {
		return false;
	}
	else if(a->length() > b->length()) {
		return true;
	}
	return (ACE_OS_String::memcmp(a->get_buffer(), b->get_buffer(),	a->length()) > 0);
}

// ����������� ������ target ������������ ������� base
template <class _C>
_C& normalize (const _C& base, _C& target, bool with_back) {
	if (target.size() && base.size()) {
		_C::const_iterator it = base.begin();
		for (; it != base.end(); it++) {
			if (target.size() && (*it) == (*target.begin())) {
				target.erase (target.begin());
			} else {
				break;
			}
		}

		if ( target.size() == 1 && base.back() == target.back() ) {
			it--;
			target.insert (target.begin(), *it );
		}
		if ( target.size() == 0 && with_back) {
			target.push_back ( base.back() );
		}
	}

	return target;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// for std::set

template <class _Key, class _Compare, class _Allocator>
std::set<_Key, _Compare, _Allocator>& merge (
	std::set<_Key, _Compare, _Allocator>& cont
	, const std::set<_Key, _Compare, _Allocator>& operand
) {
	for (std::set<_Key, _Compare, _Allocator>::iterator it = operand.begin(); it != operand.end(); it++) {
		if (cont.find(*it) == cont.end()) {
			cont.insert(*it);
		}
	}
	return cont;
}
//#UC END# *450130B00213*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

