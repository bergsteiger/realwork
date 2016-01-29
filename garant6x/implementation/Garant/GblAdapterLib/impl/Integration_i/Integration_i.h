////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Integration_i::Integration_i
// Заголовок реализации класса серванта для интерфеса Integration
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTEGRATION_I_INTEGRATION_I_H__
#define __GARANT6X_GBLADAPTERLIB_INTEGRATION_I_INTEGRATION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject.h"

namespace GblAdapterLib {
namespace Integration_i {

class Integration_i; // self forward Var
typedef ::Core::Var<Integration_i> Integration_i_var;
typedef ::Core::Var<const Integration_i> Integration_i_cvar;

class Integration_i_factory;

class Integration_i:
	virtual public Integration
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Integration_i)
	friend class Integration_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Integration_i ();

	virtual ~Integration_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable boost::tribool m_is_integration_enabled;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	boost::tribool get_is_integration_enabled () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Integration
	// возвращает идентификатор комлекта.
	virtual GCI::IO::String* get_integration_complect_id () const /*throw (CanNotFindData)*/;

	// implemented method from Integration
	// метод возвращает объект по поданному xml-у
	virtual IntegrationType get_object_by_xml (
		const char* xml
		, Core::IObject*& result
	) const /*throw (
		CanNotFindData
		, InvalidXMLType
		, CantCreateObject
	)*/;

	// implemented method from Integration
	// доступны ли в версии возможности для внешних интеграторов
	virtual const bool get_integration_enabled () const;
}; // class Integration_i

} // namespace Integration_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTEGRATION_I_INTEGRATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
