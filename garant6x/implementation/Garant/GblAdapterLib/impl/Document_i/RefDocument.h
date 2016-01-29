////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/RefDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::RefDocument
// Заголовок реализации класса серванта для интерфеса 
//
// Документ с http ссылками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_REFDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_REFDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"

namespace GblAdapterLib {

class RefDocument; // self forward Var
typedef ::Core::Var<RefDocument> RefDocument_var;
typedef ::Core::Var<const RefDocument> RefDocument_cvar;

class RefDocument_factory;

// Документ с http ссылками
class RefDocument:
	virtual public SimpleDocument
{
	SET_OBJECT_COUNTER (RefDocument)
	friend class RefDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RefDocument (const GCD::PID& pid, const char* name);

	explicit RefDocument (GblPilot::Document* document);

	virtual ~RefDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

}; // class RefDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_REFDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
