////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/LockViews/MDSupportServerAuthorization.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::MDSupportServerAuthorization
//
// диалог для ввода логина и пароля для доступа на сервер залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_LOCKVIEWS_MDSUPPORTSERVERAUTHORIZATION_H__
#define __MDPROCESS_MDAADDINLIB_LOCKVIEWS_MDSUPPORTSERVERAUTHORIZATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// диалог для ввода логина и пароля для доступа на сервер залочек
class MDSupportServerAuthorization : public CDialog {
	SET_OBJECT_COUNTER (MDSupportServerAuthorization)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// Данные введеные пользователем
	struct DialogData {
		// логин пользователя
		std::string login;
		// пароль пользователя
		std::string pass;
		// запомнить выбранное и больше не показывать диалог авторизации
		bool use_saved_auth;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_MD_SUPPORT_SERVER_AUTHORIZATION };

public:
	MDSupportServerAuthorization ();

public:
	virtual ~MDSupportServerAuthorization ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(MDSupportServerAuthorization)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
public:
	// возвращает реультаты выполнения диалога
	virtual const DialogData& get_result () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// логин
	std::string m_init_login;

	// пароль
	std::string m_init_password;

	DialogData m_result;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_init_login () const;

	void set_init_login (const std::string& init_login);

	const std::string& get_init_password () const;

	void set_init_password (const std::string& init_password);
}; // class MDSupportServerAuthorization



#endif //__MDPROCESS_MDAADDINLIB_LOCKVIEWS_MDSUPPORTSERVERAUTHORIZATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

