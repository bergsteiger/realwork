////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractElementDumper
//
// ���������� ������ ��� ���� IRoseItem
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571D3040222_CUSTOM_INCLUDES*
//#UC END# *4571D3040222_CUSTOM_INCLUDES*


//#UC START# *4571D3040222*
RoseAbstractElementDumper::RoseAbstractElementDumper (const RoseAbstractDumper* parent, IRoseElementPtr cls, const AbstractDumperBase::StereotypeID& st) 
	: RoseAbstractDumper (parent, cls, st) 
{
}

bool RoseAbstractElementDumper::is_it_first (const ObjectTreeResolver* od) const {
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*>(od);
	if (!rad) {
		return false;
	}
	return (this->elem_order() > rad->elem_order());
}
//#UC END# *4571D3040222*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractElementDumper::~RoseAbstractElementDumper () {
	//#UC START# *4571D3040222_DESTR_BODY*
	//#UC END# *4571D3040222_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// �������� ���������� ���� ��������:
// 1. �������� �� �������� ������������� ���������� �������� - ������� ���� ������� � ������
// 2. �������� �� �������� ��� ���������� ����, ���������� ��� ���������� ������ ���� (current_type)
// 3. ���� ��������� - ������������ �������
// 4. ���� �� ��������� - ����������� �������� ������ ���� �� �����, ���������� � ����������
// �������� ����������� � ������
const RoseAbstractDumper* RoseAbstractElementDumper::resolve_target_type (std::string& current_type) {
	//#UC START# *4ABC406501AA*
	IRoseElementPtr elem = this->rose_element ();
	std::string resolved_guid = TypeLinkHelperFactory::get ().get_linked (elem);
	
	if (!resolved_guid.empty ()) {
		const RoseAbstractDumper* resolved_type = RoseAbstractDumper::find_in_tree (resolved_guid);
		if (resolved_type) {		
			std::string resolved_type_full_name = (static_cast<const Base::NamedElement*> (resolved_type))->get_full_name ();

			//���������, ��� ������ ��� �������� �� ������������� �� current_type
			//�� ����� �������� ���
			if (!GCL::end_with (resolved_type_full_name.c_str (), current_type.c_str ())) {			
				current_type = resolved_type->get_name_str ();
			}

			return resolved_type;
		}
	}

	const RoseAbstractDumper* resolved_type = this->resolve (current_type);
	return resolved_type;
	//#UC END# *4ABC406501AA*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// ���������� true, ���� ������� ����� "�������"
bool RoseAbstractElementDumper::can_dump () const {
	//#UC START# *4AB372760177_4571D3040222*
	return this->accepted_generator();
	//#UC END# *4AB372760177_4571D3040222*
}

// overloaded method from ObjectTreeResolver
// ����������� �� �������� � ������� �������� (� ������� �������� �� ������) - ����� �������� ��
// ����� �������� � ����.
bool RoseAbstractElementDumper::sort_in_model_order () const {
	//#UC START# *4AB0CD170066_4571D3040222*
	return true;
	//#UC END# *4AB0CD170066_4571D3040222*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

