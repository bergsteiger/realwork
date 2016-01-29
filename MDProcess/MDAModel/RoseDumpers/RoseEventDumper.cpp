////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseEventDumper.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseEventDumper
//
// ������ ��� IRoseEvent
// �������������� get_initial_value � � �������� ��������� ����������
// �������� GuardCondition � IRoseEvent
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseEventDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// �����������
RoseEventDumper::RoseEventDumper (const RoseAbstractDumper* parent, IRoseElementPtr item)
//#UC START# *468A3C9402AF_BASE_INIT*
: RoseAbstractDumper (parent, item, AbstractDumperBase::StereotypeID (""))
//#UC END# *468A3C9402AF_BASE_INIT*
{
	//#UC START# *468A3C9402AF_BODY*
	//#UC END# *468A3C9402AF_BODY*
}

RoseEventDumper::~RoseEventDumper () {
	//#UC START# *468A3C660157_DESTR_BODY*
	//#UC END# *468A3C660157_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// ���������� �����
const std::string RoseEventDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_468A3C660157*
	return "TransitionEvent";
	//#UC END# *465EA35D005D_468A3C660157*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// �������� �� ��������� (��� ��������� � ���������� ��������)
const std::string RoseEventDumper::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_468A3C660157*
	IRoseEventPtr rose_event = this->rose_element ();
	if (rose_event) {
		return (const char*)rose_event->GuardCondition;
	}
	return "";
	//#UC END# *4666BA9F03D8_468A3C660157*
}

// overloaded method from ObjectTreeResolver
// ��������� � ��������� ���� supplier
void RoseEventDumper::link_suppliers () {
	//#UC START# *465E57F1029F_468A3C660157*
	RoseAbstractDumper::link_suppliers ();
	IRoseEventPtr rose_event = this->rose_element ();
	if (rose_event) {
		IRoseItemPtr sup = rose_event->GetAction ();
		if (sup != 0) {	
			this->add_supplier (RoseAbstractDumper::find_in_tree(sup), ST_IGNORED, ST_USER_DEF_TARGET );
		}
	}	
	//#UC END# *465E57F1029F_468A3C660157*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

