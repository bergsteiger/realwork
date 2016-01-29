////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/RequestTransformer_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::RequestTransformer_i
// Заголовок реализации класса серванта для интерфеса IRequestTransformer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "shared/Morpho/Def/Def.h"

namespace ContextSearch {
namespace Manage_i {

class RequestTransformer_i; // self forward Var
typedef ::Core::Var<RequestTransformer_i> RequestTransformer_i_var;
typedef ::Core::Var<const RequestTransformer_i> RequestTransformer_i_cvar;

class RequestTransformer_i_factory;

class RequestTransformer_i:
	virtual public Manage::IRequestTransformer
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (RequestTransformer_i)
	friend class RequestTransformer_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Константы
	static const size_t MAX_WORDS_OF_REQUEST; // максимальное количество слов в морфозапросе

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// исключить слова и фразы
	static void exclude (std::string& str, const GCL::StrVector& data, bool is_fake);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	RequestTransformer_i (Morpho::Def::INormalizer* normalizer);

	~RequestTransformer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// получить значение даты
	const std::string& correct_date (std::string& str);

	// исключение стоп-слов c учетом hard-словосочетаний
	void exclude_hard (std::string& req, const GCL::StrVector& data, const GCL::StrVector& hard);

	// проверка строки на значения "Г", "Г.", "ГОД",..
	bool is_year (const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Morpho::Def::INormalizer_var m_normalizer;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Manage::IRequestTransformer
	// корректировка
	void correct (const std::string& in, std::string& out);

	// implemented method from Manage::IRequestTransformer
	// исключение стоп-слов
	size_t exclude (std::string& req, const GCL::StrVector& data, const DBComm::PSDTemplates& templates, bool is_fake);

	// implemented method from Manage::IRequestTransformer
	// выполнить
	GCL::StrVector* execute (
		const std::string& in
		, const GCL::StrVector& data
		, const GCL::StrVector& hard
		, Defs::StrStrMap& pseudo
	);

	// implemented method from Manage::IRequestTransformer
	// исключение стоп-слов
	void unchecked_exclude (std::string& req, const GCL::StrVector& data);
}; // class RequestTransformer_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
