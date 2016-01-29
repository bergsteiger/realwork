////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionViewContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionViewContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionViewContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const TransitionViewContent& item) {
	out_stream << "{" << std::endl;
	if (item.properties ().empty () == false) {
		PropertyList::const_iterator it = item.get_properties ().begin ();
		PropertyList::const_iterator it_end = item.get_properties ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.param_views ().empty () == false) {
		ParamViewList::const_iterator it = item.get_param_views ().begin ();
		ParamViewList::const_iterator it_end = item.get_param_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.stereotype_views ().empty () == false) {
		StereotypeViewList::const_iterator it = item.get_stereotype_views ().begin ();
		StereotypeViewList::const_iterator it_end = item.get_stereotype_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const PropertyList& TransitionViewContent::get_properties () const {
	//#UC START# *48ABFEFE0272_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48ABFEFE0272_GET_ACCESSOR*
}

void TransitionViewContent::set_properties (const PropertyList& properties) {
	//#UC START# *48ABFEFE0272_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48ABFEFE0272_SET_ACCESSOR*
}

const ParamViewList& TransitionViewContent::get_param_views () const {
	//#UC START# *48ACED8400F0_GET_ACCESSOR*
	return m_param_views;
	//#UC END# *48ACED8400F0_GET_ACCESSOR*
}

void TransitionViewContent::set_param_views (const ParamViewList& param_views) {
	//#UC START# *48ACED8400F0_SET_ACCESSOR*
	m_param_views = param_views;
	//#UC END# *48ACED8400F0_SET_ACCESSOR*
}

const StereotypeViewList& TransitionViewContent::get_stereotype_views () const {
	//#UC START# *48ACED8700D0_GET_ACCESSOR*
	return m_stereotype_views;
	//#UC END# *48ACED8700D0_GET_ACCESSOR*
}

void TransitionViewContent::set_stereotype_views (const StereotypeViewList& stereotype_views) {
	//#UC START# *48ACED8700D0_SET_ACCESSOR*
	m_stereotype_views = stereotype_views;
	//#UC END# *48ACED8700D0_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

