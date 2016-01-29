////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DictDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DictDocument
// Заголовок реализации класса серванта для интерфеса 
//
// Документ - толкование толкового словаря
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DICTDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DICTDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class DictDocument; // self forward Var
typedef ::Core::Var<DictDocument> DictDocument_var;
typedef ::Core::Var<const DictDocument> DictDocument_cvar;

class DictDocument_factory;

// Документ - толкование толкового словаря
class DictDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (DictDocument)
	friend class DictDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit DictDocument (GblPilot::Document* document);

	DictDocument (const GCD::PID& pid, const char* name);

	virtual ~DictDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

}; // class DictDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DICTDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
