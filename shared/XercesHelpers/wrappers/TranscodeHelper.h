////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/XercesHelpers/wrappers/TranscodeHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::TranscodeHelper
//
// �������������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_TRANSCODEHELPER_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_TRANSCODEHELPER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *491C2F1503A1_CUSTOM_INCLUDES*
#include "xercesc/util/PlatformUtils.hpp"
#include "xercesc/util/TransService.hpp"
//#UC END# *491C2F1503A1_CUSTOM_INCLUDES*

namespace XercesHelpers {

// �������������� �����
class TranscodeHelper {
	SET_OBJECT_COUNTER (TranscodeHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit TranscodeHelper (const char* encoding);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ��������� xml
	void change_encoding (const char* encoding);

	// ������������� ������
	char* transcode (const XMLCh* from) const;

	// ������������� ������
	XMLCh* transcode (const char* from) const;

	// ������������� ������
	void transcode (const char* from, XMLCh*& to) const;


//#UC START# *491C2F1503A1*
private:
	friend class XercesHelper;

private:
	TranscodeHelper (const TranscodeHelper&);
	TranscodeHelper& operator = (const TranscodeHelper&);

private:
	mutable Core::Aptr<XERCES_CPP_NAMESPACE::XMLTranscoder> m_trans;
	mutable Core::Mutex m_mutex;
//#UC END# *491C2F1503A1*
}; // class TranscodeHelper

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_TRANSCODEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

