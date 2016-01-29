////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/StaticNodeIterator.h"
// C++ header files (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::StaticNodeIterator
//
// �������� �� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_STATICNODEITERATOR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_STATICNODEITERATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"


// �������� �� ������
class StaticNodeIterator :
	virtual public Core::UnsortedLessBase
{
	SET_OBJECT_COUNTER (StaticNodeIterator)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// root - ���� � ������� �������� �����
	explicit StaticNodeIterator (GCL::StaticNode* root);

public:
	virtual ~StaticNodeIterator ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ���������� �������� ������
	virtual GCL::StaticNode* get_next ();

	// ������������� ���������
	virtual void init (GCL::StaticNode* root);

private:
	// ����������� �� ������� �����
	virtual GCL::StaticNode* up_level ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� ����, �� ������� ��������� ��������
	GCL::StaticNode_var m_current;

	// ���� ���������� ������ �� ��� �������� get_next
	bool m_is_first;
}; // class StaticNodeIterator



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_STATICNODEITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

