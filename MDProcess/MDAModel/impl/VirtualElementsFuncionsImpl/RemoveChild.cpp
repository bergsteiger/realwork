////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveChild
//
// %S%f_remove_child(<��� ��������>) - ������� �������� �������� �� ������ ��������� - ���� �������
// � �������� ���'�� ����� ����� �������� �������� (%S) ���� ������� - ������� ������� �� ������,
// ���� �� ������� - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RemoveChild::RemoveChild ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BODY*
}

RemoveChild::~RemoveChild () {
	//#UC START# *4AEEA95E027A_DESTR_BODY*
	//#UC END# *4AEEA95E027A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string RemoveChild::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4AEEA95E027A*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	const RoseAbstractDumper* parent = dynamic_cast<const RoseAbstractDumper*> (self);
	if (parent) {
		std::string uid = TemplatePainter::resolve_exp(params[0], painter);
		RoseAbstractDumper* child = RoseAbstractDumper::find_in_tree (uid);
		if (child) {
			if (IsVirtualFactory::get ().execute (child->rose_element ())) {
				if (child->is_child_of (parent)) {
					AbstractDumper::delete_virtual_dumper (child);
					painter->invalidate_dumpers_list (SX_3_CONTENTS, parent);
					painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, parent);
				} else {
					throw Base::FatalError (
						"������� \""
						+ (static_cast<const Base::NamedElement*> (child))->get_full_name ()
						+ "\" �� �������� �������� \""
						+ (static_cast<const Base::NamedElement*> (parent))->get_full_name ()
					);
				}
			} else {
				throw Base::FatalError ("������� ��������� ������ � ����������� ���������");
			}
		} else {
			throw Base::FatalError ("�� ������� ����� ������� � ���������������: " + uid);
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4AEEA95E027A*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

