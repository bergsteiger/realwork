////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmFirmDocument_i
// Заголовок реализации класса серванта для интерфеса 
//
// Фирма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMFIRMDOCUMENT_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMFIRMDOCUMENT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"

namespace GblAdapterLib {

class PharmFirmDocument_i; // self forward Var
typedef ::Core::Var<PharmFirmDocument_i> PharmFirmDocument_i_var;
typedef ::Core::Var<const PharmFirmDocument_i> PharmFirmDocument_i_cvar;

class PharmFirmDocument_i_factory;

// Фирма
class PharmFirmDocument_i:
	virtual public SimpleDocument
{
	SET_OBJECT_COUNTER (PharmFirmDocument_i)
	friend class PharmFirmDocument_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PharmFirmDocument_i (const GCD::PID& pid, const char* name);

	explicit PharmFirmDocument_i (GblPilot::Document* document);

	virtual ~PharmFirmDocument_i ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual const NodeBase* get_attributes_root () const;
	virtual NodeBase* get_attributes_root ();

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

	// overloaded method from Document
	// Получить список выпускаемых фирмой препаратов
	virtual CatalogBase* get_drug_list () const /*throw (CanNotFindData)*/;

	// overloaded method from Document
	// Проверка возможности отображения атрибутов документа для текущего документа.
	// Возвращает true в случае, если показ атрибутов разрешен.
	// 
	// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции
	// )
	virtual bool may_show_attributes () const;

}; // class PharmFirmDocument_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMFIRMDOCUMENT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
