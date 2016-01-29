////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MlmaRu_i
//
// Сервант-обертка для экспорта функций библиотеки mlmaru
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/LibHome.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i.h"

//#UC START# *4EA56D6601E0_CUSTOM_INCLUDES*
//#UC END# *4EA56D6601E0_CUSTOM_INCLUDES*

namespace MorphoAdapterLib {
namespace Impl {

//#UC START# *4EA56D6601E0*
//#UC END# *4EA56D6601E0*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MlmaRu_i::MlmaRu_i ()
//#UC START# *4EA17C3A0381_4EA17FF50393_4EA56D6601E0_BASE_INIT*
//#UC END# *4EA17C3A0381_4EA17FF50393_4EA56D6601E0_BASE_INIT*
{
	//#UC START# *4EA17C3A0381_4EA17FF50393_4EA56D6601E0_BODY*
	m_adapter = Adapters::MLMA32RUAdapterSingleton::instance ();

	GDS_ASSERT (m_adapter);
	//#UC END# *4EA17C3A0381_4EA17FF50393_4EA56D6601E0_BODY*
}

MlmaRu_i::~MlmaRu_i () {
	//#UC START# *4EA56D6601E0_DESTR_BODY*
	//#UC END# *4EA56D6601E0_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MlmaRu
// mlmaruBuildForm
short MlmaRu_i::build_form (
	const char* word
	, unsigned long id
	, unsigned short options
	, unsigned char form
	, char* res
	, unsigned short len
) {
	//#UC START# *4EA56C9703D2_4EA56D6601E0*
	return m_adapter->build_form (word, id, options, form, res, len);
	//#UC END# *4EA56C9703D2_4EA56D6601E0*
}

// implemented method from MlmaRu
// mlmaruBuildFormGI
short MlmaRu_i::build_form_gi (
	const char* word
	, unsigned long lex_id
	, unsigned short options
	, unsigned short gr_info
	, unsigned char flags
	, char* dest
	, unsigned short cc_dest
) {
	//#UC START# *4EA57CA10210_4EA56D6601E0*
	return m_adapter->build_form_gi (word, lex_id, options, gr_info, flags, dest, cc_dest);
	//#UC END# *4EA57CA10210_4EA56D6601E0*
}

// implemented method from MlmaRu
// mlmaruCheckHelp
short MlmaRu_i::check_help (const char* word, char* list) {
	//#UC START# *4EA57D4301DC_4EA56D6601E0*
	return m_adapter->check_help (word, list);
	//#UC END# *4EA57D4301DC_4EA56D6601E0*
}

// implemented method from MlmaRu
// mlmaruCheckWord
short MlmaRu_i::check_word (const char* word, unsigned short options) {
	//#UC START# *4EA57C5F02D8_4EA56D6601E0*
	return m_adapter->check_word (word, options);
	//#UC END# *4EA57C5F02D8_4EA56D6601E0*
}

// implemented method from MlmaRu
// mlmaruLemmatize
short MlmaRu_i::lemmatize (
	const char* word
	, unsigned short options
	, char* lemm
	, void* LIDs
	, char* gram
	, unsigned short nlemm
	, unsigned short nLID
	, unsigned short ngram
) {
	//#UC START# *4EA56A69023C_4EA56D6601E0*
	return m_adapter->lemmatize (word, options, lemm, (unsigned long*) LIDs, gram, nlemm, nLID, ngram);
	//#UC END# *4EA56A69023C_4EA56D6601E0*
}
} // namespace Impl
} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

