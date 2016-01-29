#ifndef __SHARED_GCL_ALG_SET_OPERATIONS_H__
#define __SHARED_GCL_ALG_SET_OPERATIONS_H__

namespace GCL {

template<class FirstIt, class SecondIt>
bool has_intersection (FirstIt fbegin, FirstIt fend, SecondIt sbegin, SecondIt send) {
	while ((fbegin != fend) && (sbegin != send)) {
		if (*fbegin < *sbegin) {
			fbegin = std::lower_bound (fbegin, fend, *sbegin);
		} else if (*sbegin < *fbegin) {
			sbegin = std::lower_bound (sbegin, send, *fbegin);
		} else {
			break;
		}
	}

	return (fbegin != fend) && (sbegin != send);
}

// хелперы дл€ опреаций с множествами в stl, возвращают модифицированный первый элемент
// так же как операции с множествами в €дре (которые модифируют this)

template<class Container>
void set_union (Container& first, const Container& second) {
	if (first.empty ()) {
		first = second;
		return;
	}

	Container tmp (first.size () + second.size ());
	Container::iterator it = std::set_union (first.begin (), first.end (), second.begin (), second.end (), tmp.begin ());
	tmp.resize (it - tmp.begin ());
	std::swap (tmp, first);
}

template<class Container>
void set_difference (Container& first, const Container& second) {
	if (first.empty () || second.empty ()) {
		return;
	}

	Container tmp (first.size ());
	Container::iterator it = std::set_difference (first.begin (), first.end (), second.begin (), second.end (), tmp.begin ());
	tmp.resize (it - tmp.begin ());
	std::swap (tmp, first);
}

template<class Container>
void set_intersection (Container& first, const Container& second) {
	if (first.empty () || second.empty ()) {
		first.swap (Container ());
		return;
	}

	Container tmp (first.size ());
	Container::iterator it = std::set_intersection (first.begin (), first.end (), second.begin (), second.end (), tmp.begin ());
	tmp.resize (it - tmp.begin ());
	std::swap (tmp, first);
}

template<class Container, class Comparator>
void set_union (Container& first, const Container& second, Comparator comparator) {
	if (first.empty ()) {
		first = second;
		return;
	}

	Container tmp (first.size () + second.size ());
	Container::iterator it = std::set_union (
		first.begin (), first.end (), second.begin (), second.end (), tmp.begin (), comparator
	);
	tmp.resize (it - tmp.begin ());
	std::swap (tmp, first);
}

template<class Container, class Comparator>
void set_difference (Container& first, const Container& second, Comparator comparator) {
	if (first.empty () || second.empty ()) {
		return;
	}

	Container tmp (first.size ());
	Container::iterator it = std::set_difference (
		first.begin (), first.end (), second.begin (), second.end (), tmp.begin (), comparator
	);
	tmp.resize (it - tmp.begin ());
	std::swap (tmp, first);
}

template<class Container, class Comparator>
void set_intersection (Container& first, const Container& second, Comparator comparator) {
	if (first.empty () || second.empty ()) {
		first.swap (Container ());
		return;
	}

	Container tmp (first.size ());
	Container::iterator it = std::set_intersection (
		first.begin (), first.end (), second.begin (), second.end (), tmp.begin (), comparator
	);
	tmp.resize (it - tmp.begin ());
	std::swap (tmp, first);
}

// пересекаем множества, оставл€€ в первом только те элементы, которые есть во втором
template<class LeftIt, class RightIt, class Comparator>
LeftIt intersect (LeftIt l_from, LeftIt l_to, RightIt r_from, RightIt r_to, Comparator comp) {
	LeftIt result = l_from;
	while ((l_from != l_to) && (r_from != r_to)) {
		if (comp (*l_from, *r_from)) {
			++l_from;
			continue;
		}
		if (comp (*r_from, *l_from)) {
			++r_from;
			continue;
		}
		if (result != l_from) {
			*result = *l_from;
		}
		++result;
		++l_from;
		++r_from;
	}

	return result;
}

// оставл€ем в контейнере только уникальные элементы

template<class Container>
void unique_helper (Container& c) {
	std::sort (c.begin (), c.end ());
	c.erase (std::unique (c.begin (), c.end ()), c.end ());
}

template<class Container, class LessOperator, class EqualOperator>
void unique_helper (Container& c, LessOperator less, EqualOperator equal) {
	std::sort (c.begin (), c.end (), less);
	c.erase (std::unique (c.begin (), c.end (), equal), c.end ());
}

}

#endif
