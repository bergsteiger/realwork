////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTree.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DynListNode_i::DynListNode_i ()
//#UC START# *4608DDE7033F_BASE_INIT*
	: m_list_node_type (-1)
	, m_document_id (0)
//#UC END# *4608DDE7033F_BASE_INIT*
{
	//#UC START# *4608DDE7033F_BODY*
	//#UC END# *4608DDE7033F_BODY*
}

DynListNode_i::DynListNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *4608DDF5017A_BASE_INIT*
	: RealNodeBase (owner_tree, snode)
	, DefaultNodeBase (owner_tree)	
	, NodeBase_i (owner_tree, snode)
	, m_list_node_type (static_cast<char>(NT_UNKNOWN))
	, m_document_id (0)
//#UC END# *4608DDF5017A_BASE_INIT*
{
	//#UC START# *4608DDF5017A_BODY*
	if (0 != snode.pointer && snode.value.in ()) {
		GblDocList::SnippetListNodeValue* snippet_val = GblDocList::SnippetListNodeValue::_downcast (snode.value.in ());
		if (snippet_val) {
			const char* snippet_text = snippet_val->snippet ();
			m_snippet_text = ACE_OS::strlen (snippet_text) ? GCI::IO::StringFactory::make (snippet_text) : 0;
		}

		GblDocList::ListNodeValue* val = GblDocList::ListNodeValue::_downcast (snode.value.in ());
		if (val) {
			GblDocList::ListNodeType type = val->type ();
			// алгоритм определения иконок для мед. препаратов описан в К13746
			if (GblDocList::LNT_PHARM & type) {
				if (GblDocList::LNT_SUB & type) {
					ListTree<DynListNode_i>* list_tree = dynamic_cast<ListTree<DynListNode_i>*>(owner_tree);
					GDS_ASSERT (list_tree);
					list_tree->add_block_position (snode.pointer, val->data ());

					if (GblDocList::LNT_ANNULED & type) {
						m_list_node_type = GblAdapterLib::LNT_FORM_ANNULED;
						return;
					}
					if (GblDocList::LNT_IMPORTANT & type) {
						if (GblDocList::LNT_RUSSIAN & type) {
							m_list_node_type = GblAdapterLib::LNT_FORM_RUSSIAN_IMPORTANT;
						} else {
							m_list_node_type = GblAdapterLib::LNT_FORM_NONRUSSIAN_IMPORTANT;
						}
					} else {
						if (GblDocList::LNT_RUSSIAN & type) {
							m_list_node_type = GblAdapterLib::LNT_FORM_RUSSIAN_NONIMPORTANT;
						} else {
							m_list_node_type = GblAdapterLib::LNT_FORM_NONRUSSIAN_NONIMPORTANT;
						}
					}
				} else {
					m_document_id  = val->data ();
					if (GblDocList::LNT_ANNULED & type) {
						m_list_node_type = GblAdapterLib::LNT_DRUG_ANNULED;
						return;
					}
					if (GblDocList::LNT_NARCOTIC & type) {
						m_list_node_type = GblAdapterLib::LNT_DRUG_NARCOTIC;
					} else {
						m_list_node_type = GblAdapterLib::LNT_DRUG_NONANNULED_NONNARCOTIC;
					}
				}
			} else {
				if (this->is_document_node (type)) {
					m_document_id = val->data ();
				}
				switch (type) {
					case GblDocList::LNT_DOCUMENT_ABOLISHED: 
						m_list_node_type = GblAdapterLib::LNT_DOCUMENT_ABOLISHED;
						break;
					case GblDocList::LNT_DOCUMENT_ACTIVE:
						m_list_node_type = GblAdapterLib::LNT_DOCUMENT_ACTIVE; 
						break;
					case GblDocList::LNT_DOCUMENT_PREACTIVE:
						m_list_node_type = GblAdapterLib::LNT_DOCUMENT_PREACTIVE; 
						break;
					case GblDocList::LNT_DOCUMENT_UNKNOWN:
						m_list_node_type = GblAdapterLib::LNT_DOCUMENT_UNKNOWN; 
						break;
					case GblDocList::LNT_EDITION_ABOLISHED:
						m_list_node_type = GblAdapterLib::LNT_EDITION_ABOLISHED; 
						break;
					case GblDocList::LNT_EDITION_ACTIVE:
						m_list_node_type = GblAdapterLib::LNT_EDITION_ACTIVE; 
						break;
					case GblDocList::LNT_EDITION_PREACTIVE:
						m_list_node_type = GblAdapterLib::LNT_EDITION_PREACTIVE; 
						break;
					case GblDocList::LNT_EDITION_UNKNOWN:
						m_list_node_type = GblAdapterLib::LNT_EDITION_UNKNOWN; 
						break;
					case GblDocList::LNT_PARA:
					{
						m_list_node_type = GblAdapterLib::LNT_PARA;
						ListTree<DynListNode_i>* list_tree = dynamic_cast<ListTree<DynListNode_i>*>(owner_tree);
						GDS_ASSERT (list_tree);
						list_tree->add_block_position (snode.pointer, val->data ());
						break;
					}
					case GblDocList::LNT_SUB:
					{
						m_list_node_type = GblAdapterLib::LNT_SUB;
						ListTree<DynListNode_i>* list_tree = dynamic_cast<ListTree<DynListNode_i>*>(owner_tree);
						GDS_ASSERT (list_tree);
						list_tree->add_block_position (snode.pointer, val->data ());
						break;
					}
					case GblDocList::LNT_EDITIONS_GROUP:
						m_list_node_type = GblAdapterLib::LNT_EDITIONS_GROUP;
						break;
					
					case GblDocList::LNT_AAK:
						m_list_node_type = GblAdapterLib::LNT_AAK;
						break;

					default:
						GDS_ASSERT (false && "bad type of document");
				}
			}
		}
	}
	//#UC END# *4608DDF5017A_BODY*
}

DynListNode_i::~DynListNode_i () {
	//#UC START# *460780FC02D6_DESTR_BODY*
	//#UC END# *460780FC02D6_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

unsigned long DynListNode_i::get_block_position () const {
	//#UC START# *4608EC590062*
	const ListTree<DynListNode_i>* list_tree = dynamic_cast<const ListTree<DynListNode_i>*>(this->owner_tree ());
	GDS_ASSERT (list_tree);
	return list_tree->get_block_position (this->get_server_pointer ());
	//#UC END# *4608EC590062*
}

ObjectId DynListNode_i::get_parent_document_id () const {
	//#UC START# *53D0F7660082*
	NodeBase_cvar doc_node = this->get_parent ();
	GDS_ASSERT (doc_node.ptr ());
	return doc_node.ptr () ? dynamic_cast <const DynListNode*> (doc_node.ptr ())->get_document_id () : 0;
	//#UC END# *53D0F7660082*
}

bool DynListNode_i::is_document_node (GblDocList::ListNodeType type) const {
	//#UC START# *53D0FE0901A7*
	return type == GblDocList::LNT_DOCUMENT_ABOLISHED 
			|| type == GblDocList::LNT_DOCUMENT_ACTIVE
			|| type == GblDocList::LNT_DOCUMENT_PREACTIVE
			|| type == GblDocList::LNT_DOCUMENT_UNKNOWN
			|| type == GblDocList::LNT_AAK; 
	//#UC END# *53D0FE0901A7*
}

bool DynListNode_i::is_sub_or_para_node () const {
	//#UC START# *53D0FF91018A*
	return m_list_node_type == GblAdapterLib::LNT_PARA || m_list_node_type == GblAdapterLib::LNT_SUB;
	//#UC END# *53D0FF91018A*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DynListNode
// Получить идентифкатор документа из ноды списка
ObjectId DynListNode_i::get_document_id () const {
	//#UC START# *53CF894902A4_460780FC02D6*
	if (!m_document_id && this->is_sub_or_para_node ()) {
		m_document_id = get_parent_document_id ();
	}
	return m_document_id;
	//#UC END# *53CF894902A4_460780FC02D6*
}

// implemented method from DynListNode
const GCI::IO::String* DynListNode_i::get_snippet_text () const {
	//#UC START# *56D44B0E0092_460780FC02D6*
	return m_snippet_text._sretn ();
	//#UC END# *56D44B0E0092_460780FC02D6*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* DynListNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_460780FC02D6_GET*
	//Core::GDS::StopWatch sw ("DynListNode_i::get_entity");
	try {
		GTree::NodeEntity_var server_entity = this->entity ();

		GblPilot::ListEntryInfo* info;
		if ((*server_entity >>= info) && info->doc.ptr ()) {
			ListEntryInfo_var lei = ListEntryInfoFactory::make (*info, this);
			if (!lei.ptr ()) {
				throw NoEntity ();
			}
			return Core::IObject::_duplicate (lei.in ());
		}
	} catch (GTree::InvalidPointer&) {
	}
	// Тут был assert. Он лишний, поскольку с оболочки может приходить open для ноды, не являющейся документом
	// В этом случае должно лететь NoEntity, что вполне нормально и ожидаемо оболочкой.
	throw NoEntity (); // not reached
	//#UC END# *45F65BEA00DA_460780FC02D6_GET*
}

EntityBase* DynListNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const DynListNode_i*)this)->get_entity ());
}

void DynListNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_460780FC02D6_SET*
	NodeBase_i::set_entity (entity);
	//#UC END# *45F65BEA00DA_460780FC02D6_SET*
}

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType DynListNode_i::get_type () const {
	//#UC START# *45EEB9590224_460780FC02D6_GET*
	//if (m_list_node_type == GblAdapter::LNT_SUB || m_list_node_type == GblAdapter::LNT_PARA) {
	//	return GblAdapter::LNT_BLOCK;
	//}
	return m_list_node_type;
	//#UC END# *45EEB9590224_460780FC02D6_GET*
}

void DynListNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_460780FC02D6_SET*
	 NodeBase_i::set_type (type);
	//#UC END# *45EEB9590224_460780FC02D6_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

