////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/LogMsgSmartBackend.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::LogMsgSmartBackend
//
// бекенд для АСЕ-логера, позволяет управлять максимальным размеров выходного лог-файла или
// "сбрасывать" весь текущий лог в отдельный файл (имя: "<год>-<месяц>-<число>-<час>-<минута>-
// <секунда>.log")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_LOGMSGSMARTBACKEND_H__
#define __SHARED_CORE_MNG_LOGMSGSMARTBACKEND_H__

#include "ace/ACE.h"

//#UC START# *4500362202BF_USER_INCLUDES*
#include "ace/Log_Msg_Backend.h"
#include "ace/Log_Record.h"
#include "ace/SString.h"
#include "ace/Synch.h"
#include "ace/Vector_T.h"
//#UC END# *4500362202BF_USER_INCLUDES*

namespace Core {

//#UC START# *4500362202BF_USER_DEFINITION*
class LogMsgSmartBackend: virtual public ACE_Log_Msg_Backend {
public:
	LogMsgSmartBackend (int& argc, char** argv);
	virtual ~LogMsgSmartBackend ();
public:
	virtual int open (const ACE_TCHAR* logger_key);
	virtual int reset ();
	virtual int close ();

	virtual int log (ACE_Log_Record& log_record);
public:
	void reset_to_truncate_mode ();
public:
	void do_backup ();
	void do_truncate ();
private:
	void init (int& argc, char** argv);
	void fini ();
	void open_h ();
	void close_h ();

	void set_hook ();
	void clr_hook ();
private:
	long head_position ();
private:
	int open_i ();
	int reset_i ();
	int close_i ();

	int log_i (ACE_Log_Record& log_record);
private:
	ACE_Log_Msg_Backend* m_log_msg_backend;
	u_long m_stored_flags;
private:
	ACE_SYNCH_RECURSIVE_MUTEX m_mutex;
	ACE_SYNCH_RECURSIVE_MUTEX m_mutex4backup;

	ACE_TString m_backup_dir;
	ACE_TString m_log_file;

	bool m_is_manual_mode;

	long m_max_log_file_size;
	long m_max_log_free_size;
private:
	ACE_HANDLE m_handle;
	FILE* m_file;
}; // class LogMsgSmartBackend


class LogMsgSmartBackendCatcher {
public:
	LogMsgSmartBackendCatcher (ACE_Log_Msg_Backend* log_msg_backend);
	virtual ~LogMsgSmartBackendCatcher ();
private:
	ACE_Log_Msg_Backend* m_log_msg_backend;
	u_long m_stored_flags;
}; // class LogMsgSmartBackendTraslator
//#UC END# *4500362202BF_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_LOGMSGSMARTBACKEND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
