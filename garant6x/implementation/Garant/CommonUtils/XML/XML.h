////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/CommonUtils/XML/XML.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::CommonUtils::XML
//
// ��������� ��� ������ XML �� ������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_COMMONUTILS_XML_H__
#define __GARANT6X_COMMONUTILS_XML_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "shared/GCI/IO/IO.h"

namespace CommonUtils {
namespace XML {

// ���������� ������������, ���� �� ������ ��������� xml
class BadXMLFormat : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class XMLReader;
typedef ::Core::Var<XMLReader> XMLReader_var;
typedef ::Core::Var<const XMLReader> XMLReader_cvar;
// ��������� ���  ������ XML �� ������� ������
class XMLReader
	: virtual public ::Core::IObject
{
public:
	// ������ xml � ������� � ������������
	virtual GblConsultingDef::ConsultationData* read_result (GCI::IO::Stream* result) const /*throw (BadXMLFormat)*/ = 0;
};

/// factory interface for XMLReader
class XMLReaderFactory {
public:
	// ������� ��� ���������� XMLReader
	static XMLReader* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace XML
} // namespace CommonUtils

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <CommonUtils::XML::XMLReader> {
	typedef CommonUtils::XML::XMLReaderFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_COMMONUTILS_XML_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
