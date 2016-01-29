////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Section_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::Section_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Section_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Section_i::Section_i (const char* name)
//#UC START# *455B0BE903C8_455B0C0500BB_455B1AB10196_BASE_INIT*
: m_name (name), m_state (IniConverter::PS_EXIST)
//#UC END# *455B0BE903C8_455B0C0500BB_455B1AB10196_BASE_INIT*
{
	//#UC START# *455B0BE903C8_455B0C0500BB_455B1AB10196_BODY*
	//#UC END# *455B0BE903C8_455B0C0500BB_455B1AB10196_BODY*
}

Section_i::Section_i (const char* name, IniConverter::ParameterState state)
//#UC START# *455B0BE903C8_45829B58001F_455B1AB10196_BASE_INIT*
: m_name (name), m_state (state)
//#UC END# *455B0BE903C8_45829B58001F_455B1AB10196_BASE_INIT*
{
	//#UC START# *455B0BE903C8_45829B58001F_455B1AB10196_BODY*
	//#UC END# *455B0BE903C8_45829B58001F_455B1AB10196_BODY*
}

Section_i::~Section_i () {
	//#UC START# *455B1AB10196_DESTR_BODY*
	//#UC END# *455B1AB10196_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Section
// добавить параметр в секцию
void Section_i::add_parameter (IniConverter::Parameter* parameter) {
	//#UC START# *455B33A6004E_455B1AB10196*
	ParameterTable::iterator it = m_parameters.find (parameter->get_name ());
	if (it == m_parameters.end ()) {
		m_parameters[parameter->get_name ()] = parameter;
		return;
	}

	IniConverter::Parameter_var auto_destroy (parameter);
	if (
		(it->second->get_state () == IniConverter::PS_COMMENTED) 
		&&  (parameter->get_state () == IniConverter::PS_EXIST)
	) {
		it->second->add_commented_value (it->second->get_value ());
		it->second->set_value (parameter->get_value ());
		it->second->set_state (IniConverter::PS_EXIST);
	} else if (
		(it->second->get_state () == IniConverter::PS_EXIST) 
		&&  (parameter->get_state () == IniConverter::PS_COMMENTED)
	) {
		it->second->add_commented_value (parameter->get_value ());
	} else if (
		(it->second->get_state () == IniConverter::PS_EXIST) 
		&&  (parameter->get_state () == IniConverter::PS_EXIST)
	) {
		std::cerr << "Two values for parameter " << it->first << " using first" << std::endl;
	}
	//#UC END# *455B33A6004E_455B1AB10196*
}

// implemented method from IniConverter::Section
// удалить параметр из секции
void Section_i::delete_parameter (const char* name) {
	//#UC START# *455B392D0119_455B1AB10196*
	m_parameters.erase (name);
	//#UC END# *455B392D0119_455B1AB10196*
}

// implemented method from IniConverter::Section
// получить параметр в заданной секции
IniConverter::Parameter* Section_i::get_cached_parameter (const char* name) {
	//#UC START# *45825C430261_455B1AB10196*
	ParameterTable::iterator it = m_parameters.find (name);
	return (it == m_parameters.end ()) ? 0 : it->second.ptr ();
	//#UC END# *45825C430261_455B1AB10196*
}

// implemented method from IniConverter::Section
// объеденить содержимое 2-ух секций (та, на которой зовётся операция имеет приоритет, её
// содержимое добавляется в аргумент)
void Section_i::merge (IniConverter::Section* section) {
	//#UC START# *45C6F5BC0280_455B1AB10196*
	for (ParameterTable::iterator it = m_parameters.begin (); it != m_parameters.end (); ++it) {
		IniConverter::Parameter_var my_parameter = it->second;
		IniConverter::Parameter* parameter = section->get_cached_parameter (it->first.c_str ());
		if (parameter) {
			// приоритет имеет значение из старого инишника
			parameter->set_value (my_parameter->get_value ());
			parameter->set_state (my_parameter->get_state ());

			const IniConverter::ValuesList& values = my_parameter->get_commented_values ();
			for (
				IniConverter::ValuesList::const_iterator it = values.begin ()
				; it != values.end ()
				; ++it
			) {
				parameter->add_commented_value (*it);
			}

		} else {
			section->add_parameter  (my_parameter._sretn ());
		}
	}
	//#UC END# *45C6F5BC0280_455B1AB10196*
}

// implemented method from IniConverter::Section
// имя секции
const std::string& Section_i::get_name () const {
	//#UC START# *455C35090109_455B1AB10196_GET*
	return m_name;
	//#UC END# *455C35090109_455B1AB10196_GET*
}

// implemented method from IniConverter::Section
// вывод информации в отладочных целях
void Section_i::print (std::ostream& stream) const {
	//#UC START# *45825C6602EE_455B1AB10196*
	if (m_state == IniConverter::PS_EXIST) {
		stream << m_name << std::endl;
		for (ParameterTable::const_iterator it = m_parameters.begin (); it != m_parameters.end (); ++it) {
			it->second->print (stream);
		}
	}
	//#UC END# *45825C6602EE_455B1AB10196*
}

// implemented method from IniConverter::Section
// состояние секции
IniConverter::ParameterState Section_i::get_state () const {
	//#UC START# *45829AC700AB_455B1AB10196_GET*
	return m_state;
	//#UC END# *45829AC700AB_455B1AB10196_GET*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

