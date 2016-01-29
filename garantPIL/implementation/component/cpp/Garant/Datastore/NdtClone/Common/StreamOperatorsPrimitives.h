#ifndef __PRIMITIVES_H_
#define __PRIMITIVES_H_

#include <string>
#include <vector>
#include <memory>
#include "boost/cstdint.hpp"
#include "tao/corba.h"
#include "shared/Core/mng/Aptr.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/RecoverableIndex.h"

namespace NdtClone {

template<typename T>
inline void operator << (Stream& stream, const T& value) {

#if defined(_DEBUG)
	float x = static_cast<float> (value); // prevents instance of non-numeric T at compile time
	T tmp = static_cast<T> (x);           // ensure two-way static_cast between T and float
#endif

	long res = stream.Write (&value, sizeof (T));
	if (res != sizeof (T)) throw Error ();
}

template<typename T>
inline void operator >> (Stream& stream, T& value) {

#if defined(_DEBUG)
	float x = static_cast<float> (value); // prevents instance of non-numeric T at compile time
	T tmp = static_cast<T> (x);           // ensure two-way static_cast between T and float
#endif

	long res = stream.Read (&value, sizeof (T));
	if (res != sizeof (T)) throw Error ();
}

template<typename T>
inline void operator << (Stream& stream, const std::vector<T>& value) {
	GDS_ASSERT (value.size () <= std::numeric_limits <boost::uint32_t>::max ());
#if defined(_DEBUG)
	T check (0);
	float x = static_cast<float> (check); // prevents instance of non-numeric T at compile time
	check = static_cast<T> (x);           // ensure two-way static_cast between T and float
#endif

	boost::uint32_t size = value.size ();
	long res = stream.Write (&size, sizeof (size));
	if (res != sizeof(size)) throw Error ();

	for (size_t i = 0; i < size; ++i) {
		res = stream.Write (&value[i], sizeof (T));
		if (res != sizeof (T)) throw Error ();
	}
}

template<typename T>
inline void operator >> (Stream& stream, std::vector<T>& value) {

#if defined(_DEBUG)
	T check (0);
	float x = static_cast<float> (check); // prevents instance of non-numeric T at compile time
	check = static_cast<T> (x);           // ensure two-way static_cast between T and float
#endif

	boost::uint32_t size = 0;
	long res = stream.Read (&size, sizeof (size));
	if (res != sizeof(size)) throw Error ();
	value.resize (size);

	for (size_t i = 0; i < size; ++i) {
		res = stream.Read (&value[i], sizeof (T));
		if (res != sizeof (T)) throw Error ();
	}
}

inline void operator << (Stream& stream, const std::string& value) {
	GDS_ASSERT (value.size () <= std::numeric_limits <boost::uint32_t>::max ());
	boost::uint32_t size = static_cast<boost::uint32_t> (value.size ());
	long res = stream.Write (&size, sizeof (size));
	if (res != sizeof(size)) throw Error ();
	res = stream.Write (value.c_str (), size);
	if (res != static_cast<long> (size)) throw Error ();
}

inline void operator >> (Stream& stream, std::string& value) {
	boost::uint32_t size = 0;
	long res = stream.Read (&size, sizeof (size));
	if (res != sizeof(size)) throw Error ();
	Core::Aptr<char, Core::ArrayDeleteDestructor<char> > buff (new char[size]);
	res = stream.Read (buff.ptr (), size);
	if (res != static_cast<long> (size)) throw Error ();
	value.clear ();
	value.append (buff.ptr (), size);
}

} // namespace

#endif //__PRIMITIVES_H_

