////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FlashDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::FlashDocument
// Заголовок реализации класса серванта для интерфеса 
//
// Документ-флеш
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FLASHDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FLASHDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class FlashDocument; // self forward Var
typedef ::Core::Var<FlashDocument> FlashDocument_var;
typedef ::Core::Var<const FlashDocument> FlashDocument_cvar;

class FlashDocument_factory;

// Документ-флеш
class FlashDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (FlashDocument)
	friend class FlashDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit FlashDocument (GblPilot::Document* document);

	FlashDocument (const GCD::PID& pid, const char* name);

	virtual ~FlashDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

	// overloaded method from Document
	// Получение флеш-ролика
	virtual ExternalObject* get_flash () const;

}; // class FlashDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FLASHDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
