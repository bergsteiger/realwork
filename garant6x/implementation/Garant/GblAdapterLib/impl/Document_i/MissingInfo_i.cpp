////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/MissingInfo_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::MissingInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/MissingInfo_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MissingInfo_i::MissingInfo_i (const GCD::PID& pid)
//#UC START# *45EEB6520309_46110DBE01ED_46110C95021F_BASE_INIT*
//#UC END# *45EEB6520309_46110DBE01ED_46110C95021F_BASE_INIT*
{
	//#UC START# *45EEB6520309_46110DBE01ED_46110C95021F_BODY*
	GCD::StringList_var string_list (ApplicationHelper::instance ()->get_cached_function_manager ()->get_doc_info (pid));

	CORBA::ULong length = string_list->length ();
	if (length > 1) {
		m_obj_name = GCI::IO::StringFactory::make (string_list [CORBA::ULong (0)]);

		m_blocks_info = GCI::IO::StringFactory::make ("");
		for (CORBA::ULong i = 1; i < length; ++i) {
			if (i != 1) {
				m_blocks_info->add ("\r\n");
			}
			m_blocks_info->add (string_list [i]);
		}
		m_is_one_block = (length == 2);
	} else {
		throw InvalidTopicId ();
	}
	//#UC END# *45EEB6520309_46110DBE01ED_46110C95021F_BODY*
}

MissingInfo_i::~MissingInfo_i () {
	//#UC START# *46110C95021F_DESTR_BODY*
	//#UC END# *46110C95021F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MissingInfo
// Имена блоков (баз), в которых содержится отсутствующий объект.
const GCI::IO::String& MissingInfo_i::get_blocks_info () const {
	//#UC START# *45EEB652030C_46110C95021F_GET*
	return *(m_blocks_info.ptr ());
	//#UC END# *45EEB652030C_46110C95021F_GET*
}

GCI::IO::String& MissingInfo_i::get_blocks_info () {
	return const_cast<GCI::IO::String&>(((const MissingInfo_i*)this)->get_blocks_info ());
}

// implemented method from MissingInfo
// Отсутствующий объект содержится только в одном блоке (базе) - необходимо для правильного
// постоения сообщения о том, в каком(их) блоке(ах) содержится отсутствующий объект.  Если в
// blocks_info содержится только один блок, то возвращается true, в противном случае false.
bool MissingInfo_i::is_one_block () const {
	//#UC START# *45EEB652030A_46110C95021F*
	return m_is_one_block;
	//#UC END# *45EEB652030A_46110C95021F*
}

// implemented method from MissingInfo
// Имя отсутствующего объекта.
const GCI::IO::String& MissingInfo_i::get_obj_name () const {
	//#UC START# *45EEB652030B_46110C95021F_GET*
	return *(m_obj_name.ptr ());
	//#UC END# *45EEB652030B_46110C95021F_GET*
}

GCI::IO::String& MissingInfo_i::get_obj_name () {
	return const_cast<GCI::IO::String&>(((const MissingInfo_i*)this)->get_obj_name ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

