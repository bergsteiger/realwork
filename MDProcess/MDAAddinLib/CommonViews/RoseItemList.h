////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/RoseItemList.h"
// генератор заголовочных файлов C++ (.h)
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
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEITEMLIST_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEITEMLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "afxcmn.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseViewBase.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *47E79D7E0362_CUSTOM_INCLUDES*
//#UC END# *47E79D7E0362_CUSTOM_INCLUDES*


// ГУИ - список для отображения элементов розы. Позволяет отображать элементы в виде списка с
// иконками, данные для списка поставлются извне. Список содержит 3 колонки: имя элемента,
// стереотип, документация
class RoseItemList : public CListCtrl, public RoseViewBase {
	SET_OBJECT_COUNTER (RoseItemList)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// направление сортировки
	enum SortDirection {
		ST_ASCENDING // по возрастанию
		, ST_DESCENDING // по убыванию
	};

	// структура параметров сортировки
	struct SortParam {
		// указатель на список, который нужно сортировать
		CListCtrl* list;
		// первичный столбец, по которому буде твестись сортировка
		int primary_column_id;
		// вторичный столбец, по которому будет вестись сортировка
		int secondary_column_id;
		// направление сортировки
		SortDirection direction;
		SortParam ()
			: list(0)
			, primary_column_id(-1)
			, secondary_column_id(-1)
			, direction(ST_ASCENDING)
		{
			//#UC START# *47E8A70D03D6_DEF_INIT_CTOR*
			//#UC END# *47E8A70D03D6_DEF_INIT_CTOR**cpp*
		}
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор
	RoseItemList ();

public:
	virtual ~RoseItemList ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(RoseItemList)

public:
	// Добавить элемент в список. info - список связанной с элементом информации по колонкам.
	virtual void add_item (IRoseElementPtr elem, const GCL::StrVector& info);

	// удаляет элемент из списка
	virtual void delete_item (int index);

	// возвращает розовский элемент, с котороым связан элемент списка под номером index
	virtual IRoseElementPtr get_item (int index) const;

	// пересортровать список
	virtual void sort (SortParam& sort_param);

private:
	// callback, вызываемый фрэймворком MFC при уничтожении контрола - нужен для очистки мапы
	// элементов.
	virtual void OnDestroy ();

	// возвращает элемент списка по координатам (в координатах экрана)
	virtual IRoseElementPtr get_item_by_coord (POINT point) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// текущее направление сортировки
	SortDirection m_current_direction;

	// список иконок для контрола
	Core::Box<CImageList> m_image_list;

	// флаг определяющий разрешена ли пересортировка списка
	bool m_is_sorting_permited;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	bool get_is_sorting_permited () const;

	void set_is_sorting_permited (bool is_sorting_permited);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from RoseViewBase
	// Метод инициализации - вызывается при отображении конкртеного элемента управления
	virtual void init ();
protected:

	// implemented method from RoseViewBase
	// удаление элемента из вью
	virtual void delete_item_from_view (size_t guid);

//#UC START# *47E79D7E0362*
protected:
	void OnLvnItemActivateResult(NMHDR *pNMHDR, LRESULT *pResult);
	void on_list_header_click (NMHDR* pNMHDR, LRESULT* pResult);

	void OnContextMenu (CWnd* pWnd, CPoint pos);
//#UC END# *47E79D7E0362*
}; // class RoseItemList



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEITEMLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

