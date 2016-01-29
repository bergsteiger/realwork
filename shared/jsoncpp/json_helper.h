#pragma once

#include "shared/jsoncpp/value.h"

namespace Json {
	// возвращает новый размер массива
	UInt remove_element_from_array (Value& array, UInt index);
}

