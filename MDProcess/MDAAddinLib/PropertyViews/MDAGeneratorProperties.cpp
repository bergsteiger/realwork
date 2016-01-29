////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/MDAGeneratorProperties.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::PropertyViews::MDAGeneratorProperties
//
// дилог управления различными свойствами MDA-генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/MDAGeneratorProperties.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MDAGeneratorProperties::MDAGeneratorProperties ()
	: WinGUI::ETSLayoutDialog (MDAGeneratorProperties::IDD)
//#UC START# *4AF94677004F_CTOR_BASE_INIT*
//#UC END# *4AF94677004F_CTOR_BASE_INIT*
{
	//#UC START# *4AF94677004F_CTOR*
	//#UC END# *4AF94677004F_CTOR*
}


MDAGeneratorProperties::~MDAGeneratorProperties () {
	//#UC START# *4AF94677004F_DESTR_BODY*
	//#UC END# *4AF94677004F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(MDAGeneratorProperties, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *4AF94677004F_MESSAGE_MAP*
	ON_BN_CLICKED(IDOK, on_ok)
	//#UC END# *4AF94677004F_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(MDAGeneratorProperties, CDialog)

void MDAGeneratorProperties::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4AF94677004F_DO_DATA_EXCHANGE*
	//#UC END# *4AF94677004F_DO_DATA_EXCHANGE*
}

BOOL MDAGeneratorProperties::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *4AF94677004F_ON_INIT_DLG*
		CRect rc_client;
		GetClientRect(rc_client);
		//rc_client.top += 46;
		//rc_client.bottom -= 23;
		
		// Setup the window style
		DWORD style = WS_VISIBLE;
		
		// Setup the tree options 
		// OT_OPTIONS_SHOWINFOWINDOW
		DWORD options = OT_OPTIONS_SHADEEXPANDCOLUMN | OT_OPTIONS_SHADEROOTITEMS;
		
		// Create tree options
		if (m_properties.Create (style, rc_client, this, options, IDC_STATIC) == FALSE) {
			return FALSE;
		}

		m_properties.DeleteAllItems ();
				
		m_properties.SetAutoSizeColumn(false);		
		m_properties.SetAttributeOffset(4);

		this->fill_properties ();
		m_properties.ExpandAllItems ();
		m_properties.SetColumn ((rc_client.Width ()*3)/4);

		//#UC END# *4AF94677004F_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"MDAGeneratorProperties\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int MDAGeneratorProperties::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void MDAGeneratorProperties::init_constraint () {
	//#UC START# *4AF94677004F_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL) 
		<< item (&m_properties, GREEDY)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< itemGrowing (HORIZONTAL)
			<< item (IDCANCEL, NORESIZE)
			<< item (IDOK, NORESIZE)
		);
	//#UC END# *4AF94677004F_CUSTOM_CONTROLS_CONSTRAINT*
}


// заполняет дерево свойств
void MDAGeneratorProperties::fill_properties () {
	//#UC START# *4AF94B390034*
	m_properties.LockAll();

	int item_id = 0;
	WinGUI::COptionTreeItem* root = m_properties.InsertItem (new WinGUI::COptionTreeItem ());
	root->SetLabelText (_T("Свойства генерации:"));

	MDAGeneratorPropertiesModel enable_spell_explicit_call_logging_item;
	enable_spell_explicit_call_logging_item.id = ++item_id;
	enable_spell_explicit_call_logging_item.label = "Логировать явный вызов spell-генератора";
	enable_spell_explicit_call_logging_item.bool_get = &GenerationParams::get_enable_spell_explicit_call_logging;
	enable_spell_explicit_call_logging_item.bool_set = &GenerationParams::set_enable_spell_explicit_call_logging;
	enable_spell_explicit_call_logging_item.type = PT_BOOL;



	
	m_properties_model.push_back (enable_spell_explicit_call_logging_item);

	MDAGeneratorPropertiesModel scold_if_call_tpl_function_on_null;
	scold_if_call_tpl_function_on_null.id = ++item_id;
	scold_if_call_tpl_function_on_null.label = "Ругаться ли, если в шаблоне вызывают функцию на несуществующем элементе";
	scold_if_call_tpl_function_on_null.bool_get = &GenerationParams::get_scold_if_call_tpl_function_on_null;
	scold_if_call_tpl_function_on_null.bool_set = &GenerationParams::set_scold_if_call_tpl_function_on_null;
	scold_if_call_tpl_function_on_null.type = PT_BOOL;

	m_properties_model.push_back (scold_if_call_tpl_function_on_null);

	MDAGeneratorPropertiesModel overwrite_creation_order;
	overwrite_creation_order.id = ++item_id;
	overwrite_creation_order.label = "Перезаписывать свойство, определяющее порядковый номер генерации элемента";
	overwrite_creation_order.bool_get = &GenerationParams::get_overwrite_creation_order_property;
	overwrite_creation_order.bool_set = &GenerationParams::set_overwrite_creation_order_property;
	overwrite_creation_order.type = PT_BOOL;

	m_properties_model.push_back (overwrite_creation_order);

	MDAGeneratorPropertiesModelList::iterator it = m_properties_model.begin ();
	MDAGeneratorPropertiesModelList::iterator it_end = m_properties_model.end ();
	for (; it != it_end; ++it) {
		switch (it->type) {
			case PT_BOOL: {
				WinGUI::COptionTreeItem* item = this->make_bool_property (*it, *root);
				item->SetItemParam (reinterpret_cast<LPARAM> (&(*it)));
			}
		    break;
			
			default:
				GDS_ASSERT (0);
				break;
		}
	}
	
	m_properties.UnLockAll();
	//#UC END# *4AF94B390034*
}

// создает вью для отображения свойства булевского типа
WinGUI::COptionTreeItem* MDAGeneratorProperties::make_bool_property (
	const MDAGeneratorPropertiesModel& data
	, WinGUI::COptionTreeItem& root
) {
	//#UC START# *4B028C1301A5*
	WinGUI::COptionTreeItemCheckBox* item = static_cast<WinGUI::COptionTreeItemCheckBox*> (
		m_properties.InsertItem (new WinGUI::COptionTreeItemCheckBox (), &root)
	);

	GDS_ASSERT(item);
	item->SetLabelText (data.label.c_str ());
	item->SetCtrlID (data.id);
	
	if (item->CreateCheckBoxItem(false, OT_CHECKBOX_SHOWCHECK | OT_CHECKBOX_SHOWTEXT) == TRUE) {
		item->SetCheckText(_T("true"), _T("false"));
		if (data.bool_get ()) {
			item->SetCheck (true);
		} else {
			item->SetCheck (false);
		}
	}

	return item;
	//#UC END# *4B028C1301A5*
}

// обработчик нажатия кнопки OK
void MDAGeneratorProperties::on_ok () {
	//#UC START# *4AF94988015C*
	
	WinGUI::COptionTreeItem* root = m_properties.GetRootItem ();

	if (root && (root = root->GetChild ())) {
		;

		for (
			WinGUI::COptionTreeItem* next = root->GetChild ()
			; next != 0
			; next = next->GetSibling ()
		) {
			switch (next->GetItemType ()) {
				case OT_ITEM_CHECKBOX: {
					WinGUI::COptionTreeItemCheckBox* item 
						= static_cast<WinGUI::COptionTreeItemCheckBox*> (next);
					
					MDAGeneratorPropertiesModelList::value_type* it = reinterpret_cast<MDAGeneratorPropertiesModelList::value_type*> (
						item->GetItemParam ()
					);
					if (it) {
						it->bool_set (item->GetCheck ());
					}
				}
				break;
				
				default:
					GDS_ASSERT (0);
					break;
			}
		}
	}
		
	WinGUI::ETSLayoutDialog::OnOK ();
	//#UC END# *4AF94988015C*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

