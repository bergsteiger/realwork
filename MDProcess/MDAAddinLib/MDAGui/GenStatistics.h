////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/MDAGui/GenStatistics.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::GenStatistics
//
// ����� ���������� ��������� - ���������� ������ �����, ������������, �������������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_GENSTATISTICS_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_GENSTATISTICS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include <map>
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAAddinLib/MDAGui/ListCtrlWithCopy.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457416330177_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "afxwin.h"
//#UC END# *457416330177_CUSTOM_INCLUDES*


// ����� ���������� ��������� - ���������� ������ �����, ������������, �������������� ����������
class GenStatistics : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (GenStatistics)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��������� ��������� ��������� ������
	typedef std::set < std::string > TempFileSet;

	// ��� �������� � ������ ��������������� ����������
	enum ItemType {
		ET_ARTEFACT // ������� - ��� �������� ���������
		, ET_NAME_DEL // ������� - ��� �������� ��� ������ �������� ���������
		, ET_NAME_EQ // ������� - ��� �������� ��� ������ �������������� ���������
		, ET_NAME_CHG // ������� - ��� �������� ��� ������ ������������ ���������
		, ET_NAME_NEW // ������� - ��� �������� ��� ������ ����� ���������
	};

	// ���������� �� �������� ������
	struct ItemInfo {
		// ��� ��������
		ItemType type;
		// ������ ��������� ��������� � ���������
		const AbstractDumper::GenArtData* art_data;
	};

	// ������� ��� ��������� ItemInfo
	struct ItemInfoLess : public std::binary_function<ItemInfo, ItemInfo, bool> {
		bool operator () (const ItemInfo& first_param_, const ItemInfo& second_param_) const;
	};

	// ���� ������ �������� � ������ -> ����������
	typedef std::map < int, ItemInfo > IndexToInfo;

	// ���� �������� �����, ��������� � ���������� ���������
	typedef std::map < const ItemInfo, std::string, ItemInfoLess > GenArtDataToText;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_GEN_STATISTICS };

public:
	GenStatistics ();

public:
	virtual ~GenStatistics ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(GenStatistics)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
public:
	// ���������� true, ���� ���� ���������� ����� "Minor changes", ����� false
	virtual bool is_minor_changes () const;

	// ����� ������� ����� ��������� ��������� �����
	virtual void remove_temp_files ();

protected:
	// ��������� � ���� � ��������� ��������� ������
	virtual void add_temp_file (const std::string& file);

private:
	// ����������� - ��� ���������� ���������� ���������� ����, ��� ����� � �������� �������� �������
	// �������� � ��������� ���������
	virtual void do_details (int index);

	// �������� ��������� ��� �������� � ������� index � ������
	virtual void do_restore (int index);

	// ��������� ����������� ������ ���������
	virtual void fill_list (ItemType type, CListCtrl& lb);

	// ��������� ���������� �� ���������.
	virtual void fill_statistic ();

	// ���������� ����� ��� �������� ������
	virtual const char* get_item_text (const ItemInfo& info);

	// ���������� ������������ ����� ������ � ������
	virtual int get_max_text_width () const;

	// ���������� �������� ��� ��������� ���������
	virtual const std::string get_text_for_art (const AbstractDumper::GenArtData& key) const;

	// ���������� ������� ������ Apply - ��������� ��������� ��� ���������� � ������ ����������
	virtual void on_apply ();

	// ���������� ������� ������ "Diff" - ���������� ����.
	virtual void on_diff ();

	// ���������� ������ "Restore" - �������� ��������� ��������� � ���������� � ������ ����������.
	virtual void on_restore ();

	// �������� ��������� ��� ���� ����������
	virtual void on_restore_all ();

	// �������������� ������ ��� ����������� � ������
	virtual void prepare_item_texts () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������ ���������, ������� "�������" Apply - ����� ��� ����, ����� ����� �� �������� ��� ����
	// ��������� restore
	AbstractDumper::ArtefactSet m_applied_arts;

	// �������-������ ���������� ����������
	ListCtrlWithCopy m_details;

	// ���� ��� ��������� �� ������ �������� � ������ ���������� �� ���� ��������
	IndexToInfo m_index2info;

	// ���� ������ �����,  ��������� � ���������� ���������, �������������� � �������� ���������
	mutable GenArtDataToText m_list_texts;

	// ���� ������������ �������� ��������� ������� ��� ���
	int m_minor_changes;

	// ��������� ��������� ��������� ������
	TempFileSet m_temp_files;

//#UC START# *457416330177*
private:
	//notifies handlers
	void on_dbl_click(NMHDR* pNMHDR, LRESULT* pResult);
	void on_get_item_info(NMHDR* pNMHDR, LRESULT* pResult);
	void on_select_item(NMHDR* pNMHDR, LRESULT* pResult);	
	
	void on_key_down (NMHDR* pNMHDR, LRESULT* pResult);

	const AbstractDumper::GenArtData* GenStatistics::get_item_data (int item) const;

	//controls
	CButton	m_diff_btn;
	CButton	m_restore_btn;
	CButton	m_apply_btn;
	CStatic	m_total;
	CStatic	m_new;
	CStatic	m_equ;
	CStatic	m_chg;
	CStatic m_del;
//#UC END# *457416330177*
}; // class GenStatistics



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_GENSTATISTICS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

