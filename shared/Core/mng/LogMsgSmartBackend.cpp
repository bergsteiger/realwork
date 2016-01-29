////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/LogMsgSmartBackend.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::LogMsgSmartBackend
// Файл реализации утилитного набора LogMsgSmartBackend
//
// бекенд для АСЕ-логера, позволяет управлять максимальным размеров выходного лог-файла или
// "сбрасывать" весь текущий лог в отдельный файл (имя: "<год>-<месяц>-<число>-<час>-<минута>-
// <секунда>.log")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/mng/LogMsgSmartBackend.h"

//#UC START# *4500362202BF_CUSTOM_INCLUDES*
#include "ace/Argv_Type_Converter.h"
#include "ace/Arg_Shifter.h"
#include "ace/Date_Time.h"
#include "ace/Log_Msg.h"
#include "ace/OS.h"
#include "bzlib.h"
//#UC END# *4500362202BF_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *4500362202BF*
namespace {
	const size_t c_internal_copy_size = 32*1024; // 32 Kb

	const ACE_TCHAR c_backup_dir_parameter [] = ACE_TEXT ("-SBEBackupDir");

	const ACE_TCHAR c_log_file_parameter [] = ACE_TEXT ("-SBELogFile");

	const ACE_TCHAR c_max_log_file_size_parameter [] = ACE_TEXT ("-SBEMaxLogFileSize");
	const ACE_TCHAR c_max_log_free_size_parameter [] = ACE_TEXT ("-SBEMaxLogFreeSize");

	const long c_min_log_file_size = 64*1024; // 64 Kb
	const long c_min_log_free_size = 32*1024; // 32 Kb;
} // namespace

namespace {
	class StaticHelper {
	public:
		inline static int mkdir (
			const ACE_TCHAR* path
		) {
			int result (0);

			if (
				(
					path != 0
				) && (
					path [0] != ACE_TEXT ('\0')
				) && (
					(
						path [0] != ACE_TEXT ('.')
					) || (
						path [1] != ACE_TEXT ('\0')
					)
#if (defined (ACE_WIN32))
				) && (
					(
						path [1] != ACE_TEXT ('\0')
					) && (
						(
							path [1] != ACE_TEXT (':')
						) || (
							path [2] != ACE_TEXT ('\0')
						)
					)
#endif // (defined (ACE_WIN32))
				)
			) {
				if (ACE_OS::access (path, F_OK) == -1) {
					if (ACE_OS::last_error () == ENOENT) {
						const ACE_TString dirname (ACE::dirname (path));
				
						if ((result = StaticHelper::mkdir (dirname.c_str ())) != -1) {
							result = ACE_OS::mkdir (path);
						}
					} else {
						result = -1;
					}
				}
			}

			return result;
		}

		inline static ACE_HANDLE open (
			const ACE_TCHAR* filename
			, int mode
			, bool use_temp = true
		) {
			const ACE_TString dirname (ACE::dirname (filename));

			ACE_HANDLE result ((StaticHelper::mkdir (dirname.c_str ()), ACE_OS::open (filename, mode)));

			if ((result == ACE_INVALID_HANDLE) && (use_temp)) {
				const ACE_TString basename (ACE::basename (filename));

				ACE_TCHAR temp_file_name_dir [MAXPATHLEN+ 1];

				if (ACE::get_temp_dir (temp_file_name_dir, MAXPATHLEN) == -1) {
					ACE_OS::strcpy (temp_file_name_dir, ACE_TEXT ("."));
					ACE_OS::strcat (temp_file_name_dir, ACE_DIRECTORY_SEPARATOR_STR);
				}

				ACE_TString filename (temp_file_name_dir);
				filename += basename;

				result = StaticHelper::open (filename.c_str (), mode, false);
			}

			return result;
		}
	public:
		inline static void copy_all_data (const ACE_TCHAR* backup_name, const ACE_TCHAR* backup_dir) {
			class Handle {
			public:
				Handle (const ACE_TCHAR* name, int mode) {
					m_value = ACE_OS::open (name, mode);
				}

				~Handle () {
					ACE_OS::close (m_value);
				}
			public:
				ACE_HANDLE value () {
					return m_value;
				}
			private:
				ACE_HANDLE m_value;
			}; // class Handle

			const ACE_TCHAR file_name_format [] = ACE_TEXT ("%s%s%04d-%02d-%02d-%02d-%02d-%02d.log");

			ACE_Auto_Basic_Array_Ptr <ACE_TCHAR> file_name_auto_ptr (
				new ACE_TCHAR [
					ACE_OS::strlen (file_name_format)
					- 2 // length of `%s`
					+ ACE_OS::strlen (backup_dir)
					- 2 // length of `%s`
					+ ACE_OS::strlen (ACE_DIRECTORY_SEPARATOR_STR)
					- 4 // length of `%04d`
					+ 4 // length of expanded `%04d`
					- 4 // length of `%02d`
					+ 2 // length of expanded `%02d`
					- 4 // length of `%02d`
					+ 2 // length of expanded `%02d`
					- 4 // length of `%02d`
					+ 2 // length of expanded `%02d`
					- 4 // length of `%02d`
					+ 2 // length of expanded `%02d`
					- 4 // length of `%02d`
					+ 2 // length of expanded `%02d`
					+ 1 // length of `\x00`
				]
			);

			ACE_TCHAR* file_name (file_name_auto_ptr.get ());
			ACE_Date_Time current_date_time;

			ACE_OS::sprintf (
				file_name
				, file_name_format
				, backup_dir
				, ACE_DIRECTORY_SEPARATOR_STR
				, current_date_time.year ()
				, current_date_time.month ()
				, current_date_time.day ()
				, current_date_time.hour ()
				, current_date_time.minute ()
				, current_date_time.second ()
			);

			{
				StaticHelper::copy_data_by_handle (
					Handle (file_name, (O_CREAT| O_TRUNC| O_WRONLY)).value ()
					, Handle (backup_name, O_RDONLY).value ()
				);
			}

			ACE_OS::unlink (backup_name);
		}

		inline static void trim_odd_data (ACE_HANDLE handle, off_t off) {
			class PositionHolder {
			public:
				PositionHolder (ACE_HANDLE handle): m_handle (handle), m_off (0) {
					m_off = ACE_OS::lseek (m_handle, m_off, SEEK_CUR);
				}

				~PositionHolder () {
					m_off = ACE_OS::lseek (m_handle, m_off, SEEK_SET);
				}
			private:
				ACE_HANDLE m_handle;
				off_t m_off;
			}; // class PositionHolder

			if ((off != 0) && (ACE_OS::lseek (handle, off, SEEK_SET) != -1L)) {
				ACE_Auto_Basic_Array_Ptr <char> buffer (new char [c_internal_copy_size]);

				char* portion = buffer.get ();
				off_t portion_off = 0;

				bool align_to_newline = true;

				while (true) {
					size_t portion_size = c_internal_copy_size;

					ssize_t result = ACE_OS::read (handle, portion, portion_size);

					if (result <= 0) {
						break;
					}

					portion_size = static_cast <size_t> (result);

					size_t newline_offset = 0;

					if (align_to_newline) {
						for (size_t i = 0; i < portion_size; ++i) {
							if (portion [i] == '\n') {
								newline_offset = i+1;
								break;
							}
						}

						align_to_newline = false;
					}

					PositionHolder position_holder (handle);

					portion_size -= newline_offset;

					ACE_OS::lseek (handle, portion_off, SEEK_SET);
					ACE_OS::write (handle, &portion [newline_offset], portion_size);

					portion_off += static_cast <off_t> (portion_size);
				}

				ACE_OS::ftruncate ((ACE_OS::lseek (handle, portion_off, SEEK_SET), handle), portion_off);
			}
		}
	private:
		inline static void copy_data_by_handle (ACE_HANDLE dst_handle, ACE_HANDLE src_handle) {
			class BZFile {
			public:
				BZFile (ACE_HANDLE handle): m_file (handle) {
					m_value = BZ2_bzWriteOpen (&m_error, m_file.value (), 5, 0, 0);
				}

				~BZFile () {
					BZ2_bzWriteClose (&m_error, m_value, 0, 0, 0);
				}
			public:
				BZFILE* value () {
					return m_value;
				}
			public:
				int* error () {
					return &m_error;
				}
			private:
				class File {
				public:
					File (ACE_HANDLE handle) {
						m_value = ACE_OS::fdopen (ACE_OS::dup (handle), ACE_TEXT ("wb"));
					}

					~File () {
						ACE_OS::fclose (m_value);
					}
				public:
					FILE* value () {
						return m_value;
					}
				private:
					FILE* m_value;
				} m_file; // class File
			private:
				int m_error;
				BZFILE* m_value;
			}; // class BZFile

			ACE_Auto_Basic_Array_Ptr <char> buffer (new char [c_internal_copy_size]);

			char* portion = buffer.get ();

			BZFile bzfile (dst_handle);

			while (true) {
				size_t portion_size = c_internal_copy_size;

				ssize_t result = ACE_OS::read (src_handle, portion, portion_size);

				if (result <= 0) {
					break;
				}

				portion_size = static_cast <size_t> (result);

				BZ2_bzWrite (bzfile.error (), bzfile.value (), portion, static_cast <int> (portion_size));
			}
		}
	}; // class StaticHelper
} // namespace

LogMsgSmartBackend::LogMsgSmartBackend (int& argc, char** argv)
	: m_log_msg_backend () // uninitialized
	, m_stored_flags ()    // uninitialized
	, m_mutex ()
	, m_mutex4backup ()
	, m_backup_dir ()
	, m_log_file ()
	, m_is_manual_mode (true)
	, m_max_log_file_size (-1)
	, m_max_log_free_size (-1)
	, m_handle (ACE_INVALID_HANDLE)
	, m_file (0) {
	this->init (argc, argv);
}

LogMsgSmartBackend::~LogMsgSmartBackend () {
	this->fini ();
}

int LogMsgSmartBackend::open (const ACE_TCHAR* logger_key) {
	if (
		ACE_BIT_ENABLED (m_stored_flags, ACE_Log_Msg::CUSTOM)
		&& (m_log_msg_backend != 0)
		&& (m_log_msg_backend->open (logger_key) == -1)
	) {
		return -1;
	}

	return this->open_i ();
}

int LogMsgSmartBackend::reset () {
	int result = this->reset_i ();

	if (
		ACE_BIT_ENABLED (m_stored_flags, ACE_Log_Msg::CUSTOM)
		&& (m_log_msg_backend != 0)
		&& (m_log_msg_backend->reset () == -1)
	) {
		result = -1;
	}

	return result;
}

int LogMsgSmartBackend::close () {
	int result = this->close_i ();

	if (
		ACE_BIT_ENABLED (m_stored_flags, ACE_Log_Msg::CUSTOM)
		&& (m_log_msg_backend != 0)
		&& (m_log_msg_backend->close () == -1)
	) {
		return -1;
	}

	return result;
}

int LogMsgSmartBackend::log (ACE_Log_Record& log_record) {
	int result = this->log_i (log_record);

	if (
		ACE_BIT_ENABLED (m_stored_flags, ACE_Log_Msg::CUSTOM)
		&& (m_log_msg_backend != 0)
		&& (m_log_msg_backend->log (log_record) == -1)
	) {
		return -1;
	}

	return result;
}

void LogMsgSmartBackend::reset_to_truncate_mode () {
	m_is_manual_mode = false;

	this->do_truncate ();
}

void LogMsgSmartBackend::do_backup () {
	const ACE_TCHAR* log_file (m_log_file.c_str ());

	ACE_Auto_Basic_Array_Ptr <ACE_TCHAR> backup_log_file_auto_ptr;
	{
		ACE_GUARD (ACE_SYNCH_RECURSIVE_MUTEX, _GUARD, m_mutex);

		if (m_is_manual_mode) {
			if ((m_handle != ACE_INVALID_HANDLE) && (m_backup_dir.length () != 0)) {
				const ACE_TCHAR file_name_format [] = ACE_TEXT ("%s4backup");

				ACE_Auto_Basic_Array_Ptr <ACE_TCHAR> file_name_auto_ptr (
					new ACE_TCHAR [
						ACE_OS::strlen (file_name_format)
						- 2 // length of `%s`
						+ ACE_OS::strlen (log_file)
						+ 1 // length of `\x00`
					]
				);

				ACE_TCHAR* file_name (file_name_auto_ptr.get ());
				ACE_OS::sprintf (file_name, file_name_format, log_file);

				ACE_GUARD (ACE_SYNCH_RECURSIVE_MUTEX, _GUARD4BACKUP, m_mutex4backup);

				this->close_i ();
				{
					this->close_h ();
					{
						ACE_OS::rename (log_file, file_name);
					}
					this->open_h ();
				}
				this->open_i ();

				backup_log_file_auto_ptr = file_name_auto_ptr;
			}
		}
	}

	ACE_TCHAR* backup_log_file (backup_log_file_auto_ptr.get ());

	if (backup_log_file != 0) {
		const ACE_TCHAR* backup_dir (m_backup_dir.c_str ());

		ACE_GUARD (ACE_SYNCH_RECURSIVE_MUTEX, _GUARD4BACKUP, m_mutex4backup);

		StaticHelper::copy_all_data (backup_log_file, (StaticHelper::mkdir (backup_dir), backup_dir));
	}
}

void LogMsgSmartBackend::do_truncate () {
	ACE_GUARD (ACE_SYNCH_RECURSIVE_MUTEX, _GUARD, m_mutex);

	if (!m_is_manual_mode) {
		if ((m_handle != ACE_INVALID_HANDLE) && (m_file != 0) && (m_max_log_file_size != -1)) {
			long log_file_size = ACE_OS::ftell (m_file);

			if ((log_file_size != -1) && (log_file_size >= m_max_log_file_size)) {
				this->close_i ();
					StaticHelper::trim_odd_data (m_handle, this->head_position ());
				this->open_i ();
			}
		}
	}
}

void LogMsgSmartBackend::init (int& argc, char** argv) {
	ACE_Argv_Type_Converter command_line (argc, argv);
	ACE_Arg_Shifter arg_shifter (command_line.get_argc (), command_line.get_TCHAR_argv ());

	while (arg_shifter.is_anything_left ()) {
		const ACE_TCHAR* current_arg = 0;

		if ((current_arg = arg_shifter.get_the_parameter (c_log_file_parameter))) {
			m_log_file = current_arg;

			arg_shifter.consume_arg ();
        } else if ((current_arg = arg_shifter.get_the_parameter (c_backup_dir_parameter))) {
			m_backup_dir = current_arg;

			arg_shifter.consume_arg ();
        } else if ((current_arg = arg_shifter.get_the_parameter (c_max_log_file_size_parameter))) {
			m_max_log_file_size = ACE_OS::strtol (current_arg, 0, 10);

			if (m_max_log_file_size < c_min_log_file_size) {
				m_max_log_file_size = c_min_log_file_size;
			}

			arg_shifter.consume_arg ();
        } else if ((current_arg = arg_shifter.get_the_parameter (c_max_log_free_size_parameter))) {
			m_max_log_free_size = ACE_OS::strtol (current_arg, 0, 10);

			if (m_max_log_free_size < c_min_log_free_size) {
				m_max_log_free_size = c_min_log_free_size;
			}

			arg_shifter.consume_arg ();
        } else {
			arg_shifter.ignore_arg (); // skip unknown options
		}
	}

	if (m_log_file != "") {
		if (m_backup_dir == "") {
			m_backup_dir = ACE::dirname (m_log_file.c_str ());
		}

		this->open_h ();
		this->open_i ();

		this->set_hook ();
	}
}

void LogMsgSmartBackend::fini () {
	if (m_log_file != "") {
		this->clr_hook ();

		this->close_i ();
		this->close_h ();
	}
}

void LogMsgSmartBackend::open_h () {
	if (m_log_file != "") {
		m_handle = StaticHelper::open (m_log_file.c_str (), (O_CREAT | O_APPEND| O_RDWR));
	}
}

void LogMsgSmartBackend::close_h () {
	if (m_handle != ACE_INVALID_HANDLE) {
		(ACE_OS::close (m_handle), m_handle = ACE_INVALID_HANDLE);
	}
}

void LogMsgSmartBackend::set_hook () {
	m_stored_flags = ACE_LOG_MSG->flags ();

	(ACE_LOG_MSG->clr_flags (ACE_Log_Msg::CUSTOM), m_log_msg_backend = ACE_LOG_MSG->msg_backend (this));
	(ACE_LOG_MSG->set_flags (ACE_Log_Msg::CUSTOM), ACE_LOG_MSG->clr_flags (ACE_Log_Msg::STDERR | ACE_Log_Msg::LOGGER));
}

void LogMsgSmartBackend::clr_hook () {
	(ACE_LOG_MSG->clr_flags (ACE_Log_Msg::CUSTOM), ACE_LOG_MSG->msg_backend (m_log_msg_backend));
	(ACE_LOG_MSG->set_flags (m_stored_flags), ACE_LOG_MSG->clr_flags (~m_stored_flags));
}

long LogMsgSmartBackend::head_position () {
	if ((m_max_log_free_size == -1) || (m_max_log_free_size > m_max_log_file_size/2)) {
		return m_max_log_file_size/2;
	}

	return m_max_log_free_size;
}

int LogMsgSmartBackend::open_i () {
	ACE_GUARD_RETURN (ACE_SYNCH_RECURSIVE_MUTEX, _GUARD, m_mutex, -1);

	if (
		(
			m_handle != ACE_INVALID_HANDLE
		) && (
			(m_file = ACE_OS::fdopen (ACE_OS::dup (m_handle), ACE_TEXT ("a+"))) == 0
		)
	) {
		return -1;
	}

	if (m_file != 0) {
#if (defined (ACE_WIN32))
		_setmode (_fileno (m_file), _O_TEXT); // for Windows only ('\n' == `0x0D``0x0A`)
#endif // (defined (ACE_WIN32))
	}

	return 0;
}

int LogMsgSmartBackend::reset_i () {
	return this->close_i ();
}

int LogMsgSmartBackend::close_i () {
	ACE_GUARD_RETURN (ACE_SYNCH_RECURSIVE_MUTEX, _GUARD, m_mutex, -1);

	if (m_file != 0) {
		(ACE_OS::fclose (m_file), m_file = 0);
	}

	return 0;
}

int LogMsgSmartBackend::log_i (ACE_Log_Record& log_record) {
	ACE_GUARD_RETURN (ACE_SYNCH_RECURSIVE_MUTEX, _GUARD, m_mutex, -1);

	if (m_file != 0) {
		if ((ACE_OS::fprintf (m_file, "%s", log_record.msg_data ()) < 0) || (ACE_OS::fflush (m_file) == -1)) {
			return -1;
		}

		this->do_truncate ();
	}

	return 0;
}


LogMsgSmartBackendCatcher::LogMsgSmartBackendCatcher (ACE_Log_Msg_Backend* log_msg_backend): m_log_msg_backend (0) {
	m_stored_flags = ACE_LOG_MSG->flags ();

	if (log_msg_backend != 0) {
		(ACE_LOG_MSG->clr_flags (ACE_Log_Msg::CUSTOM), m_log_msg_backend = ACE_LOG_MSG->msg_backend (log_msg_backend));
		(ACE_LOG_MSG->set_flags (ACE_Log_Msg::CUSTOM), ACE_LOG_MSG->clr_flags (ACE_Log_Msg::STDERR | ACE_Log_Msg::LOGGER));
	}
}

LogMsgSmartBackendCatcher::~LogMsgSmartBackendCatcher () {
	(ACE_LOG_MSG->clr_flags (ACE_Log_Msg::CUSTOM), ACE_LOG_MSG->msg_backend (m_log_msg_backend));
	(ACE_LOG_MSG->set_flags (m_stored_flags), ACE_LOG_MSG->clr_flags (~m_stored_flags));
}
//#UC END# *4500362202BF*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

