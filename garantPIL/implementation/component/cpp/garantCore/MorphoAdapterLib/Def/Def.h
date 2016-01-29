////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/Def/Def.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// Интерфейсы и типы морфо-адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_DEF_H__
#define __GARANTCORE_MORPHOADAPTERLIB_DEF_H__

#include "shared/Core/sys/std_inc.h"

namespace MorphoAdapterLib {

class MorphoAdapter;
typedef ::Core::Var<MorphoAdapter> MorphoAdapter_var;
typedef ::Core::Var<const MorphoAdapter> MorphoAdapter_cvar;
// Адаптер для морфо-алгоритмов
class MorphoAdapter
	: virtual public ::Core::IObject
{
public:
	// нормализация
	virtual size_t normalize (const char* word, char* out) = 0;
};

/// factory interface for MorphoAdapter
class MorphoAdapterFactory {
public:
	// фабрика
	static MorphoAdapter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class MlmaRu;
typedef ::Core::Var<MlmaRu> MlmaRu_var;
typedef ::Core::Var<const MlmaRu> MlmaRu_cvar;
// API библиотеки mlma
class MlmaRu
	: virtual public ::Core::IObject
{
public:
	// mlmaruLemmatize
	virtual short lemmatize (
		const char* word
		, unsigned short options
		, char* lemm
		, void* LIDs
		, char* gram
		, unsigned short nlemm
		, unsigned short nLID
		, unsigned short ngram
	) = 0;

	// mlmaruBuildForm
	virtual short build_form (
		const char* word
		, unsigned long id
		, unsigned short options
		, unsigned char form
		, char* res
		, unsigned short len
	) = 0;

	// mlmaruCheckWord
	virtual short check_word (const char* word, unsigned short options) = 0;

	// mlmaruBuildFormGI
	virtual short build_form_gi (
		const char* word
		, unsigned long lex_id
		, unsigned short options
		, unsigned short gr_info
		, unsigned char flags
		, char* dest
		, unsigned short cc_dest
	) = 0;

	// mlmaruCheckHelp
	virtual short check_help (const char* word, char* list) = 0;
};

/// factory interface for MlmaRu
class MlmaRuFactory {
public:
	// фабрика
	static MlmaRu* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class MorphoManager;
typedef ::Core::Var<MorphoManager> MorphoManager_var;
typedef ::Core::Var<const MorphoManager> MorphoManager_cvar;
// Интерфейс для инициализации/деинициализации морфологии
class MorphoManager
	: virtual public ::Core::IObject
{
public:
	// инициализация
	virtual void init (const char* base_path) = 0;

	// деинициализация
	virtual void done () = 0;
};

/// factory interface for MorphoManager
class MorphoManagerFactory {
public:
	// фабрика
	static MorphoManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace MorphoAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <MorphoAdapterLib::MorphoAdapter> {
	typedef MorphoAdapterLib::MorphoAdapterFactory Factory;
};
template <>
struct TypeTraits <MorphoAdapterLib::MlmaRu> {
	typedef MorphoAdapterLib::MlmaRuFactory Factory;
};
template <>
struct TypeTraits <MorphoAdapterLib::MorphoManager> {
	typedef MorphoAdapterLib::MorphoManagerFactory Factory;
};
} // namespace Core


#endif //__GARANTCORE_MORPHOADAPTERLIB_DEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
