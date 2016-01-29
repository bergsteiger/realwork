////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersManager_i
// Заголовк реализации фабрик интерфеса Folders для серванта FoldersManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folders_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"

/// Servant-factory implementation for FoldersManager_i
namespace GblAdapterLib {
	class Folder_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class FoldersNode_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class FoldersManager_iServantFactory {
	friend class Folder_i;
	friend class FoldersNode_i;

	static FoldersManager_i& make ();
};

/// Interface-factory implementation for FoldersManager_i
class FoldersManager_i_factory: virtual public ::Core::RefCountObjectBase, virtual public FoldersAbstractFactory {
	friend class FoldersManager_iServantFactory;

public:
	FoldersManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static FoldersManager_i_factory* s_instance;

	const char* key () const;

	Folders* make ();

};

typedef ::Core::Var<FoldersManager_i_factory> FoldersManager_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::FoldersManager_i> {
	typedef GblAdapterLib::FoldersManager_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

