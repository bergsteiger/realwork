#include "shared/jsoncpp/json_helper.h"

namespace Json {

UInt remove_element_from_array (Value& array, UInt index) {
	if (array.type () != arrayValue) {
		return array.size ();
	}
	const UInt array_size = array.size ();
	if (index >= array_size) {
		return array_size;
	}

	for (UInt i = index; i < (array.size () - 1); ++i) {
		array[i].swap (array[i + 1]);
	}
	array.resize (array.size () - 1);

	return array.size ();
}

}
