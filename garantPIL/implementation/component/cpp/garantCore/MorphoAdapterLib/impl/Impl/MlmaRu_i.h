////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MlmaRu_i
// Заголовок реализации класса серванта для интерфеса MlmaRu
//
// Сервант-обертка для экспорта функций библиотеки mlmaru
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_IMPL_MLMARU_I_H__
#define __GARANTCORE_MORPHOADAPTERLIB_IMPL_MLMARU_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/Def.h"

//#UC START# *4EA56D6601E0_CUSTOM_INCLUDES*
#include "shared/Adapters/mlmaru/MLMARUAdapter.h"
//#UC END# *4EA56D6601E0_CUSTOM_INCLUDES*

namespace MorphoAdapterLib {
namespace Impl {

class MlmaRu_i; // self forward Var
typedef ::Core::Var<MlmaRu_i> MlmaRu_i_var;
typedef ::Core::Var<const MlmaRu_i> MlmaRu_i_cvar;

class MlmaRu_i_factory;

// Сервант-обертка для экспорта функций библиотеки mlmaru
class MlmaRu_i:
	virtual public MlmaRu
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MlmaRu_i)
	friend class MlmaRu_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	MlmaRu_i ();

	~MlmaRu_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MlmaRu
	// mlmaruBuildForm
	short build_form (
		const char* word
		, unsigned long id
		, unsigned short options
		, unsigned char form
		, char* res
		, unsigned short len
	);

	// implemented method from MlmaRu
	// mlmaruBuildFormGI
	short build_form_gi (
		const char* word
		, unsigned long lex_id
		, unsigned short options
		, unsigned short gr_info
		, unsigned char flags
		, char* dest
		, unsigned short cc_dest
	);

	// implemented method from MlmaRu
	// mlmaruCheckHelp
	short check_help (const char* word, char* list);

	// implemented method from MlmaRu
	// mlmaruCheckWord
	short check_word (const char* word, unsigned short options);

	// implemented method from MlmaRu
	// mlmaruLemmatize
	short lemmatize (
		const char* word
		, unsigned short options
		, char* lemm
		, void* LIDs
		, char* gram
		, unsigned short nlemm
		, unsigned short nLID
		, unsigned short ngram
	);

//#UC START# *4EA56D6601E0*
private:
	Adapters::MLMA32RUAdapter* m_adapter;
//#UC END# *4EA56D6601E0*
}; // class MlmaRu_i

} // namespace Impl
} // namespace MorphoAdapterLib


#endif //__GARANTCORE_MORPHOADAPTERLIB_IMPL_MLMARU_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
