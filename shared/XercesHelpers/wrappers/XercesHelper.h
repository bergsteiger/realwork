////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/XercesHelpers/wrappers/XercesHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::XercesHelper
//
// ��������� ����� � �� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_XERCESHELPER_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_XERCESHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Singleton.h"
#include "xercesc/dom/DOMDocument.hpp"
#include "xercesc/dom/DOMElement.hpp"
#include "xercesc/dom/DOMNode.hpp"

//#UC START# *491C2F420352_CUSTOM_INCLUDES*
#include "xercesc/util/XercesVersion.hpp"
#include "xercesc/util/XercesDefs.hpp"

#include "shared/XercesHelpers/wrappers/TranscodeHelper.h" // ��� ����������� �������� � Core::Aptr

namespace XERCES_CPP_NAMESPACE {
	class DOMElement;
	class DOMDocument;
	class DOMNode;
	class DOMText;
}
//#UC END# *491C2F420352_CUSTOM_INCLUDES*

namespace XercesHelpers {

// ��������� ����� � �� ���������
class XercesHelper {

	// singleton declaration
	typedef ACE_Singleton <XercesHelper, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <XercesHelper, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static XercesHelper* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	XercesHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ��������� DOM ���� � ���������� DOM �������
	XERCES_CPP_NAMESPACE::DOMNode* add_text_node (
		XERCES_CPP_NAMESPACE::DOMDocument* doc
		, XERCES_CPP_NAMESPACE::DOMNode* node
		, const char* text
	);

	// �������� ���������
	void change_encoding (const char* locale);

	// ������� DOM �������
	XERCES_CPP_NAMESPACE::DOMElement* create_element (XERCES_CPP_NAMESPACE::DOMDocument* doc, const char* name);

	// ������� ��������� DOM ����
	XERCES_CPP_NAMESPACE::DOMText* create_text_node (XERCES_CPP_NAMESPACE::DOMDocument* doc, const char* text);

	// �������� �������
	char* get_attribute (XERCES_CPP_NAMESPACE::DOMElement* element, const char* name);

	// �������� ���������������� ������
	XMLCh* get_string (const char* to_transcode) const;

	// �������� ���������������� ������
	char* get_string (const XMLCh* to_transcode) const;

	// ���������� �������
	void set_attribute (XERCES_CPP_NAMESPACE::DOMElement* element, const char* name, const char* value);

	// ���������� �������
	void set_attribute (XERCES_CPP_NAMESPACE::DOMElement* element, const char* name, int value);


//#UC START# *491C2F420352*
public:
	char* transcode (const XMLCh* from) const;
	void transcode (const char* from, XMLCh*& to) const;

private:
	template <class TYPE, class ACE_LOCK> friend class ::ACE_Singleton; // DO NOT REMOVE '::' before ACE_Singleton !!! g++ requires it

private:
	Core::Aptr<TranscodeHelper> m_transcode_helper;
	mutable Core::Mutex m_mutex;
private:
	// ������ � ��������������� ��� DomNodeEx
	const TranscodeHelper* get_cached_transcode_helper () const;
//#UC END# *491C2F420352*
}; // class XercesHelper

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_XERCESHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

