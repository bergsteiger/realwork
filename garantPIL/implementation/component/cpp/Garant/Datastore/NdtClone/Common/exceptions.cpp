#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/exceptions.h"

namespace NdtClone {

InvalidBaseVersion::InvalidBaseVersion (long required, long actual) : m_required (required), m_actual (actual) {
	LOG_E ((
		"%s: NdtClone database version mismatch: required %d, actual %d", GDS_CURRENT_FUNCTION, m_required, m_actual
		));
}

long InvalidBaseVersion::required () {
	return m_required;
}

long InvalidBaseVersion::actual () {
	return m_actual;
}



Error::Error () {
}

const char* Error::what () {
	return "NdtClone::Error";
}

Error::~Error () throw () {
}



RecoveredIndex::RecoveredIndex (const std::string& index) : m_message ("index [" + index + "] WAS RECOVERED") {
}	

RecoveredIndex::~RecoveredIndex () throw () {
}

const char* RecoveredIndex::what () {
	return m_message.c_str (); 
}

} // namespace

