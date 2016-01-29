////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsContentsDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ActualAnalyticsContentsDocument
// Заголовок реализации класса серванта для интерфеса 
//
// ААК-содержание
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ACTUALANALYTICSCONTENTSDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ACTUALANALYTICSCONTENTSDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class ActualAnalyticsContentsDocument; // self forward Var
typedef ::Core::Var<ActualAnalyticsContentsDocument> ActualAnalyticsContentsDocument_var;
typedef ::Core::Var<const ActualAnalyticsContentsDocument> ActualAnalyticsContentsDocument_cvar;

class ActualAnalyticsContentsDocument_factory;

// ААК-содержание
class ActualAnalyticsContentsDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (ActualAnalyticsContentsDocument)
	friend class ActualAnalyticsContentsDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ActualAnalyticsContentsDocument (const GCD::PID& pid, const char* name);

	explicit ActualAnalyticsContentsDocument (GblPilot::Document* document);

	virtual ~ActualAnalyticsContentsDocument ();


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

}; // class ActualAnalyticsContentsDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_ACTUALANALYTICSCONTENTSDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
