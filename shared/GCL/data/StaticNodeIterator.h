////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/data/StaticNodeIterator.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNodeIterator
//
// �������� �� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STATICNODEITERATOR_H__
#define __SHARED_GCL_DATA_STATICNODEITERATOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"

namespace GCL {

// �������� �� ������
class StaticNodeIterator {
	SET_OBJECT_COUNTER (StaticNodeIterator)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// root - ���� � ������� �������� �����
	explicit StaticNodeIterator (StaticNode* root);

public:
	virtual ~StaticNodeIterator ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ���������� �������� ������
	virtual StaticNode* get_next ();

	// ������������� ���������
	virtual void init (StaticNode* root);

private:
	// ����������� �� ������� �����
	virtual StaticNode* up_level ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� ����, �� ������� ��������� ��������
	StaticNode_var m_current;

	// ���� ���������� ������ �� ��� �������� get_next
	bool m_is_first;
}; // class StaticNodeIterator

} // namespace GCL


#endif //__SHARED_GCL_DATA_STATICNODEITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

