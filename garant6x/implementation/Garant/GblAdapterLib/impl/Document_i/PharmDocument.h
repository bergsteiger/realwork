////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmDocument
// Заголовок реализации класса серванта для интерфеса 
//
// Перапарат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class PharmDocument; // self forward Var
typedef ::Core::Var<PharmDocument> PharmDocument_var;
typedef ::Core::Var<const PharmDocument> PharmDocument_cvar;

class PharmDocument_factory;

// Перапарат
class PharmDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (PharmDocument)
	friend class PharmDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit PharmDocument (GblPilot::Document* document);

	PharmDocument (const GCD::PID& pid, const char* name);

	virtual ~PharmDocument ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable boost::tribool m_has_same;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

	// overloaded method from Document
	// Получить список похожих документов
	virtual void get_same_documents (CatalogBase*& out_list) const;

	// overloaded method from Document
	// Проверка наличия похожих документов
	virtual bool has_same_documents () const;
private:

	// overloaded method from BaseUpdateChecker_i
	virtual void clear_cache ();

}; // class PharmDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
