////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// Пакет для проекта интеграции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_H__
#define __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// тип объекта
enum IntegrationType {
	IT_LISTENTRYINFO // закладка
	, IT_LIST // список
	, IT_QUERY // запрос
};

// в базе недостаточно данных для построения объекта
class CantCreateObject : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Integration;
typedef ::Core::Var<Integration> Integration_var;
typedef ::Core::Var<const Integration> Integration_cvar;
// интерфейс для работы с проектом интеграции
class Integration
	: virtual public ::Core::IObject
{
public:
	// доступны ли в версии возможности для внешних интеграторов
	virtual const bool get_integration_enabled () const = 0;

	// возвращает идентификатор комлекта.
	virtual GCI::IO::String* get_integration_complect_id () const /*throw (CanNotFindData)*/ = 0;

	// метод возвращает объект по поданному xml-у
	virtual IntegrationType get_object_by_xml (
		const char* xml
		, Core::IObject*& result
	) const /*throw (
		CanNotFindData
		, InvalidXMLType
		, CantCreateObject
	)*/ = 0;
};

/// factory interface for Integration
class IntegrationFactory {
public:
	// фабрика
	static Integration* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Integration> {
	typedef GblAdapterLib::IntegrationFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
