////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Global/Defines/Common/XMLDef.h"
#include <fstream>
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"

//#UC START# *47BEECCF0383_CUSTOM_INCLUDES*
#include "boost/lambda/lambda.hpp"
#include "boost/lambda/bind.hpp"

#include "shared/GCI/I18N/I18N.h"
#include "shared/Core/Params/Params.h"

#include "garantServer/src/Global/Core/Common/XMLParser.h"

#include "bzlib.h"
//#UC END# *47BEECCF0383_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *47BEECCF0383*
class BZHandle {
public:
	BZHandle (const std::string& name) {
		m_value = ACE_OS::open (name.c_str (), O_CREAT| O_TRUNC| O_WRONLY);
	}

	~BZHandle () {
		ACE_OS::close (m_value);
	}

public:
	ACE_HANDLE value () {
		return m_value;
	}

private:
	ACE_HANDLE m_value;
}; // class BZHandle

// todo: на модель в shared?
class BZFile {
public:
	BZFile (ACE_HANDLE handle): m_file (handle), m_error (0) {
		m_value = ::BZ2_bzWriteOpen (&m_error, m_file.value (), 5, 0, 0);
	}

	~BZFile () {
		::BZ2_bzWriteClose (&m_error, m_value, 0, 0, 0);
	}

public:
	void write (void* data, ACE_UINT32 data_size) {
		BZ2_bzWrite (&m_error, m_value, data, static_cast <int> (data_size));
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
	::BZFILE* m_value;
}; // class BZFile
//#UC END# *47BEECCF0383*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PrimeManager_i::PrimeManager_i ()
//#UC START# *47BED66B0384_47BEE1810005_47BEECCF0383_BASE_INIT*
	: m_has_online_access (ApplicationHelper::instance ()->get_cached_prime ()->has_online_access ())
//#UC END# *47BED66B0384_47BEE1810005_47BEECCF0383_BASE_INIT*
{
	//#UC START# *47BED66B0384_47BEE1810005_47BEECCF0383_BODY*
	//#UC END# *47BED66B0384_47BEE1810005_47BEECCF0383_BODY*
}

PrimeManager_i::~PrimeManager_i () {
	//#UC START# *47BEECCF0383_DESTR_BODY*
	//#UC END# *47BEECCF0383_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// создать имя файла для сохранения prime
const std::string PrimeManager_i::result_file_name (const char* path) const {
	//#UC START# *4B2F6060025B*
	const char* default_name = "id_not_found";

	CORBA::String_var file_name = ApplicationHelper::instance ()->get_cached_user_manager ()->get_registration_number ();
	if (NOT_UNICODE_TR("ОТСУТСТВУЕТ") == file_name.in ()) {
		file_name = CORBA::string_dup (default_name);
	}
	return std::string (path) + ACE_DIRECTORY_SEPARATOR_CHAR + std::string (file_name.in ()) + std::string (".psx");
	//#UC END# *4B2F6060025B*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from PrimeManager
// сохраняет на сервере свеже созданный запрос для рассылок
Prime* PrimeManager_i::add (const GCI::IO::String* name, const Query* query) /*throw (DuplicateName)*/ {
	//#UC START# *47C29A6A0154_47BEECCF0383*
	try {
		GblFoldersAdap::SavedQueryData data;
		GblPilotQueryDef::Query_var q (const_cast<Query*> (query)->build_query());
		data.query = q;
		data.doc_count = 0;
		data.filter_type = GblFolders::NO_FILTER;
		GblPrime::PrimeQueryKey key = ApplicationHelper::instance ()->get_cached_prime ()->add_query (name->get_data (), data);
		Prime_var prime = PrimeFactory::make (key, name->get_data (), data);
		m_list.push_back (Core::IObject::_duplicate (prime.in ()));
		return prime._retn ();
	} catch (Containers::DuplicateName&) {
		throw DuplicateName ();
	}
	//#UC END# *47C29A6A0154_47BEECCF0383*
}

// implemented method from PrimeManager
// проверить соединение с онлайн сервисом праймов
bool PrimeManager_i::check_connection_to_online_server () const {
	//#UC START# *5416C35E015D_47BEECCF0383*
	return ApplicationHelper::instance ()->get_cached_prime ()->check_connection_to_online_server ();
	//#UC END# *5416C35E015D_47BEECCF0383*
}

// implemented method from PrimeManager
// есть ли доступ к онлайн редактированию анкет прайма
bool PrimeManager_i::get_has_online_access () const {
	//#UC START# *54118609033D_47BEECCF0383_GET*
	return m_has_online_access;
	//#UC END# *54118609033D_47BEECCF0383_GET*
}

// implemented method from PrimeManager
const PrimeList& PrimeManager_i::get_list () const {
	//#UC START# *47C2CF1700BC_47BEECCF0383_GET*
	if (m_list.empty ()) {
		GblPrime::PrimeQueryList_var list (
			ApplicationHelper::instance ()->get_cached_prime ()->get_query_list ()
		);
		
		for (size_t i = 0, size = list->length (); i < size; ++i) {
			m_list.push_back (PrimeFactory::make (list [i].key, list [i].name.in (), list [i].query));
		}
	}
	return m_list;	
	//#UC END# *47C2CF1700BC_47BEECCF0383_GET*
}

// implemented method from PrimeManager
void PrimeManager_i::remove (PrimeKey id) {
	//#UC START# *47C29C2001FA_47BEECCF0383*
	ApplicationHelper::instance ()->get_cached_prime ()->delete_query (id);
	for (size_t i = 0; i < m_list.size (); ++i) {
		if (m_list[i]->get_id () == id) {
			m_list.erase (m_list.begin () + i);
			break;
		}
	}
	//#UC END# *47C29C2001FA_47BEECCF0383*
}

// implemented method from PrimeManager
// рассылку в локальных настройках и отправить на сервер праймов
void PrimeManager_i::save_and_send_to_online_server () const {
	//#UC START# *5411BC740155_47BEECCF0383*
	ApplicationHelper::instance ()->get_cached_prime ()->save_and_send_to_online_server ();
	//#UC END# *5411BC740155_47BEECCF0383*
}

// implemented method from PrimeManager
void PrimeManager_i::save_list_to_xml (
	const KeysList& keys
	, const char* xml_file_path
) const /*throw (
	UnknownExportError
)*/ {
	//#UC START# *4BE3CF5C02CB_47BEECCF0383*
	if (keys.empty ()) {
		return;
	}
	try {
		GblPrime::KeysList server_keys;
		server_keys.length (keys.size ());
		for (size_t i = 0;  i < keys.size (); ++i) {
			server_keys[i] = keys[i];
		}
		GCD::XMLText_var xml_text (
			ApplicationHelper::instance ()->get_cached_prime_xml_save ()->save_list_to_xml (server_keys)
		);

		if (xml_text.ptr ()) {
			GCL::XMLParser::save_xml_buffer_to_file (&xml_text.in (), xml_file_path);
		}
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		throw UnknownExportError (); 
	}
	//#UC END# *4BE3CF5C02CB_47BEECCF0383*
}

// implemented method from PrimeManager
void PrimeManager_i::save_mail_delivery_task (const char* xml_file_path) const /*throw (UnknownExportError)*/ {
	//#UC START# *47C5860401E8_47BEECCF0383*
	try {
		GCD::XMLText_var xml_text (
			ApplicationHelper::instance ()->get_cached_prime_xml_save ()->save (Defines::XT_MONITORINGS)
		);

		if (xml_text.ptr ()) {
			const std::string file = this->result_file_name (xml_file_path);
			BZHandle bz_handle (file);
			BZFile bzfile (bz_handle.value ());
			bzfile.write (xml_text->get_buffer (), xml_text->length ());
		}
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		throw UnknownExportError (); 
	}
	//#UC END# *47C5860401E8_47BEECCF0383*
}

// implemented method from PrimeManager
void PrimeManager_i::share_prime_for_file_server () const /*throw (UnknownExportError)*/ {
	//#UC START# *47D4FEDA03DC_47BEECCF0383*
	AssemblyInfo_var info (AssemblyInfoFactory::make ());
	if (!info->get_is_desktop ()) {
		return;
	}
	
	// расшаривание прайма между оболочками в файл-серверной версии 
	try {
		if (Core::ParamManagerFactory::get ().is_exist ("-XMLSavePath")) {
			std::string xml_server_path = Core::ParamManagerFactory::get ().get_string ("-XMLSavePath");
			ApplicationHelper::instance ()->get_cached_xml_save ()->save (Defines::XT_PRIME, xml_server_path.c_str ());
		} else {
			LOG_I (("%s: '-XMLSavePath' parameter not exist", GDS_CURRENT_FUNCTION));
		}
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		throw UnknownExportError ();
	}
	//#UC END# *47D4FEDA03DC_47BEECCF0383*
}

// implemented method from PrimeManager
// обновить данные о новостных лентах у всех клиентов. Должен быть вызван перед выходом из утилиты.
void PrimeManager_i::update () const {
	//#UC START# *4C88A58B02D8_47BEECCF0383*
	ApplicationHelper::instance ()->get_cached_prime ()->update ();
	//#UC END# *4C88A58B02D8_47BEECCF0383*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

