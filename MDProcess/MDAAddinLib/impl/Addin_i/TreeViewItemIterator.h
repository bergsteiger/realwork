////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/TreeViewItemIterator.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::TreeViewItemIterator
//
// �������� �� ���-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWITEMITERATOR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWITEMITERATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/MDAAddinLib/MDAGui/ATLControls.h"


// �������� �� ���-������
class TreeViewItemIterator {
	SET_OBJECT_COUNTER (TreeViewItemIterator)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ������ ��������� ������-���
	typedef std::vector < ATLControls::CTreeItem > TreeItemVec;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	TreeViewItemIterator (ATLControls::CTreeItem& root, bool in_root_only);

public:
	virtual ~TreeViewItemIterator ();

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

	// ������������ ����� ������� ������ �� ��������� ���� m_root
	bool m_in_root_only;

	bool m_is_first;

	TreeItemVec m_parents_with_children;

	ATLControls::CTreeItem m_root;
}; // class TreeViewItemIterator



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_TREEVIEWITEMITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

