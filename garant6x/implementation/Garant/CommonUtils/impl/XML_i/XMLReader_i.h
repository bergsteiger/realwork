////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::CommonUtils::XML_i::XMLReader_i
// Заголовок реализации класса серванта для интерфеса XMLReader
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_COMMONUTILS_XML_I_XMLREADER_I_H__
#define __GARANT6X_COMMONUTILS_XML_I_XMLREADER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/CommonUtils/XML/XML.h"

//#UC START# *443136380271_CUSTOM_INCLUDES*
//#UC END# *443136380271_CUSTOM_INCLUDES*

namespace CommonUtils {
namespace XML_i {

class XMLReader_i; // self forward Var
typedef ::Core::Var<XMLReader_i> XMLReader_i_var;
typedef ::Core::Var<const XMLReader_i> XMLReader_i_cvar;

class XMLReader_i_factory;

class XMLReader_i:
	virtual public XML::XMLReader
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (XMLReader_i)
	friend class XMLReader_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <XMLReader_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <XMLReader_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	XMLReader_i ();

	virtual ~XMLReader_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from XML::XMLReader
	// чтение xml с данными о консультации
	virtual GblConsultingDef::ConsultationData* read_result (
		GCI::IO::Stream* result
	) const /*throw (
		XML::BadXMLFormat
	)*/;

//#UC START# *443136380271*
//#UC END# *443136380271*
}; // class XMLReader_i

} // namespace XML_i
} // namespace CommonUtils


#endif //__GARANT6X_COMMONUTILS_XML_I_XMLREADER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
