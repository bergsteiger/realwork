////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/PrimitiveContainers/MapsSmalTest.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> TestModel::BasicTests::PrimitiveContainers::MapsSmalTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_MAPSSMALTEST_H__
#define __TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_MAPSSMALTEST_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <hash_map>
#include "shared/Core/data/unsorted_containers.h"

namespace BasicTests {

struct MultiAllocAndComp {
	bool operator () (const char* x, const char* y) const;

	bool operator () (const Core::Box<const char>& x, const Core::Box<const char>& y) const;

	bool operator () (const char** const x, const char** const y) const;

};

struct StringHash {
	size_t operator () (const char* x) const;

};

struct LongLongAllocator {
};

struct StringComparator {
	bool operator () (const Core::Box<char>& x, const Core::Box<char>& y) const;

	bool operator () (const char* x, const char* y) const;

};

struct StringComplntegerAlloc {
	bool operator () (char** const x, char** const y) const;

};

typedef boost::unordered_map <const char**
	, const bool*
	, Core::hash<const char**>
	, MultiAllocAndComp
	, MultiAllocAndComp> ConstLnkStringToConstLnkBoolUnsortedMap;

typedef std::map < char*, ACE_INT64, StringComparator, LongLongAllocator > StringAgrToLongLongAgrMap;

typedef std::map < Core::Box<char>, Core::Box<long>, StringComparator > StringRefToLongRefMap;

typedef std::map < char**, int*, StringComplntegerAlloc, StringComplntegerAlloc > StringLnkToIntegerLnkMap;

typedef std::multimap < Core::Box<const char>, Core::Box<const float>, MultiAllocAndComp, MultiAllocAndComp > ConstRefStringToConstRefFloatMultiMap;

typedef std::hash_map <const char*
	, const std::string
	, StringHash
	, MultiAllocAndComp
	, MultiAllocAndComp> ConstAgrStringToCinstAgrAStringHashMap;

typedef std::map < char, double > AgrCharToAgrDoubleMap;


} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_MAPSSMALTEST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
