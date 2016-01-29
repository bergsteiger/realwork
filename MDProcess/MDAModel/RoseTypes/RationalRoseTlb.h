////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseTypes::RationalRoseTlb
//
// файл заглушка для включения КОМ-овского описания розовского интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSETYPES_RATIONALROSETLB_H__
#define __MDPROCESS_MDAMODEL_ROSETYPES_RATIONALROSETLB_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include <vector>

//#UC START# *4571DD8C003E_USER_INCLUDES*
#define TOOL_NAME OLESTR("MDA Generator")

#import "X:\support\import\RationalRose.tlb"                                                              \
	no_namespace                                                                                                       \
	rename ("GetClassName", "GetRoseClassName")                                                                        \
	rename ("GetProfileString", "GetRoseProfileString")                                                                \
	rename ("WriteProfileString", "WriteRoseProfileString")		\
	rename ("GetUniqueID", "DeprecatedGetUniqueID")					\
	no_implementation
//#UC END# *4571DD8C003E_USER_INCLUDES*


// обертка над Розовским элементом, нужна для помещения их в контэйнеры
struct RoseElementWrapper {
	// собственно ровозвский элемент
	IRoseElementPtr element;

	// контсруктор, задёт обертку над элементом
	RoseElementWrapper (IRoseElementPtr elem);
};

// функтор сравнения розовских элементов
struct RoseElementComparator : public std::binary_function<RoseElementWrapper, RoseElementWrapper, bool> {
	bool operator () (const RoseElementWrapper& first_param_, const RoseElementWrapper& second_param_) const;
};

// множество элементов розы
typedef std::set < RoseElementWrapper, RoseElementComparator > RoseElementSet;

// константы, используемые при вызове IsClass
static const char* CLASS_TYPE = "Class";
static const char* ATTRIBUTE_TYPE = "Attribute";
static const char* OPERATION_TYPE = "Operation";
static const char* ROSE_OBJECT_TYPE = "Object";
static const char* ROSE_ITEM_TYPE = "Item";
static const char* ROSE_ELEMENT_TYPE = "Element";
static const char* CATEGORY_TYPE = "Category";
static const char* PARAMETER_TYPE = "Parameter";
static const char* CLASS_DEPENDENCY_TYPE = "ClassDependency";
static const char* CONTROLLABLE_UNIT_TYPE = "ControllableUnit";
static const char* DEPENDENCY_TYPE = "Dependency";
static const char* MODEL_TYPE = "Model";
static const char* ROLE_TYPE = "Role";

// вектор розовских элементов
typedef std::vector < RoseElementWrapper > RoseElementVector;

// типы видимости
static const char* PUBLIC_ACCESS = "PublicAccess"; // публичный тип видимости
static const char* PROTECTED_ACCESS = "ProtectedAccess"; // protected
static const char* PRIVATE_ACCESS = "PrivateAccess"; // private
static const char* IMPLEMENTATION_ACCESS = "ImplementationAccess"; // implementation

// Возвращает идентификатор элемента. Т.к при перемещении некоторых элементов приходится удалять
// старый элемент и создавать новый, при этом меняется идентификатор элемента, что приводит к
// неприятным последствями - "отъезжают" юзер секции. Для решения этой проблемы, при таком
// перемещении в свойства нового элемента по ключу Base::STORED_UID_KEY записывается идентификатор
// удаленного элемента. В связи с этим, весь код должен использовать ТОЛЬКО этот метод для
// получения идентификатора
const std::string get_rose_element_uid (IRoseElementPtr elem);

//#UC START# *4571DD8C003E_USER_DEFINITION*
static char ROSE_NEWLINE_REPLACEMENT = (char)164; //замена символа переноса строки, для хранения свойств в модели
//#UC END# *4571DD8C003E_USER_DEFINITION*



#endif //__MDPROCESS_MDAMODEL_ROSETYPES_RATIONALROSETLB_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
