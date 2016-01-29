////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/GenStatistics.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::GenStatistics
//
// дилог статистики генерации - показывает список новых, изменившихся, неизменившихся артефактов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenStatistics.h"

//#UC START# *457416330177_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "shared/GCL/os/FileOp.h"
#include "shared/GCL/str/str_op.h"
#include <boost/lexical_cast.hpp>
//#UC END# *457416330177_CUSTOM_INCLUDES*


//#UC START# *457416330177*
GCL::StrSet get_changed_diags_guid (const AbstractDumper::GenArtData* key) {
	GCL::StrSet ret;
	const AbstractDumper::GenSourceInfoToDumpersMap& source_map = AbstractDumperBase::get_source_to_dumpers ();
	AbstractDumper::GenSourceInfoToDumpersMap::const_iterator f_it = source_map.find (key->source_info);

	if (f_it != source_map.end ()) {
		AbstractDumperBase::ADList dumpers (f_it->second.begin (), f_it->second.end ());
		AbstractDumperBase::ADList::iterator list_it_end = std::unique (dumpers.begin (), dumpers.end ());
		AbstractDumperBase::ADList::iterator list_it = dumpers.begin ();							
		for (; list_it != list_it_end; ++list_it) {
			if ((*list_it)->is_changed ()) {
				std::string guid = (*list_it)->get_model_unique_id_str () + ".jpg";
				ret.insert (guid);
			}
		}
	}
	return ret;
}

GCL::StrSet get_diags_guid (const AbstractDumperBase* adb) {
	GCL::StrSet ret;
	if (adb) {
		Core::Aptr<AbstractDumperBase::ADList> diags = adb->get_diagrams ();
		if (diags.is_nil () == false) {
			for (
				AbstractDumperBase::ADList::iterator it = diags->begin ()
				; it != diags->end ()
				; ++it
			) {
				std::string diag_guid = (*it)->get_model_unique_id_str () + ".jpg";
				ret.insert (diag_guid);
				/*CORBA::String_var diag_hash 
					= key->source_info.source.wiki_page ()->get_diagram_hash (
						diag_guid.data ()
					);
				if (ACE_OS::strcmp (diag_hash.in (), "") != 0) {
					stream << diag_guid << ": "<< diag_hash.in () << std::endl;
				}*/
			}
		}
	}
	return ret;
}

template <class T>
void dump_diags_hash (
	const AbstractDumper::GenArtData* key
	, T* page
	, bool dump_changed
	, std::ostream& out_stream
) {
	GCL::StrSet diags_guid = get_diags_guid (key->dumper);
	GCL::StrSet changed_diags = get_changed_diags_guid (key);
	for (
		GCL::StrSet::iterator it = diags_guid.begin ()
		; it != diags_guid.end ()
		; ++it
	) {
		CORBA::String_var diag_hash (
			page->get_diagram_hash (
				it->c_str ()
			)
		);
		if (diag_hash.in () && ACE_OS::strcmp (diag_hash.in (), "") != 0) {
			out_stream << *it << ": "<< diag_hash.in ();
			if (dump_changed && changed_diags.find (*it) != changed_diags.end ()) {
				out_stream << ", coords changed";
			}
			out_stream << std::endl;
		}
	}
}

void GenStatistics::on_dbl_click(NMHDR* pNMHDR, LRESULT* pResult) {
	*pResult = 0;

	LPNMITEMACTIVATE pNMIA = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);	
	this->do_details (pNMIA->iItem);	
}

void GenStatistics::on_get_item_info(NMHDR* pNMHDR, LRESULT* pResult) {
	*pResult = 0;

	NMLVDISPINFO *pDispInfo = reinterpret_cast<NMLVDISPINFO*>(pNMHDR);

	if (pDispInfo->item.mask & LVIF_TEXT) {
		int item = pDispInfo->item.iItem;
		IndexToInfo::const_iterator it = m_index2info.find (item);
		if (it != m_index2info.end ()) {
			const char* text = get_item_text (it->second);
			if (text != 0) {
				pDispInfo->item.mask |= LVIF_DI_SETITEM; // это чтобы больше он не спрашивал чего писать
				pDispInfo->item.pszText = const_cast<char*> (text);

				m_details.SetColumnWidth (0, get_max_text_width ());
			}
		}
	}
}

const AbstractDumper::GenArtData* GenStatistics::get_item_data (int item) const {	
	IndexToInfo::const_iterator it = m_index2info.find (item);
	return (it != m_index2info.end ()) ? it->second.art_data : 0;
}

void GenStatistics::on_select_item (NMHDR* pNMHDR, LRESULT* pResult) {
	*pResult = 0;

	LPNMITEMACTIVATE pNMIA = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	
	const AbstractDumper::GenArtData* key 
		= get_item_data (pNMIA->iItem);

	if (key == 0) {
		m_diff_btn.EnableWindow(false);
		m_restore_btn.EnableWindow(false);
		m_apply_btn.EnableWindow(false);
	} else if (key->status == AbstractDumper::SS_EQ) {
		m_diff_btn.EnableWindow(true);
		m_apply_btn.EnableWindow(false);
		m_restore_btn.EnableWindow(false);
	} else if (key->status == AbstractDumper::SS_DEL || key->status == AbstractDumper::SS_NEW) {
		m_diff_btn.EnableWindow(false);
		m_restore_btn.EnableWindow(true);
		m_apply_btn.EnableWindow(true);
	} else {
		m_diff_btn.EnableWindow(true);
		m_restore_btn.EnableWindow(true);
		m_apply_btn.EnableWindow(true);
	} 
}


struct SortArtByName
	: public std::binary_function<AbstractDumper::GenArtData, AbstractDumper::GenArtData, bool>
{
	SortArtByName (const GenStatistics::GenArtDataToText& texts) 
		: m_texts (texts)
	{
	}

	bool operator()(const AbstractDumper::GenArtData* const x, const AbstractDumper::GenArtData* const y) const {
		GenStatistics::ItemInfo info_x;
		GenStatistics::ItemInfo info_y;
		info_x.art_data = x;
		info_x.type = GenStatistics::ET_ARTEFACT;
		
		info_y.art_data = y;
		info_y.type = GenStatistics::ET_ARTEFACT;
		
		GenStatistics::GenArtDataToText::const_iterator x_it = m_texts.find (info_x);
		GenStatistics::GenArtDataToText::const_iterator y_it = m_texts.find (info_y);

		std::string x_str ((x_it != m_texts.end ()) ? x_it->second : "");
		std::string y_str ((y_it != m_texts.end ()) ? y_it->second : "");

		return x_str < y_str;
	}
private:
	const GenStatistics::GenArtDataToText& m_texts;
};

struct SortArtByType
	: public std::binary_function<AbstractDumper::GenArtData, AbstractDumper::GenArtData, bool>
{	
	SortArtByType (const GenStatistics::GenArtDataToText& texts) 
		: m_texts (texts)
	{
	}
	bool operator()(const AbstractDumper::GenArtData* const x, const AbstractDumper::GenArtData* const y) const {
		if (x->source_info.source.d_ () == y->source_info.source.d_ ()) {
			GenStatistics::ItemInfo info_x;
			GenStatistics::ItemInfo info_y;
			info_x.art_data = x;
			info_x.type = GenStatistics::ET_ARTEFACT;
			
			info_y.art_data = y;
			info_y.type = GenStatistics::ET_ARTEFACT;
			
			GenStatistics::GenArtDataToText::const_iterator x_it = m_texts.find (info_x);
			GenStatistics::GenArtDataToText::const_iterator y_it = m_texts.find (info_y);

			std::string x_str ((x_it != m_texts.end ()) ? x_it->second : "");
			std::string y_str ((y_it != m_texts.end ()) ? y_it->second : "");
			
			return x_str == y_str ? x < y : x_str < y_str;
		} else {
			return x->source_info.source.d_ () < y->source_info.source.d_ ();
		}
	}
private:
	const GenStatistics::GenArtDataToText& m_texts;
};
//#UC END# *457416330177*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool GenStatistics::ItemInfoLess::operator () (const ItemInfo& first_param_, const ItemInfo& second_param_) const {
	//#UC START# *4923AA23017C_IMPL*
	return first_param_.type == second_param_.type 
		? first_param_.art_data < second_param_.art_data
		: first_param_.type < second_param_.type;
	//#UC END# *4923AA23017C_IMPL*
}

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GenStatistics::GenStatistics ()
	: WinGUI::ETSLayoutDialog (GenStatistics::IDD)
//#UC START# *457416330177_CTOR_BASE_INIT*
//#UC END# *457416330177_CTOR_BASE_INIT*
{
	//#UC START# *457416330177_CTOR*
	m_minor_changes = BST_CHECKED;
	//#UC END# *457416330177_CTOR*
}


GenStatistics::~GenStatistics () {
	//#UC START# *457416330177_DESTR_BODY*
	//#UC END# *457416330177_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(GenStatistics, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *457416330177_MESSAGE_MAP*
	ON_WM_SIZE()
	ON_BN_CLICKED(IDC_DIFF, on_diff)
	ON_BN_CLICKED(IDC_RESTORE, on_restore)
	ON_BN_CLICKED(IDC_APPLY, on_apply)
	ON_BN_CLICKED(IDC_RESTORE_ALL, on_restore_all)
	ON_NOTIFY(LVN_GETDISPINFO, IDC_DETAILS, on_get_item_info)
	ON_NOTIFY(NM_CLICK, IDC_DETAILS, on_select_item)
	ON_NOTIFY(NM_DBLCLK, IDC_DETAILS, on_dbl_click)	
	//#UC END# *457416330177_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(GenStatistics, CDialog)

void GenStatistics::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *457416330177_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_DIFF, m_diff_btn);
	DDX_Control(pDX, IDC_RESTORE, m_restore_btn);
	DDX_Control(pDX, IDC_APPLY, m_apply_btn);
	DDX_Control(pDX, IDC_TOTAL, m_total);
	DDX_Control(pDX, IDC_NEW, m_new);
	DDX_Control(pDX, IDC_EQU, m_equ);
	DDX_Control(pDX, IDC_CHG, m_chg);
	DDX_Control(pDX, IDC_DETAILS, m_details);
	DDX_Control(pDX, IDC_DEL, m_del);
	DDX_Check (pDX, IDC_MINOR_CHANGES, m_minor_changes);
	//#UC END# *457416330177_DO_DATA_EXCHANGE*
}

BOOL GenStatistics::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *457416330177_ON_INIT_DLG*
		//Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
		//подготавливаем данные для отображения
		this->prepare_item_texts ();

		m_applied_arts.clear ();
		m_minor_changes = BST_CHECKED;
		
		m_details.InsertColumn (0, "", LVCFMT_LEFT, this->get_max_text_width ());
		
		this->fill_statistic ();
		//#UC END# *457416330177_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"GenStatistics\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int GenStatistics::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void GenStatistics::init_constraint () {
	//#UC START# *457416330177_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_STATIC1, NORESIZE)
			<< item (IDC_TOTAL, NORESIZE)
		) << (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_STATIC2, NORESIZE)
			<< item (IDC_DEL, NORESIZE)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_STATIC3, NORESIZE)
			<< item (IDC_NEW, NORESIZE)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_STATIC4, NORESIZE)
			<< item (IDC_CHG, NORESIZE)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_STATIC5, NORESIZE)
			<< item (IDC_EQU, NORESIZE)
		) 
		<< item (IDC_STATIC6, NORESIZE)
		<< item (IDC_DETAILS, GREEDY)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_DIFF, NORESIZE)
			<< item (IDC_RESTORE, NORESIZE)
			<< item (IDC_APPLY, NORESIZE)
			<< item (IDC_RESTORE_ALL, NORESIZE)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_MINOR_CHANGES, NORESIZE)
			<< item (IDOK, NORESIZE)
		);
	//#UC END# *457416330177_CUSTOM_CONTROLS_CONSTRAINT*
}


// добавляет в файл в множество временных файлов
void GenStatistics::add_temp_file (const std::string& file) {
	//#UC START# *464977A20128*
	m_temp_files.insert (file);
	//#UC END# *464977A20128*
}

// детелизация - для измененных артефактов показывает дифу, для новых и удалённых пытается открыть
// артефакт в системном редакторе
void GenStatistics::do_details (int index) {
	//#UC START# *4922C6490312*
	const AbstractDumper::GenArtData* key 
		= get_item_data (index);
	if (!key) {
		return;
	}

	if (key->status != AbstractDumper::SS_CHG) {
		std::string fn;
		if (key->source_info.source.d_ () == AbstractDumper::GST_FILE) {
			if (key->status == AbstractDumper::SS_NEW) {
				fn = AbstractDumper::create_gen_file_name(key->source_info.source.file_name());
			} else {
				// EQ or DEL
				fn = key->source_info.source.file_name();
			}
			HINSTANCE err_border = (HINSTANCE)32;
			if (ShellExecute(NULL, "open", fn.data(), NULL, NULL, SW_SHOWNORMAL) < err_border) {
				MessageBox ("Cant open selected file (shell command OPEN returns error)", "ERROR", MB_OK|MB_ICONEXCLAMATION);
			}
		} else if (key->source_info.source.d_ () == AbstractDumper::GST_WIKI) {
			if (key->source_info.source.wiki_page () != 0) {				
				ACE_TCHAR filename_[MAXPATHLEN + 1];
				// Create a temporary file.
				if (ACE::get_temp_dir (filename_, MAXPATHLEN - 11) != -1) {
					// Add the filename to the end
					std::string templ = key->dumper->get_model_unique_id_str () + key->source_info.gen_id;
					fn += filename_ + templ + ".txt";
					std::ofstream new_file (fn.c_str (), std::ios_base::out);
					if (new_file.is_open () == false) {
						LOG_E (("Can't open file \"%s\" for writing", fn.c_str ()));
					} else {						
						new_file << "Private data:" << std::endl;
						
						//выводим путь к странице
						//CORBA::String_var path = key->source_info.source.wiki_page ()->get_path ();
						//new_file << "Path: "<< path.in () << std::endl;
						new_file << "Path: "<< key->source_info.source.wiki_page ()->get_path () << std::endl;
						

						//выводим хэши всех диаграмм
						dump_diags_hash (key, key->source_info.source.wiki_page (), false, new_file);
						
						/*GCL::StrSet diags_guid = get_diags_guid (key->dumper);
						for (
							GCL::StrSet::iterator it = diags_guid.begin ()
							; it != diags_guid.end ()
							; ++it
						) {
							CORBA::String_var diag_hash 
								= key->source_info.source.wiki_page ()->get_diagram_hash (
									it->c_str ()
								);
							if (ACE_OS::strcmp (diag_hash.in (), "") != 0) {
								new_file << *it << ": "<< diag_hash.in () << std::endl;
							}
						}*/

						//выводим выставленные лэйблы
						/*CORBA::String_var labels = key->source_info.source.wiki_page ()->get_labels ();
						if (ACE_OS::strcmp (labels.in (), "") != 0) {
							new_file << "Labels: "<< labels.in () << std::endl;
						}*/

						std::string labels = key->source_info.source.wiki_page ()->get_labels ();
						if (!labels.empty ()) {
							new_file << "Labels: "<< labels << std::endl;
						}
						
						new_file << std::endl << "Page text:" << std::endl;
						//CORBA::String_var text = key->source_info.source.wiki_page ()->get_generated_text ();
						//new_file << text.in ();
						new_file << key->source_info.source.wiki_page ()->get_generated_text ();
						new_file.close ();
						
						HINSTANCE err_border = (HINSTANCE)32;
						if (ShellExecute(NULL, "open", fn.data(), NULL, NULL, SW_SHOWNORMAL) < err_border) {
							MessageBox ("Cant open selected file (shell command OPEN returns error)", "ERROR", MB_OK|MB_ICONEXCLAMATION);
						}
						this->add_temp_file (fn);						
					}
				} else {
					LOG_E (("Can't get temp dir"));
				}
			}
		}		
		return;
	}

	std::string REGISTRY_KEY_PATH = "SOFTWARE\\Garant\\MDAGenerator";
	std::string REGISTRY_OPTION_NAME = "DiffProgram";
	std::string DEFAULT_OPTION_VALUE = "C:\\Program Files\\Araxis\\Araxis Merge v6.5\\compare.exe";

	std::string diff_app_name = Core::RegistryHelper::get_option_value (
		Core::RegistryHelper::KEY_LOCAL_MACHINE
		, REGISTRY_KEY_PATH
		, REGISTRY_OPTION_NAME
		, DEFAULT_OPTION_VALUE
	);
	
	std::string new_file;
	std::string old_file;
	std::string args = "\"";
	args += diff_app_name;
	args += "\"";
	args += " ";
	if (key->source_info.source.d_ () == AbstractDumper::GST_FILE) {
		old_file = key->source_info.source.file_name().data();		
		new_file = AbstractDumper::create_gen_file_name (key->source_info.source.file_name()).data();
	} else if (key->source_info.source.d_ () == AbstractDumper::GST_WIKI) {
		if (key->source_info.source.wiki_page () != 0) {
			ACE_TCHAR filename_[MAXPATHLEN + 1];			
			// Create a temporary file.
			if (ACE::get_temp_dir (filename_, MAXPATHLEN) != -1) {
				// Add the filename to the end
				// Create a temporary file.				 				
				std::string templ = filename_+ key->dumper->get_model_unique_id_str () + key->source_info.gen_id;				
				old_file = templ + "_old.txt";
				std::ofstream old_file_stream (old_file.c_str (), std::ios_base::out);
				
				GCL::StrSet diags_guid = get_diags_guid (key->dumper);

				if (old_file_stream.is_open () == false) {
					LOG_E (("Can't open file \"%s\" for writing", old_file.c_str ()));
				} else {
					ServerGate::GenerationContents::Page_var page_before_changes = 
						key->source_info.source.wiki_page ()->get_page_before_changes ();
					
					old_file_stream << "Private data:" << std::endl;					

					//выводим путь к странице
					CORBA::String_var path = page_before_changes->get_path ();
					old_file_stream << "Path: "<< path.in () << std::endl;
					old_file_stream << "Metadatas checksum: " << page_before_changes->get_all_property_cheksum () << std::endl;
					
					dump_diags_hash (key, page_before_changes.in (), false, old_file_stream);
					
					CORBA::String_var labels = page_before_changes->get_labels ();
					if (ACE_OS::strcmp (labels.in (), "") != 0) {
						old_file_stream << "Labels: "<< labels.in () << std::endl;
					}
					CORBA::String_var old_text 
						= page_before_changes->get_generated_text ();
					old_file_stream << std::endl << "Page text:" << std::endl;
					old_file_stream << old_text.in ();					
					old_file_stream.close ();
					this->add_temp_file (old_file);
				}				
				new_file = templ + "_new.txt";
				std::ofstream new_file_stream (new_file.c_str (), std::ios_base::out);
				if (new_file_stream.is_open () == false) {
					LOG_E (("Can't open file \"%s\" for writing", new_file.c_str ()));
				} else {
					
					new_file_stream << "Private data:" << std::endl;
					//выводим путь к странице
					//CORBA::String_var path = key->source_info.source.wiki_page ()->get_path ();
					//new_file_stream << "Path: "<< path.in () << std::endl;
					new_file_stream << "Path: "<< key->source_info.source.wiki_page ()->get_path () << std::endl;
					new_file_stream << "Metadatas checksum: " << key->source_info.source.wiki_page ()->get_all_property_cheksum () << std::endl;
					
					dump_diags_hash (key, key->source_info.source.wiki_page (), true, new_file_stream);
													
					/*CORBA::String_var labels = key->source_info.source.wiki_page ()->get_labels ();
					if (ACE_OS::strcmp (labels.in (), "") != 0) {
						new_file_stream << "Labels: "<< labels.in () << std::endl;
					}*/
					std::string labels = key->source_info.source.wiki_page ()->get_labels ();
					if (!labels.empty ()) {
						new_file_stream << "Labels: "<< labels << std::endl;
					}
					
					new_file_stream << std::endl << "Page text:" << std::endl;
					//CORBA::String_var new_text = key->source_info.source.wiki_page ()->get_generated_text ();
					//new_file_stream << new_text.in ();
					
					new_file_stream << key->source_info.source.wiki_page ()->get_generated_text ();
					new_file_stream.close ();
					this->add_temp_file (new_file);
				}
			} else {
				LOG_E (("Can't get temp dir"));
			}
		}
	}
	args += "\"" + old_file + "\"";
	args += " ";
	args += "\"" + new_file+ "\"";
	STARTUPINFO si;
	PROCESS_INFORMATION pi;

	ZeroMemory( &si, sizeof(si) );
	si.cb = sizeof(si);
	ZeroMemory( &pi, sizeof(pi) );

	if (CreateProcess (
		diff_app_name.data()
		, (char*) args.data()
		, NULL
		, NULL
		, false
		, 0
		, NULL
		, NULL
		, &si
		, &pi
	)) {
		CloseHandle(pi.hThread);

		//if (WaitForSingleObject(pi.hProcess, INFINITE) == WAIT_FAILED) {
		//	TerminateProcess(pi.hProcess, WAIT_FAILED);
		//}

		CloseHandle(pi.hProcess);
	} else {
		MessageBox ("Cant execute DIFF programm. Check path an registry data.", "ERROR", MB_OK|MB_ICONEXCLAMATION);
	}
	//#UC END# *4922C6490312*
}

// отменяет изменения для элемента с номером index в списке
void GenStatistics::do_restore (int index) {
	//#UC START# *4922C60F02FE*
	const AbstractDumper::GenArtData* key = get_item_data (index);
	
	//восстанавливаем ТОЛЬКО изменённые элементы
	if (
		key 
		&& key->status != AbstractDumper::SS_EQ
		&& m_applied_arts.find (key) == m_applied_arts.end ()
	) {
		AbstractDumper::get_artefacts ().restore (*key);
		AbstractDumperBase::erase_source (key->source_info);
	}
	//#UC END# *4922C60F02FE*
}

// заполняет информацией список генерации
void GenStatistics::fill_list (ItemType type, CListCtrl& lb) {
	//#UC START# *4922C4FC0146*
	class local {
	public:
		static AbstractDumper::ArtefactSet* get_arts (ItemType type) {
			Core::Aptr<AbstractDumper::ArtefactSet> ret;
			switch (type) {
				case ET_NAME_DEL: 
					ret = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_DEL);
					break;
				case ET_NAME_EQ: 
					ret = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_EQ);
					break;
				case ET_NAME_CHG: 
					ret = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_CHG);
					break;
				case ET_NAME_NEW: 
					ret = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_NEW);
					break;
				default: 
					break;
			}
			return ret.forget ();
		}
	};
	int i = m_index2info.size ();
	m_index2info[i].art_data = 0;
	m_index2info[i].type = type;
	i = m_index2info.size ();
			
	Core::Aptr<AbstractDumper::ArtefactSet> arts = local::get_arts (type);	
	if (!arts.is_nil ()) {
		this->prepare_item_texts ();
		typedef std::set<const AbstractDumper::GenArtData*, SortArtByType> SortedArtefactSet;
		SortArtByType sort_functor (m_list_texts);
		SortedArtefactSet sorted_arts (arts->begin(), arts->end(), sort_functor); 
		for (SortedArtefactSet::const_iterator it = sorted_arts.begin(); it != sorted_arts.end(); it++, i++) {
			m_index2info[i].art_data = *it;
			m_index2info[i].type = ET_ARTEFACT;
		}
	}
	//#UC END# *4922C4FC0146*
}

// формирует информацию по генерации.
void GenStatistics::fill_statistic () {
	//#UC START# *4922C4C0007B*
	//Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	m_details.DeleteAllItems ();
	m_index2info.clear ();

	AbstractDumper::get_artefacts ().correct_data ();

	char buf[256];
	Core::Aptr<AbstractDumper::ArtefactSet> chg_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_CHG);
	Core::Aptr<AbstractDumper::ArtefactSet> new_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_NEW);
	Core::Aptr<AbstractDumper::ArtefactSet> del_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_DEL);
	Core::Aptr<AbstractDumper::ArtefactSet> eq_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_EQ);
		
	m_total.SetWindowText (
		itoa(chg_a->size() + eq_a->size() + new_a->size(), buf, 10)
	);
	
	m_equ.SetWindowText (
		itoa(eq_a->size(), buf, 10)
	);
	
	m_new.SetWindowText (
		itoa(new_a->size(), buf, 10)
	);
	
	m_chg.SetWindowText (
		itoa(chg_a->size(), buf, 10)
	);
	
	m_del.SetWindowText (
		itoa(del_a->size(), buf, 10)
	);
	
	fill_list (ET_NAME_DEL, m_details);
	fill_list (ET_NAME_NEW, m_details);
	fill_list (ET_NAME_CHG, m_details);
	fill_list (ET_NAME_EQ, m_details);
	
	int total_count = chg_a->size() + eq_a->size() + new_a->size() + del_a->size () + 4; // 4 - названия списков
	m_details.SetItemCountEx(total_count);

	m_details.EnsureVisible (0, FALSE);
	m_details.SetItemState (0, LVIS_SELECTED | LVIS_FOCUSED, LVIS_SELECTED | LVIS_FOCUSED);

	m_diff_btn.EnableWindow(false);
	m_restore_btn.EnableWindow(false);
	m_apply_btn.EnableWindow(false);
	//#UC END# *4922C4C0007B*
}

// возвращает текст для элемента списка
const char* GenStatistics::get_item_text (const ItemInfo& info) {
	//#UC START# *492392C002EF*
	const char* result = 0;
	this->prepare_item_texts ();

	GenArtDataToText::const_iterator it = m_list_texts.find (info);
	if (it == m_list_texts.end ()) {
		std::string text (info.art_data != 0 ? this->get_text_for_art (*info.art_data) : "");
		it = m_list_texts.insert (std::make_pair (info, text)).first;
	}
	result = it->second.c_str ();

	return result;
	//#UC END# *492392C002EF*
}

// возвращает максимальную длину текста в списке
int GenStatistics::get_max_text_width () const {
	//#UC START# *4923AFC00258*
	int max_width = -1;

	this->prepare_item_texts ();
	// определяем текущий шрифт списка 
	CFont* font = m_details.GetFont(); 

	// создаем контекст для измерения ширины строк 
	CClientDC dc (const_cast<GenStatistics*> (this)); 
	font = dc.SelectObject(font);

	//вычисляем максимальную ширину строки
	for (
		GenArtDataToText::const_iterator it = m_list_texts.begin ()
		; it != m_list_texts.end ()
		; ++it
	) {			
		SIZE size = dc.GetTextExtent(it->second.c_str (), it->second.size ());
		max_width = std::max<int> (max_width, size.cx);			
	}
	dc.SelectObject(font);

	return max_width + 6;
	//#UC END# *4923AFC00258*
}

// возвращает описание для артефакта генерации
const std::string GenStatistics::get_text_for_art (const AbstractDumper::GenArtData& key) const {
	//#UC START# *4923DCCC01D3*
	std::string text ("    ");
	if (key.source_info.source.d_() == AbstractDumper::GST_FILE) {
		text += "file: ";
		text += key.source_info.source.file_name();
	} else if (key.source_info.source.d_() == AbstractDumper::GST_WIKI) {
		if (key.source_info.source.wiki_page () != 0) {
			text += "page: ";
			//CORBA::String_var page_path = key.source_info.source.wiki_page ()->get_path ();
			//text += page_path.in ();
			text += key.source_info.source.wiki_page ()->get_path ();
		}
	} else {
		GDS_ASSERT (0);
	}
	AbstractDumperBase::GenID  tmp_map = AbstractDumperBase::s_current_map;
	AbstractDumperBase::s_current_map = key.source_info.gen_id;

	if (key.dumper && key.dumper->get_post_command_str() != "") {
		text += "   <!>";
	} 

	AbstractDumperBase::s_current_map = tmp_map;				
	return text;
	//#UC END# *4923DCCC01D3*
}

// возвращает true, если была поставлена галка "Minor changes", иначе false
bool GenStatistics::is_minor_changes () const {
	//#UC START# *4677DE1F0261*
	return (m_minor_changes == BST_CHECKED);
	//#UC END# *4677DE1F0261*
}

// обработчик нажатия кнопки Apply - применяет изменения для выделенных в списке артефактов
void GenStatistics::on_apply () {
	//#UC START# *4922C53A0110*
	try {
		POSITION pos = m_details.GetFirstSelectedItemPosition();
		if (pos != NULL) {
			while (pos) {
				int selected_item = m_details.GetNextSelectedItem(pos);
				const AbstractDumper::GenArtData* key = get_item_data (selected_item);			
				if (key) {
					if (AbstractDumper::commit (*key) == false) {
						std::string mess ("Some warning while commit change: ");
						if (key->source_info.source.d_() == AbstractDumper::GST_FILE) {
							mess += key->source_info.source.file_name();
						} else if (key->source_info.source.d_() == AbstractDumper::GST_WIKI) {
							if (key->source_info.source.wiki_page () != 0) {
								//CORBA::String_var path = key->source_info.source.wiki_page ()->get_path ();
								//mess += path.in ();
								mess += key->source_info.source.wiki_page ()->get_path ();
							} else {
								mess += "unknown";
							}
						}
						mess += ", see log for more info";				
						GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());
					}
					m_applied_arts.insert (key);
				}
			}
		}
	} catch (Base::FatalError& ex) {
		RoseAbstractDumper::has_error (false);
		/*GenSupport::LogManagerFactory::get ().log_error ("Fatal error:");
		GenSupport::LogManagerFactory::get ().log_error (ex.what ());
		
		::MessageBox (
			NULL
			, "Применение результатов генерации завершилось ошибкой смотри лог для деталей"
			, "Ошибка"
			, MB_OK|MB_ICONEXCLAMATION
		);*/
		this->EndDialog (IDCANCEL);
		throw ex;
	}
	this->fill_statistic ();
	//#UC END# *4922C53A0110*
}

// обрабочтик нажатия кнопки "Diff" - показывает дифу.
void GenStatistics::on_diff () {
	//#UC START# *4922C550007D*
	POSITION pos = m_details.GetFirstSelectedItemPosition();
	if (pos != NULL) {
		while (pos) {
			int selected_item = m_details.GetNextSelectedItem(pos);
			this->do_details (selected_item);	
		}
	}
	//#UC END# *4922C550007D*
}

// обработчик кнопки "Restore" - отменяет изменения сделанные с выделенным в списке артефактом.
void GenStatistics::on_restore () {
	//#UC START# *4922C5960173*
	POSITION pos = m_details.GetFirstSelectedItemPosition();
	if (pos != NULL) {
		while (pos) {
			int selected_item = m_details.GetNextSelectedItem(pos);
			this->do_restore (selected_item);	
		}
	}
	this->fill_statistic ();
	//#UC END# *4922C5960173*
}

// отменяет изменения для всех артефактов
void GenStatistics::on_restore_all () {
	//#UC START# *4922C5C500A1*
	//Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
	unsigned count = m_details.GetItemCount ();

	for (unsigned i = 0; i < count; i++) {
		this->do_restore (i);
	}

	this->fill_statistic ();
	//#UC END# *4922C5C500A1*
}

// подготавливает данные для отображения в списке
void GenStatistics::prepare_item_texts () const {
	//#UC START# *4923A9AB0305*
	if (m_list_texts.empty ()) {
		Core::Aptr<AbstractDumper::ArtefactSet> chg_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_CHG);
		Core::Aptr<AbstractDumper::ArtefactSet> new_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_NEW);
		Core::Aptr<AbstractDumper::ArtefactSet> del_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_DEL);
		Core::Aptr<AbstractDumper::ArtefactSet> eq_a = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_EQ);
		
		AbstractDumper::ArtefactSet all_artefacts (chg_a->begin (), chg_a->end ());
		all_artefacts.insert (new_a->begin (), new_a->end ());
		all_artefacts.insert (del_a->begin (), del_a->end ());
		all_artefacts.insert (eq_a->begin (), eq_a->end ());
		
		for (
			AbstractDumper::ArtefactSet::const_iterator it = all_artefacts.begin ()
			; it != all_artefacts.end ()
			; ++it
		) {
			if ((*it)->source_info.source.d_ () == AbstractDumper::GST_FILE) {
				ItemInfo info;
				info.type = ET_ARTEFACT;
				info.art_data = *it;
				
				if (info.art_data != 0) {
					m_list_texts[info] = this->get_text_for_art (*info.art_data);
				}
			}
		}
		{
			ItemInfo info;
			info.type = ET_NAME_DEL;
			info.art_data = 0;
			m_list_texts[info] = "Удалённые:";
		}
		{
			ItemInfo info;
			info.type = ET_NAME_EQ;
			info.art_data = 0;
			m_list_texts[info] = "Неизменившиеся:";
		}
		{
			ItemInfo info;
			info.type = ET_NAME_CHG;
			info.art_data = 0;
			m_list_texts[info] = "Изменённые:";
		}
		{
			ItemInfo info;
			info.type = ET_NAME_NEW;
			info.art_data = 0;
			m_list_texts[info] = "Новые:";
		}		
	}
	//#UC END# *4923A9AB0305*
}

// метод удаляет ранее созданные временные файлы
void GenStatistics::remove_temp_files () {
	//#UC START# *464977790186*
	for (
		TempFileSet::iterator it = m_temp_files.begin ()
		; it != m_temp_files.end ()
		; ++it
	) {
		GCL::FileOp::remove_file (it->data());
	}
	//#UC END# *464977790186*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

