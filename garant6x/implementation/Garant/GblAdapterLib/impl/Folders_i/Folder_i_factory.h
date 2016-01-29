////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::Folder_i
// Заголовк реализации фабрик интерфеса Folder для серванта Folder_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folders_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i.h"

/// Servant-factory implementation for Folder_i
namespace GblAdapterLib {
	class FoldersNode_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class Folder_iServantFactory {
	friend class FoldersNode_i;

	static Folder_i* make (GblFolders::Folder* folder_content, FoldersNode* folders_node);
};

/// Interface-factory implementation for Folder_i
class Folder_i_factory: virtual public ::Core::RefCountObjectBase, virtual public FolderAbstractFactory {
	friend class Folder_iServantFactory;

public:
	Folder_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static Folder_i_factory* s_instance;

	const char* key () const;

	Folder* make (GblFolders::Folder* folder_content, FoldersNode* folders_node);

};

typedef ::Core::Var<Folder_i_factory> Folder_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Folder_i> {
	typedef GblAdapterLib::Folder_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

