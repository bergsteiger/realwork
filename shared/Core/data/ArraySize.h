#pragma once

template<class T, size_t N>
size_t array_size (const T (&arr) [N]) {
	return N;
}