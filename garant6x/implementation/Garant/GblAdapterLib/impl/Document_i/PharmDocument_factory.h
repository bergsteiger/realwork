////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmDocument
// Заголовк реализации фабрик интерфеса  для серванта PharmDocument
//
// Перапарат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDOCUMENT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDOCUMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PharmDocument
class PharmDocument_factory: virtual public ::Core::RefCountObjectBase, virtual public DocumentAbstractFactory {
public:
	PharmDocument_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const FactoryKey key () const;

	Document* make (GblPilot::Document* document);

	Document* make (const GCD::PID& pid, bool is_edition, const char* name);

};

typedef ::Core::Var<PharmDocument_factory> PharmDocument_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDOCUMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

