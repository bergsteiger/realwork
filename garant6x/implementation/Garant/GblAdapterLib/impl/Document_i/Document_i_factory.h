////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Document_i
// Заголовк реализации фабрик интерфеса Document для серванта Document_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"

/// Servant-factory implementation for Document_i
namespace GblAdapterLib {
	class DocumentState_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class FoldersNode_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ListEntryInfo_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class Document_iServantFactory {
	friend class DocumentState_i;
	friend class FoldersNode_i;
	friend class ListEntryInfo_i;

	static Document_i* make_servant ();

	static Document_i* make_servant (GblPilot::Document* document);

	static Document_i* make_servant (const char* name);
};


} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Document_i> {
	typedef GblAdapterLib::Document_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

