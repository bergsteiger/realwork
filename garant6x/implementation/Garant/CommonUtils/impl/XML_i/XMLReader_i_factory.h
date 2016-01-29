////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::CommonUtils::XML_i::XMLReader_i
// Заголовк реализации фабрик интерфеса XMLReader для серванта XMLReader_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_COMMONUTILS_XML_I_XMLREADER_I_FCTR_H__
#define __GARANT6X_COMMONUTILS_XML_I_XMLREADER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/CommonUtils/XML/XMLFactories.h"

namespace CommonUtils {
namespace XML_i {

/// Interface-factory implementation for XMLReader_i
class XMLReader_i_factory: virtual public ::Core::RefCountObjectBase, virtual public XML::XMLReaderAbstractFactory {
public:
	XMLReader_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	XML::XMLReader* make ();

};

typedef ::Core::Var<XMLReader_i_factory> XMLReader_i_factory_var;

} // namespace XML_i
} // namespace CommonUtils


#endif //__GARANT6X_COMMONUTILS_XML_I_XMLREADER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

