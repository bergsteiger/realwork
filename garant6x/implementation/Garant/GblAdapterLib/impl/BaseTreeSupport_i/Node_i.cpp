////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/Node_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTreeSupport_i::Node_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/Node_i.h"

//#UC START# *45702285038A_CUSTOM_INCLUDES*
//#UC END# *45702285038A_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45702285038A*
//#UC END# *45702285038A*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Node_i::Node_i ()
//#UC START# *456FE63B01D4_4602879E0119_45702285038A_BASE_INIT*
//#UC END# *456FE63B01D4_4602879E0119_45702285038A_BASE_INIT*
{
	//#UC START# *456FE63B01D4_4602879E0119_45702285038A_BODY*
	//#UC END# *456FE63B01D4_4602879E0119_45702285038A_BODY*
}

Node_i::Node_i (
	const char* caption
	, void* data
	, long flags
	, const char* hint
	, unsigned long level
	, unsigned long index
	, unsigned long object_type
	, Node* parent
)
//#UC START# *460284D90167_BASE_INIT*
	: m_index (index)
	, m_loaded (false) 
	, m_data (data)
	, m_flags (flags)
	, m_level (level)
	, m_object_type (object_type)
	, m_parent (parent)
	, m_children_count (-1)
	, m_all_children_count (-1)
	, m_through_index (-1)
//#UC END# *460284D90167_BASE_INIT*
{
	//#UC START# *460284D90167_BODY*
	m_caption = GCI::IO::StringFactory::make (caption);
	m_hint = GCI::IO::StringFactory::make (hint);
	//#UC END# *460284D90167_BODY*
}

Node_i::~Node_i () {
	//#UC START# *45702285038A_DESTR_BODY*
	//#UC END# *45702285038A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Node_i::clear_cache () {
	//#UC START# *4602844902BF*
	m_children_map.clear ();
	m_children_count = -1;
	m_all_children_count = -1;
	m_through_index = -1;
	//#UC END# *4602844902BF*
}

void Node_i::clear_cache (unsigned long index, long count) {
	//#UC START# *46028451029F*
	if (m_all_children_count != -1) {
		m_all_children_count -= count;
	}
	if (m_children_count != -1) {
		--m_children_count;
	}
	
	{
		ChildrenMap::iterator it = m_children_map.find (index);
		GDS_ASSERT (it != m_children_map.end ());
		
		m_children_map.erase (it++);

		while (it != m_children_map.end ()) {				
			unsigned long key = it->first - 1;
			Node_var data = it->second;
			
			Node_i* node_i = dynamic_cast <Node_i*> (data.ptr ());
			GDS_ASSERT (node_i);
			node_i->fix_indexes (1, 1, count);

			m_children_map [key] = data;
			
			m_children_map.erase (it++);				
		}
	}

	Node_cvar parent = this->get_parent ();
	if (!parent.is_nil ()) {
		const Node_i* node_i = dynamic_cast <const Node_i*> (parent.ptr ());
		const_cast <Node_i*> (node_i)->fix_after_del (this->get_index (), count);
	}
	//#UC END# *46028451029F*
}

void Node_i::fix_after_del (unsigned long index, long decrement) {
	//#UC START# *46028470000F*
	if (m_all_children_count != -1) {
		m_all_children_count -= decrement;
	}
	for (ChildrenMap::iterator it = m_children_map.begin (); it != m_children_map.end (); ++it) {
		if (it->first > index) {
			Node_i* node_i = dynamic_cast <Node_i*> (it->second.ptr ());
			node_i->fix_indexes (0, decrement, decrement);
		}
	}
	//#UC END# *46028470000F*
}

void Node_i::fix_indexes (long index_decrement, long through_index_decrement, long index_in_list_decrement) {
	//#UC START# *4602848C001F*
	m_index -= index_decrement;
	if (m_through_index != -1) {
		m_through_index -= through_index_decrement;
	}
	//#UC END# *4602848C001F*
}

void* Node_i::get_data () const {
	//#UC START# *460284320261*
	return const_cast<void*> (m_data);
	//#UC END# *460284320261*
}

void Node_i::nil_parent () {
	//#UC START# *460284CF031C*
	m_parent = 0;
	//#UC END# *460284CF031C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Node
// Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если
// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify.
// Если нода не может содержать детей возвращается исключение InvalidContainer
Node* Node_i::add_child_node (
	const Core::IObject* entity
) const /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, DuplicateNode
	, InvalidEntityType
)*/ {
	//#UC START# *456FE63B01DE_45702285038A*
	throw Unsupported ();
	//#UC END# *456FE63B01DE_45702285038A*
}

// implemented method from Node
// Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если
// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify
Node* Node_i::add_sibling_node (
	const Core::IObject* entity
) const /*throw (
	ConstantModify
	, Unsupported
	, DuplicateNode
)*/ {
	//#UC START# *456FE63B01E0_45702285038A*
	throw Unsupported ();
	//#UC END# *456FE63B01E0_45702285038A*
}

// implemented method from Node
// Количество вложенных элементов для текущего с учетом всех уровней вложенности.
// У листьевых элементов =0.
long Node_i::get_all_child_count () const {
	//#UC START# *456FE63B01F1_45702285038A_GET*
	if (m_all_children_count == -1) {
		long children_count = this->get_child_count ();
		m_all_children_count = children_count;
		
		for (long i = 0; i < children_count; ++i) {
			Node_var node = const_cast<Node_i*> (this)->get_child (i);
			m_all_children_count += node->get_all_child_count ();
		}
	}
	return m_all_children_count;
	//#UC END# *456FE63B01F1_45702285038A_GET*
}

// implemented method from Node
// можно ли скопировать ноду
bool Node_i::can_copy () const {
	//#UC START# *456FE63B01E7_45702285038A*
	return false;
	//#UC END# *456FE63B01E7_45702285038A*
}

// implemented method from Node
// можно ли вставить ноду
bool Node_i::can_insert (Node* source) const {
	//#UC START# *456FE63B01E8_45702285038A*
	return false;
	//#UC END# *456FE63B01E8_45702285038A*
}

// implemented method from Node
// можно ли модифицировать ноду
bool Node_i::can_modify () const {
	//#UC START# *4AA55863036D_45702285038A*
	return false;
	//#UC END# *4AA55863036D_45702285038A*
}

// implemented method from Node
// можно ли переместить ноду
bool Node_i::can_move () const {
	//#UC START# *456FE63B01E6_45702285038A*
	return false;
	//#UC END# *456FE63B01E6_45702285038A*
}

// implemented method from Node
// название
const GCI::IO::String& Node_i::get_caption () const {
	//#UC START# *457025090261_45702285038A_GET*
	const_cast<Node_i*>(this)->load ();
	
	return *m_caption.in ();
	//#UC END# *457025090261_45702285038A_GET*
}

GCI::IO::String& Node_i::get_caption () {
	return const_cast<GCI::IO::String&>(((const Node_i*)this)->get_caption ());
}

void Node_i::set_caption (GCI::IO::String* caption)
	/*throw (ConstantModify, AccessDenied)*/
{
	//#UC START# *457025090261_45702285038A_SET*
	throw ConstantModify ();
	//#UC END# *457025090261_45702285038A_SET*
}

// implemented method from Node
// Количество вложенных элементов для текущего (один уровень).
// У листьевых элементов =0.
long Node_i::get_child_count () const {
	//#UC START# *456FE63B01F0_45702285038A_GET*
	return m_children_count;
	//#UC END# *456FE63B01F0_45702285038A_GET*
}

// implemented method from Node
// Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком.
// Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение
// InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение
// CopyDisabled
void Node_i::copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/ {
	//#UC START# *456FE63B01E4_45702285038A*
	if (!this->can_copy ()) {
		throw CopyDisabled ();
	} 
	//#UC END# *456FE63B01E4_45702285038A*
}

// implemented method from Node
// Удаляет указанные узел из списка/дерева.
// Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево
// созданно как константное (неизменяемое) то генерится исключение ConstantModify
void Node_i::delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/ {
	//#UC START# *456FE63B01DD_45702285038A*
	//#UC END# *456FE63B01DD_45702285038A*
}

// implemented method from Node
// Поле для передачи дополнительной винарной информации о статусе элемента.
long Node_i::get_flags () const {
	//#UC START# *456FE63B01F4_45702285038A_GET*
	const_cast<Node_i*>(this)->load ();
	
	return m_flags;
	//#UC END# *456FE63B01F4_45702285038A_GET*
}

// implemented method from Node
// Получить интерфейс на один из вложенных элементов.
// Параметр должен принимать значения из диапазона: 0<=index<=(child_coun-1)
Node* Node_i::get_child (long index) /*throw (InvalidIndex)*/ {
	//#UC START# *456FE63B01D6_45702285038A*
	Node_var result;
	if ((index >= 0) && (index < this->get_child_count ())) {
		ChildrenMap::const_iterator it = m_children_map.find (index);
		if (it == m_children_map.end ()) {
			result = load_child (index);
			m_children_map[index] = result;
		} else {
			result = it->second;
		}
	}
	return result._retn ();
	//#UC END# *456FE63B01D6_45702285038A*
}

// implemented method from Node
// Есть ли дочерние элементы.
bool Node_i::has_child () const {
	//#UC START# *456FE63B01EC_45702285038A*
	return false;
	//#UC END# *456FE63B01EC_45702285038A*
}

// implemented method from Node
// информация о ноде
const GCI::IO::String& Node_i::get_hint () const {
	//#UC START# *4570251D0119_45702285038A_GET*
	const_cast<Node_i*>(this)->load ();
	
	return *m_hint.in ();
	//#UC END# *4570251D0119_45702285038A_GET*
}

GCI::IO::String& Node_i::get_hint () {
	return const_cast<GCI::IO::String&>(((const Node_i*)this)->get_hint ());
}

void Node_i::set_hint (GCI::IO::String* hint)
	/*throw (ConstantModify, AccessDenied)*/
{
	//#UC START# *4570251D0119_45702285038A_SET*
	throw ConstantModify ();
	//#UC END# *4570251D0119_45702285038A_SET*
}

// implemented method from Node
// Позиция текущего элемента в предке (parent).
long Node_i::get_index () const {
	//#UC START# *456FE63B01F5_45702285038A_GET*
	return m_index;
	//#UC END# *456FE63B01F5_45702285038A_GET*
}

// implemented method from Node
// Первый элемент.
bool Node_i::is_first () const {
	//#UC START# *456FE63B01EB_45702285038A*
	return false;
	//#UC END# *456FE63B01EB_45702285038A*
}

// implemented method from Node
// Последнией элемент.
bool Node_i::is_last () const {
	//#UC START# *456FE63B01EA_45702285038A*
	return false;
	//#UC END# *456FE63B01EA_45702285038A*
}

// implemented method from Node
// Сравнивает текущий элемент с элементом, поданным в параметре node.
// Возвращает true в случае совпадения.
bool Node_i::is_same_node (const Node* node) const {
	//#UC START# *456FE63B01D9_45702285038A*
	// Наверное просто не сравниваем, так как лишний раз динамик каст дёргать не хотим
	return (node == 0) ? false : (this == dynamic_cast<const Node_i*>(node));
	//#UC END# *456FE63B01D9_45702285038A*
}

// implemented method from Node
// Уровень вложенности элемента в древовидной структуре.
// У root_node=0.
long Node_i::get_level () const {
	//#UC START# *456FE63B01EF_45702285038A_GET*
	return m_level;
	//#UC END# *456FE63B01EF_45702285038A_GET*
}

// implemented method from Node
// Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять ноду
// (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция
// перемещения узлов не доступна, генерируется исключение MoveDisabled
void Node_i::move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/ {
	//#UC START# *456FE63B01E2_45702285038A*
	if (!this->can_move ()) {
		throw MoveDisabled ();
	}
	//#UC END# *456FE63B01E2_45702285038A*
}

// implemented method from Node
// следующая нода в дереве
const Node* Node_i::get_next_node () const {
	//#UC START# *456FE84E033C_45702285038A_GET*
	if ((m_parent != 0) && (m_index+1 < static_cast<unsigned long> (m_parent->get_child_count ()))) {
		return m_parent->get_child (m_index+1);
	}

	return 0;
	//#UC END# *456FE84E033C_45702285038A_GET*
}

Node* Node_i::get_next_node () {
	return const_cast<Node*>(((const Node_i*)this)->get_next_node ());
}

// implemented method from Node
// тип сущности, представляемой нодой
EntityType Node_i::get_object_type () const
	/*throw (Unsupported)*/
{
	//#UC START# *457025CB033C_45702285038A_GET*
	const_cast<Node_i*>(this)->load ();
	
	return m_object_type;
	//#UC END# *457025CB033C_45702285038A_GET*
}

// implemented method from Node
// Возвращает интерфейс для работы с конкретным элементом (сущностью) системы.
Core::IObject* Node_i::open () /*throw (CanNotFindData, NotEntityElement)*/ {
	//#UC START# *456FE63B01DB_45702285038A*
	throw CanNotFindData ();
	//#UC END# *456FE63B01DB_45702285038A*
}

// implemented method from Node
// перезаписать дочернюю ноду
Node* Node_i::override_child_node (
	const Core::IObject* entity
) const /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, DuplicateNode
	, InvalidEntityType
)*/ {
	//#UC START# *456FE63B01ED_45702285038A*
	throw Unsupported ();
	//#UC END# *456FE63B01ED_45702285038A*
}

// implemented method from Node
// родитель
const Node* Node_i::get_parent () const {
	//#UC START# *456FE7BC03C8_45702285038A_GET*
	return Node::_duplicate (m_parent);
	//#UC END# *456FE7BC03C8_45702285038A_GET*
}

Node* Node_i::get_parent () {
	return const_cast<Node*>(((const Node_i*)this)->get_parent ());
}

// implemented method from Node
// предыдущая нода в дереве
const Node* Node_i::get_previous_node () const {
	//#UC START# *456FE82903C8_45702285038A_GET*
	return m_index != 0 ? m_parent->get_child (m_index-1) : 0;
	//#UC END# *456FE82903C8_45702285038A_GET*
}

Node* Node_i::get_previous_node () {
	return const_cast<Node*>(((const Node_i*)this)->get_previous_node ());
}

// implemented method from Node
// Сквозная позиция элемента.
long Node_i::get_through_index () const {
	//#UC START# *456FE63B01F6_45702285038A_GET*
	if (m_through_index == -1) {
		m_through_index = 0;
		if (m_parent != 0) {
			for (ACE_UINT32 i = 0; i < m_index; ++i) {
				Node_var node =	m_parent->get_child (i);
				m_through_index += (node->get_all_child_count ()+1);
			}
		}
	}
	return m_through_index;
	//#UC END# *456FE63B01F6_45702285038A_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

