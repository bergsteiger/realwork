////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ActualAnalyticsDocument
// Заголовок реализации класса серванта для интерфеса 
//
// ААК
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ACTUALANALYTICSDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ACTUALANALYTICSDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class ActualAnalyticsDocument; // self forward Var
typedef ::Core::Var<ActualAnalyticsDocument> ActualAnalyticsDocument_var;
typedef ::Core::Var<const ActualAnalyticsDocument> ActualAnalyticsDocument_cvar;

class ActualAnalyticsDocument_factory;

// ААК
class ActualAnalyticsDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (ActualAnalyticsDocument)
	friend class ActualAnalyticsDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ActualAnalyticsDocument (const GCD::PID& pid, const char* name);

	explicit ActualAnalyticsDocument (GblPilot::Document* document);

	virtual ~ActualAnalyticsDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

	// overloaded method from Document_i
	virtual DocumentTextProvider* make_text_provider (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	) const;

}; // class ActualAnalyticsDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ACTUALANALYTICSDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
