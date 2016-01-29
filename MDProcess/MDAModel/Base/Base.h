////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/Base/Base.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::Base
//
// пакет базовых типов (в будущем это должен быть пакет с интерфейсами дамперов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASE_H__
#define __MDPROCESS_MDAMODEL_BASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>

namespace Base {

class AbstractTemplatePainter;
typedef ::Core::Var<AbstractTemplatePainter> AbstractTemplatePainter_var;
typedef ::Core::Var<const AbstractTemplatePainter> AbstractTemplatePainter_cvar;
// Нужен для того, чтобы не зависеть от AbstractDumpers - в идеале почти весь AbstractDumpers
// должен быть поделен на интерфейс и реализацию - сейчас они совмещены.
class AbstractTemplatePainter
	: virtual public ::Core::IObject
{
};

class NamedElement;
typedef ::Core::Var<NamedElement> NamedElement_var;
typedef ::Core::Var<const NamedElement> NamedElement_cvar;
// базовый интерфейс для именованного элемента
class NamedElement
	: virtual public ::Core::IObject
{
public:
	// возвращает полное имя элемента
	virtual const std::string get_full_name () const = 0;
};

class Dumper;
typedef ::Core::Var<Dumper> Dumper_var;
typedef ::Core::Var<const Dumper> Dumper_cvar;
// базовый интерфейс для всех дамперов (пока никаких методов на нем нет - нужно подумать все ли
// публичные методы с AbstractDumperBase переносить на него или нет и создавать полную модель
// интерфейсов дамперов)
class Dumper
	: virtual public NamedElement
{
};

// Исключение возникающее в процессе генерации
class FatalError : public ::Core::Exception {
public:
	FatalError (const std::string& info);

	virtual ~FatalError () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// Информация - что случилось
	std::string m_info;
};

// константы определяющие дополнительные свойства элементов
static const std::string VISIBILITY_LEVEL_KEY = "VisibilityLevel"; // уровень видимости детей
static const std::string RESOLVED_TYPE_GUID = "ResolvedTypeGuid"; // имя свойства, для хранения идентификатора типа, с которым связан элемент (например для типа атрибута, параметра)
static const std::string GLOBAL_LOCALLY_KEY = "GlobalLocally"; // ключ для свойство локальной глобальности
static const std::string STORED_UID_KEY = "StoredUIDKey"; // имя свойства для хранения идентификатора элемента
static const char* OVERRIDEN_ELEMENTS_PROPERTIES = "OverridenElementsProperties";
static const char* USER_PROPERTY_TOOL = "MDA Generator User Properties";
static const char* ABSTRACTION_TYPE = "AbstarctOperation"; // ключ в свойствах элементах, по которому хранится тип абстрактности
static const char* VISIBILITY_TYPE = "VisabilityType"; // ключ в свойствах элемента, по которому хранится тип видимости
static const char* IS_OVERRIDEN_WRAPPER = "IsOverridenWrapper"; // флаг для того, чтобы понимать, что элемент на самом деле - обертка для переопределяемой операции/атрибута/класса и т.д
static const std::string ELEMENT_CREATION_ORDER = "ElementCreationOrder"; // ключ свойства, определяющего порядковый номер создания элемента

// значения для переключателя режимов реализации абстрактных методов
static const std::string ALL = "all"; // все
static const std::string INCLUDE = "include"; // включая
static const std::string EXCLUDE = "exclude"; // исключая

// Исключение возникает, если в одном файле находятся 2 юзер-секции с одинаковыми идентификаторами
class MultipleUCSections : public ::Core::Exception {
public:
	MultipleUCSections (const std::string& info);

	virtual ~MultipleUCSections () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// информация
	std::string m_info;
};

// мапа свойств
typedef std::map < std::string, std::string > PropertyMap;

typedef std::map < std::string, PropertyMap > ToolPropertyMap;

} // namespace Base


#endif //__MDPROCESS_MDAMODEL_BASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
