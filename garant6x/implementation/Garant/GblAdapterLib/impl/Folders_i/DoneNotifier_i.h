////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/DoneNotifier_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Folders_i::DoneNotifier_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_DONENOTIFIER_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_DONENOTIFIER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folders_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FolderNotifier_i.h"

namespace GblAdapterLib {

class DoneNotifier_i;
typedef Core::Var<DoneNotifier_i> DoneNotifier_i_var;
typedef Core::Var<const DoneNotifier_i> DoneNotifier_i_cvar;

class DoneNotifier_i :
	virtual public DoneNotifier
	, virtual public Core::RefCountObjectBase
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit DoneNotifier_i (FolderNotifier_i* servant);

public:
	virtual ~DoneNotifier_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void add_notify_data (NotifyStatus status, unsigned long folder_id);

	virtual void clear_cache ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Mutex m_done_mutex;

	bool m_fire_done;

	FolderNotifier_i* m_notifier;

	NotifyDataList m_notify_data_list;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DoneNotifier
	virtual bool done ();
}; // class DoneNotifier_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_DONENOTIFIER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

