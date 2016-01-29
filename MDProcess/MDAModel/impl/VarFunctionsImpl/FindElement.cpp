////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::FindElement
//
// ���������� ���������� ������� ���������� _find_element.
// _find_element(��������������|����, ������������) - ������� ������� �� ����� ��� ��
// �������������� � ���������� ��� � ����������. ������ �������� ������� ���������������� ���
// ������������� ��������, ���� ������� � ����� ��������������� �� ��� ������, �� ��������
// ���������������� ��� ��� ��������, ������ ��� ����� ����������� � ������ ���� �� ���� ��
// �������� (��� ��������� ������). ���� � ���������� ������ �� ����� ������� ����� ������ ��������
// - ������������� ����������. ��������:
// {code}
// %S%f_find_element(%SU, SELF)  - ���������� SELF ���� ��������� �� ������� ������� (S)
// %S%f_set_var (A::B::attr, ATTR)  - ���������� ATTR ����� ��������� �� �������, �� ��������
// ������ ���� �� ���� ������������� �� "A::B::attr"
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "MDProcess/MDAModel/AbstractDumpers/EmptyDumper.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FindElement::FindElement ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9367B90020_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9367B90020_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9367B90020_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9367B90020_BODY*
}

FindElement::~FindElement () {
	//#UC START# *4A9367B90020_DESTR_BODY*
	//#UC END# *4A9367B90020_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string FindElement::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A9367B90020*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	
	std::string uid = TemplatePainter::resolve_exp(params[0], painter);

	if (uid.empty ()) {
		throw Base::FatalError ("�� ����� ������������� (��� ���) �������� ��� ������");
	}

	std::string var_id = TemplatePainter::resolve_exp(params[1], painter);
	
	EmptyDumper empty (uid);
	ObjectTreeResolver::ObjectTree::Item_ptr it =  ObjectTreeResolver::s_tree->find (&empty);

	const AbstractDumperBase* result = 0;
	if (it) {
		result = dynamic_cast<const AbstractDumperBase*> (*it);
	} else {
		//���� �� �����
		Core::Aptr<ObjectTreeResolver::OTRVector> elements = ObjectTreeResolver::find_by_name (uid);

		if (elements->size () > 1) {
			throw Base::FatalError (
				std::string ("������� ����� ������ �������� � ������: ")
				+ uid
			);
		}

		if (!elements->empty ()) {
			result = dynamic_cast<const AbstractDumperBase*>((*elements)[0]);
		}
	}
	
	if (!result) {
		throw Base::FatalError (
			std::string ("�� ������� ����� �������: ")
			+ uid
		);
	}

	TemplatePainter::set_var_dumper (var_id, result);

	return std::string ();
	//#UC END# *4A2CE18202C1_4A9367B90020*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

