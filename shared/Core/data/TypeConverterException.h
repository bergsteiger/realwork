////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/data/TypeConverterException.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::data::TypeConverterException
//
// ����� ���������� ������������� ��� ����� � TypeConvertor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_TYPECONVERTEREXCEPTION_H__
#define __SHARED_CORE_DATA_TYPECONVERTEREXCEPTION_H__

#include "ace/ACE.h"
#include "shared/Core/sys/Exception.h"

namespace Core {

// ������ ���� �� ������
class ElementNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};


} // namespace Core


#endif //__SHARED_CORE_DATA_TYPECONVERTEREXCEPTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
