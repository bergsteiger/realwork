////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/RoseItemList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> MDProcess::MDAAddinLib::CommonViews::RoseItemList
//
// ГУИ - список для отображения элементов розы. Позволяет отображать элементы в виде списка с
// иконками, данные для списка поставлются извне. Список содержит 3 колонки: имя элемента,
// стереотип, документация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseItemList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"

//#UC START# *47E79D7E0362_CUSTOM_INCLUDES*
//#UC END# *47E79D7E0362_CUSTOM_INCLUDES*


//#UC START# *47E79D7E0362*
static int CALLBACK sort_func (LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort) {
	RoseItemList::SortParam* param = reinterpret_cast<RoseItemList::SortParam*> (lParamSort);
	CListCtrl* pListCtrl = param->list;
	int first_column_id = param->primary_column_id;
	int second_column_id = param->secondary_column_id;
	LVFINDINFO info;

	info.flags = LVFI_PARTIAL|LVFI_PARAM;
	info.lParam = lParam1;
	
	int item1 = pListCtrl->FindItem (&info);
	
	info.lParam = lParam2;
	int item2 = pListCtrl->FindItem (&info);
	
	int res = lParam2 < lParam1;

	if (first_column_id != -1 && item1 != -1 && item2 != -1) {
		CString    strItem1 = pListCtrl->GetItemText(item1, first_column_id);
		CString    strItem2 = pListCtrl->GetItemText(item2, first_column_id);
		
		res = strcmp(strItem1, strItem2);
		if (res == 0 && second_column_id != -1) {
			strItem1 = pListCtrl->GetItemText(item1, second_column_id);
			strItem2 = pListCtrl->GetItemText(item2, second_column_id);
			res = strcmp(strItem1, strItem2);
		}
	}
	if (param->direction == RoseItemList::ST_DESCENDING) {
		res *= -1;
	}
	return res;
}

void RoseItemList::on_list_header_click (NMHDR* pNMHDR, LRESULT* pResult) 
{
	if (m_is_sorting_permited) {
		NMLISTVIEW *pLV = (NMLISTVIEW *) pNMHDR;
		
		SortParam param;
		param.primary_column_id = pLV->iSubItem;
		switch (m_current_direction) {
			case ST_ASCENDING:
				param.direction = ST_DESCENDING;
				m_current_direction = ST_DESCENDING;
				break;
			case ST_DESCENDING:
				param.direction = ST_ASCENDING;
				m_current_direction = ST_ASCENDING;
				break;
		}
		this->sort (param);
	}
	*pResult = 0;
}

void RoseItemList::OnLvnItemActivateResult(NMHDR *pNMHDR, LRESULT *pResult) {
	*pResult = 0;

	LPNMITEMACTIVATE pNMIA = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	
	IRoseElementPtr elem = get_item (pNMIA->iItem);
	// cut-and-paste from ItemPropertyPage
	if (elem) {
		RoseHelper::show_item (elem);

		RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (elem, false, false);
		if (is_ok == RoseHelper::ER_DELETE) {
			this->delete_item (pNMIA->iItem);		
		}
	}
}

void RoseItemList::OnContextMenu (CWnd* pWnd, CPoint pos) {
	IRoseElementPtr elem = this->get_item_by_coord (pos);
	if (elem) {
		show_context_menu (elem, pos, *this);
	}
};

//#UC END# *47E79D7E0362*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
RoseItemList::RoseItemList ()
//#UC START# *4803450901FD_BASE_INIT*
//#UC END# *4803450901FD_BASE_INIT*
{
	//#UC START# *4803450901FD_BODY*
	m_is_sorting_permited = true;
	//#UC END# *4803450901FD_BODY*
}

RoseItemList::~RoseItemList () {
	//#UC START# *47E79D7E0362_DESTR_BODY*
	//#UC END# *47E79D7E0362_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(RoseItemList, CListCtrl)
	//#UC START# *47E79D7E0362_MESSAGE_MAP*
	ON_NOTIFY_REFLECT(LVN_ITEMACTIVATE, OnLvnItemActivateResult)
	ON_NOTIFY_REFLECT(LVN_COLUMNCLICK, on_list_header_click)
	ON_WM_CONTEXTMENU ()
	ON_WM_DESTROY()
	//#UC END# *47E79D7E0362_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(RoseItemList, CListCtrl)



// callback, вызываемый фрэймворком MFC при уничтожении контрола - нужен для очистки мапы элементов.
void RoseItemList::OnDestroy () {
	//#UC START# *480438870124*
	//при уничтожении контрола очищаем мапу объектов - это нужно т.к контрол может крутится в 
	//потоке и розовские объекты, которыми он оперирует могли быть получены из глобальной таблицы 
	//COM-объектов, и если их не почистить, то при выходе из приложения повисаем...

	this->fini ();
	CListCtrl::OnDestroy ();
	//#UC END# *480438870124*
}

// Добавить элемент в список. info - список связанной с элементом информации по колонкам.
void RoseItemList::add_item (IRoseElementPtr elem, const GCL::StrVector& info) {
	//#UC START# *47E79FD60319*	
	size_t guid_hash = elem != 0 ? this->on_new_item (elem) : this->GetItemCount ();
	
	if (guid_hash != (size_t)-1) {
		int img_id = elem != 0 ? RoseHelper::get_image_index (elem) : -1;
		this->InsertItem (
			0
			, info.empty () == false ? info[0].c_str () : ""
			, img_id
		);		

		this->SetItemData (0, guid_hash);

		if (info.empty () == false) {
			GCL::StrVector::const_iterator it = info.begin ();
			GCL::StrVector::const_iterator it_end = info.end ();
			++it;
			for (size_t i = 1; it != it_end; ++it, ++i) {
				this->SetItemText (0, i, it->c_str ());
			}

		}
	}
	//#UC END# *47E79FD60319*
}

// удаляет элемент из списка
void RoseItemList::delete_item (int index) {
	//#UC START# *47E7A1190014*
	size_t guid = static_cast<size_t> (this->GetItemData (index));	
	this->delete_item_from_view (guid);
	//#UC END# *47E7A1190014*
}

// возвращает розовский элемент, с котороым связан элемент списка под номером index
IRoseElementPtr RoseItemList::get_item (int index) const {
	//#UC START# *47E7B1C70089*
	size_t guid = static_cast<size_t> (this->GetItemData (index));
	return this->get_item_by_guid (guid);
	//#UC END# *47E7B1C70089*
}

// возвращает элемент списка по координатам (в координатах экрана)
IRoseElementPtr RoseItemList::get_item_by_coord (POINT point) const {
	//#UC START# *48030249036B*
	int n_item = -1;
	int count = this->GetItemCount ();	
	for (int i = 0; i <= count; ++i) {
		CRect rect;
		this->GetItemRect (i, &rect, LVIR_BOUNDS);
		this->ClientToScreen (&rect);
		if (rect.PtInRect (point)) {
			n_item = i;
			break;
		}
	}
	IRoseElementPtr res = 0;
	if (n_item != -1) {
		res = this->get_item (n_item);
	}
	return res;
	//#UC END# *48030249036B*
}

// пересортровать список
void RoseItemList::sort (SortParam& sort_param) {
	//#UC START# *47E8AAC30059*
	m_current_direction = sort_param.direction;
	sort_param.list = this;
	this->SortItems (sort_func, reinterpret_cast<DWORD> (&sort_param));
	//#UC END# *47E8AAC30059*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

bool RoseItemList::get_is_sorting_permited () const {
	//#UC START# *4803440F013A_GET_ACCESSOR*
	return m_is_sorting_permited;
	//#UC END# *4803440F013A_GET_ACCESSOR*
}

void RoseItemList::set_is_sorting_permited (bool is_sorting_permited) {
	//#UC START# *4803440F013A_SET_ACCESSOR*
	m_is_sorting_permited = is_sorting_permited;
	//#UC END# *4803440F013A_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from RoseViewBase
// удаление элемента из вью
void RoseItemList::delete_item_from_view (size_t guid) {
	//#UC START# *4981635301EC_47E79D7E0362*
	this->on_delete_item (guid);
	int count = this->GetItemCount ();

	for (int i = 0; i <= count; ++i) {
		size_t item_guid = static_cast<size_t> (this->GetItemData (i));
		if (item_guid == guid) {
			this->DeleteItem (i);
		}

	}
	//#UC END# *4981635301EC_47E79D7E0362*
}

// implemented method from RoseViewBase
// Метод инициализации - вызывается при отображении конкртеного элемента управления
void RoseItemList::init () {
	//#UC START# *498159980259_47E79D7E0362*
	m_image_list = new CImageList ();
	m_image_list->Create (RoseHelper::get_rose_image_list ());
	this->SetImageList (m_image_list.in (), LVSIL_SMALL);
	//#UC END# *498159980259_47E79D7E0362*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

