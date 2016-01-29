////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalObjectTypeTranslator.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

JournalNode::JournalNode ()
//#UC START# *45EEB95901C5_45F6694A01B5_4A92B65B024B_BASE_INIT*
//#UC END# *45EEB95901C5_45F6694A01B5_4A92B65B024B_BASE_INIT*
{
	//#UC START# *45EEB95901C5_45F6694A01B5_4A92B65B024B_BODY*
	//#UC END# *45EEB95901C5_45F6694A01B5_4A92B65B024B_BODY*
}

JournalNode::JournalNode (FakeFacetForFactory* owner_tree, const GTree::Node& snode)
//#UC START# *45EEB95901C5_45FFF849002E_4A92B65B024B_BASE_INIT*
	: RealNodeBase (dynamic_cast <TreeBase*> (owner_tree), snode)
	, DefaultNodeBase (dynamic_cast <TreeBase*> (owner_tree))	
	, NodeBase_i (dynamic_cast <TreeBase*> (owner_tree), snode)
//#UC END# *45EEB95901C5_45FFF849002E_4A92B65B024B_BASE_INIT*
{
	//#UC START# *45EEB95901C5_45FFF849002E_4A92B65B024B_BODY*
	GblUserJournalDef::JournalValue* jv = GblUserJournalDef::JournalValue::_downcast(snode.value.in ());
	m_type = translate (jv->type ());
	//#UC END# *45EEB95901C5_45FFF849002E_4A92B65B024B_BODY*
}

JournalNode::~JournalNode () {
	//#UC START# *4A92B65B024B_DESTR_BODY*
	//#UC END# *4A92B65B024B_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* JournalNode::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_4A92B65B024B_GET*
	try {
		GTree::NodeEntity_var server_entity = this->entity ();
		GblUserJournal::JournalBookmark* server_journal_bookmark;
		if (*server_entity >>= server_journal_bookmark) {
			return JournalBookmarkFactory::make (server_journal_bookmark);
		} 
		GblUserJournal::JournalQuery* server_journal_query;
		if (*server_entity >>= server_journal_query) {
			QueryCreator_var creator (QueryCreatorFactory::make ());
			return creator->make_query (server_journal_query);
		}

	} catch (GTree::InvalidPointer&) {
	} catch (GCD::CanNotFindData&) {
	}
	throw NoEntity ();
	//#UC END# *45F65BEA00DA_4A92B65B024B_GET*
}

EntityBase* JournalNode::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const JournalNode*)this)->get_entity ());
}

void JournalNode::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_4A92B65B024B_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_4A92B65B024B_SET*
}

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType JournalNode::get_type () const {
	//#UC START# *45EEB9590224_4A92B65B024B_GET*
	return m_type;
	//#UC END# *45EEB9590224_4A92B65B024B_GET*
}

void JournalNode::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_4A92B65B024B_SET*
	GDS_ASSERT (false);
	throw ConstantModify ();
	//#UC END# *45EEB9590224_4A92B65B024B_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

