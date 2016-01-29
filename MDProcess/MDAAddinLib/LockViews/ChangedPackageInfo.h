////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::ChangedPackageInfo
//
// диалог для отображения изменных другим пользователем пакетов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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


// диалог для отображения изменных другим пользователем пакетов
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
	// статус изменённости пакета
	enum ChangeStatus {
		CT_LOCK // паект залочен
		, CT_UNLOCK // пакет разлочен
	};

	// информация об ищменённом пакете
	struct Info {
		// уникальный идентификатор пакета на модели
		std::string package_guid;
		// пользователь, совершивший изменения
		std::string user_name;
		// время залочки/разлочки пакета
		std::string time;
		// статус изменения (залочен, разлочен)
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

	// список с информацией
	typedef std::vector < Info > VectorInfo;

	// сообщения обрабытваемые окном
	static const unsigned long WM_SHOW_INFO; // показать диалог
	static const unsigned long WM_ADD_INFO; // сообщение о добавлении информации в диалог



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
	// добавляем информацию в список
	virtual void add_info (const Info& info);

	// Принудительно закрывает диалог
	virtual void close ();

	// регистрирует интерфейс для комовского маршалинга, нужно для вывзова
	// из не майн потока, в котором крутятся сообщения диалога
	virtual void register_for_com_marshal (IRoseApplicationPtr app);

	// показать диалог
	/*oneway*/ Core::ThreadHandle show ();

	// дерегестрирует интерфейс из глобальной таблицы
	virtual void unregister_for_com_marshal ();

private:
	// метод для добавления данных в список
	virtual bool add_item_to_list (RoseItemList& list, const Info& info);

	// добавляет информацию о пакетах
	// l_param содержит указатель на структуру Info, при выходе из обработчика память по этому
	// указателю следует очистить
	virtual LRESULT on_add_info (WPARAM w_param, LPARAM l_param);

	// обработчик нажатия кнопки OK
	virtual void on_ok ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// идентификатор розовского объекта в глобальной таблице COM-интерфейсов
	DWORD m_current_app_id;

	// интерфейс глобальной таблицы COM-объектов
	IGlobalInterfaceTablePtr m_git;

	// мьютекс для синхронизации доступа к GIT
	mutable Core::Mutex m_git_mutex;

	// мьютекс для синхронизации доступа к дилогу из разных потоках
	mutable Core::Mutex m_info_mutex;

	// показан ли дилог на экране
	bool m_is_showed;

	// список с информацией о залоченных пакетах
	RoseItemList m_locked_info_list;

	// список залоченых пакетов
	VectorInfo m_locked_packages;

	// количество новых залоченных пакетов (нужно для того, чтобы знать сколько элементов списка нужно
	// покрасить красным)
	long m_new_locked;

	// количество новых разлоченных пакетов (нужно для того, чтобы знать сколько элементов списка
	// нужно покрасить красным)
	long m_new_unlocked;

	// список с информацией о разлоченных пакетах
	RoseItemList m_unlocked_info_list;

	// писок разлоченных пакетов
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

