////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::TranslatedDocument
// Заголовк реализации фабрик интерфеса  для серванта TranslatedDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TRANSLATEDDOCUMENT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TRANSLATEDDOCUMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument.h"

/// Servant-factory implementation for TranslatedDocument
namespace GblAdapterLib {
	class Document_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class TranslatedDocumentServantFactory {
	friend class Document_i;

	static TranslatedDocument* make (GblPilot::Document* document);

	static TranslatedDocument* make (const GCD::PID& pid, bool is_edition, const char* name);

	static TranslatedDocument* make_servant (GblPilot::Document* document);
};

/// Interface-factory implementation for TranslatedDocument
class TranslatedDocument_factory: virtual public ::Core::RefCountObjectBase, virtual public DocumentAbstractFactory {
	friend class TranslatedDocumentServantFactory;

public:
	TranslatedDocument_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static TranslatedDocument_factory* s_instance;

	const FactoryKey key () const;

	Document* make (GblPilot::Document* document);

	Document* make (const GCD::PID& pid, bool is_edition, const char* name);

};

typedef ::Core::Var<TranslatedDocument_factory> TranslatedDocument_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::TranslatedDocument> {
	typedef GblAdapterLib::TranslatedDocumentServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TRANSLATEDDOCUMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

