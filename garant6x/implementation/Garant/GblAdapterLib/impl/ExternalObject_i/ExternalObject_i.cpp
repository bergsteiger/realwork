////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalObject_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i.h"

//#UC START# *45EE7EE90046_CUSTOM_INCLUDES*
//#UC END# *45EE7EE90046_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45EE7EE90046*
//#UC END# *45EE7EE90046*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExternalObject_i::ExternalObject_i ()
//#UC START# *45ED932A0044_45EE710A03CF_45EE7EE90046_BASE_INIT*
//#UC END# *45ED932A0044_45EE710A03CF_45EE7EE90046_BASE_INIT*
{
	//#UC START# *45ED932A0044_45EE710A03CF_45EE7EE90046_BODY*
	//#UC END# *45ED932A0044_45EE710A03CF_45EE7EE90046_BODY*
}

ExternalObject_i::ExternalObject_i (GblPilot::InternalObj* obj)
//#UC START# *45ED932A0044_462CCE240075_45EE7EE90046_BASE_INIT*
: m_blob (obj->get_blob ()), m_name (GCI::IO::StringFactory::make (CORBA::String_var (obj->get_name ()).in ()))
//#UC END# *45ED932A0044_462CCE240075_45EE7EE90046_BASE_INIT*
{
	//#UC START# *45ED932A0044_462CCE240075_45EE7EE90046_BODY*
	//#UC END# *45ED932A0044_462CCE240075_45EE7EE90046_BODY*
}

ExternalObject_i::~ExternalObject_i () {
	//#UC START# *45EE7EE90046_DESTR_BODY*
	//#UC END# *45EE7EE90046_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ExternalObject
// Указатель на буфер с данными.
const void* ExternalObject_i::get_data_pointer () const {
	//#UC START# *45ED932A0047_45EE7EE90046_GET*
	return m_blob->m_data.get_buffer ();
	//#UC END# *45ED932A0047_45EE7EE90046_GET*
}

void* ExternalObject_i::get_data_pointer () {
	return const_cast<void*>(((const ExternalObject_i*)this)->get_data_pointer ());
}

// implemented method from ExternalObject
// Общий размер возвращаемых данных.
unsigned long ExternalObject_i::get_data_size () const {
	//#UC START# *45ED932A0046_45EE7EE90046_GET*
	return m_blob->m_data.length ();
	//#UC END# *45ED932A0046_45EE7EE90046_GET*
}

// implemented method from ExternalObject
ExternalObjectType ExternalObject_i::get_data_type () const {
	//#UC START# *45ED93C9017C_45EE7EE90046_GET*
	if (ACE_OS_String::strcmp (m_blob->m_type, "MP3") == 0) {
		return EOT_MP3;
	}

	if (
		ACE_OS_String::strcmp (m_blob->m_type, "PIC") == 0 ||
		ACE_OS_String::strcmp (m_blob->m_type, "PNG") == 0 ||
		ACE_OS_String::strcmp (m_blob->m_type, "GIF") == 0 ||
		ACE_OS_String::strcmp (m_blob->m_type, "JPG") == 0 
		) {
		return EOT_PIC;
	} 
	
	if (ACE_OS_String::strcmp (m_blob->m_type, "RTF") == 0) {
		return EOT_RTF;
	} 
	
	if (ACE_OS_String::strcmp (m_blob->m_type, "XLS") == 0) {
		return EOT_XLS;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "PDF") == 0) {
		return EOT_PDF;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "TIF") == 0) {
		return EOT_TIF;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "PPT") == 0) {
		return EOT_PPT;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "CDR") == 0) {
		return EOT_CDR;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "DOC") == 0) {
		return EOT_DOC;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "XML") == 0) {
		return EOT_XML;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "XSD") == 0) {
		return EOT_XSD;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "DOCX") == 0) {
		return 	EOT_DOCX;
	}

	if (ACE_OS_String::strcmp (m_blob->m_type, "XLSX") == 0) {
		return EOT_XLSX;
	}

	return EOT_USR;
	//#UC END# *45ED93C9017C_45EE7EE90046_GET*
}

// implemented method from ExternalObject
// расширение для файла (вместе с лидирующей точкой) на диске
const GCI::IO::String* ExternalObject_i::get_extension () const {
	//#UC START# *4DAFFA490034_45EE7EE90046_GET*
	const static std::string point (".");
	return GCI::IO::StringFactory::make ((point + m_blob->m_type.in ()).c_str ());
	//#UC END# *4DAFFA490034_45EE7EE90046_GET*
}

// implemented method from ExternalObject
// Имя внешнего объекта.
const GCI::IO::String* ExternalObject_i::get_name () const {
	//#UC START# *45ED932A0048_45EE7EE90046_GET*
	return m_name._sretn ();
	//#UC END# *45ED932A0048_45EE7EE90046_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

