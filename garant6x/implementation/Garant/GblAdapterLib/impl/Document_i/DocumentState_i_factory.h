////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentState_i
// Заголовк реализации фабрик интерфеса DocumentState для серванта DocumentState_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTSTATE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTSTATE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"

/// Servant-factory implementation for DocumentState_i
namespace GblAdapterLib {
	class Document_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DocumentState_iServantFactory {
	friend class Document_i;

	static DocumentState_i* make (Document* source_doc);

	static DocumentState_i* make ();
};

/// Interface-factory implementation for DocumentState_i
class DocumentState_i_factory: virtual public ::Core::RefCountObjectBase, virtual public DocumentStateAbstractFactory {
	friend class DocumentState_iServantFactory;

public:
	DocumentState_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DocumentState_i_factory* s_instance;

	const char* key () const;

	DocumentState* make (Document* source_doc);

	DocumentState* make ();

};

typedef ::Core::Var<DocumentState_i_factory> DocumentState_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DocumentState_i> {
	typedef GblAdapterLib::DocumentState_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTSTATE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

