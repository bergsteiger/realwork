////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveInheritable
//
// %S%f_remove_inheritable(<��� ��������>) - ������� �������� ����� ������������ ����� �������
// ��������� � ���������, ������� ���'��. ���� �� ������� ����� ������� � �������� ���'�� ��� �
// ���� ��������� ��� ����� ������������ - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RemoveInheritable::RemoveInheritable ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEAA540271_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEAA540271_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEAA540271_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEAA540271_BODY*
}

RemoveInheritable::~RemoveInheritable () {
	//#UC START# *4AEEAA540271_DESTR_BODY*
	//#UC END# *4AEEAA540271_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string RemoveInheritable::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4AEEAA540271*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	RoseAbstractDumper* source = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	IRoseClassPtr cls = source->rose_element ();
	if (source && cls) {
		std::string uid = TemplatePainter::resolve_exp(params[0], painter);
		RoseAbstractDumper* target = RoseAbstractDumper::find_in_tree (uid);
		if (target) {
			//��� ��������� ���������� ������, � �� ������ ���������, �.�
			//����������� ����� ������������ � ���������� ��� ����� ������ ���� ���� ���������
			//� ������ ��� ���������� ������
			IRoseInheritRelationCollectionPtr generalizations = cls->GetInheritRelations ();
			short generalizations_count = generalizations->Count;

			IRoseInheritRelationPtr founded_rel;
			for (short i = 0; i < generalizations_count; ++i) {
				IRoseInheritRelationPtr rel = generalizations->GetAt (i);
				
				IRoseItemPtr supplier = rel->GetSupplier ();
				std::string supplier_guid (get_rose_element_uid(supplier));
				if (supplier_guid == uid) {
					founded_rel = rel;
					break;
				}
			}
			
			if (founded_rel) {
				if (IsVirtualFactory::get ().execute (cls)) {
					cls->DeleteInheritRel (founded_rel);
				}
				
				source->remove_supplier (target, ObjectTreeResolver::ST_NAVIGABLE, ST_LINK_INH);

				painter->invalidate_dumpers_list (SX_3_GENERALIZATION, source);
				painter->invalidate_dumpers_list (SX_3_REQURSIVE_GENERALIZATION, source);
				painter->invalidate_dumpers_list (SX_3_DERIVED_OVER, source);
				painter->invalidate_dumpers_list (SX_3_DERIVED_IMPL, source);
				painter->invalidate_dumpers_list (SX_3_NOT_IMPLEMENTED_DERIVED_ABSTRACT, source);
			} else {
				throw Base::FatalError (
					"�� ������� ����� ����� ������������ ����� ��������� \""
					+ (static_cast<const Base::NamedElement*> (source))->get_full_name ()
					+ "\" � \""
					+ (static_cast<const Base::NamedElement*> (target))->get_full_name ()
				);
			}			
		} else {
			throw Base::FatalError ("�� ������� ����� ������� � ���������������: " + uid);
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4AEEAA540271*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

