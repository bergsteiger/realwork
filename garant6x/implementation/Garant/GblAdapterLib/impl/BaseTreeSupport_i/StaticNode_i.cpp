////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/StaticNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTreeSupport_i::StaticNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/StaticNode_i.h"
// by <<uses>> dependencies
#include "shared/GCL/data/StaticNodeStubBase.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StaticNode_i::StaticNode_i ()
//#UC START# *456FE63B01D4_4602879E0119_461A222D0212_BASE_INIT*
//#UC END# *456FE63B01D4_4602879E0119_461A222D0212_BASE_INIT*
{
	//#UC START# *456FE63B01D4_4602879E0119_461A222D0212_BODY*
	//#UC END# *456FE63B01D4_4602879E0119_461A222D0212_BODY*
}

StaticNode_i::~StaticNode_i () {
	//#UC START# *461A222D0212_DESTR_BODY*
	//#UC END# *461A222D0212_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Node
// Количество вложенных элементов для текущего с учетом всех уровней вложенности.
// У листьевых элементов =0.
long StaticNode_i::get_all_child_count () const {
	//#UC START# *456FE63B01F1_461A222D0212_GET*
	unsigned long ret = 0;
	
	for (GCL::StaticNode* cp = m_last_child; cp; GCL::StaticNode::shift_prev(cp)) {
		const GCL::StaticNodeStubBase* snsb = dynamic_cast<const GCL::StaticNodeStubBase*>(cp);
		if (snsb) {
			long stub_count = snsb->stub_count();
			ret += abs(stub_count);
			if (stub_count != 1 && snsb->has_pair()) {
				ret++;
				GCL::StaticNode::shift_prev(cp);
			}
		} else {
			ret += dynamic_cast<const StaticNode_i*>(cp)->get_all_child_count () + 1;
		}
	}

	return ret;
	//#UC END# *456FE63B01F1_461A222D0212_GET*
}

// implemented method from Node
// можно ли скопировать ноду
bool StaticNode_i::can_copy () const {
	//#UC START# *456FE63B01E7_461A222D0212*
	return false;
	//#UC END# *456FE63B01E7_461A222D0212*
}

// implemented method from Node
// можно ли вставить ноду
bool StaticNode_i::can_insert (Node* source) const {
	//#UC START# *456FE63B01E8_461A222D0212*
	return false;
	//#UC END# *456FE63B01E8_461A222D0212*
}

// implemented method from Node
// можно ли модифицировать ноду
bool StaticNode_i::can_modify () const {
	//#UC START# *4AA55863036D_461A222D0212*
	return false;
	//#UC END# *4AA55863036D_461A222D0212*
}

// implemented method from Node
// можно ли переместить ноду
bool StaticNode_i::can_move () const {
	//#UC START# *456FE63B01E6_461A222D0212*
	return false;
	//#UC END# *456FE63B01E6_461A222D0212*
}

// implemented method from Node
// Количество вложенных элементов для текущего (один уровень).
// У листьевых элементов =0.
long StaticNode_i::get_child_count () const {
	//#UC START# *456FE63B01F0_461A222D0212_GET*
	return GCL::StaticNode::children_count ();
	//#UC END# *456FE63B01F0_461A222D0212_GET*
}

// implemented method from Node
// Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком.
// Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение
// InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение
// CopyDisabled
void StaticNode_i::copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/ {
	//#UC START# *456FE63B01E4_461A222D0212*
	if (!this->can_copy ()) {
		throw CopyDisabled ();
	} 
	StaticNode_i* static_node_i = dynamic_cast <StaticNode_i*> (destination);
	if ((static_node_i != 0) && (static_node_i->can_insert (this))) {
		this->copy_to_destination (static_node_i);
	} else {
		throw InvalidContainer ();
	}
	//#UC END# *456FE63B01E4_461A222D0212*
}

// implemented method from Node
// Удаляет указанные узел из списка/дерева.
// Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево
// созданно как константное (неизменяемое) то генерится исключение ConstantModify
void StaticNode_i::delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/ {
	//#UC START# *456FE63B01DD_461A222D0212*
	this->remove_from_tree ();
	//#UC END# *456FE63B01DD_461A222D0212*
}

// implemented method from Node
// Получить интерфейс на один из вложенных элементов.
// Параметр должен принимать значения из диапазона: 0<=index<=(child_coun-1)
Node* StaticNode_i::get_child (long index) /*throw (InvalidIndex)*/ {
	//#UC START# *456FE63B01D6_461A222D0212*
	GCL::StaticNode_var static_node = this->child_by_index (index);
	if (static_node.is_nil ()) {
		throw InvalidIndex ();
	}
	return Core::IObject::_duplicate (dynamic_cast <StaticNode_i*> (static_node.in ()));
	//#UC END# *456FE63B01D6_461A222D0212*
}

// implemented method from Node
// Есть ли дочерние элементы.
bool StaticNode_i::has_child () const {
	//#UC START# *456FE63B01EC_461A222D0212*
	return GCL::StaticNode::has_children ();
	//#UC END# *456FE63B01EC_461A222D0212*
}

// implemented method from Node
// Позиция текущего элемента в предке (parent).
long StaticNode_i::get_index () const {
	//#UC START# *456FE63B01F5_461A222D0212_GET*
	unsigned long ret = 0;
	
	for (GCL::StaticNode* cp = m_last_child; cp; GCL::StaticNode::shift_prev(cp)) {
		const GCL::StaticNodeStubBase* snsb = dynamic_cast<const GCL::StaticNodeStubBase*>(cp);
		if (snsb) {
			long stub_count = snsb->stub_count();
			ret += abs(stub_count);
			if (stub_count != 1 && snsb->has_pair()) {
				++ret;
				GCL::StaticNode::shift_prev(cp);
			}
		} else {
			++ret;
		}
	}
	
	return ret;
	//#UC END# *456FE63B01F5_461A222D0212_GET*
}

// implemented method from Node
// Первый элемент.
bool StaticNode_i::is_first () const {
	//#UC START# *456FE63B01EB_461A222D0212*
	return GCL::StaticNode::is_first ();
	//#UC END# *456FE63B01EB_461A222D0212*
}

// implemented method from Node
// Последнией элемент.
bool StaticNode_i::is_last () const {
	//#UC START# *456FE63B01EA_461A222D0212*
	return GCL::StaticNode::is_last ();
	//#UC END# *456FE63B01EA_461A222D0212*
}

// implemented method from Node
// Сравнивает текущий элемент с элементом, поданным в параметре node.
// Возвращает true в случае совпадения.
bool StaticNode_i::is_same_node (const Node* node) const {
	//#UC START# *456FE63B01D9_461A222D0212*
	return this->is_equal (dynamic_cast <const StaticNode_i*> (node));
	//#UC END# *456FE63B01D9_461A222D0212*
}

// implemented method from Node
// Уровень вложенности элемента в древовидной структуре.
// У root_node=0.
long StaticNode_i::get_level () const {
	//#UC START# *456FE63B01EF_461A222D0212_GET*
	return this->level ();
	//#UC END# *456FE63B01EF_461A222D0212_GET*
}

// implemented method from Node
// Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду
// (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция
// перемещения узлов не доступна, генерируется исключение MoveDisabled
void StaticNode_i::move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/ {
	//#UC START# *456FE63B01E2_461A222D0212*
	if (!this->can_move ()) {
		throw MoveDisabled ();
	} 
	StaticNode_i* static_node_i = dynamic_cast <StaticNode_i*> (destination);
	if ((static_node_i != 0) && (static_node_i->can_insert (this))) {
		this->move_to_destination (static_node_i);
	} else {
		throw InvalidContainer ();
	}
	//#UC END# *456FE63B01E2_461A222D0212*
}

// implemented method from Node
// следующая нода в дереве
const Node* StaticNode_i::get_next_node () const {
	//#UC START# *456FE84E033C_461A222D0212_GET*
	return dynamic_cast <const StaticNode_i*> (GCL::StaticNode::next ());
	//#UC END# *456FE84E033C_461A222D0212_GET*
}

Node* StaticNode_i::get_next_node () {
	return const_cast<Node*>(((const StaticNode_i*)this)->get_next_node ());
}

// implemented method from Node
// тип сущности, представляемой нодой
EntityType StaticNode_i::get_object_type () const
	/*throw (Unsupported)*/
{
	//#UC START# *457025CB033C_461A222D0212_GET*
	throw Unsupported ();
	//#UC END# *457025CB033C_461A222D0212_GET*
}

// implemented method from Node
// перезаписать дочернюю ноду
Node* StaticNode_i::override_child_node (
	const Core::IObject* entity
) const /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, DuplicateNode
	, InvalidEntityType
)*/ {
	//#UC START# *456FE63B01ED_461A222D0212*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *456FE63B01ED_461A222D0212*
}

// implemented method from Node
// родитель
const Node* StaticNode_i::get_parent () const {
	//#UC START# *456FE7BC03C8_461A222D0212_GET*
	return dynamic_cast <const StaticNode_i*> (StaticNode::parent ());
	//#UC END# *456FE7BC03C8_461A222D0212_GET*
}

Node* StaticNode_i::get_parent () {
	return const_cast<Node*>(((const StaticNode_i*)this)->get_parent ());
}

// implemented method from Node
// предыдущая нода в дереве
const Node* StaticNode_i::get_previous_node () const {
	//#UC START# *456FE82903C8_461A222D0212_GET*
	return dynamic_cast <const StaticNode_i*> (GCL::StaticNode::prev ());
	//#UC END# *456FE82903C8_461A222D0212_GET*
}

Node* StaticNode_i::get_previous_node () {
	return const_cast<Node*>(((const StaticNode_i*)this)->get_previous_node ());
}

// implemented method from Node
// Сквозная позиция элемента.
long StaticNode_i::get_through_index () const {
	//#UC START# *456FE63B01F6_461A222D0212_GET*
	unsigned long ret = 0;

	for (GCL::StaticNode* cp = m_last_child; cp; GCL::StaticNode::shift_prev(cp)) {
		const GCL::StaticNodeStubBase* snsb = dynamic_cast<const GCL::StaticNodeStubBase*>(cp);
		if (snsb) {
			long stub_count = snsb->stub_count();
			ret += abs(stub_count);
			if (stub_count != 1 && snsb->has_pair()) {
				++ret;
				GCL::StaticNode::shift_prev(cp);
			}
		} else {
			ret += cp->children_count() + 1;
		}
	}
	
	return ret;
	//#UC END# *456FE63B01F6_461A222D0212_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

