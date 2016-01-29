////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include <fstream>
#include "garantServer/src/Global/Defines/Common/XMLDef.h"
#include "garantServer/src/Business/GblXMLSave/GblXMLSaveC.h"
#include "boost/bind.hpp"
#include "boost/lambda/lambda.hpp"
#include "boost/function.hpp"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FoldersManager_i::FoldersManager_i ()
//#UC START# *45EED7A20292_45EED7B8013A_45742F5B0196_BASE_INIT*
//#UC END# *45EED7A20292_45EED7B8013A_45742F5B0196_BASE_INIT*
{
	//#UC START# *45EED7A20292_45EED7B8013A_45742F5B0196_BODY*
	//#UC END# *45EED7A20292_45EED7B8013A_45742F5B0196_BODY*
}

FoldersManager_i::~FoldersManager_i () {
	//#UC START# *45742F5B0196_DESTR_BODY*
	//#UC END# *45742F5B0196_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void FoldersManager_i::pick_up_nodes (Node* node, unsigned long flags, NodeVector& nodes) const {
	//#UC START# *4619F6B0005D*
	GDS_ASSERT (node); 
	
	long child_count = node->get_child_count ();
	for (long i = 0; i < child_count; ++i) {
		Node_var child = node->get_child (i);
		GDS_ASSERT (child.ptr ());

		if (child->get_flags () & flags) {
			nodes.push_back (child);
		}

		this->pick_up_nodes (child.in (), flags, nodes);
	}
	//#UC END# *4619F6B0005D*
}

void FoldersManager_i::recalc_node_flags () {
	//#UC START# *45F80EA501FD*
	this->refresh ();
	dynamic_cast <FoldersNode_i*> (m_root.ptr ())->recalc_node_flags (false, NF_COMMENTS, NF_IN_COMMENTS);
	//#UC END# *45F80EA501FD*
}

void FoldersManager_i::recalc_shared_flags () {
	//#UC START# *45F80E9001BE*
	this->refresh ();

	dynamic_cast <FoldersNode_i*> (m_root.ptr ())->recalc_shared_flags (false);
	//#UC END# *45F80E9001BE*
}

void FoldersManager_i::refresh () {
	//#UC START# *45F80EF1019F*
	GUARD (m_root_mutex);
	if (m_root.is_nil ()) {
		LOG_D (("%s: Create root", GDS_CURRENT_FUNCTION));
		// Берем первую дочернюю папку, которая является личной папкой
		//  текущего пользователя
		GblFolders::Folder_var root_folder = ApplicationHelper::instance ()->get_cached_folders ()->get_folders ();
		Core::Var<FoldersNode_i> f = new FoldersNode_i (root_folder.in (), this);
		this->set_root (f.in ());
	}
	//#UC END# *45F80EF1019F*
}

void FoldersManager_i::set_root (StaticNode_i* root) {
	//#UC START# *461A005F02FD*
	m_root = Node::_duplicate (root);
	//#UC END# *461A005F02FD*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseCatalog
// наложенный фильтр
const EntityType FoldersManager_i::get_filter () const {
	//#UC START# *457024AB002E_45742F5B0196_GET*
	throw Unsupported ();
	//#UC END# *457024AB002E_45742F5B0196_GET*
}

void FoldersManager_i::set_filter (EntityType filter) {
	//#UC START# *457024AB002E_45742F5B0196_SET*
	throw Unsupported ();
	//#UC END# *457024AB002E_45742F5B0196_SET*
}

// implemented method from BaseCatalog
// Найти узел по его элементу.
Node* FoldersManager_i::find (const Core::IObject* entity) const {
	//#UC START# *456FEA67007E_45742F5B0196*
	throw Unsupported ();
	//#UC END# *456FEA67007E_45742F5B0196*
}

// implemented method from BaseCatalog
// Поиск контекста среди элементов списка.
Node* FoldersManager_i::find_context (
	const char* mask
	, const SearchMode& mode
	, const Node* cur_item
	, ContextSearchResult*& result
) const {
	//#UC START# *456FEA670080_45742F5B0196*
	throw Unsupported ();
	//#UC END# *456FEA670080_45742F5B0196*
}

// implemented method from BaseCatalog
// сбрасывает все установленные фильтры по типам
void FoldersManager_i::reset_type_filter () const {
	//#UC START# *456FEA670085_45742F5B0196*
	throw Unsupported ();
	//#UC END# *456FEA670085_45742F5B0196*
}

// implemented method from BaseCatalog
// корень дерева
const Node* FoldersManager_i::get_root () const {
	//#UC START# *456FEA7A03B9_45742F5B0196_GET*
	GUARD (m_root_mutex);
	if (m_root.is_nil ()) {
		const_cast <FoldersManager_i*> (this)->refresh ();
		const_cast <FoldersManager_i*> (this)->recalc_node_flags ();
		const_cast <FoldersManager_i*> (this)->recalc_shared_flags ();
	}

	return m_root._sretn ();
	//#UC END# *456FEA7A03B9_45742F5B0196_GET*
}

Node* FoldersManager_i::get_root () {
	return const_cast<Node*>(((const FoldersManager_i*)this)->get_root ());
}

// implemented method from Folders
// Фабрика узлов, возвращает новый созданный экземпляр BaseEntity типа Folder.
Folder* FoldersManager_i::create_folder () const {
	//#UC START# *45EED7A20295_45742F5B0196*
	Containers::Content_var content;
	GblFolders::Folder_var folder_content;

	content = ApplicationHelper::instance ()->get_cached_folders ()->create_content (Defines::CT_FOLDER);
	folder_content = GblFolders::Folder::_narrow (content);

	Folder_var out_folder = FolderFactory::make (folder_content.in (), 0);
	return out_folder._retn ();
	//#UC END# *45EED7A20295_45742F5B0196*
}

// implemented method from Folders
// Найти узел папки по его идентификатору. Если не найден то CanNotFindData.
FoldersNode* FoldersManager_i::find_folder_node (FolderId id) const {
	//#UC START# *45EED7A20296_45742F5B0196*
	bool found = false;
	FoldersNode* out_folders_node;
	try {
		Node_var root = const_cast <FoldersManager_i*> (this)->get_root ();

		FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (root.ptr ());
		out_folders_node = folders_node_i->find_node_by_id (id);
		if (out_folders_node != 0) {
			found  = true;
		}
	} catch (...) {
	}
	if (!found) {
		throw CanNotFindData ();
	}
	return out_folders_node;
	//#UC END# *45EED7A20296_45742F5B0196*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

