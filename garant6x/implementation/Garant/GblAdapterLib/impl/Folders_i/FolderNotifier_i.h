////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FolderNotifier_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Folders_i::FolderNotifier_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERNOTIFIER_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERNOTIFIER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"

namespace GblAdapterLib {

class FolderNotifier_i;
typedef Core::Var<FolderNotifier_i> FolderNotifier_i_var;
typedef Core::Var<const FolderNotifier_i> FolderNotifier_i_cvar;

class FolderNotifier_i :
	virtual public GSI::NotifyService_i::Consumer_i
{
	SET_OBJECT_COUNTER (FolderNotifier_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:

	class NotifierStatusConvertor : 
		public Core::UnsortedTypeConverter<GblFolders::ChangedStatus, NotifyStatus> {
		protected:
			void fill_array () {
				//#UC START# *4619EB9C032B_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblFolders::cs_Node, NS_NODE);
				this->add (GblFolders::cs_Content, NS_CONTENT);
				//#UC END# *4619EB9C032B_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class NotifierStatusConvertor

	typedef ACE_Singleton<NotifierStatusConvertor, ACE_SYNCH_NULL_MUTEX> NotifierStatusConvertorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	FolderNotifier_i ();

public:
	virtual ~FolderNotifier_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Возвращает true, если нотифаер готов обрабатывать нотификацию от сервера.
	virtual bool ready () const;

	virtual void send_notify (NotifyStatus status, unsigned long folder_id);

	// Установить оболочечный нотифайер
	virtual void set_external_folders_change_notifier (ExternalFoldersChangeNotifier* notifier);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCD::Uid m_current_user;

	DoneNotifier_var m_done_notifier;

	ExternalFoldersChangeNotifier_var m_external_folders_change_notifier;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from GSI::NotifyService::Consumer
	// Для получения сообщений реализация перекрывает этот метод.
	virtual void fire_event (const CORBA::Any& event);

}; // class FolderNotifier_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERNOTIFIER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

