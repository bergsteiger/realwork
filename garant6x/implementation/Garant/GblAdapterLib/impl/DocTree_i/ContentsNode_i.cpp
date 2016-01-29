////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i.h"

//#UC START# *4C778CFA0134_CUSTOM_INCLUDES*
//#UC END# *4C778CFA0134_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4C778CFA0134*
//#UC END# *4C778CFA0134*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ContentsNode_i::ContentsNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *4C77B3A50193_BASE_INIT*
: RealNodeBase (owner_tree, snode)
, DefaultNodeBase (owner_tree)	
, NodeBase_i (owner_tree, snode)
//#UC END# *4C77B3A50193_BASE_INIT*
{
	//#UC START# *4C77B3A50193_BODY*
	GblPilot::ContentsNodeValue* node_value = GblPilot::ContentsNodeValue::_downcast (snode.value.in ());
	m_type = node_value->para_list_type ();
	m_id = node_value->para_list_id ();
	//#UC END# *4C77B3A50193_BODY*
}

ContentsNode_i::ContentsNode_i ()
//#UC START# *4C77D2FF02C2_BASE_INIT*
: m_id (0), m_type (0)
//#UC END# *4C77D2FF02C2_BASE_INIT*
{
	//#UC START# *4C77D2FF02C2_BODY*
	//#UC END# *4C77D2FF02C2_BODY*
}

ContentsNode_i::~ContentsNode_i () {
	//#UC START# *4C778CFA0134_DESTR_BODY*
	//#UC END# *4C778CFA0134_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е. не
// уникален.
NodeId ContentsNode_i::get_node_id () const {
	//#UC START# *45EEB95901DE_4C778CFA0134*
	return m_id;
	//#UC END# *45EEB95901DE_4C778CFA0134*
}

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType ContentsNode_i::get_type () const {
	//#UC START# *45EEB9590224_4C778CFA0134_GET*
	return m_type;
	//#UC END# *45EEB9590224_4C778CFA0134_GET*
}

void ContentsNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_4C778CFA0134_SET*
	throw ConstantModify ();
	//#UC END# *45EEB9590224_4C778CFA0134_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

