////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::VariantsForDocFilter_i
// Заголовок реализации класса серванта для интерфеса VariantsForDocFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTSFORDOCFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTSFORDOCFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class VariantsForDocFilter_i; // self forward Var
typedef ::Core::Var<VariantsForDocFilter_i> VariantsForDocFilter_i_var;
typedef ::Core::Var<const VariantsForDocFilter_i> VariantsForDocFilter_i_cvar;

class VariantsForDocFilter_i_factory;

class VariantsForDocFilter_i:
	virtual public VariantsForDocFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (VariantsForDocFilter_i)
	friend class VariantsForDocFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	VariantsForDocFilter_i (unsigned long doc_id);

	VariantsForDocFilter_i ();

	virtual ~VariantsForDocFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	unsigned long m_doc_id;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from VariantsForDocFilter
	// идентификатор документа
	virtual const unsigned long get_doc_id () const;
}; // class VariantsForDocFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTSFORDOCFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
