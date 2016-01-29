////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
#include "garantServer/src/Business/GblFolders/GblFoldersAdapC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

typedef unsigned long PrimeKey;

class Prime;
typedef ::Core::Var<Prime> Prime_var;
typedef ::Core::Var<const Prime> Prime_cvar;
class Prime
	: virtual public ::Core::IObject
{
public:
	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	virtual const Query* get_query () const = 0;
	virtual Query* get_query () = 0;

	virtual void set_query (Query* query) = 0;

	virtual PrimeKey get_id () const = 0;
};

/// factory interface for Prime
class PrimeFactory {
public:
	static Prime* make (PrimeKey key, const char* name, GblFoldersAdap::SavedQueryData query)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < Prime_var > PrimeList;

class UnknownExportError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// список ключей рассылок
typedef std::vector < PrimeKey > KeysList;

class PrimeManager;
typedef ::Core::Var<PrimeManager> PrimeManager_var;
typedef ::Core::Var<const PrimeManager> PrimeManager_cvar;
class PrimeManager
	: virtual public ::Core::IObject
{
public:
	// есть ли доступ к онлайн редактированию анкет прайма
	virtual bool get_has_online_access () const = 0;

	virtual const PrimeList& get_list () const = 0;

	// сохраняет на сервере свеже созданный запрос для рассылок
	virtual Prime* add (const GCI::IO::String* name, const Query* query) /*throw (DuplicateName)*/ = 0;

	virtual void remove (PrimeKey id) = 0;

	virtual void save_mail_delivery_task (const char* xml_file_path) const /*throw (UnknownExportError)*/ = 0;

	virtual void share_prime_for_file_server () const /*throw (UnknownExportError)*/ = 0;

	virtual void save_list_to_xml (
		const KeysList& keys
		, const char* xml_file_path
	) const /*throw (
		UnknownExportError
	)*/ = 0;

	// обновить данные о новостных лентах у всех клиентов. Должен быть вызван перед выходом из утилиты.
	virtual void update () const = 0;

	// рассылку в локальных настройках и отправить на сервер праймов
	virtual void save_and_send_to_online_server () const = 0;

	// проверить соединение с онлайн сервисом праймов
	virtual bool check_connection_to_online_server () const = 0;
};

/// factory interface for PrimeManager
class PrimeManagerFactory {
public:
	static PrimeManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PrimeSettingsManager;
typedef ::Core::Var<PrimeSettingsManager> PrimeSettingsManager_var;
typedef ::Core::Var<const PrimeSettingsManager> PrimeSettingsManager_cvar;
// настройки для утилиты настройки новостных лент
class PrimeSettingsManager
	: virtual public BaseSettingsManager
{
};

/// factory interface for PrimeSettingsManager
class PrimeSettingsManagerFactory {
public:
	// фабрика
	static PrimeSettingsManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PrimeContractData;
typedef ::Core::Var<PrimeContractData> PrimeContractData_var;
typedef ::Core::Var<const PrimeContractData> PrimeContractData_cvar;
// данные для печатной формы прайма.
class PrimeContractData
	: virtual public ::Core::IObject
{
public:
	virtual const GCI::IO::String& get_info_kind () const = 0;
	virtual GCI::IO::String& get_info_kind () = 0;

	virtual const GCI::IO::String& get_themes_name () const = 0;
	virtual GCI::IO::String& get_themes_name () = 0;

	virtual const GCI::IO::String& get_client_name () const = 0;
	virtual GCI::IO::String& get_client_name () = 0;

	virtual const GCI::IO::String& get_profession () const = 0;
	virtual GCI::IO::String& get_profession () = 0;

	virtual const GCI::IO::String& get_organisation_type () const = 0;
	virtual GCI::IO::String& get_organisation_type () = 0;

	virtual const GCI::IO::String& get_area () const = 0;
	virtual GCI::IO::String& get_area () = 0;

	virtual const GCI::IO::String& get_taxes () const = 0;
	virtual GCI::IO::String& get_taxes () = 0;

	virtual const GCI::IO::String& get_email () const = 0;
	virtual GCI::IO::String& get_email () = 0;

	// получить шаблон для печатной формы Прайма
	virtual GCI::IO::Stream* get_contract_evd_form () const /*throw (CanNotFindData)*/ = 0;
};

/// factory interface for PrimeContractData
class PrimeContractDataFactory {
public:
	// получить данные для заполнения печатной формы Прайма
	static PrimeContractData* get_contract_data (Query* query)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Prime> {
	typedef GblAdapterLib::PrimeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::PrimeManager> {
	typedef GblAdapterLib::PrimeManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::PrimeSettingsManager> {
	typedef GblAdapterLib::PrimeSettingsManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::PrimeContractData> {
	typedef GblAdapterLib::PrimeContractDataFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
