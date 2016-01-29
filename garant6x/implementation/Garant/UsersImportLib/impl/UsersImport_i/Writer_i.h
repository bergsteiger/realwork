////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Writer_i
// Заголовок реализации класса серванта для интерфеса DataWriter
//
// передаёт на сервер заданные данные для создания пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_WRITER_I_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_WRITER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include <map>
#include "garantServer/src/Global/Core/gcdC.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"

namespace UsersImport_i {

class Writer_i; // self forward Var
typedef ::Core::Var<Writer_i> Writer_i_var;
typedef ::Core::Var<const Writer_i> Writer_i_cvar;

class Writer_i_factory;

// передаёт на сервер заданные данные для создания пользователя
class Writer_i:
	virtual public UsersImport::DataWriter
	, virtual public ::Core::RefCountObjectBase
	, virtual public GCM::GCMSimpleServer
{
	SET_OBJECT_COUNTER (Writer_i)
	friend class Writer_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// класс для авторизации администратора
	class AutoLoginAdmin {
		SET_OBJECT_COUNTER (AutoLoginAdmin)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// фабрика
		explicit AutoLoginAdmin (GslUserManager::UserManager* user_manager);

	public:
		virtual ~AutoLoginAdmin ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// серверная компонента
		GslUserManager::UserManager_var m_user_manager;

	//#UC START# *48200E98006D*
	//#UC END# *48200E98006D*
	}; // class AutoLoginAdmin

	// список групп с именами
	typedef std::map < std::string, GCD::Uid > GroupsWithNames;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Writer_i ();

	virtual ~Writer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// метод запуска компоненты
	virtual void execute ();

private:
	// возвращает булево значение - можно ли платить за консультации.
	virtual bool convert_consulting_status_to_boolean (boost::tribool value) const;

	// получить список групп с сервера
	virtual void get_groups_info ();

	// залогиниться на сервере
	virtual void login ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::auto_ptr<AutoLoginAdmin> m_auto_login;

	GblPilot::FunctionMng_var m_function_manager;

	GslUserManager::GroupManager_var m_group_manager;

	GroupsWithNames m_groups_data;

	// серверная компонента
	GslUserManager::UserManager_var m_user_manager;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UsersImport::DataWriter
	// записать данные
	virtual void add_user (const UsersImport::UserData& user_data);

	// implemented method from UsersImport::DataWriter
	// сменить данные пользователя
	virtual void change_user (const UsersImport::UserData& user_data, CORBA::ULong fields_count);

	// implemented method from UsersImport::DataWriter
	// удалить пользователя
	virtual void erase_user (const UsersImport::UserData& user_data);

	// implemented method from UsersImport::DataWriter
	// получить идентификатор группы по её имени
	virtual GCD::Uid get_group_id (const std::string& name);
}; // class Writer_i

} // namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_WRITER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
