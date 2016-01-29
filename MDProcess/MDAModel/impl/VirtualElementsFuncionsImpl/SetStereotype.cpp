////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetStereotype
//
// %f_set_stereotype(<���������>) - ������������� ��������� ��������. ��������� ������ �
// ����������� ���������, ��� �������� ��������� ����� ��������� ����������. ���� ������� �� �����
// ����� �������� ��������� - ������������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetStereotype::SetStereotype ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AC34CF20255_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AC34CF20255_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AC34CF20255_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AC34CF20255_BODY*
}

SetStereotype::~SetStereotype () {
	//#UC START# *4AC34CF20255_DESTR_BODY*
	//#UC END# *4AC34CF20255_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string SetStereotype::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4AC34CF20255*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		IRoseElementPtr item = rad->rose_element ();
		if (item) {
			if (IsVirtualFactory::get ().execute (item)) {
				if (item->IsClass (ROSE_ITEM_TYPE)) {
					std::string stereotype = TemplatePainter::resolve_exp (params[0], painter);

					((IRoseItemPtr)item)->Stereotype = stereotype.c_str ();
					rad->reset_model_stereotype ();

					Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory ();
					if (!df->check_stereotype (item)) {
						throw Base::FatalError (
							std::string ("������������ ����������� ���������: <<")
							+ stereotype
							+ std::string (">>")
						);
					}

					if (!rad->check_stereotype_use ()) {
						throw Base::FatalError (
							std::string ("������ ������������ ���������: <<")
							+ stereotype
							+ std::string (">>, �.� ��� ��������� ��������� ������������� ��������")
						);
					}
				} else {
					throw Base::FatalError (
						std::string ("������ ��� ��������� �� ������������ ��������� ����������: ")
						+ std::string (static_cast<const char*> (item->IdentifyClass ()))
					);
				}
			} else {
				throw Base::FatalError ("������� ��������� ������ ��� ����������� ���������");
			}
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4AC34CF20255*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

