////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersNode_i
// Заголовк реализации фабрик интерфеса FoldersNode для серванта FoldersNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folders_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"

/// Servant-factory implementation for FoldersNode_i
namespace GblAdapterLib {
	class Consultation_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class FolderNotifier_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class Folder_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class FoldersNode_iServantFactory {
	friend class Consultation_i;
	friend class FolderNotifier_i;
	friend class Folder_i;

	static FoldersNode_i* make (Containers::Content* content, Folders* folders);
};

/// Interface-factory implementation for FoldersNode_i
class FoldersNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public FoldersNodeAbstractFactory {
	friend class FoldersNode_iServantFactory;

public:
	FoldersNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static FoldersNode_i_factory* s_instance;

	const char* key () const;

	FoldersNode* make (Containers::Content* content, Folders* folders);

};

typedef ::Core::Var<FoldersNode_i_factory> FoldersNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::FoldersNode_i> {
	typedef GblAdapterLib::FoldersNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

