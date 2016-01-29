////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::ChangedPackageInfo
//
// ������ ��� ����������� �������� ������ ������������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_LOCKVIEWS_CHANGEDPACKAGEINFO_H__
#define __MDPROCESS_MDAADDINLIB_LOCKVIEWS_CHANGEDPACKAGEINFO_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseItemList.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4732CB080290_CUSTOM_INCLUDES*
//#UC END# *4732CB080290_CUSTOM_INCLUDES*


// ������ ��� ����������� �������� ������ ������������� �������
class ChangedPackageInfo : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (ChangedPackageInfo)

	// singleton declaration
	typedef ACE_Singleton <ChangedPackageInfo, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ChangedPackageInfo, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static ChangedPackageInfo* instance () {
		return Singleton::instance();
	}

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ������ ����������� ������
	enum ChangeStatus {
		CT_LOCK // ����� �������
		, CT_UNLOCK // ����� ��������
	};

	// ���������� �� ��������� ������
	struct Info {
		// ���������� ������������� ������ �� ������
		std::string package_guid;
		// ������������, ����������� ���������
		std::string user_name;
		// ����� �������/�������� ������
		std::string time;
		// ������ ��������� (�������, ��������)
		ChangeStatus status;

		Info (
			const std::string& package_guid_
			, const std::string& user_name_
			, const std::string& time_
			, ChangeStatus status_
		);

		Info (const Info& copy);

		Info& operator = (const Info& copy);
	};

	// ������ � �����������
	typedef std::vector < Info > VectorInfo;

	// ��������� ������������� �����
	static const unsigned long WM_SHOW_INFO; // �������� ������
	static const unsigned long WM_ADD_INFO; // ��������� � ���������� ���������� � ������



//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_CHANGED_PACKAGE_INFO };

public:
	ChangedPackageInfo ();

public:
	virtual ~ChangedPackageInfo ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ChangedPackageInfo)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
public:
	// ��������� ���������� � ������
	virtual void add_info (const Info& info);

	// ������������� ��������� ������
	virtual void close ();

	// ������������ ��������� ��� ���������� ����������, ����� ��� �������
	// �� �� ���� ������, � ������� �������� ��������� �������
	virtual void register_for_com_marshal (IRoseApplicationPtr app);

	// �������� ������
	/*oneway*/ Core::ThreadHandle show ();

	// �������������� ��������� �� ���������� �������
	virtual void unregister_for_com_marshal ();

private:
	// ����� ��� ���������� ������ � ������
	virtual bool add_item_to_list (RoseItemList& list, const Info& info);

	// ��������� ���������� � �������
	// l_param �������� ��������� �� ��������� Info, ��� ������ �� ����������� ������ �� �����
	// ��������� ������� ��������
	virtual LRESULT on_add_info (WPARAM w_param, LPARAM l_param);

	// ���������� ������� ������ OK
	virtual void on_ok ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������������� ���������� ������� � ���������� ������� COM-�����������
	DWORD m_current_app_id;

	// ��������� ���������� ������� COM-��������
	IGlobalInterfaceTablePtr m_git;

	// ������� ��� ������������� ������� � GIT
	mutable Core::Mutex m_git_mutex;

	// ������� ��� ������������� ������� � ������ �� ������ �������
	mutable Core::Mutex m_info_mutex;

	// ������� �� ����� �� ������
	bool m_is_showed;

	// ������ � ����������� � ���������� �������
	RoseItemList m_locked_info_list;

	// ������ ��������� �������
	VectorInfo m_locked_packages;

	// ���������� ����� ���������� ������� (����� ��� ����, ����� ����� ������� ��������� ������ �����
	// ��������� �������)
	long m_new_locked;

	// ���������� ����� ����������� ������� (����� ��� ����, ����� ����� ������� ��������� ������
	// ����� ��������� �������)
	long m_new_unlocked;

	// ������ � ����������� � ����������� �������
	RoseItemList m_unlocked_info_list;

	// ����� ����������� �������
	VectorInfo m_unlocked_packages;
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_show_ (void* arg);

protected:
	virtual void show_ ();


//#UC START# *4732CB080290*
	afx_msg void on_custom_draw_list (NMHDR *pNMHDR, LRESULT *pResult);	
//#UC END# *4732CB080290*
}; // class ChangedPackageInfo



#endif //__MDPROCESS_MDAADDINLIB_LOCKVIEWS_CHANGEDPACKAGEINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

