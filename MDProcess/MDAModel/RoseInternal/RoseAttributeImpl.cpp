////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::RoseAttributeImpl
// ���� ���������� ���������� ������ RoseAttributeImpl
//
// ���������� COM-���������� IRoseAttribute
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseAttribute.h"

//#UC START# *4A2FA11A0053_CUSTOM_INCLUDES*
//#UC END# *4A2FA11A0053_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4A2FA11A0053*
STDMETHODIMP RoseAttributeImpl::Invoke(DISPID id, REFIID , LCID , WORD Flags, DISPPARAMS *DispParams, VARIANT* Result, EXCEPINFO* pe, UINT* pu) {
	return this->dispatch (id, Flags, DispParams, Result);
}
//#UC END# *4A2FA11A0053*

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

