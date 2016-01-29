#ifndef __SHARED_GCL_ALG_MOVETOFRONT_H__
#define __SHARED_GCL_ALG_MOVETOFRONT_H__

namespace GCL {

// сдвигает в начало последовательности элементы, удовлетворяющие условию
// возвращает итератор, указывающий на элемент, следующий за последним передвинутым
template<class ForwardIterator, class UnaryPredicate>
ForwardIterator move_to_front (ForwardIterator from, ForwardIterator to, UnaryPredicate pred)  {
	ForwardIterator place_to_insert = from;

	for (; from != to; ++from) {
		if (pred (*from)) {
			if (from != place_to_insert) {
				std::swap (*from, *place_to_insert);
			}
			++place_to_insert;
		}
	}

	return place_to_insert;
}

}

#endif
