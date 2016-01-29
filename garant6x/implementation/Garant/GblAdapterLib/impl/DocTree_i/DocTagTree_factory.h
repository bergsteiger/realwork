////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagTree_factory.h"
// C++ Interface Factories header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocTagTree
// Заголовк реализации фабрик интерфеса Tree для серванта DocTagTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCTAGTREE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCTAGTREE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagTree.h"

namespace GblAdapterLib {

/// Servant-factory implementation for DocTagTree
class DocTagTreeServantFactory {
	friend class FAKE;

	static DocTagTree* make (GTree::Tree* tree, bool optimize_for_everest);

};


} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCTAGTREE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

