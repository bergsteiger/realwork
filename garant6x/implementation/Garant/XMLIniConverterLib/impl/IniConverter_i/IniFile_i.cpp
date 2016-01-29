////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::IniFile_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"
// by <<uses>> dependencies
#include <fstream>
#include <algorithm>
#include <algorithm>
#include "shared/GCL/str/str_op.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IniFile_i::IniFile_i (const char* filename)
//#UC START# *455B0BA20232_455B0BC60148_455B363A033C_BASE_INIT*
//#UC END# *455B0BA20232_455B0BC60148_455B363A033C_BASE_INIT*
{
	//#UC START# *455B0BA20232_455B0BC60148_455B363A033C_BODY*
	std::ifstream ini_file (filename);

	if (!ini_file) {
		std::cerr << "Error: can't read file " << filename << std::endl;
		throw IniConverter::FileReadingError ();
	}
	const size_t max_string_size = 1024;
	char buffer[max_string_size];
	size_t i = 0;
	while (ini_file.getline (buffer, max_string_size)) {
		std::string result = GCL::trim_ws (buffer);
		if (!result.empty ()) {
			this->add_string (result);
		}
	}

	m_file_name = filename;
	//#UC END# *455B0BA20232_455B0BC60148_455B363A033C_BODY*
}

IniFile_i::~IniFile_i () {
	//#UC START# *455B363A033C_DESTR_BODY*
	//#UC END# *455B363A033C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить комментарий
void IniFile_i::add_comment (const std::string& buffer) {
	//#UC START# *45C2F44E0196*
	// если комментарий в начале файла, просто сохраняем его
	if (!m_current_section.ptr ()) {
		m_file_comment += buffer + "\n";
	}

	size_t i = 0;
	for (; i < buffer.size (); ++i) {
		if (buffer[i] != IniConverter::COMMENT_CHAR) {
			break;
		}
	}
	if (i == (buffer.size () - 1)) {
		std::cerr << "bad comments: only " << IniConverter::COMMENT_CHAR << " symbols" << std::endl;
		return;
	}
	std::string uncommented = buffer.substr(i);
	
	// закомментированная секция, пока никак не обрабатываем
	if (uncommented[0] == '[') {
		return;
	} else {
		// TODO: пока считаем, что комментарий - это параметр, нужно подумать, можно ли различать
		// комментарии и параметры
		this->add_parameter (uncommented, IniConverter::PS_COMMENTED);
	}
	//#UC END# *45C2F44E0196*
}

// добавить параметр
void IniFile_i::add_parameter (const std::string& buffer, IniConverter::ParameterState state) {
	//#UC START# *455C312C0157*
	if (!m_current_section.ptr ()) {
		std::cerr << "can't add parameter " << buffer << " without section" <<std::endl;
		return;
	}
	std::string name;
	std::string value;
	std::string delimiter ("=");
	this->get_name_and_value_by_string (buffer, delimiter, name, value);
	if (name.empty ()) {
		delimiter = " ";
		this->get_name_and_value_by_string (buffer, delimiter, name, value);
		if (name.empty ()) {
			delimiter.clear ();
			name = buffer;
		}
	}
	m_current_section->add_parameter (IniConverter::ParameterFactory::make (name.c_str (), value.c_str (), state, delimiter.c_str ()));
	//#UC END# *455C312C0157*
}

// добавить секцию
void IniFile_i::add_section (const std::string& buffer) {
	//#UC START# *455C2F4D0186*
	if (buffer[buffer.size () - 1] != ']') {
		std::cerr << "bad section name: " <<  buffer;
	} else {
		SectionTable::iterator it = std::find_if (m_sections.begin (), m_sections.end (), IsSectionName (buffer.c_str ()));
		if (it == m_sections.end ()) {
			m_current_section = IniConverter::SectionFactory::make (buffer.c_str ());
			m_sections.push_back (m_current_section);
		} else {
			m_current_section = *it;
		}
	}
	//#UC END# *455C2F4D0186*
}

// разобрать очередную строку из ini файла
void IniFile_i::add_string (const std::string& buffer) {
	//#UC START# *455C2DD902DE*
	switch (buffer[0]) {
		case IniConverter::COMMENT_CHAR:
			// comment
			this->add_comment (buffer);
			break;
		case '[':
			// section
			this->add_section (buffer);
			break;
		default:
			// parameter
			this->add_parameter (buffer, IniConverter::PS_EXIST);
			break;
	}
	//#UC END# *455C2DD902DE*
}

// разобрать строку на имя и значение параметра
void IniFile_i::get_name_and_value_by_string (
	const std::string& buffer
	, const std::string& delimiter
	, std::string& name
	, std::string& value
) const {
	//#UC START# *455D7CFC00CB*
	std::string::size_type delimiter_position = buffer.find_first_of (delimiter);

	if (delimiter_position != std::string::npos) {
		name = buffer.substr (0, delimiter_position);
		value = buffer.substr (delimiter_position + 1);
	}
	//#UC END# *455D7CFC00CB*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::IniFile
// добавить секцию в инишник
void IniFile_i::add_section (IniConverter::Section* section) {
	//#UC START# *45C6FB5E0119_455B363A033C*
	m_sections.push_back (section);
	//#UC END# *45C6FB5E0119_455B363A033C*
}

// implemented method from IniConverter::IniFile
// удалить секцию из инишника
void IniFile_i::delete_section (const char* name) {
	//#UC START# *45C3468F02FD_455B363A033C*
	m_sections.erase (
		std::remove_if (m_sections.begin (), m_sections.end (), IsSectionName (name))
		, m_sections.end ()
	);
	//#UC END# *45C3468F02FD_455B363A033C*
}

// implemented method from IniConverter::IniFile
// получить параметр по секции и имени
IniConverter::Parameter* IniFile_i::get_cached_parameter (const char* section_name, const char* parameter_name) {
	//#UC START# *455B325702FD_455B363A033C*
	IniConverter::Section* section = this->get_cached_section (section_name);
	if (section) {
		return section->get_cached_parameter (parameter_name);
	}

	return 0;
	//#UC END# *455B325702FD_455B363A033C*
}

// implemented method from IniConverter::IniFile
// получить секцию по имени
IniConverter::Section* IniFile_i::get_cached_section (const char* name) {
	//#UC START# *455B0BDA00DA_455B363A033C*
	SectionTable::iterator it = std::find_if (m_sections.begin (), m_sections.end (), IsSectionName (name));

	return (it != m_sections.end ()) ? (*it).ptr () : 0;
	//#UC END# *455B0BDA00DA_455B363A033C*
}

// implemented method from IniConverter::IniFile
// объеденить содержимое 2-ух инишников (тот, на котором зовётся операция имеет приоритет, его
// содержимое добавляется в аргумент)
void IniFile_i::merge (IniConverter::IniFile* inifile) {
	//#UC START# *45C6F16E01E4_455B363A033C*
	if (!m_file_comment.empty ()) {
		inifile->set_comment (m_file_comment);
	}
	for (SectionTable::iterator it = m_sections.begin (); it != m_sections.end (); ++it) {
		IniConverter::Section* section = inifile->get_cached_section ((*it)->get_name ().c_str ());
		if (section) {
			(*it)->merge (section);
		} else {
			inifile->add_section (it->_sretn ());
		}
	}
	//#UC END# *45C6F16E01E4_455B363A033C*
}

// implemented method from IniConverter::IniFile
// вывод инифайла в поток
void IniFile_i::print (std::ostream& stream) const {
	//#UC START# *45825BDE033C_455B363A033C*
	if (!m_file_comment.empty ()) {
		stream << this->m_file_comment << std::endl;
	}
	for (SectionTable::const_iterator it = m_sections.begin (); it != m_sections.end (); ++it) {
		(*it)->print (stream);
		stream << std::endl;
	}
	//#UC END# *45825BDE033C_455B363A033C*
}

// implemented method from IniConverter::IniFile
// устанавливает комментарий к файлу (только в том случае, если он ещё не установлен)
void IniFile_i::set_comment (const std::string& comment) {
	//#UC START# *45C703B10222_455B363A033C*
	if (m_file_comment.empty ()) {
		m_file_comment = comment;
	}
	//#UC END# *45C703B10222_455B363A033C*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

