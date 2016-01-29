////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocNodeFilter_i
// Заголовок реализации класса серванта для интерфеса DocNodeFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree.h"

namespace GblAdapterLib {

class DocNodeFilter_i; // self forward Var
typedef ::Core::Var<DocNodeFilter_i> DocNodeFilter_i_var;
typedef ::Core::Var<const DocNodeFilter_i> DocNodeFilter_i_cvar;

class DocNodeFilter_i_factory;

class DocNodeFilter_i:
	virtual public DocNodeFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DocNodeFilter_i)
	friend class DocNodeFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DocNodeFilter_i ();

	virtual ~DocNodeFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	TagHandle m_id;

	bool m_inheritable;

	NodeType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocNodeFilter
	virtual TagHandle get_id () const;

	virtual void set_id (TagHandle id);

	// implemented method from DocNodeFilter
	virtual bool get_inheritable () const;

	virtual void set_inheritable (bool inheritable);

	// implemented method from DocNodeFilter
	virtual NodeType get_type () const;

	virtual void set_type (NodeType type);
}; // class DocNodeFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
