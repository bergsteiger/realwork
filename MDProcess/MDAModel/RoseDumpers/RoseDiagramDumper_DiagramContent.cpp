////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper_DiagramContent.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseDiagramDumper::DiagramContent
//
// класс представляют собой содержимое диаграммы (координаты и размеры
// элементов на ней) позволяет загружать сохраненное содержимое из
// строки и сохранять в строковом виде
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"

class RoseDiagramDumper;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// ctor загружает хранилище из строки
RoseDiagramDumper::DiagramContent::DiagramContent (const std::string& str)
//#UC START# *467B66B90399_BASE_INIT*
//#UC END# *467B66B90399_BASE_INIT*
{
	//#UC START# *467B66B90399_BODY*
	if (str != "") {
		this->load (str);
	}
	//#UC END# *467B66B90399_BODY*
}

RoseDiagramDumper::DiagramContent::~DiagramContent () {
	//#UC START# *467B64B702DE_DESTR_BODY*
	//#UC END# *467B64B702DE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает свойство key, для элемента guid
const std::string RoseDiagramDumper::DiagramContent::get_property (
	const std::string& guid
	, const std::string& key
) const {
	//#UC START# *467B671E032C*	
	std::string ret;
	PropertyMap::const_iterator guid_it = m_properties.find (guid);
	if (guid_it != m_properties.end ()) {
		Properties::const_iterator prop_it = guid_it->second.find (key);
		if (prop_it != guid_it->second.end ()) {
			ret = prop_it->second;
		}
	}
	return ret;
	//#UC END# *467B671E032C*
}

// загружает хранилище из строки
void RoseDiagramDumper::DiagramContent::load (const std::string& str) {
	//#UC START# *467B66EC0261*
	m_properties.clear ();
	GCL::StrSet contents = GCL::split_string_by_sub_string_uniq (str.c_str (), ";");
	for (GCL::StrSet::iterator it = contents.begin (); it != contents.end (); ++it) {
		std::string::size_type pos = it->find_first_of (":");
		GDS_ASSERT_MSG (pos != std::string::npos, ("Wrong diagram contens"));
		std::string guid = GCL::trim_ws (it->substr (0, pos).c_str ());
		std::string property_str = GCL::trim_ws (it->substr (pos + 1).c_str ());
		GCL::StrSet properties = GCL::split_string_by_sub_string_uniq (property_str.c_str (), ",");
		
		Properties properties_map;
		for (GCL::StrSet::iterator prop_it = properties.begin (); prop_it != properties.end (); ++prop_it) {
			std::string::size_type prop_pos = prop_it->find_first_of ("=");
			GDS_ASSERT_MSG (prop_pos != std::string::npos, ("Wrong diagram contens"));
			std::string prop_key = GCL::trim_ws (prop_it->substr (0, prop_pos).c_str ());
			std::string prop_value = GCL::trim_ws (prop_it->substr (prop_pos + 1).c_str ());
			properties_map[prop_key] = prop_value;
		}
		m_properties[guid] = properties_map;
	}
	//#UC END# *467B66EC0261*
}

// сохраняет хранилище в строку
const std::string RoseDiagramDumper::DiagramContent::save () const {
	//#UC START# *467B67AC0222*
	GCL::StrSet contents;
	for (
		PropertyMap::const_iterator guid_it = m_properties.begin ()
		; guid_it != m_properties.end ()
		; ++guid_it
	) {
		std::string guid = guid_it->first;
		GCL::StrSet properties;
		for (
			Properties::const_iterator prop_it = guid_it->second.begin ()
			; prop_it != guid_it->second.end ()
			; ++prop_it
		) {
			std::string prop = prop_it->first + "=" + prop_it->second;
			properties.insert (prop);
		}
		std::string properties_str = GCL::merge_string_and_sub_string (properties, ",");
		std::string content_str = guid + ":" + properties_str;
		contents.insert (content_str);
	}
	std::string ret = GCL::merge_string_and_sub_string (contents, ";");
	return ret;
	//#UC END# *467B67AC0222*
}

// записывает свойство key со значением value для элемента guid
void RoseDiagramDumper::DiagramContent::set_property (
	const std::string& guid
	, const std::string& key
	, const std::string& value
) {
	//#UC START# *467B675903C8*
	m_properties[guid].insert (Properties::value_type (key, value));
	//#UC END# *467B675903C8*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

