////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/CommonViews/QuestionBox.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::CommonViews::QuestionBox
//
// ������ - ������ � ������������ ���������� ���������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_QUESTIONBOX_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_QUESTIONBOX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *45FE6247002E_CUSTOM_INCLUDES*
//#UC END# *45FE6247002E_CUSTOM_INCLUDES*


// ������ - ������ � ������������ ���������� ���������� ��������
class QuestionBox : public CDialog {
	SET_OBJECT_COUNTER (QuestionBox)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ���������� ���� � ��������, ���������� IDOK ��� IDCANCEL
	// \question - ����� �������
	// \caption - ��������� ����
	static int show (const char* question, const char* caption);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_QUESTION_BOX };

public:
	QuestionBox (const char* question, const char* caption);

public:
	virtual ~QuestionBox ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(QuestionBox)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
public:
	// ���������� true, ���� ����� ����� ���������
	virtual bool need_save () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_caption;

	int m_need_save;

	std::string m_question;

//#UC START# *45FE6247002E*
	afx_msg void on_no ();
//#UC END# *45FE6247002E*
}; // class QuestionBox



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_QUESTIONBOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

