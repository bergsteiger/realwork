////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseInitialValue.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseInitialValue
//
// дампер значечений начальных значений (используетс€ дл€ вывода начальных значений атрибутов и
// параметров операций)
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseInitialValue.h"
// by <<uses>> dependencies
#include "boost/regex.hpp"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *473D50220261_CUSTOM_INCLUDES*
//#UC END# *473D50220261_CUSTOM_INCLUDES*


//#UC START# *473D50220261*
bool RoseInitialValue::operator == (const AbstractDumperBase& c) const {

	return get_name_str() == c.get_name_str() 
		&& (get_target() != 0 && c.get_target() != 0 && *get_target() == *c.get_target());
}
//#UC END# *473D50220261*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// parent - родитель элемента-значени€ по-умолчанию
RoseInitialValue::RoseInitialValue (RoseAbstractDumper* parent)
//#UC START# *473D543901A5_BASE_INIT*
: m_parent (parent), m_type (0)
//#UC END# *473D543901A5_BASE_INIT*
{
	//#UC START# *473D543901A5_BODY*
	//#UC END# *473D543901A5_BODY*
}

RoseInitialValue::~RoseInitialValue () {
	//#UC START# *473D50220261_DESTR_BODY*
	//#UC END# *473D50220261_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ¬ыполн€етс€ св€зывание значени€ по-умолчанию с конкретным типом. “ип определ€етс€ по следующему
// алгоритму: если строка, соответствующа€ значению по-умолчанию записана в формате: [VALUE], то на
// модели ищетс€ элемент с именем VALUE, и с ним св€зываетс€ родитель элемента - значение по
// умолчанию (дл€ правильной сортировки по зависимости), тип значени€-по-умолчанию устанавливаетс€
// равным типу элемента VALUE, в качестве значени€ по-умолчанию устанавливаетс€ строка: VALUE. ≈сли
// же формат строки иной, то тип значени€-поумолчанию устанавливаетс€ равным типу родительского
// элемента.
// в параметр value - записываетс€ строка значение по умолчанию.
void RoseInitialValue::link (std::string& value) {
	//#UC START# *4770A1E20360*
	GDS_ASSERT(m_parent);

	static const std::string delimeter ("::");
	static boost::regex exp ("^\\w+::.*");
	boost::smatch match;

	if (boost::regex_match (value, match, exp)) {
		std::string::size_type pos = value.find_last_of (delimeter);

		if (pos != std::string::npos) {
			std::string type = value.substr (0, pos - 1);
			m_init_value= value.substr (pos + delimeter.size () - 1);
			if (type.empty () == false) {
				const RoseAbstractDumper* init_value_supl = m_parent->resolve (type);
				if (init_value_supl) {
					value = type + "::" + m_init_value;
					m_type = const_cast<RoseAbstractDumper*> (init_value_supl);
					m_parent->add_supplier (init_value_supl, ObjectTreeResolver::ST_NOT_NAVIGABLE, ST_INIT_VALUE);
				}
			} else {
				m_type = m_parent->get_target ();
			}
		} else {
			m_init_value = value;
			m_type = m_parent->get_target ();
		}
	} else {
		m_init_value = value;
		m_type = m_parent->get_target ();
	}
	
/*	static boost::regex init_exp ("^\\{(.+)\\}");
	boost::smatch match;
	
	if (boost::regex_match (value, match, init_exp)) {
		std::string type (match[1].first, match[1].second);
		
		const RoseAbstractDumper* init_value_supl = m_parent->resolve_ex (type);
		if (init_value_supl) {
			value = "{";
			value += type;
			value += "}";
						

			if (init_value_supl->rose_element ()->IsClass (ATTRIBUTE_TYPE)) {
				//m_type = init_value_supl->get_target ();
				m_init_value = init_value_supl->get_name_str ();
				IRoseElementPtr attr_container = RoseHelper::get_nearest_container (init_value_supl->rose_element ());
				init_value_supl = RoseAbstractDumper::find_in_tree(attr_container);
			} else {
				m_init_value = init_value_supl->get_name_str ();
			}
			m_type = const_cast<RoseAbstractDumper*> (init_value_supl);
			if (init_value_supl) {
				m_parent->add_supplier (init_value_supl, ObjectTreeResolver::ST_NOT_NAVIGABLE, ST_INIT_VALUE);
			}
		}
	} else {
		m_init_value = value;
		m_type = m_parent->get_target ();
	}*/
	//#UC END# *4770A1E20360*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает им€
const std::string RoseInitialValue::get_name_str () const {
	//#UC START# *466554D9006D_473D50220261*
	return m_init_value;
	//#UC END# *466554D9006D_473D50220261*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает класс
const std::string RoseInitialValue::get_model_class_str () const {
	//#UC START# *465EA35D005D_473D50220261*
	return "InitialValue";
	//#UC END# *465EA35D005D_473D50220261*
}

// overloaded method from AbstractDumperBase
// возвращает цель
AbstractDumperBase* RoseInitialValue::get_target () const {
	//#UC START# *466554FF030D_473D50220261*
	return m_type;
	//#UC END# *466554FF030D_473D50220261*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

