////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/GenStatistics.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::GenStatistics
//
// дилог статистики генерации - показывает список новых, изменившихся, неизменившихся артефактов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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


// дилог статистики генерации - показывает список новых, изменившихся, неизменившихся артефактов
class GenStatistics : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (GenStatistics)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// множество созданных временыых файлов
	typedef std::set < std::string > TempFileSet;

	// тип элемента в списке сгенерированных артефактов
	enum ItemType {
		ET_ARTEFACT // элемент - это артефакт генерации
		, ET_NAME_DEL // элемент - это название для списка удалённых элементов
		, ET_NAME_EQ // элемент - это название для списка неизменившихся элементов
		, ET_NAME_CHG // элемент - это название для списка изменившихся элементов
		, ET_NAME_NEW // элемент - это название для списка новых элементов
	};

	// информация об элементе списка
	struct ItemInfo {
		// тип элемента
		ItemType type;
		// данные генерации связанные с элементом
		const AbstractDumper::GenArtData* art_data;
	};

	// функтор для сравнения ItemInfo
	struct ItemInfoLess : public std::binary_function<ItemInfo, ItemInfo, bool> {
		bool operator () (const ItemInfo& first_param_, const ItemInfo& second_param_) const;
	};

	// мапа индекс элемента в списке -> информация
	typedef std::map < int, ItemInfo > IndexToInfo;

	// мапа хранящая текст, связанный с артефактом генерации
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
	// возвращает true, если была поставлена галка "Minor changes", иначе false
	virtual bool is_minor_changes () const;

	// метод удаляет ранее созданные временные файлы
	virtual void remove_temp_files ();

protected:
	// добавляет в файл в множество временных файлов
	virtual void add_temp_file (const std::string& file);

private:
	// детелизация - для измененных артефактов показывает дифу, для новых и удалённых пытается открыть
	// артефакт в системном редакторе
	virtual void do_details (int index);

	// отменяет изменения для элемента с номером index в списке
	virtual void do_restore (int index);

	// заполняет информацией список генерации
	virtual void fill_list (ItemType type, CListCtrl& lb);

	// формирует информацию по генерации.
	virtual void fill_statistic ();

	// возвращает текст для элемента списка
	virtual const char* get_item_text (const ItemInfo& info);

	// возвращает максимальную длину текста в списке
	virtual int get_max_text_width () const;

	// возвращает описание для артефакта генерации
	virtual const std::string get_text_for_art (const AbstractDumper::GenArtData& key) const;

	// обработчик нажатия кнопки Apply - применяет изменения для выделенных в списке артефактов
	virtual void on_apply ();

	// обрабочтик нажатия кнопки "Diff" - показывает дифу.
	virtual void on_diff ();

	// обработчик кнопки "Restore" - отменяет изменения сделанные с выделенным в списке артефактом.
	virtual void on_restore ();

	// отменяет изменения для всех артефактов
	virtual void on_restore_all ();

	// подготавливает данные для отображения в списке
	virtual void prepare_item_texts () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// список арефактов, которым "сказали" Apply - нужно для того, чтобы потом не вызывать для такх
	// элементов restore
	AbstractDumper::ArtefactSet m_applied_arts;

	// контрол-список сгенерённых артефактов
	ListCtrlWithCopy m_details;

	// мапа для получения по номеру элемента в списке информации об этом элементе
	IndexToInfo m_index2info;

	// мапа хранит текст,  связанный с артефактом генерации, отображающийся в статиске генерации
	mutable GenArtDataToText m_list_texts;

	// флаг определеляет являются изменения важными или нет
	int m_minor_changes;

	// множество созданных временных файлов
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

