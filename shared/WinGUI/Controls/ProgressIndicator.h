////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Controls/ProgressIndicator.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> shared::WinGUI::Controls::ProgressIndicator
//
// �������� ���������. �������� � ���� �� ���������� �������, ��� �������� "������� ��� ����",
// ������� ������ ��� ��������� �� ������ ��������� �� ��������!!!
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_CONTROLS_PROGRESSINDICATOR_H__
#define __SHARED_WINGUI_CONTROLS_PROGRESSINDICATOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/Controls/CommonControls.h"
//#UC START# *4AD426A003AF_CUSTOM_INCLUDES*
#include "shared/WinGUI/Controls/Controls.h"
//#UC END# *4AD426A003AF_CUSTOM_INCLUDES*

namespace WinGUI {

class ProgressIndicatorDelegate;
// �������� ���������. �������� � ���� �� ���������� �������, ��� �������� "������� ��� ����",
// ������� ������ ��� ��������� �� ������ ��������� �� ��������!!!
class ProgressIndicator : public CDialog {
	SET_OBJECT_COUNTER (ProgressIndicator)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ���������
	static const unsigned long WM_UPDATE_LABEL_TEXT; // ��������� �� ���������� ������ ������
	static const unsigned long WM_PROGRESS_STEPIT; // ��������� � ����

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_PROGRESS_INDICATOR };

public:
	// �����������
	explicit ProgressIndicator (ProgressIndicatorDelegate* delegate);

public:
	virtual ~ProgressIndicator ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ProgressIndicator)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
public:
	// ������� ������
	virtual void close ();

	// �������� ������
	/*oneway*/ Core::ThreadHandle show ();

	// ��� ���������
	virtual void step ();

	// ���������� ���, �������� ��������� ����������� ���
	virtual void step (const std::string& message);

	// ��������� ����� � IDC_PROGRESS_LABEL �� text
	virtual void update_label_text (const std::string& text);

private:
	// ���������� ������� ������ "Cancel"
	virtual void on_cancel ();

	// ��������� ������
	virtual void on_ok ();

	// ���������� ���� �������� ����������, ���� �������� ������ ����� - ������ � ���������
	// �����������, ����� ���� ���������� ��������� progress_indicator_finished ()
	virtual LRESULT step_impl (WPARAM w_param, LPARAM l_param);

	// ���������� ��������� WM_UPDATE_LABEL_TEXT
	virtual LRESULT update_label_impl (WPARAM w_param, LPARAM l_param);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������, ����������� ������ ��������� � ������� ���������� � �������������� ��� �������
	ProgressIndicatorDelegate* m_delegate;

	// ����, ��� ����� ������� �� ������
	bool m_is_showed;

	// ������� ��� �������������
	mutable Core::Mutex m_mutex;

	// �������� ��� ����������� ��������
	CProgressCtrl m_progress;

	// ������� � ���, ��� ���� ������ ������ "Cancel"
	bool m_was_canceled;
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_show_ (void* arg);

protected:
	virtual void show_ ();


//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const ProgressIndicatorDelegate* get_delegate () const;

	virtual void set_delegate (ProgressIndicatorDelegate* delegate);

//#UC START# *4AD426A003AF*
protected:
	//virtual void PostNcDestroy ();
//#UC END# *4AD426A003AF*
}; // class ProgressIndicator

} // namespace WinGUI


#endif //__SHARED_WINGUI_CONTROLS_PROGRESSINDICATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

