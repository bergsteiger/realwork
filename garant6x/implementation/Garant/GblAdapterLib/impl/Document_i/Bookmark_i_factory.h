////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Bookmark_i
// Заголовк реализации фабрик интерфеса Bookmark для серванта Bookmark_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARK_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARK_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i.h"

/// Servant-factory implementation for Bookmark_i
namespace GblAdapterLib {
	class FoldersNode_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class Bookmark_iServantFactory {
	friend class FoldersNode_i;

	static Bookmark_i* make (
		const GblPilotDef::Bookmark& bookmark
		, GblFolders::DocBookmark* doc_bookmark
		, FoldersNode* folders_node
	);
};

/// Interface-factory implementation for Bookmark_i
class Bookmark_i_factory: virtual public ::Core::RefCountObjectBase, virtual public BookmarkAbstractFactory {
	friend class Bookmark_iServantFactory;

public:
	Bookmark_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static Bookmark_i_factory* s_instance;

	const char* key () const;

	Bookmark* make (
		const GblPilotDef::Bookmark& bookmark
		, GblFolders::DocBookmark* doc_bookmark
		, FoldersNode* folders_node
	);

};

typedef ::Core::Var<Bookmark_i_factory> Bookmark_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Bookmark_i> {
	typedef GblAdapterLib::Bookmark_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARK_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

