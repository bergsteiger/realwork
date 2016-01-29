////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeManager_i
// Заголовок реализации класса серванта для интерфеса PrimeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMEMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMEMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"

//#UC START# *47BEECCF0383_CUSTOM_INCLUDES*
//#UC END# *47BEECCF0383_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class PrimeManager_i; // self forward Var
typedef ::Core::Var<PrimeManager_i> PrimeManager_i_var;
typedef ::Core::Var<const PrimeManager_i> PrimeManager_i_cvar;

class PrimeManager_i_factory;

class PrimeManager_i:
	virtual public PrimeManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PrimeManager_i)
	friend class PrimeManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PrimeManager_i ();

	virtual ~PrimeManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// создать имя файла для сохранения prime
	const std::string result_file_name (const char* path) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_has_online_access;

	mutable PrimeList m_list;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from PrimeManager
	// сохраняет на сервере свеже созданный запрос для рассылок
	virtual Prime* add (const GCI::IO::String* name, const Query* query) /*throw (DuplicateName)*/;

	// implemented method from PrimeManager
	// проверить соединение с онлайн сервисом праймов
	virtual bool check_connection_to_online_server () const;

	// implemented method from PrimeManager
	// есть ли доступ к онлайн редактированию анкет прайма
	virtual bool get_has_online_access () const;

	// implemented method from PrimeManager
	virtual const PrimeList& get_list () const;

	// implemented method from PrimeManager
	virtual void remove (PrimeKey id);

	// implemented method from PrimeManager
	// рассылку в локальных настройках и отправить на сервер праймов
	virtual void save_and_send_to_online_server () const;

	// implemented method from PrimeManager
	virtual void save_list_to_xml (const KeysList& keys, const char* xml_file_path) const /*throw (UnknownExportError)*/;

	// implemented method from PrimeManager
	virtual void save_mail_delivery_task (const char* xml_file_path) const /*throw (UnknownExportError)*/;

	// implemented method from PrimeManager
	virtual void share_prime_for_file_server () const /*throw (UnknownExportError)*/;

	// implemented method from PrimeManager
	// обновить данные о новостных лентах у всех клиентов. Должен быть вызван перед выходом из утилиты.
	virtual void update () const;

//#UC START# *47BEECCF0383*
//#UC END# *47BEECCF0383*
}; // class PrimeManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMEMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
