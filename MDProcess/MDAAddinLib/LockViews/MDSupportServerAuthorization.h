////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/LockViews/MDSupportServerAuthorization.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::MDSupportServerAuthorization
//
// ������ ��� ����� ������ � ������ ��� ������� �� ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_LOCKVIEWS_MDSUPPORTSERVERAUTHORIZATION_H__
#define __MDPROCESS_MDAADDINLIB_LOCKVIEWS_MDSUPPORTSERVERAUTHORIZATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// ������ ��� ����� ������ � ������ ��� ������� �� ������ �������
class MDSupportServerAuthorization : public CDialog {
	SET_OBJECT_COUNTER (MDSupportServerAuthorization)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ������ �������� �������������
	struct DialogData {
		// ����� ������������
		std::string login;
		// ������ ������������
		std::string pass;
		// ��������� ��������� � ������ �� ���������� ������ �����������
		bool use_saved_auth;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_MD_SUPPORT_SERVER_AUTHORIZATION };

public:
	MDSupportServerAuthorization ();

public:
	virtual ~MDSupportServerAuthorization ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(MDSupportServerAuthorization)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
public:
	// ���������� ��������� ���������� �������
	virtual const DialogData& get_result () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �����
	std::string m_init_login;

	// ������
	std::string m_init_password;

	DialogData m_result;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_init_login () const;

	void set_init_login (const std::string& init_login);

	const std::string& get_init_password () const;

	void set_init_password (const std::string& init_password);
}; // class MDSupportServerAuthorization



#endif //__MDPROCESS_MDAADDINLIB_LOCKVIEWS_MDSUPPORTSERVERAUTHORIZATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

