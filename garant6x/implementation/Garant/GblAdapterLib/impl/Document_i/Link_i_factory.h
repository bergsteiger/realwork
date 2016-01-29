////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Link_i
// Заголовк реализации фабрик интерфеса Link для серванта Link_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINK_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINK_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Link_i
class Link_i_factory: virtual public ::Core::RefCountObjectBase, virtual public LinkAbstractFactory {
public:
	Link_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Link* make (unsigned long doc_id, const Topic& topic, RedactionID redaction_id);

	Link* make (const Document* document, unsigned long doc_id, const Topic& topic, RedactionID redaction_id);

};

typedef ::Core::Var<Link_i_factory> Link_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINK_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

