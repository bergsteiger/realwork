////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/AsynchronousCalls.h"
// C++ header files (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::AsynchronousCalls
//
// ����� ��� ������ ����������� ������ � ����������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_ASYNCHRONOUSCALLS_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_ASYNCHRONOUSCALLS_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *45B9F39802BF_CUSTOM_INCLUDES*
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC END# *45B9F39802BF_CUSTOM_INCLUDES*


// ����� ��� ������ ����������� ������ � ����������� ������
class AsynchronousCalls {
	SET_OBJECT_COUNTER (AsynchronousCalls)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
public:
	// ������� ������� ������
	static void thread_func (void* ptr);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

//#UC START# *45B9F39802BF*
	struct ComModuleAutoLock {
	public:
		ComModuleAutoLock (ATL::CComModule& module) 
			: m_module (module) 
		{			
				m_module.Lock ();		
		};

		~ComModuleAutoLock () {			
				m_module.Unlock ();			
		};
		ATL::CComModule& m_module;
	};
//#UC END# *45B9F39802BF*
}; // class AsynchronousCalls



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_ASYNCHRONOUSCALLS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

