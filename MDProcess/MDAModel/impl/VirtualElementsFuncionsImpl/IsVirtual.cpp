////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/IsVirtual.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::IsVirtual
//
// �������� �� ������� �����������:
// %S%f_is_virtual()
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/IsVirtual.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IsVirtual::IsVirtual ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B18EEF601AF_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B18EEF601AF_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B18EEF601AF_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B18EEF601AF_BODY*
}

IsVirtual::~IsVirtual () {
	//#UC START# *4B18EEF601AF_DESTR_BODY*
	//#UC END# *4B18EEF601AF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string IsVirtual::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4B18EEF601AF*
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);

	return ::IsVirtualFactory::get ().execute (rad->rose_element ()) ? std::string ("true") : std::string ("false");
	//#UC END# *4A2DFD7B0291_4B18EEF601AF*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

