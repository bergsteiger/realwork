////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/impl/Root_i/ExecutorBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::ExecutorBase
// ��������� ���������� ������ �������� ��� ��������� Executor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_EXECUTORBASE_H__
#define __SHARED_CORE_ROOT_I_EXECUTORBASE_H__

#include "ace/ACE.h"
#include "shared/Core/Root/Root.h"

namespace Core {
namespace Root_i {

class ExecutorBase; // self forward Var
typedef ::Core::Var<ExecutorBase> ExecutorBase_var;
typedef ::Core::Var<const ExecutorBase> ExecutorBase_cvar;

class ExecutorBase:
	virtual public Root::Executor
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ExecutorBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExecutorBase ();

	virtual ~ExecutorBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// ������������� ������
	virtual void set_current_status (Root::ExecutorStatus current_status);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Root::ExecutorStatus m_current_status;

	// �������, ��� ������������� ������� � ������
	mutable Core::Mutex m_guard;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Root::Executor
	// ������� ������ �����������
	virtual Root::ExecutorStatus get_current_status () const;

	// implemented method from Root::Executor
	// ����� ���������� ������ ������ �����������, ���������� �����������
	virtual void execute_ ();
}; // class ExecutorBase

} // namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_EXECUTORBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
