////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/sys/IUnsortedLess.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::IUnsortedLess
//
// ������� ��������� ���� �������� � ���������� �������� �������� ���������, ��� �� �������������
// �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_IUNSORTEDLESS_H__
#define __SHARED_CORE_SYS_IUNSORTEDLESS_H__

#include "ace/ACE.h"

//#UC START# *459CEBF101F9_CUSTOM_INCLUDES*
namespace Core {

template <class _VarType, bool is_pointer>
struct ArbitraryLess;

}
//#UC END# *459CEBF101F9_CUSTOM_INCLUDES*

namespace Core {

// ������� ��������� ���� �������� � ���������� �������� �������� ���������, ��� �� �������������
// �����������
class IUnsortedLess {
// virtual void destructor
public:
	virtual ~IUnsortedLess () {};

//#UC START# *459CEBF101F9*
protected:
	template <class _VarType, bool is_pointer> friend struct ArbitraryLess;
	virtual bool is_unsorted_less (const IUnsortedLess* c) const = 0;
//#UC END# *459CEBF101F9*
}; // class IUnsortedLess

} // namespace Core


#endif //__SHARED_CORE_SYS_IUNSORTEDLESS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

