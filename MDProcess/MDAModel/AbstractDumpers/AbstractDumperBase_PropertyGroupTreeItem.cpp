////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase_PropertyGroupTreeItem.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase::PropertyGroupTreeItem
//
// группа свойств - элемент дерева, объединяет (группирует) пользовательские свойства
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
// by <<uses>> dependencies
#include "shared/GCL/data/StaticNodeIterator.h"

class AbstractDumperBase;
//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation

const char* AbstractDumperBase::PropertyGroupTreeItem::PropertyAlreadyExist::uid () const /*throw ()*/ {
	return "D48D7C1D-FD4D-4CA6-9B64-A07A41373573";
}

const char* AbstractDumperBase::PropertyGroupTreeItem::PropertyAlreadyExist::what () const throw () {
	//#UC START# *4701DC4102DE_WHAT_IMPL*
	return "PropertyAlreadyExist (Исключение возникает при попытке добавить в группу свойство, уже присутствующее в другой группе. В пределах одного дерева имена свойств должны быть уникальны.)";
	//#UC END# *4701DC4102DE_WHAT_IMPL*
}



//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// метод для копирования узла дерева
AbstractDumperBase::PropertyGroupTreeItem* AbstractDumperBase::PropertyGroupTreeItem::make_copy (const PropertyGroupTreeItem* source) {
	//#UC START# *47008DB10157*
	Core::Var<PropertyGroupTreeItem> ret = new PropertyGroupTreeItem (source->get_name());
	ret->m_user_properties = source->m_user_properties;
	return ret._retn();
	//#UC END# *47008DB10157*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор.
// \group_name - имя группы
AbstractDumperBase::PropertyGroupTreeItem::PropertyGroupTreeItem (const std::string& group_name)
//#UC START# *46FB9E57029F_BASE_INIT*
: m_group_name (group_name)
//#UC END# *46FB9E57029F_BASE_INIT*
{
	//#UC START# *46FB9E57029F_BODY*	
	//#UC END# *46FB9E57029F_BODY*
}

AbstractDumperBase::PropertyGroupTreeItem::~PropertyGroupTreeItem () {
	//#UC START# *46FB9E22002E_DESTR_BODY*
	//#UC END# *46FB9E22002E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет свойство в список, если свойство уже есть - перезаписывает его
void AbstractDumperBase::PropertyGroupTreeItem::add_property (
	const std::string& name
	, const UserPropertyData& data
) /*throw (
	PropertyAlreadyExist
)*/ {
	//#UC START# *46FBA02E029F*
	class local {
	public:
		//ищем свойство с именнем name, возвращаем группу, в которой найденно это свойство
		static void find_group (
			const std::string& name
			, PropertyGroupTreeItem* source
			, PropertyGroupTreeItem*& group
		) {
			GDS_ASSERT(source);
			GCL::StaticNodeIterator it (source);
			for (
				PropertyGroupTreeItem_var next = dynamic_cast<PropertyGroupTreeItem*>(it.get_next ())
				; next.is_nil () == false
				; next = dynamic_cast<PropertyGroupTreeItem*>(it.get_next ())
			) {
				const AbstractDumperBase::UserPropertyMap& ch_props =  next->get_properties ();
				if (ch_props.find (name) != ch_props.end ()) {
					group = next._sretn ();
					break;
				}
			}
			/*PropertyGroupTreeItem* source_ch = dynamic_cast<PropertyGroupTreeItem*>(source->m_last_child);			
			while (source_ch && !group) {
				const AbstractDumperBase::UserPropertyMap& ch_props =  source_ch->get_properties ();
				if (ch_props.find (name) != ch_props.end ()) {
					group = PropertyGroupTreeItem::_duplicate (source_ch);
				}
				source_ch = dynamic_cast<PropertyGroupTreeItem*>(source_ch->m_prev);
			};*/
		}
	};
	PropertyGroupTreeItem_var group;
	PropertyGroupTreeItem_var root = dynamic_cast<PropertyGroupTreeItem*> (this->root ());
	local::find_group (name, root.in (), group.out ());
	if (group.is_nil () || group.ptr () == this) {
		m_user_properties[name] = data;		
	} else {
		//group->m_user_properties[name] = data;
		std::string mess ("Properties tree already have property with name: \"");
		mess += name;
		mess += "\" in group: \"";
		mess += group->get_name ();
		mess += "\"";
		LOG_E ((mess.c_str ()));
		throw PropertyAlreadyExist ();
	}
	//#UC END# *46FBA02E029F*
}

// возвращает имя группы
const std::string& AbstractDumperBase::PropertyGroupTreeItem::get_name () const {
	//#UC START# *46FBA41402CE*
	return m_group_name;
	//#UC END# *46FBA41402CE*
}

// возвращает свойства в группе
const AbstractDumperBase::UserPropertyMap& AbstractDumperBase::PropertyGroupTreeItem::get_properties () const {
	//#UC START# *46FBA07C02AF*
	return m_user_properties;
	//#UC END# *46FBA07C02AF*
}

// Добавляет свойства, азданные диапазоном итераторов. Если свойство уде существует, то ничего не
// делаем (никаких исключений не летит)
void AbstractDumperBase::PropertyGroupTreeItem::insert_properties (
	const UserPropertyMap::const_iterator& begin
	, const UserPropertyMap::const_iterator& end
) {
	//#UC START# *471D822F0399*
	UserPropertyMap::const_iterator it_begin = begin;
	UserPropertyMap::const_iterator it_end = end;

	m_user_properties.insert (it_begin, it_end);
	//#UC END# *471D822F0399*
}

// т.к имена свойств в пределах стереотипа должны быть уникальными - нужно проверить нет ли уже в
// дереве свойства с именем prop_name, если нет - возвращает false, иначе true
bool AbstractDumperBase::PropertyGroupTreeItem::is_exists (const std::string& prop_name) const {
	//#UC START# *46FC74480157*
	bool res = false;
	PropertyGroupTreeItem_var root = dynamic_cast<PropertyGroupTreeItem*> (
		const_cast<PropertyGroupTreeItem*> (this)->root ()
	);
	GCL::StaticNodeIterator it (root.in ());
	for (
		PropertyGroupTreeItem_var next = dynamic_cast<PropertyGroupTreeItem*>(it.get_next ())
		; next.is_nil () == false
		; next = dynamic_cast<PropertyGroupTreeItem*>(it.get_next ())
	) {
		const AbstractDumperBase::UserPropertyMap& ch_props =  next->get_properties ();
		if (
			ch_props.find (prop_name) != ch_props.end ()
			&& next.ptr () != this
		) {
			res = true;
			break;
		}
	}	
	return res;
	//#UC END# *46FC74480157*
}

// устанавливает имя группы
void AbstractDumperBase::PropertyGroupTreeItem::set_name (const std::string& name) {
	//#UC START# *471D81FE02FD*
	m_group_name = name;
	//#UC END# *471D81FE02FD*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

