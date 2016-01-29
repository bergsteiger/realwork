////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/PrimitiveContainers/VectorsLageTest.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> TestModel::BasicTests::PrimitiveContainers::VectorsLageTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_VECTORSLAGETEST_H__
#define __TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_VECTORSLAGETEST_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>

namespace BasicTests {

typedef std::vector < bool > BoolAgrVector;

struct CharRefAllocator {
};

struct ShortRefAllocator {
};

struct DubleLnkAllocator {
};

struct LongMultyAllocator {
};

typedef std::vector < Core::Box<long>, LongMultyAllocator > LongRefVector;

typedef std::vector < long*, LongMultyAllocator > LongLnkVector;

typedef std::vector < char, CharRefAllocator > CharAgrVector;

typedef std::vector < Core::Box<short>, ShortRefAllocator > ShortRefVector;

typedef std::vector < double*, DubleLnkAllocator > DoubleLnkVector;

typedef std::vector < long, LongMultyAllocator > LongAgrVector;

struct MultyAllocator {
};

typedef std::vector < std::string, MultyAllocator > AStrAgrVector;

typedef std::vector < Core::Box<std::string>, MultyAllocator > AStrRefVector;

typedef std::vector < std::string*, MultyAllocator > AStrLnkVector;

typedef std::vector < char**, MultyAllocator > StrLnkVector;

typedef std::vector < Core::Box<char>, MultyAllocator > StrRefVector;

typedef std::vector < char*, MultyAllocator > StrAgrVector;

typedef std::vector < void*, MultyAllocator > PointerAgrVector;

typedef std::vector < Core::Boxx<void>, MultyAllocator > PointerRefVector;

typedef std::vector < void**, MultyAllocator > PointerLnkVector;

typedef std::vector < std::string, MultyAllocator > IdentifierAgrVector;

typedef std::vector < Core::Box<std::string>, MultyAllocator > IdentifierRefVector;

typedef std::vector < std::string*, MultyAllocator > IdentifierLnkVector;

typedef std::vector < Core::IObject_var, MultyAllocator > ObjectRefVector;

typedef std::vector < Core::IObject*, MultyAllocator > ObjectLnkVector;

typedef std::vector < Core::Exception, MultyAllocator > ExceptionAgrVector;

typedef std::vector < Core::Box<Core::Exception>, MultyAllocator > ExceptionRefVector;

typedef std::vector < Core::Exception*, MultyAllocator > ExceptionLnkVector;

struct SizeMultyAllocator {
};

typedef std::vector < Core::Box<size_t>, SizeMultyAllocator > SizeAgrVector;

typedef std::vector < Core::Box<size_t>, SizeMultyAllocator > SizeRefVector;

typedef std::vector < Core::Box<size_t>, SizeMultyAllocator > SizeLnkVector;

typedef std::vector < Core::Box<const size_t>, SizeMultyAllocator > ConstSizeAgrVector;

typedef std::vector < Core::Box<const size_t>, SizeMultyAllocator > ConstSizeRefVector;

typedef std::vector < Core::Box<const size_t>, SizeMultyAllocator > ConstSizeLnkVector;


} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_PRIMITIVECONTAINERS_VECTORSLAGETEST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
