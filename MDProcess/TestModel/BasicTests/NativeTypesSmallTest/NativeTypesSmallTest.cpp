////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NativeTypesSmallTest/NativeTypesSmallTest.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NativeTypesSmallTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NativeTypesSmallTest/NativeTypesSmallTest.h"

namespace BasicTests {
namespace NativeTypesSmallTest {


//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& NewException::get_property () const {
	//#UC START# *49B9229C0112_GET_ACCESSOR*
	return m_property;
	//#UC END# *49B9229C0112_GET_ACCESSOR*
}

void NewException::set_property (const std::string& property) {
	//#UC START# *49B9229C0112_SET_ACCESSOR*
	m_property = property;
	//#UC END# *49B9229C0112_SET_ACCESSOR*
}

const std::string& NewException::get_ro_property () const {
	//#UC START# *49B922B002CD_GET_ACCESSOR*
	return m_ro_property;
	//#UC END# *49B922B002CD_GET_ACCESSOR*
}

void NewException::set_wo_property (const std::string& wo_property) {
	//#UC START# *49B922CA037D_SET_ACCESSOR*
	m_wo_property = wo_property;
	//#UC END# *49B922CA037D_SET_ACCESSOR*
}

NewException::NewException ()
//#UC START# *49B9227C0055_BASE_INIT*
//#UC END# *49B9227C0055_BASE_INIT*
{
	//#UC START# *49B9227C0055_BODY*
	//#UC END# *49B9227C0055_BODY*
}

NewException::~NewException () throw () {
}

const char* NewException::uid () const /*throw ()*/ {
	return "F968FC6E-EBAF-4F4E-B163-BF747EFEAF33";
}

const char* NewException::what () const throw () {
	//#UC START# *49AEDAED01F3_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "NewException (), attr=%s, property=%s, ro_property=%s, wo_property=%s"
		, m_attr.c_str ()
		, m_property.c_str ()
		, m_ro_property.c_str ()
		, m_wo_property.c_str ()
	);
	return m_message;
	//#UC END# *49AEDAED01F3_WHAT_IMPL*
}

FullCharStruct::~FullCharStruct () {
	//#UC START# *49AEDB5301AD_DCTOR*
	//#UC END# *49AEDB5301AD_DCTOR*
}
FullCharStruct::FullCharStruct (
	char char_agr_
	, char const_char_agr_
	, char ref_char_agr_
	, char constref_char_agr_
	, char char_ref_
	, char const_char_ref_
	, char* char_lnk_
	, const char* const_char_lnk_
	, char*& ref_char_lnk_
	, const char*& constref_char_lnk_
)
//#UC START# *49AEDB5301AD_INIT_CTOR_BASE_INIT*
//#UC END# *49AEDB5301AD_INIT_CTOR_BASE_INIT*
{
	//#UC START# *49AEDB5301AD_INIT_CTOR*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEDB5301AD_INIT_CTOR*
}
FullCharStruct::FullCharStruct (const FullCharStruct& copy) 
//#UC START# *49AEDB5301AD_COPY_CTOR_BASE_INIT*
//#UC END# *49AEDB5301AD_COPY_CTOR_BASE_INIT*
{
	//#UC START# *49AEDB5301AD_COPY_CTOR*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEDB5301AD_COPY_CTOR*
}

FullCharStruct& FullCharStruct::operator = (const FullCharStruct& copy) {
	//#UC START# *49AEDB5301AD_ASSIGN_OP*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEDB5301AD_ASSIGN_OP*
	return *this;
}

FullCharStruct::FullCharStruct ()
//#UC START# *49B9226E014C_INIT_CTOR_BASE_INIT*
//#UC END# *49B9226E014C_INIT_CTOR_BASE_INIT*
{
	//#UC START# *49B9226E014C_CTOR_BODY*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B9226E014C_CTOR_BODY*
}
} // namespace NativeTypesSmallTest
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

