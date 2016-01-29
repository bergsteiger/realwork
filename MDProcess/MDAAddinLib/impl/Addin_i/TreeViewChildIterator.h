////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/TreeViewChildIterator.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::TreeViewChildIterator
//
// �������� �� ���-������
// ������������ ���������� �� ���� � ������ ��� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWCHILDITERATOR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWCHILDITERATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/ATLControls.h"


// �������� �� ���-������
// ������������ ���������� �� ���� � ������ ��� �����
class TreeViewChildIterator {
	SET_OBJECT_COUNTER (TreeViewChildIterator)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit TreeViewChildIterator (ATLControls::CTreeItem& root);

public:
	virtual ~TreeViewChildIterator ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� �������
	virtual ATLControls::CTreeItem get_next ();

	// ������������� ���������
	virtual void init (ATLControls::CTreeItem root);

private:
	// ����������� �� ������� �����, �� �������� ���������
	virtual ATLControls::CTreeItem up_level ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ATLControls::CTreeItem m_current;

	bool m_is_first;

	ATLControls::CTreeItem m_root;
}; // class TreeViewChildIterator



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWCHILDITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

