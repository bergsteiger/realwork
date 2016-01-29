////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/I18N_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::I18N_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_H__
#define __SHARED_GCI_I18N_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCI/I18N/I18N.h"


namespace GCI {
namespace I18N_i {

// ������� ���������� ������ � �����
enum EndianType {
	ET_BIG_ENDIAN // ������� ���������� ������ big endian
	, ET_LITTLE_ENDIAN // ������� ���������� ������ little endian
};

// ����� ��������
typedef std::vector < char > CharBuffer;

} //namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

