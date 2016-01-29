////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/DiagramColorizer.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::DiagramColorizer
//
// ����������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_DIAGRAMCOLORIZER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_DIAGRAMCOLORIZER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


// ����������� ��������
class DiagramColorizer {
	SET_OBJECT_COUNTER (DiagramColorizer)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// guid �������� -> �������� � ��������� ����
	typedef std::map < std::string, IRoseNoteViewPtr > NoteMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ����������.
	// \diag - ���������, ������� ����� �����������
	explicit DiagramColorizer (IRoseDiagramPtr diag);

public:
	virtual ~DiagramColorizer ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ���� ������� �� ���������
	// \elem - �������, ������� ����� �����������
	virtual void colorize (IRoseElementPtr elem);

	// ������������� ��� ���������
	virtual void colorize ();

private:
	// ��������� ��� ����������� �������� �� ���������
	virtual void colorize_i (IRoseItemViewPtr view);

	// �������� ���������� ��� ��������, ���� � ���� ���� ��������������� ��������
	virtual void colorize_overwritten_prop (IRoseItemViewPtr view);

	// �������������� ���� ���
	virtual void init_notes ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������������� ���������
	IRoseDiagramPtr m_diag;

	// �������� ��������� (����� ��� �����)
	IRoseElementPtr m_diag_parent;

	// ���� ���, ������������� ��������������� �� ��� �������� (������ � ��� �������� ���������
	// ��������)
	NoteMap m_note_map;

	// ���� ��� � �������������� �����������
	NoteMap m_up_note_map;
}; // class DiagramColorizer



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_DIAGRAMCOLORIZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

