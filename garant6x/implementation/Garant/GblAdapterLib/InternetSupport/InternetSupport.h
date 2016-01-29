////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// Возможности, доступные через интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

class InternetSupport;
typedef ::Core::Var<InternetSupport> InternetSupport_var;
typedef ::Core::Var<const InternetSupport> InternetSupport_cvar;
// поддержка работы пользователей через internet
class InternetSupport
	: virtual public ::Core::IObject
{
public:
	// Разрешена ли онлайн проверка ревизий документов (для супермобильной версии)
	virtual bool revision_check_enabled () const = 0;

	// получить URL для заданного документа
	virtual GCI::IO::String* get_url_for_document (unsigned long doc_id, unsigned long para_id) const = 0;

	// Разрешен ли Интернет-Агент.
	virtual bool is_internet_agent_enabled () const = 0;

	// получить URL для интранет версии
	virtual GCI::IO::String* get_url_for_internet_version () const = 0;

	// Нужно ли показывать блямбу об отключении онлайн проверки
	virtual bool show_warning () const = 0;
};

/// factory interface for InternetSupport
class InternetSupportFactory {
public:
	// фабрика
	static InternetSupport* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DecisionsArchiveSupport;
typedef ::Core::Var<DecisionsArchiveSupport> DecisionsArchiveSupport_var;
typedef ::Core::Var<const DecisionsArchiveSupport> DecisionsArchiveSupport_cvar;
// Интерфейс доступа к архивам судебных решений
class DecisionsArchiveSupport
	: virtual public ::Core::IObject
{
public:
	// получить ссылку для перехода на архив судебных решений
	virtual GCI::IO::String* get_archive_url () const = 0;

	// архив судебных решений доступен
	virtual bool archive_available () const = 0;
};

/// factory interface for DecisionsArchiveSupport
class DecisionsArchiveSupportFactory {
public:
	static DecisionsArchiveSupport* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::InternetSupport> {
	typedef GblAdapterLib::InternetSupportFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DecisionsArchiveSupport> {
	typedef GblAdapterLib::DecisionsArchiveSupportFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
