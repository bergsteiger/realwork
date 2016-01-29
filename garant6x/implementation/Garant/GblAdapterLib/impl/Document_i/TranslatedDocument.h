////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::TranslatedDocument
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TRANSLATEDDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TRANSLATEDDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"

namespace GblAdapterLib {

class TranslatedDocument; // self forward Var
typedef ::Core::Var<TranslatedDocument> TranslatedDocument_var;
typedef ::Core::Var<const TranslatedDocument> TranslatedDocument_cvar;

class TranslatedDocument_factory;
class TranslatedDocumentServantFactory;

class TranslatedDocument:
	virtual public SimpleDocument
{
	SET_OBJECT_COUNTER (TranslatedDocument)
	friend class TranslatedDocument_factory; // self factory
	friend class TranslatedDocumentServantFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit TranslatedDocument (GblPilot::Document* document);

	virtual ~TranslatedDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	// Присутствие предупреждения.
	virtual bool has_warning () const;

	// overloaded method from Document
	// Предупреждение к документу.
	virtual const GCI::IO::String& get_warning () const;
	virtual GCI::IO::String& get_warning ();

}; // class TranslatedDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TRANSLATEDDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
