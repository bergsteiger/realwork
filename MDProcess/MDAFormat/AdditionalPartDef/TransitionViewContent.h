////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionViewContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionViewContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONVIEWCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONVIEWCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ParamView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StereotypeView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class TransitionViewContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const ParamViewList& get_param_views () const;

	void set_param_views (const ParamViewList& param_views);

	const StereotypeViewList& get_stereotype_views () const;

	void set_stereotype_views (const StereotypeViewList& stereotype_views);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	PropertyList m_properties;

	ParamViewList m_param_views;

	StereotypeViewList m_stereotype_views;


}; //class TransitionViewContent

std::ostream& operator << (std::ostream& out_stream, const TransitionViewContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONVIEWCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
