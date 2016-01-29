////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::BookDocument
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class BookDocument; // self forward Var
typedef ::Core::Var<BookDocument> BookDocument_var;
typedef ::Core::Var<const BookDocument> BookDocument_cvar;

class BookDocument_factory;

class BookDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (BookDocument)
	friend class BookDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BookDocument (const GCD::PID& pid, const char* name);

	explicit BookDocument (GblPilot::Document* document);

	virtual ~BookDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

}; // class BookDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
