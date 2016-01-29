////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::AutoreferatDocument
// Заголовк реализации фабрик интерфеса  для серванта AutoreferatDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATDOCUMENT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATDOCUMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument.h"

/// Servant-factory implementation for AutoreferatDocument
namespace GblAdapterLib {
	class DocumentMaster; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class AutoreferatDocumentServantFactory {
	friend class DocumentMaster;

	static AutoreferatDocument* make (GblPilot::Document* document);

	static AutoreferatDocument* make (const GCD::PID& pid, bool is_edition, const char* name);

	static AutoreferatDocument* make_servant (GblPilot::Document* document);
};

/// Interface-factory implementation for AutoreferatDocument
class AutoreferatDocument_factory: virtual public ::Core::RefCountObjectBase, virtual public DocumentAbstractFactory {
	friend class AutoreferatDocumentServantFactory;

public:
	AutoreferatDocument_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static AutoreferatDocument_factory* s_instance;

	const FactoryKey key () const;

	Document* make (GblPilot::Document* document);

	Document* make (const GCD::PID& pid, bool is_edition, const char* name);

};

typedef ::Core::Var<AutoreferatDocument_factory> AutoreferatDocument_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::AutoreferatDocument> {
	typedef GblAdapterLib::AutoreferatDocumentServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_AUTOREFERATDOCUMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

