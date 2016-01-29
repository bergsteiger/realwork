////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/ReportView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::ReportView
//
// дилог построения отчета, например отчет о недокументированных элементах модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/ReportView.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/MDAGui/CreateReport.h"
#include "MDProcess/MDAAddinLib/MDAGui/AdvancedSearch.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "boost/lexical_cast.hpp"
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

//#UC START# *457415DF00BB_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.h"
//#UC END# *457415DF00BB_CUSTOM_INCLUDES*


//#UC START# *457415DF00BB*
void ReportView::run_query() {	
	m_result_list.DeleteAllItems ();
	while (m_result_list.GetHeaderCtrl()->GetItemCount() > 0) {
		m_result_list.DeleteColumn (m_result_list.GetHeaderCtrl()->GetItemCount() - 1);
	}		

	RoseHelper::check_model_for_changes ();
	RoseAbstractDumper::get_model_tree_root();
	const AbstractDumperBase::ReportsTreeItem* report;

	if (m_auto_run_rep) {
		report = m_auto_run_rep;
	} else {
		CString str;
		m_reports_combo.GetWindowText (str);
		AbstractDumperBase::ReportInfos::iterator f = AbstractDumperBase::s_report_infos.find ((const char*)str);
		assert (f != AbstractDumperBase::s_report_infos.end());
		report = f->second;
	}
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatch sw ("Report %s", report->name ().c_str ());
#endif

	unsigned i = 1;
	for (
		AbstractDumperBase::ReportsTreeItem::Views::const_iterator it = report->get_views().begin()
		; it != report->get_views().end()
		; it++
	) {
		m_result_list.InsertColumn (i++, it->name.data(), LVCFMT_LEFT, it->view_length );
	}

	//AbstractDumperBase::s_current_map = "h";

	m_result_list.EnableWindow (true);
	i = 0;

	RoseAbstractDumper::auto_locker lck;
	
	Helpers::ReportBuilder_var report_builder (Helpers::ReportBuilderFactory::make ());
	for (
		RoseElementVector::const_iterator items_it = m_items.begin ()
		; items_it != m_items.end ()
		; ++items_it
	) {

		const RoseAbstractDumper* rad_root = RoseAbstractDumper::find_in_tree (items_it->element);
		if (rad_root) {
			try {
				Core::Aptr<Helpers::ReportResult> result (report_builder->build (rad_root, report));

				for (
					Helpers::ReportResult::iterator it = result->begin ()
					; it != result->end ()
					; ++it
				) {
					int ind = 0; //column index
					IRoseElementPtr rose_element = it->element->rose_element ();
					for (
						GCL::StrVector::const_iterator mess_it = it->messages.begin ()
						; mess_it != it->messages.end()
						; ++mess_it
					) {
						if (ind == 0) {
							std::string str (*mess_it);
							if (IsVirtualFactory::get ().execute (rose_element)) {
								str.insert (0, "(virtual) ");
							}

							this->m_result_list.InsertItem (i, str.data());
						} else {
							this->m_result_list.SetItemText (i, ind, mess_it->c_str ());
						}
						ind++;
					}
				
					int img_id = RoseHelper::get_image_index (rose_element);
					
					if (img_id != -1) {
						this->m_result_list.SetItem (i, 0, LVIF_IMAGE, 0, img_id, 0, 0, 0);
					}
					
					this->m_result_list.SetItemData (i, reinterpret_cast<DWORD> (it->element));
					i++;
				}

				if (m_result_list.GetItemCount() == 0) {
					if (m_auto_run_rep && !m_auto_run_rep->get_auto ().empty ()) {
						this->OnOK ();
					} else {
						this->MessageBox ("Empty report's data", 0, MB_OK|MB_ICONINFORMATION);
					}
				}

			} catch (Base::FatalError& ex) {
				GenSupport::LogManagerFactory::get ().log_error (ex.what ());

				GenSupport::ErrorManagerFactory::get ().error (0, "Генерация отчета завершилась ошибкой", "Отчет");
				GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
				dlg.DoModal ();

				/*GenSupport::LogManagerFactory::get ().log_error ("Report genereating finished by Fatal error:");
				GenSupport::LogManagerFactory::get ().log_error (ex.what ());
				MessageBox ("Генерациия отчета завершилась ошибкой смотри лог для деталей", "Ошибка", MB_OK|MB_ICONEXCLAMATION );*/
			} catch (...) {
				//MessageBox ("Во время генерации Репорта произошло не обработанное исключение", "Ошибка", MB_OK|MB_ICONEXCLAMATION );
				GenSupport::ErrorManagerFactory::get ().error (0, "Во время генерации отчета произошло не обработанное исключение", "Отчет");
				GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
				dlg.DoModal ();
			}
		}
	}

}

void ReportView::OnLvnItemActivateResult(NMHDR *pNMHDR, LRESULT *pResult) {
	*pResult = 0;

	LPNMITEMACTIVATE pNMIA = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	
	RoseAbstractDumper* rad = (RoseAbstractDumper*) this->m_result_list.GetItemData(pNMIA->iItem);
	
	// cut-and-paste from ItemPropertyPage
	if (rad) {			
		IRoseItemPtr item_to_select = RoseHelper::get_nearest_container (rad->rose_element());
		IRoseDiagramPtr diag = RoseHelper::get_self_diagram (rad->rose_element());

		if (diag != 0) {
			IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
			diag->Activate();
			iview->SetSelected(true);
			diag->CenterDiagramToView(iview);
		} else {
			MessageBox("No diagrams availble");
		}
	}

	RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (rad->rose_element(), false, true);

	if (is_ok == RoseHelper::ER_DELETE) {
		m_result_list.DeleteItem (pNMIA->iItem);
		if (m_result_list.GetItemCount() == 0) {
			this->OnOK ();
		}
	}
}

void ReportView::OnBnClickedAdvancedSearch() {
	this->OnCancel();
	if (!m_items.empty ()) {
		Commands::CmdManagerFactory::get ().search (m_items[0].element);
	}
}

void ReportView::OnCbnSelchangeCombo1() {
	bool can_run = true;
	CString str;
	m_reports_combo.GetWindowText (str);
	if (str == "<Add custom>...") {
		CreateReport dlg;
		if (dlg.DoModal () == IDOK) {
			int count = m_reports_combo.GetCount ();
			//вставляем предпоследним (перед "<Add custom>...")
			int pos = m_reports_combo.InsertString (count - 1, dlg.get_report_name ().c_str ());
			if (pos > 0) {
				m_reports_combo.SetCurSel (pos);
			} else {
				can_run = false;
			}
		} else {
			can_run = false;
		}
	}
	m_run_btn.EnableWindow(can_run);
}

void ReportView::OnBnClickedButEdit() {
	int selection = m_result_list.GetSelectionMark();
	if (selection >= 0) {
		RoseAbstractDumper* rad = (RoseAbstractDumper*) this->m_result_list.GetItemData(selection);

		RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (rad->rose_element(), false, true);
		
		if (is_ok == RoseHelper::ER_DELETE) {
			m_result_list.DeleteItem (selection);
			if (m_result_list.GetItemCount() == 0) {
				this->OnOK ();
			}
		}
	}
}

void ReportView::OnBnClickedButBrowse() {
	int selection = m_result_list.GetSelectionMark();
	if (selection >= 0) {
		RoseAbstractDumper* rad = (RoseAbstractDumper*) this->m_result_list.GetItemData(selection);

		// cut-and-paste from ItemPropertyPage
		if (rad) {
			RoseHelper::browse_item (rad->rose_element());
		}
	}
}

void ReportView::OnBnClickedButBrowseClose() {
	this->OnBnClickedButBrowse();
	if (m_auto_run_rep && m_auto_run_rep->get_auto () != "") {
		this->OnBnClickedButBrowseClose2();
	}
}

void ReportView::OnBnClickedButBrowseClose3() {
	this->OnOK ();
}

void ReportView::OnBnClickedButBrowseClose2() {
	if (m_auto_run_rep && m_auto_run_rep->get_auto () != "") {
		CString txt = "Auto report \"";
		txt += m_auto_run_rep->name ().data();
		txt += "\" dump:";
		if (m_auto_run_rep->get_auto () == "Error") {
			GenSupport::LogManagerFactory::get ().log_error ((const char*)txt);
		} else {
			GenSupport::LogManagerFactory::get ().log_warning ((const char*)txt);
		}

		for (int i = 0; i < m_result_list.GetItemCount(); i++) {
			int l = 0;
			for (
				AbstractDumperBase::ReportsTreeItem::Views::const_iterator it = m_auto_run_rep->get_views().begin()
				; it != m_auto_run_rep->get_views().end()
				; it++, l++
			) {
				if (l == 0) {
					txt = "";
				} else {
					txt = "\t";
				}

				txt += it->name.data();
				txt += ": ";
				txt += m_result_list.GetItemText (i, l);
			
				if (m_auto_run_rep->get_auto () == "Error") {
					GenSupport::LogManagerFactory::get ().log_error ((const char*)txt);
				} else {
					GenSupport::LogManagerFactory::get ().log_warning ((const char*)txt);
				}
			}
		}
	}
	this->OnCancel ();
}
//#UC END# *457415DF00BB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ReportView::ReportView (
	const RoseElementVector& items
	, const AbstractDumperBase::ReportsTreeItem* auto_run_rep
) :
	WinGUI::ETSLayoutDialog (ReportView::IDD)
//#UC START# *458E8DD900C4_BASE_INIT*
	, m_items (items)
//#UC END# *458E8DD900C4_BASE_INIT*
{
	//#UC START# *458E8DD900C4_BODY*
	m_auto_run_rep = auto_run_rep;
	m_constructed = false;

	if (m_auto_run_rep && m_auto_run_rep->get_auto () != "") {
		m_mess = m_auto_run_rep->get_auto ();
		m_mess += ": ";
		m_mess += m_auto_run_rep->name ();

		if (m_auto_run_rep->get_auto () == "Error") {
			m_hIcon = ::LoadIcon(NULL, IDI_ERROR);
		} else if (m_auto_run_rep->get_auto () == "Warning") {
			m_hIcon = ::LoadIcon(NULL, IDI_EXCLAMATION);
		} else {
			m_hIcon = ::LoadIcon(NULL, IDI_INFORMATION);
		}
	} else {
		m_mess = "Report viewer";

		m_hIcon = ::LoadIcon(NULL, IDI_INFORMATION);
	}

	if (!m_items.empty ()) {
		GCL::StrVector items_names;

		m_mess += " (for: ";

		for (RoseElementVector::const_iterator it = m_items.begin (); it != m_items.end (); ++it) {
			IRoseItemPtr item = it->element;
			std::string component;
			if (item && item->GetContext () != 0 && !item->GetContext ()->IsClass(MODEL_TYPE)) {
				component = ((const char*)item->GetContext()->GetName());
				component += "::";
			}
			component += (const char*)item->GetName();			
			items_names.push_back (component);
		}
		m_mess += GCL::join (items_names, ", ");
		m_mess += ")";
		
	}
	m_mess += ":";
	//#UC END# *458E8DD900C4_BODY*
}

ReportView::~ReportView () {
	//#UC START# *457415DF00BB_DESTR_BODY*
	//#UC END# *457415DF00BB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ReportView, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *457415DF00BB_MESSAGE_MAP*
	ON_BN_CLICKED(IDC_BUTTON1, run_query)
	ON_NOTIFY(LVN_ITEMACTIVATE, IDC_RESULT, OnLvnItemActivateResult)
	ON_BN_CLICKED(IDC_ADVANCED_SEARCH, OnBnClickedAdvancedSearch)
	ON_CBN_SELCHANGE(IDC_COMBO1, OnCbnSelchangeCombo1)
	ON_BN_CLICKED(IDC_BUT_EDIT, OnBnClickedButEdit)
	ON_BN_CLICKED(IDC_BUT_BROWSE, OnBnClickedButBrowse)
	ON_BN_CLICKED(IDC_BUT_BROWSE_CLOSE, OnBnClickedButBrowseClose)
	ON_BN_CLICKED(IDC_BUT_BROWSE_CLOSE3, OnBnClickedButBrowseClose3)
	ON_BN_CLICKED(IDC_BUT_BROWSE_CLOSE2, OnBnClickedButBrowseClose2)
	//#UC END# *457415DF00BB_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ReportView, CDialog)

void ReportView::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *457415DF00BB_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_RESULT, m_result_list);
	DDX_Control(pDX, IDC_COMBO1, m_reports_combo);
	DDX_Control(pDX, IDC_BUTTON1, m_run_btn);
	DDX_Control(pDX, IDC_BUT_BROWSE_CLOSE3, m_ok_btn);
	DDX_Control(pDX, IDC_BUT_BROWSE_CLOSE2, m_cancel_btn);
	DDX_Control(pDX, IDC_BUT_EDIT, m_edit_btn);
	DDX_Control(pDX, IDC_BUT_BROWSE, m_browse_btn);
	DDX_Control(pDX, IDC_BUT_BROWSE_CLOSE, m_bnc_btn);
	//#UC END# *457415DF00BB_DO_DATA_EXCHANGE*
}

BOOL ReportView::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *457415DF00BB_ON_INIT_DLG*
		this->SetIcon(m_hIcon, false);

		this->SetWindowText (m_mess.data());
		
		m_run_btn.EnableWindow(false);

		m_il = new CImageList ();
		m_il->Create (RoseHelper::get_rose_image_list ());
		m_result_list.SetImageList (m_il.in(), LVSIL_SMALL);
		m_result_list.EnableWindow (false);

		for (
			AbstractDumperBase::ReportInfos::iterator it = AbstractDumperBase::s_report_infos.begin()
			; it != AbstractDumperBase::s_report_infos.end()
			; it++
		) {
			m_reports_combo.AddString (it->first.data());
		}
		m_reports_combo.InsertString (-1, "<Add custom>...");
		m_constructed = true;

		if (m_auto_run_rep) {
			m_run_btn.EnableWindow(true);

			if (m_reports_combo.SelectString (0, m_auto_run_rep->name().data()) == LB_ERR) {
				m_reports_combo.AddString (m_auto_run_rep->name().data());
				m_reports_combo.SelectString (0, m_auto_run_rep->name().data());
			};

			m_reports_combo.EnableWindow (false);
			if (m_auto_run_rep->get_auto () == "Error") {
				m_ok_btn.ShowWindow (SW_HIDE);
			} 
			this->run_query ();
		} else {
			m_ok_btn.ShowWindow (SW_HIDE);
			m_cancel_btn.ShowWindow (SW_HIDE);
		}
		//#UC END# *457415DF00BB_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ReportView\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int ReportView::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void ReportView::init_constraint () {
	//#UC START# *457415DF00BB_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_STATIC, NORESIZE)
			<< item (IDC_COMBO1, GREEDY)
			<< item (IDC_BUTTON1, NORESIZE)
			<< item (IDC_ADVANCED_SEARCH, NORESIZE)
		)
		<< item (IDC_RESULT, GREEDY)
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< item (IDC_BUT_EDIT, NORESIZE)
				<< item (IDC_BUT_BROWSE, NORESIZE)
				<< item (IDC_BUT_BROWSE_CLOSE, NORESIZE)
				<< itemGrowing (HORIZONTAL)
				<< item( IDC_BUT_BROWSE_CLOSE3, NORESIZE )
				<< item( IDC_BUT_BROWSE_CLOSE2, NORESIZE )
		);
	//#UC END# *457415DF00BB_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

