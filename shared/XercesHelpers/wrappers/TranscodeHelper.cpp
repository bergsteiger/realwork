////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/TranscodeHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::TranscodeHelper
//
// перекодировщик строк
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/XercesHelpers/wrappers/TranscodeHelper.h"

//#UC START# *491C2F1503A1_CUSTOM_INCLUDES*
#include "shared/XercesHelpers/wrappers/exceptions.h"
//#UC END# *491C2F1503A1_CUSTOM_INCLUDES*

namespace XercesHelpers {

//#UC START# *491C2F1503A1*
//#UC END# *491C2F1503A1*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TranscodeHelper::TranscodeHelper (const char* encoding)
//#UC START# *491D8B16029E_BASE_INIT*
//#UC END# *491D8B16029E_BASE_INIT*
{
	//#UC START# *491D8B16029E_BODY*
	this->change_encoding (encoding);
	//#UC END# *491D8B16029E_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// установить кодировку xml
void TranscodeHelper::change_encoding (const char* encoding) {
	//#UC START# *491D8A2D0133*
	XERCES_CPP_NAMESPACE::XMLTransService::Codes failReason;
	const unsigned int blockSize = 2048;
	
	GUARD (m_mutex);
	m_trans = XERCES_CPP_NAMESPACE::XMLPlatformUtils::fgTransService->makeNewTranscoderFor (
		encoding
		, failReason
		, blockSize
		, XERCES_CPP_NAMESPACE::XMLPlatformUtils::fgMemoryManager
	);

	if (!m_trans.ptr ()) {
		LOG_E (("%s: can't find transcoder for %s encoding, error code %d", GDS_CURRENT_FUNCTION, encoding, failReason));
		throw XercesBadEncoding ();
	}
	//#UC END# *491D8A2D0133*
}

// перекодировка строки
char* TranscodeHelper::transcode (const XMLCh* from) const {
	//#UC START# *491D8A8701B0*
	unsigned int eaten = 0;
	unsigned int len = XERCES_CPP_NAMESPACE::XMLString::stringLen (from);
	Core::Aptr<char, Core::ArrayDeleteDestructor<char> > char_sizes	(new char[len + 1]);
	memset (char_sizes.ptr (), 0, len + 1);

	GUARD (m_mutex);
	m_trans->transcodeTo (
		from
		, len
		, reinterpret_cast<XMLByte*> (char_sizes.ptr ())
		, len
		, eaten
		, XERCES_CPP_NAMESPACE::XMLTranscoder::UnRep_RepChar
	);
	return char_sizes.forget ();
	//#UC END# *491D8A8701B0*
}

// перекодировка строки
XMLCh* TranscodeHelper::transcode (const char* from) const {
	//#UC START# *491D8ABA00BB*
	unsigned int len = XERCES_CPP_NAMESPACE::XMLString::stringLen (from);
	Core::Aptr<XMLCh, Core::ArrayDeleteDestructor<XMLCh> > to = new XMLCh[len + 1];
	Core::Aptr<unsigned char, Core::ArrayDeleteDestructor<unsigned char> > char_sizes (new unsigned char[len + 1]);
	unsigned int count = 0;

	GUARD (m_mutex);
	m_trans->transcodeFrom (
		reinterpret_cast<XMLByte*> (const_cast<char*> (from))
		, len + 1
		, to.inout ()
		, len + 1
		, count
		, char_sizes.in ()
	);

	return to.forget ();
	//#UC END# *491D8ABA00BB*
}

// перекодировка строки
void TranscodeHelper::transcode (const char* from, XMLCh*& to) const {
	//#UC START# *491D8AE301CB*
	to = this->transcode (from);
	//#UC END# *491D8AE301CB*
}

} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

