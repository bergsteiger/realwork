////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseStateMachineDumper.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseStateMachineDumper
//
// ������ ��� IRoseStateMachine
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseStateMachineDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseStateDiagramDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// �����������
RoseStateMachineDumper::RoseStateMachineDumper (const RoseAbstractDumper* parent, IRoseElementPtr item)
//#UC START# *468A3ACD03D8_BASE_INIT*
: RoseAbstractDumper (parent, item, AbstractDumperBase::EMPTY_STEREOTYPE_ID)
//#UC END# *468A3ACD03D8_BASE_INIT*
{
	//#UC START# *468A3ACD03D8_BODY*
	try {
		IRoseStateMachinePtr st_machine = item;
		IRoseStateDiagramCollectionPtr state_diags = st_machine->GetDiagrams ();
		short state_diags_count = state_diags->Count;
		for (short j = 1; j <= state_diags_count; ++j) {
			IRoseStateDiagramPtr state_diag = state_diags->GetAt (j);
			//��������� ���� �� �� ��������� �������� ��� ���
			//���� ��������� ������ - �� ��������� � � ������,
			//�.� ��� �������������
			if (state_diag->ItemViews->Count > 0) {
				this->add_diagram (new RoseStateDiagramDumper (this, state_diag));
			}
		}
		std::string this_guid (get_rose_element_uid(item));
		
		IRoseStateCollectionPtr states = st_machine->States;
		short states_count = states->Count;
		
		for (short j = 1; j <= states_count; ++j) {
			IRoseStatePtr state = states->GetAt (j);
			std::string context_guid (get_rose_element_uid(state->GetContext ()));
			if (context_guid == this_guid) {
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, state);				
			}					
		}
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseStateMachineDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseStateMachineDumper ctor");
	}
	//#UC END# *468A3ACD03D8_BODY*
}

RoseStateMachineDumper::~RoseStateMachineDumper () {
	//#UC START# *468A39AD02CE_DESTR_BODY*
	//#UC END# *468A39AD02CE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// ���������� �����
const std::string RoseStateMachineDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_468A39AD02CE*
	return "StateMachine";
	//#UC END# *465EA35D005D_468A39AD02CE*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

