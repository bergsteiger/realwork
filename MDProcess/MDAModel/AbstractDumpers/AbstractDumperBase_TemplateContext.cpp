////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase_TemplateContext.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase::TemplateContext
//
// �������� ��������� ������� - ����� ������� "�����" ��������� (�������, ���������,
// �������������...)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"

class AbstractDumperBase;
//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// ���� �������� ��� ���������
const long AbstractDumperBase::TemplateContext::INIT_STACK_SIZE = 32; // ��������� ������ �����

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// �����������, �� ��������� ����������� INIT_STACK_SIZE ��������� ��� �����
AbstractDumperBase::TemplateContext::TemplateContext ()
//#UC START# *46F21E3603B9_BASE_INIT*
//#UC END# *46F21E3603B9_BASE_INIT*
{
	//#UC START# *46F21E3603B9_BODY*
	m_stack.reserve (INIT_STACK_SIZE);
	//#UC END# *46F21E3603B9_BODY*
}

AbstractDumperBase::TemplateContext::~TemplateContext () {
	//#UC START# *46F219CE0203_DESTR_BODY*
	//#UC END# *46F219CE0203_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ������� �����
void AbstractDumperBase::TemplateContext::clear () {
	//#UC START# *46F21D84030D*
	m_stack.clear ();
	//#UC END# *46F21D84030D*
}

// ������ �� ����
bool AbstractDumperBase::TemplateContext::empty () const {
	//#UC START# *46F21EC8031C*
	return m_stack.empty ();
	//#UC END# *46F21EC8031C*
}

// ������� ������� ������� �����
void AbstractDumperBase::TemplateContext::pop () {
	//#UC START# *46F22196008C*
	if (m_stack.empty () == false) {
		m_stack.pop_back ();
	}
	//#UC END# *46F22196008C*
}

// ��������� ������ �� ������� �����
void AbstractDumperBase::TemplateContext::push (const ContextData& data) {
	//#UC START# *46F21DF4003E*
	GDS_ASSERT(!data.function_id/*.get ()*/.empty () || !data.transformator_id/*.get ()*/.empty ());
	m_stack.push_back (data);
	//#UC END# *46F21DF4003E*
}

// ������������ �������� �����
void AbstractDumperBase::TemplateContext::rewrite_top (
	const StereotypeID& st
	, const FunctionID& fn
	, const TransformatorID& tr
) {
	//#UC START# *46F2258B002E*
	AbstractDumperBase::ContextData& data = const_cast<AbstractDumperBase::ContextData&> (top ());
	data.stereotype_id = st;
	data.function_id = fn;
	data.transformator_id = tr;
	//#UC END# *46F2258B002E*
}

// ���������� ������ �� ������� �����
const AbstractDumperBase::ContextData& AbstractDumperBase::TemplateContext::top () const {
	//#UC START# *46F21D9D0242*
	GDS_ASSERT_MSG(!m_stack.empty (), ("TemplateContext stack must not be empty!"));
	
	return m_stack.back ();
	//#UC END# *46F21D9D0242*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

