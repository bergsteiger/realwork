////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FrozenNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FrozenNode_i::FrozenNode_i (const DefaultNodeBase* node_to_froze)
//#UC START# *461A1F2903CE_BASE_INIT*
//#UC END# *461A1F2903CE_BASE_INIT*
{
	//#UC START# *461A1F2903CE_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, this));

	this->m_server_path = node_to_froze->get_server_path ();
	this->m_server_name_path = node_to_froze->get_server_path (GTree::PT_NAME);
	this->m_server_point = node_to_froze->get_server_pointer ();
	this->m_server_data_version = node_to_froze->server_data_version ();
	this->m_flags = node_to_froze->get_flags ();
	this->m_settings_root_id = node_to_froze->get_settings_root_id();
	const NodeBase* nb = dynamic_cast <const NodeBase*> (node_to_froze);
	if (nb) {
		m_type = nb->get_type ();		
		m_name = GCI::IO::StringFactory:: make (nb->get_caption ().get_data ());
		m_has_filtered_children = const_cast <NodeBase*> (nb)->has_filtered_children ();
	} else {
		m_type = NT_UNKNOWN;
	}
	//#UC END# *461A1F2903CE_BODY*
}

FrozenNode_i::~FrozenNode_i () {
	//#UC START# *461A1F2903C8_DESTR_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, this));
	//#UC END# *461A1F2903C8_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GTree::NodePath* FrozenNode_i::get_server_path () const {
	//#UC START# *461A1F2903CB*
	GTree::NodePath_var ret;
	ret = (const GTree::NodePath_var)this->m_server_path;
	return ret._retn();
	//#UC END# *461A1F2903CB*
}

GTree::NodePath* FrozenNode_i::get_server_path (GTree::TreeDataVersionID server_data_version) const {
	//#UC START# *461A1F2903CC*
	GTree::NodePath_var ret;
	if (this->m_server_data_version == server_data_version) {
		ret = this->m_server_path;
	} else {
		ret = this->m_server_name_path;
	}
	return ret._retn();
	//#UC END# *461A1F2903CC*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NodeBase
// аналогично add_last_childs но для одной ноды (как-либо полученной например, через
// create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия)
void FrozenNode_i::add_last_child (NodeBase* node) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590211_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590211_461A1F2903C8*
}

// implemented method from NodeBase
// вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то
// позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте
void FrozenNode_i::add_last_childs (NodesClipboard* nodes) {
	//#UC START# *45EEB959020F_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB959020F_461A1F2903C8*
}

// implemented method from NodeBase
void FrozenNode_i::add_notifier (NodeNotifier* notifier) {
	//#UC START# *45EEB95901C7_461A1F2903C8*
	//#UC END# *45EEB95901C7_461A1F2903C8*
}

// implemented method from NodeBase
// аналогично add_prev_siblings но для одной ноды
void FrozenNode_i::add_prev_sibling (NodeBase* node) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590215_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590215_461A1F2903C8*
}

// implemented method from NodeBase
// аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно
// КОНСТАНТНЫМ будет парент текущей ноды
void FrozenNode_i::add_prev_siblings (NodesClipboard* nodes) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590213_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590213_461A1F2903C8*
}

// implemented method from NodeBase
// Пользовательское название ноды
const GCI::IO::String& FrozenNode_i::get_caption () const {
	//#UC START# *45EEB9590222_461A1F2903C8_GET*
	return *m_name.ptr ();
	//#UC END# *45EEB9590222_461A1F2903C8_GET*
}

GCI::IO::String& FrozenNode_i::get_caption () {
	return const_cast<GCI::IO::String&>(((const FrozenNode_i*)this)->get_caption ());
}

// implemented method from NodeBase
long FrozenNode_i::get_child_count () const {
	//#UC START# *45EEB9590227_461A1F2903C8_GET*
	#pragma GDS_MESSAGE ("TODO: FrozenNode::get_child_count")
	return 0;
	//#UC END# *45EEB9590227_461A1F2903C8_GET*
}

// implemented method from NodeBase
// закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все
// изменения сделанные на ноде (отправляет данные на сервер)
void FrozenNode_i::commit_change_transaction () {
	//#UC START# *45EEB9590219_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590219_461A1F2903C8*
}

// implemented method from NodeBase
// копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в
// любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!!
NodesClipboard* FrozenNode_i::copy_nodes (FlagMask mask) {
	//#UC START# *45EEB959020C_461A1F2903C8*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB959020C_461A1F2903C8*
}

// implemented method from NodeBase
// Расширенная версия метода create_view. (покачто вью всегда создается от рута)
NodeBase* FrozenNode_i::create_view_ex (
	const FilterList& filter
	, FlagMask shared_flags
	, const NodeBase* sync_node
	, VisibleIndex& sync_index
	, unsigned long levels
	, bool unfiltered
	, bool auto_open
	, bool truncate_this_view
) {
	//#UC START# *45EEB95901C9_461A1F2903C8*
	return NodeBase::_duplicate (this);
	//#UC END# *45EEB95901C9_461A1F2903C8*
}

// implemented method from NodeBase
// удаляет текущую ноду
void FrozenNode_i::delete_node () {
	//#UC START# *45EEB959020B_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB959020B_461A1F2903C8*
}

// implemented method from NodeBase
// удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!!
void FrozenNode_i::delete_nodes (FlagMask mask) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590209_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590209_461A1F2903C8*
}

// implemented method from NodeBase
const EntityBase* FrozenNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_461A1F2903C8_GET*
	throw NoEntity ();
	//#UC END# *45F65BEA00DA_461A1F2903C8_GET*
}

EntityBase* FrozenNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const FrozenNode_i*)this)->get_entity ());
}

void FrozenNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_461A1F2903C8_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_461A1F2903C8_SET*
}

// implemented method from NodeBase
// устанавливает и снимает флаг раскрытия всех нод в дереве
void FrozenNode_i::expand_all (bool expand) {
	//#UC START# *45EEB9590220_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590220_461A1F2903C8*
}

// implemented method from NodeBase
// Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого
// вхождения, иначе пустой итератор (is_good!=true).
FindIterator* FrozenNode_i::find (const FilterList& filter, const NodePosition& find_from) const {
	//#UC START# *45EEB959021C_461A1F2903C8*
	return 0;
	//#UC END# *45EEB959021C_461A1F2903C8*
}

// implemented method from NodeBase
// ищет в текущем дереву ноду равную переданной
NodeBase* FrozenNode_i::find_node (const NodeBase* node_to_find) const {
	//#UC START# *45EEB95901D2_461A1F2903C8*
	#pragma GDS_MESSAGE ("TODO: FrozenNode::find_node")
	return 0;
	//#UC END# *45EEB95901D2_461A1F2903C8*
}

// implemented method from NodeBase
// Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find
NodeIndexPath* FrozenNode_i::find_node_path (NodeBase* node_to_find) const {
	//#UC START# *45EEB95901D4_461A1F2903C8*
	LOG_D (("%s: not implemented.", GDS_CURRENT_FUNCTION));
	return 0;
	//#UC END# *45EEB95901D4_461A1F2903C8*
}

// implemented method from NodeBase
const NodeBase* FrozenNode_i::get_first_child () const {
	//#UC START# *45FE5E3000DA_461A1F2903C8_GET*
	return 0;
	//#UC END# *45FE5E3000DA_461A1F2903C8_GET*
}

NodeBase* FrozenNode_i::get_first_child () {
	return const_cast<NodeBase*>(((const FrozenNode_i*)this)->get_first_child ());
}

// implemented method from NodeBase
// Возвращает абс. индекс для ноды
VisibleIndex FrozenNode_i::get_abs_index () const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901E6_461A1F2903C8*
	throw CanNotFindData ();
	//#UC END# *45EEB95901E6_461A1F2903C8*
}

// implemented method from NodeBase
LayerIdList* FrozenNode_i::get_available_layers () const {
	//#UC START# *46236D06007D_461A1F2903C8*
	return 0;
	//#UC END# *46236D06007D_461A1F2903C8*
}

// implemented method from NodeBase
// возвращает ноду-соседа (т.е. "брата" текущей) по индексу
NodeBase* FrozenNode_i::get_by_sibbling_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D6_461A1F2903C8*
	return ind ? 0 : Core::IObject::_duplicate (this);
	//#UC END# *45EEB95901D6_461A1F2903C8*
}

// implemented method from NodeBase
// возвращает ноду по видемому индексу относительно текущей
NodeBase* FrozenNode_i::get_by_visible_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D8_461A1F2903C8*
	return ind ? 0 : Core::IObject::_duplicate (this);
	//#UC END# *45EEB95901D8_461A1F2903C8*
}

// implemented method from NodeBase
// Возвращает путь к ноде по её абс. индексу
NodeIndexPath* FrozenNode_i::get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901E7_461A1F2903C8*
	throw CanNotFindData ();
	//#UC END# *45EEB95901E7_461A1F2903C8*
}

// implemented method from NodeBase
NodeIndexPath* FrozenNode_i::get_first_fit (const FilterList& filter) const {
	//#UC START# *45EEB95901DA_461A1F2903C8*
	return 0;
	//#UC END# *45EEB95901DA_461A1F2903C8*
}

// implemented method from NodeBase
unsigned long FrozenNode_i::get_first_level_children_flag_count (FlagMask flag) const {
	//#UC START# *4677A5180213_461A1F2903C8*
	return 0;
	//#UC END# *4677A5180213_461A1F2903C8*
}

// implemented method from NodeBase
// возвращает кол-во зхаданных флагов в текущем поддереве
unsigned long FrozenNode_i::get_flag_count (FlagMask flag) const {
	//#UC START# *45EEB95901DC_461A1F2903C8*
	return this->has_flag (flag) ? 1 : 0;
	//#UC END# *45EEB95901DC_461A1F2903C8*
}

// implemented method from NodeBase
NodeBase* FrozenNode_i::get_frozen_node () const {
	//#UC START# *4624DEED008C_461A1F2903C8*
	return Core::IObject::_duplicate (const_cast<FrozenNode_i*> (this));
	//#UC END# *4624DEED008C_461A1F2903C8*
}

// implemented method from NodeBase
// Возвращает порядковый номер узла относительно родителя (начиная с 1)
VisibleIndex FrozenNode_i::get_index_from_parent () const {
	//#UC START# *45EEB95901E5_461A1F2903C8*
	return 1;
	//#UC END# *45EEB95901E5_461A1F2903C8*
}

// implemented method from NodeBase
// Дублирует с CatalogBase
NodeBase* FrozenNode_i::get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/ {
	//#UC START# *45EEB959021A_461A1F2903C8*
	return 0;
	//#UC END# *45EEB959021A_461A1F2903C8*
}

// implemented method from NodeBase
// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е. не
// уникален.
NodeId FrozenNode_i::get_node_id () const {
	//#UC START# *45EEB95901DE_461A1F2903C8*
	return m_server_point;
	//#UC END# *45EEB95901DE_461A1F2903C8*
}

// implemented method from NodeBase
NodeBase* FrozenNode_i::get_unfiltered_node () const {
	//#UC START# *4625D15D0138_461A1F2903C8*
	return const_cast<FrozenNode_i*> (Core::IObject::_duplicate (this));
	//#UC END# *4625D15D0138_461A1F2903C8*
}

// implemented method from NodeBase
// возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни)
VisibleIndex FrozenNode_i::get_visible_delta (const NodeBase* node) const /*throw (NotFound)*/ {
	//#UC START# *45EEB95901E1_461A1F2903C8*
	return this->is_same_node(const_cast<NodeBase*> (node)) ? 0 : -1;
	//#UC END# *45EEB95901E1_461A1F2903C8*
}

// implemented method from NodeBase
VisibleIndex FrozenNode_i::get_visible_delta_by_entity (const EntityBase* entity) const /*throw (NotFound)*/ {
	//#UC START# *45EEB95901E3_461A1F2903C8*
	return -1;
	//#UC END# *45EEB95901E3_461A1F2903C8*
}

// implemented method from NodeBase
// признакк есть ли дети
bool FrozenNode_i::has_children () const {
	//#UC START# *45EEB95901EA_461A1F2903C8*
	return false;
	//#UC END# *45EEB95901EA_461A1F2903C8*
}

// implemented method from NodeBase
// признак взведен ли у детей указанный флаг
bool FrozenNode_i::has_children_flag (FlagMask flag) const {
	//#UC START# *45EEB95901EB_461A1F2903C8*
	return false;
	//#UC END# *45EEB95901EB_461A1F2903C8*
}

// implemented method from NodeBase
// признак того что нода соджержит отфильтрованных детей
bool FrozenNode_i::has_filtered_children () const {
	//#UC START# *45EEB95901ED_461A1F2903C8*
	return m_has_filtered_children;
	//#UC END# *45EEB95901ED_461A1F2903C8*
}

// implemented method from NodeBase
// признак взведен ли указанный флаг
bool FrozenNode_i::has_flag (FlagMask flag) const {
	//#UC START# *45EEB95901EE_461A1F2903C8*
	return (m_flags & flag) == flag;
	//#UC END# *45EEB95901EE_461A1F2903C8*
}

// implemented method from NodeBase
// признак взведен ли у родителей указанный флаг
bool FrozenNode_i::has_parent_flag (FlagMask flag) const {
	//#UC START# *45EEB95901F0_461A1F2903C8*
	return false;
	//#UC END# *45EEB95901F0_461A1F2903C8*
}

// implemented method from NodeBase
// возвращает true, если установлен флаг раскрытия всех нод
bool FrozenNode_i::get_is_expanded () const {
	//#UC START# *45EEB9590228_461A1F2903C8_GET*
	GDS_ASSERT (false);
	return false;
	//#UC END# *45EEB9590228_461A1F2903C8_GET*
}

// implemented method from NodeBase
// признак первый ли это ребенок
bool FrozenNode_i::is_first () const {
	//#UC START# *45EEB95901F2_461A1F2903C8*
	return true;
	//#UC END# *45EEB95901F2_461A1F2903C8*
}

// implemented method from NodeBase
// возвращает true если переданная нода (it) выше текущей
bool FrozenNode_i::is_it_higher (NodeBase* it) const {
	//#UC START# *45EEB95901F3_461A1F2903C8*
	return false;
	//#UC END# *45EEB95901F3_461A1F2903C8*
}

// implemented method from NodeBase
// признак последний ли это ребенок
bool FrozenNode_i::is_last () const {
	//#UC START# *45EEB95901F5_461A1F2903C8*
	return true;
	//#UC END# *45EEB95901F5_461A1F2903C8*
}

// implemented method from NodeBase
bool FrozenNode_i::is_relevance_search_supported () const {
	//#UC START# *45EEB959021F_461A1F2903C8*
	return false;
	//#UC END# *45EEB959021F_461A1F2903C8*
}

// implemented method from NodeBase
// проверяет на равенство две ноды
bool FrozenNode_i::is_same_node (NodeBase* node) const {
	//#UC START# *45EEB95901F6_461A1F2903C8*
	if (!node) {
		return false;
	}

	const FrozenNode_i* nd = dynamic_cast <const FrozenNode_i*> (node);
	if (nd) {
		return m_server_point == nd->m_server_point;
	} 
	
	const DefaultNodeBase* nb = dynamic_cast <const DefaultNodeBase*> (node);
	if (nb) {
		return m_server_point == nb->get_server_pointer ();
	}

	return false;
	//#UC END# *45EEB95901F6_461A1F2903C8*
}

// implemented method from NodeBase
NodeIterator* FrozenNode_i::iterate_all_nodes (FlagMask with_flag) {
	//#UC START# *473D89660266_461A1F2903C8*
	return 0;
	//#UC END# *473D89660266_461A1F2903C8*
}

// implemented method from NodeBase
// возвращает сквозной итератор по нодам с указанным флагом
NodeIterator* FrozenNode_i::iterate_nodes (FlagMask with_flag) {
	//#UC START# *45EEB95901F8_461A1F2903C8*
	return 0;
	//#UC END# *45EEB95901F8_461A1F2903C8*
}

// implemented method from NodeBase
// уровень ноды в дереве
long FrozenNode_i::get_level () const {
	//#UC START# *45EEB9590223_461A1F2903C8_GET*
	return 0;
	//#UC END# *45EEB9590223_461A1F2903C8_GET*
}

// implemented method from NodeBase
void FrozenNode_i::make_visible () {
	//#UC START# *45EEB95901FA_461A1F2903C8*
	//#UC END# *45EEB95901FA_461A1F2903C8*
}

// implemented method from NodeBase
const NodeBase* FrozenNode_i::get_next () const {
	//#UC START# *45FE5E9C0109_461A1F2903C8_GET*
	return 0;
	//#UC END# *45FE5E9C0109_461A1F2903C8_GET*
}

NodeBase* FrozenNode_i::get_next () {
	return const_cast<NodeBase*>(((const FrozenNode_i*)this)->get_next ());
}

// implemented method from NodeBase
const NodeBase* FrozenNode_i::get_parent () const {
	//#UC START# *45FE5ECB0261_461A1F2903C8_GET*
	return 0;
	//#UC END# *45FE5ECB0261_461A1F2903C8_GET*
}

NodeBase* FrozenNode_i::get_parent () {
	return const_cast<NodeBase*>(((const FrozenNode_i*)this)->get_parent ());
}

// implemented method from NodeBase
const NodeBase* FrozenNode_i::get_prev () const {
	//#UC START# *45FE5E5902FD_461A1F2903C8_GET*
	return 0;
	//#UC END# *45FE5E5902FD_461A1F2903C8_GET*
}

NodeBase* FrozenNode_i::get_prev () {
	return const_cast<NodeBase*>(((const FrozenNode_i*)this)->get_prev ());
}

// implemented method from NodeBase
void FrozenNode_i::remove_notifier (NodeNotifier* notifier) {
	//#UC START# *45EEB95901FB_461A1F2903C8*
	//#UC END# *45EEB95901FB_461A1F2903C8*
}

// implemented method from NodeBase
// сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения
// (перечитывает с сервера или внутреннего буффера)
void FrozenNode_i::rollback_change_transaction () {
	//#UC START# *45EEB9590218_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590218_461A1F2903C8*
}

// implemented method from NodeBase
// устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный
// флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает корректно)
void FrozenNode_i::set_all_flag (FlagMask flag, bool value) {
	//#UC START# *45EEB95901FD_461A1F2903C8*
	this->set_flag(flag, value);
	//#UC END# *45EEB95901FD_461A1F2903C8*
}

// implemented method from NodeBase
void FrozenNode_i::set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value) {
	//#UC START# *51EFC4100162_461A1F2903C8*
	this->set_flag(flag, value);
	//#UC END# *51EFC4100162_461A1F2903C8*
}

// implemented method from NodeBase
// взводит указанный флаг
void FrozenNode_i::set_flag (FlagMask flag, bool value) {
	//#UC START# *45EEB9590200_461A1F2903C8*
	if (value) {
		m_flags |= flag;
	} else {
		m_flags &= ~flag;
	}
	//#UC END# *45EEB9590200_461A1F2903C8*
}

// implemented method from NodeBase
// Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id ().
void FrozenNode_i::set_node_id (NodeId id) {
	//#UC START# *45EEB95901DF_461A1F2903C8*
	//#UC END# *45EEB95901DF_461A1F2903C8*
}

// implemented method from NodeBase
// взводит указанный флаг на промежутке
void FrozenNode_i::set_range_flag (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
	//#UC START# *45EEB9590203_461A1F2903C8*
	this->set_flag (flag, value);
	//#UC END# *45EEB9590203_461A1F2903C8*
}

// implemented method from NodeBase
void FrozenNode_i::set_range_flag_except_first_children_of_root_children (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
	//#UC START# *51EFD26E03DF_461A1F2903C8*
	this->set_flag (flag, value);
	//#UC END# *51EFD26E03DF_461A1F2903C8*
}

// implemented method from NodeBase
// указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными
void FrozenNode_i::start_change_transaction () {
	//#UC START# *45EEB9590217_461A1F2903C8*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590217_461A1F2903C8*
}

// implemented method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType FrozenNode_i::get_type () const {
	//#UC START# *45EEB9590224_461A1F2903C8_GET*
	return m_type;
	//#UC END# *45EEB9590224_461A1F2903C8_GET*
}

void FrozenNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_461A1F2903C8_SET*
	GDS_ASSERT (false);
	//#UC END# *45EEB9590224_461A1F2903C8_SET*
}

// implemented method from SettingEntity
// Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой)
// объеков.
SettingEntity* FrozenNode_i::load_from_setting (PropertyID_const id) const {
	//#UC START# *45EECD5D02F1_461A1F2903C8*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EECD5D02F1_461A1F2903C8*
}

// implemented method from SettingEntity
// Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем.
// Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс.
void FrozenNode_i::save_in_setting (PropertyID_const id) const {
	//#UC START# *45EECD5D02EF_461A1F2903C8*
	SettingsManager_var settings = SettingsManagerFactory::make ();

	settings->set_long (const_cast<char*>((m_settings_root_id + id).data()), this->m_server_point);
	//#UC END# *45EECD5D02EF_461A1F2903C8*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

