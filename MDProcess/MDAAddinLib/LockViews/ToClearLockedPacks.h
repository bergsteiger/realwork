////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/MDProcess/MDAAddinLib/LockViews/ToClearLockedPacks.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::ToClearLockedPacks
//
// показывает список залоченых только юзером пакетов и предлагаетс€ их разлочить
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_LOCKVIEWS_TOCLEARLOCKEDPACKS_H__
#define __MDPROCESS_MDAADDINLIB_LOCKVIEWS_TOCLEARLOCKEDPACKS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *45F177A70186_CUSTOM_INCLUDES*
//#UC END# *45F177A70186_CUSTOM_INCLUDES*


// показывает список залоченых только юзером пакетов и предлагаетс€ их разлочить
class ToClearLockedPacks : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (ToClearLockedPacks)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_TO_CLEAR_LOCKED_PACKS };

public:
	ToClearLockedPacks ();

public:
	virtual ~ToClearLockedPacks ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ToClearLockedPacks)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
public:
	// добавить им€ пакета текщей модели
	virtual void add_model_pack_full_name (const std::string& name);

	// доавбить им€ залоченного пакета с других моделей
	virtual void add_other_pack_full_name (const std::string& name);

	// показать диалог
	virtual void show_all ();

private:
	// вызываетс€ при закрытии дилога, в этом методе заполн€етс€ списки пакетов подлежащих разлочке
	virtual void close_dlg ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// список залоченных пакетов текущей модели
	GCL::StrSet m_locked_model_packs;

	// список залоченных пакетов с других моделей
	GCL::StrSet m_locked_other_packs;

	// список пакетов с текущей модели
	CTreeCtrl m_model_packs;

	// список пакетов текущей модели, которые пользователь выбрал дл€ разлочки
	GCL::StrSet m_model_packs_to_unlock;

	// список пакетов других моделей, которые пользователь выбрал дл€ разлочки
	GCL::StrSet m_other_model_packs;

	// список пакетов с других моделей
	CTreeCtrl m_others_pack;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const GCL::StrSet& get_model_packs_to_unlock () const;

	virtual const GCL::StrSet& get_other_model_packs () const;

//#UC START# *45F177A70186*
private:
	afx_msg void OnOK ();
	afx_msg void OnCancel ();
	afx_msg void OnDeselectAllCurrent ();
	afx_msg void OnDeselectAllOther ();
//#UC END# *45F177A70186*
}; // class ToClearLockedPacks



#endif //__MDPROCESS_MDAADDINLIB_LOCKVIEWS_TOCLEARLOCKEDPACKS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

