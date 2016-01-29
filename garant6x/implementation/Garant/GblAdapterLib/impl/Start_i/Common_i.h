////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Common_i
// Заголовок реализации класса серванта для интерфеса Common
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_I_COMMON_I_H__
#define __GARANT6X_GBLADAPTERLIB_START_I_COMMON_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "ace/Singleton.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FolderNotifier_i.h"
#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"

//#UC START# *460A435B0157_CUSTOM_INCLUDES*
namespace Adapters {
	class DOMNodeEx;
}
//#UC END# *460A435B0157_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class Common_i; // self forward Var
typedef ::Core::Var<Common_i> Common_i_var;
typedef ::Core::Var<const Common_i> Common_i_cvar;

class Common_i_factory;

class Common_i:
	virtual public Common
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (Common_i)
	friend class Common_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <Common_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Common_i, ACE_SYNCH_RECURSIVE_MUTEX>;


//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:

	class BaseTypeTypeConvertor : 
		public Core::UnsortedTypeConverter<GblPilotDef::BaseType, BaseType> {
		protected:
			void fill_array () {
				//#UC START# *4A3F637F0199_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblPilotDef::BT_UNKNOWN, BT_UNKNOWN);
				this->add (GblPilotDef::BT_TRIAL, BT_TRIAL);
				this->add (GblPilotDef::BT_COMMERCIAL, BT_COMMERCIAL);
				this->add (GblPilotDef::BT_NON_COMMERCIAL, BT_NON_COMMERCIAL);
				this->add (GblPilotDef::BT_DEMO, BT_DEMO);
				//#UC END# *4A3F637F0199_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class BaseTypeTypeConvertor

	typedef ACE_Singleton<BaseTypeTypeConvertor, ACE_SYNCH_NULL_MUTEX> BaseTypeTypeConvertorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Common_i ();

	virtual ~Common_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual FolderNotifier_i* get_cached_folder_notifier () const;

private:
	// xml restore method for integration
	virtual Core::IObject* get_bookmark_by_xml (XercesHelpers::DOMNodeEx& root_node) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Date m_base_date;

	mutable boost::tribool m_erase_inactive_users;

	FolderNotifier_i* m_folder_notifier;

	mutable boost::tribool m_is_explanatory_dictionary_exist;

	mutable boost::tribool m_is_internal;

	// есть ли в базе инфарм
	mutable boost::tribool m_is_pharm_exist;

	mutable boost::tribool m_is_trimmed_publish_source_exists;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from Common
	// показывать ли помощь при первом запуске после инсталяции.
	virtual bool auto_show_help () const;

	// implemented method from Common
	virtual const Date& get_base_date () const;

	// implemented method from Common
	// проверка является ли база с лицензионными настройками - "для внутреннего использования"
	virtual bool check_internal () const;

	// implemented method from Common
	// Создать очередь обработки папочных нотификаций
	virtual void create_folder_notification_queue ();

	// implemented method from Common
	// Получить баннер
	virtual Banner* get_banner () const /*throw (CanNotFindData)*/;

	// implemented method from Common
	// Тип базы
	virtual BaseType get_base_type () const;

	// implemented method from Common
	virtual GCI::IO::String* get_complect_name () const;

	// implemented method from Common
	// Возвращает документ (Document) по заданному внутреннему ("гарантовскому") номеру.
	virtual bool get_document_on_number (long number, Document*& document, MissingInfo*& missing_info) const;

	// implemented method from Common
	// получить зашифрованный идентификатор комплекта
	virtual GCI::IO::String* get_encrypted_complect_id () const;

	// implemented method from Common
	virtual ExternalObject* get_picture (long id) const /*throw (CanNotFindData)*/;

	// implemented method from Common
	// получить тип установленного продукта
	virtual ProductType get_product_type () const;

	// implemented method from Common
	// словарь для скриптов (К271754146)
	virtual GCI::IO::Stream* get_scripts_system_dictionary () const;

	// implemented method from Common
	// Получить менеджер настроек
	virtual SettingsManager* get_settings_manager () const;

	// implemented method from Common
	// Получить сплеш
	virtual SplashScreen* get_splash_screen (bool is_start, short x, short y, bool flash_available) const;

	// implemented method from Common
	// доступен ли модуль ЭО.
	virtual bool is_eo_enabled () const;

	// implemented method from Common
	// включена ли поддержка удаления пользователей, которые давно не пользовались системой
	virtual bool is_erase_of_inactive_users_enabled () const;

	// implemented method from Common
	// Проверяет существует (доступен) ли в системе Толковый словарь.
	// Возвращает true в случае, если толковый словарь существует.
	virtual bool is_explanatory_dictionary_exist () const;

	// implemented method from Common
	virtual bool is_pharm_exist () const;

	// implemented method from Common
	// Есть ли усеченный индекс Источник опубликования
	virtual bool is_trimmed_publish_source_exists () const;

	// implemented method from Common
	// Лицензионные ограничения на количество пользователей
	virtual const LicenseRestrictions get_license_restrictions () const;

	// implemented method from Common
	// показывает рисунки для заданного топика (функциональность внутренней версии)
	virtual void show_pictures_on_number (long number) const /*throw (WorkingParamsNotFound, ExternalApplicationError)*/;

	// implemented method from Common
	// Установить нотификацию изменения папок.
	virtual void start_processing_folder_notification (ExternalFoldersChangeNotifier* notifier);

//#UC START# *460A435B0157*
//#UC END# *460A435B0157*
}; // class Common_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_START_I_COMMON_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
