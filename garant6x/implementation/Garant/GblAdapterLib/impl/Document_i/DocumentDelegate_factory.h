////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentDelegate
// Заголовк реализации фабрик интерфеса  для серванта DocumentDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTDELEGATE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTDELEGATE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate.h"

/// Servant-factory implementation for DocumentDelegate
namespace GblAdapterLib {
	class Document_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DocumentDelegateServantFactory {
	friend class Document_i;

	static DocumentDelegate* make (GblPilot::Document* document);

	static DocumentDelegate* make (const GCD::PID& pid, bool is_edition, const char* name);

	static DocumentDelegate* make (DocumentMaster* master, DocumentState_i* new_state);
};

/// Interface-factory implementation for DocumentDelegate
class DocumentDelegate_factory: virtual public ::Core::RefCountObjectBase, virtual public DocumentAbstractFactory {
	friend class DocumentDelegateServantFactory;

public:
	DocumentDelegate_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DocumentDelegate_factory* s_instance;

	const FactoryKey key () const;

	Document* make (GblPilot::Document* document);

	Document* make (const GCD::PID& pid, bool is_edition, const char* name);

};

typedef ::Core::Var<DocumentDelegate_factory> DocumentDelegate_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DocumentDelegate> {
	typedef GblAdapterLib::DocumentDelegateServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTDELEGATE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

