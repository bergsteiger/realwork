////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplatePainter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplatePainter
//
// Собственно класс, реализующие основные операции вывода шаблона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "shared/GCL/alg/sorting.h"
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/AbstractDumpers/UserCodeExtractor.h"
#include "boost/bind.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
// by <<friend>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"

//#UC START# *477606D700B4_CUSTOM_INCLUDES*
#include <strstream>
#include <boost/lexical_cast.hpp>
#include <boost/functional/hash/hash.hpp>
#include "boost/bind.hpp"

#include "AbstractSingleDumperBase.h"
#include "TemplateDumperDumper.h"
//#UC END# *477606D700B4_CUSTOM_INCLUDES*


//#UC START# *477606D700B4*
//#define TIME_PROFILING_ENABLED

TemplatePainter::ResolveCache TemplatePainter::s_resolve_cache;
const AbstractDumperBase::StereotypeID TemplatePainter::s_inherited_flag ("inherited");

const std::string OPEN_CHARS = "{<[";
const std::string CLOSE_CHARS = "}>]";

void debug_func (const std::string& dbg_id) {
	TRACE ("DEBUG POINT: %s\n", dbg_id.data());
}

namespace StereotypeMethods {
	template <typename ID>
	struct is_function {
		enum {value = Loki::IsSameType<ID,AbstractDumperBase::FunctionID>::value};
	};

	template <bool IsFunction>
	struct container {
		template <bool IsFunction>
		struct impl {
			typedef AbstractDumperBase::Transformators type;
		};

		template <>
		struct impl<true> {
			typedef AbstractDumperBase::Functions type;
		};

		typedef typename impl<IsFunction>::type type;
	};
} //StereotypeMethods
//если параметр шаблона true - ищем функцию, иначе трансформатор
template <bool IsFunction>
class Finder {
public:	
	typedef typename Loki::Select<
		IsFunction, const AbstractDumperBase::FunctionID, const AbstractDumperBase::TransformatorID
	>::Result ID;

	typedef typename Loki::Select<
		IsFunction
		, AbstractDumperBase::Functions::const_iterator
		, AbstractDumperBase::Transformators::const_iterator
	>::Result OuputIterator;
		
	static bool find_in (
		const AbstractDumperBase::FunctionID& id
		, const AbstractDumperBase::Template& context_tpl
		, AbstractDumperBase::Functions::const_iterator& f
	) {
		f = context_tpl.functions.find (id);
		return f != context_tpl.functions.end ();
	}

	static bool find_in (
		const AbstractDumperBase::TransformatorID& id
		, const AbstractDumperBase::Template& context_tpl
		, AbstractDumperBase::Transformators::const_iterator& f
	) {
		f = context_tpl.transformators.find (id);
		return f != context_tpl.transformators.end ();
	}
	//ищем функцию в стереотипе base_stereotype
	static bool find_one_level (
		const ID& id
		, const AbstractDumperBase::StereotypeID& base_stereotype
		, const AbstractDumperBase::Template& context_tpl
		, OuputIterator& f
	) {
		bool finded = false;
		if (
			context_tpl.base_stereotypes.find (base_stereotype) 
			!= context_tpl.base_stereotypes.end ()
		) {
			const AbstractDumperBase::Template& base_tpl = AbstractDumperBase::get_template (base_stereotype);			
			finded = find_in (id, base_tpl, f);		
		}
		return finded;
	}

	//ищет определение функции среди базовых стереотипов
	static bool find_in_base (
		const ID& id
		, const AbstractDumperBase::Template& context_tpl
		, OuputIterator& f
	) {
		StereotypeSet::const_iterator it = where_context.base_stereotypes.begin ();
		StereotypeSet::const_iterator it_end = where_context.base_stereotypes.end ();
		for (; it != it_end; ++it) {
			const AbstractDumperBase::Template& base_tpl = AbstractDumperBase::get_template (*it);
		}
	}
		
	//мапа найденных базовых стереотипов, которые содержат
	//функцию или трансформатор с идентификатором what_find 
	typedef std::map<const AbstractDumperBase::StereotypeID, OuputIterator> FindedMap;
	static void find (
		ID& what_find
		, const AbstractDumperBase::Template& where_context
		, FindedMap& out
		, AbstractDumperBase::StereotypeIDVector& main_base_stereotypes
	) {
		AbstractDumperBase::StereotypeSet::const_iterator it = where_context.base_stereotypes.begin ();
		AbstractDumperBase::StereotypeSet::const_iterator it_end = where_context.base_stereotypes.end ();
		for (; it != it_end; ++it) {
			const AbstractDumperBase::Template& base_tpl = AbstractDumperBase::get_template (*it);
			if (!base_tpl.main_base_stereotype/*.get ()*/.empty ()) {
				main_base_stereotypes.push_back (base_tpl.main_base_stereotype);
			}
			OuputIterator f;
			if (find_in (what_find, base_tpl, f)) {
				//нашли среди прямых родителей
				out[*it] = f;
			} else {
				//пытаемся найти среди "дедушек"
				find (what_find, base_tpl, out, main_base_stereotypes);
			}
		}
	}

	//ищем по иерархии наследования функцию
	//если нашли возвращаем количество найденных
	//, f указывает на последнюю найденную функцию
	//если нет - false
	static void find_with_base (
		const ID& id
		, const AbstractDumperBase::StereotypeID& base_stereotype
		, const AbstractDumperBase::Template& context_tpl
		, FindedMap& out
	) {	
		//сначала ищем среди ближайших базовых стереотипов
		OuputIterator f;
		if (!find_one_level (id, base_stereotype, context_tpl, f)) {
			//если стереотип context_tpl наследуется от base_stereotype - ищем функцию рекурсивно вверх по иерархии наследования
			//от стереотипа base_stereotype
			if (
				context_tpl.base_stereotypes.find (base_stereotype) 
				!= context_tpl.base_stereotypes.end ()
			) {
				const AbstractDumperBase::Template& base_tpl = AbstractDumperBase::get_template (base_stereotype);

				AbstractDumperBase::StereotypeIDVector main_base_stereotypes;
				find (id, base_tpl, out, main_base_stereotypes);
			}
		} else {
			out[base_stereotype] = f;
		}
	}
};

/*
class EnterContext {
public:
	EnterContext (
		const AbstractDumperBase::ContextData& data
	) {
		AbstractDumperBase::TemplateContext::instance ()->push (data);
	}
	~EnterContext () {
		AbstractDumperBase::TemplateContext::instance ()->pop ();
	}

};
*/

const std::string pop_context_wrapper (const std::string& result) {
	AbstractDumperBase::TemplateContext::instance ()->pop ();
	return result;
}

bool TemplatePainter::resolve_cond_ex (
	const AbstractDumperBase::CodeTemplate& exp
	, const TPArgs& args
	, const AbstractDumperBase* main_scope
	, TemplatePainter* base
	, const TemplatePainter* parent
) {	
	bool exp_good = false;

	GCL::StrVector exp_or_parts;
	GCL::split_string_by (
		exp.begin(), exp.end(), SX_4_COND_OR, OPEN_CHARS, SX_2_SYMBOL, CLOSE_CHARS, exp_or_parts
	);
	for (
		GCL::StrVector::iterator ep_or_it = exp_or_parts.begin()
		; ep_or_it != exp_or_parts.end() && !exp_good
		; ep_or_it++
	) {		
		GCL::StrVector exp_and_parts;
		GCL::split_string_by (
			(*ep_or_it).begin(), (*ep_or_it).end(), SX_4_COND_AND, OPEN_CHARS, SX_2_SYMBOL, CLOSE_CHARS, exp_and_parts
		);
		exp_good = true;
		for (
			GCL::StrVector::iterator ep_and_it = exp_and_parts.begin()
			; ep_and_it != exp_and_parts.end() && exp_good
			; ep_and_it++
		) {
			GCL::StrVector exp_part_parts;
			GCL::split_string_by (
				(*ep_and_it).begin(), (*ep_and_it).end(), SX_4_COND_EQU, OPEN_CHARS, SX_2_SYMBOL, CLOSE_CHARS, exp_part_parts
			);
			if (exp_part_parts.size() == 1) {
				std::string exp_resolv;
				if (!base) {
					exp_resolv = TemplatePainter::resolve_exp(exp_part_parts[0], args, main_scope, parent);
				} else {
					exp_resolv = TemplatePainter::resolve_exp (exp_part_parts[0], base);
				}
				exp_good = exp_resolv != "";
			} else {
				if (exp_part_parts.size() != 2) {
					std::string mess ("Bad expression format \"");
					mess += *ep_and_it;
					mess += "\"";

					throw TemplateBadSyntax (mess);
				}

				bool is_not = false;
				if (exp_part_parts[0][exp_part_parts[0].size()-1] == SX_4_COND_NOT) {
					is_not = true;
					exp_part_parts[0].resize(exp_part_parts[0].size()-1);
				}
				
				std::string exp_resolv_0;
				std::string exp_resolv_1;
				if (!base) {
					exp_resolv_0 = TemplatePainter::resolve_exp(exp_part_parts[0], args, main_scope, parent);
					exp_resolv_1 = TemplatePainter::resolve_exp(exp_part_parts[1], args, main_scope, parent);
				} else {
					exp_resolv_0 = TemplatePainter::resolve_exp(exp_part_parts[0], base);
					exp_resolv_1 = TemplatePainter::resolve_exp(exp_part_parts[1], base);
				}
			
				exp_good = exp_resolv_0 == exp_resolv_1;
				
				if (is_not) {
					exp_good = !exp_good;
				}
			}
		}
	}

	return exp_good;
}

void TemplatePainter::replace_iterator (const AbstractDumperBase::ADList::iterator& iter) {
	**m_cycle_it = iter;
}

AbstractDumperBase::ADListIt_box& TemplatePainter::dereference () {
	return *m_cycle_it;
}

//пустая ли была исходная последовательность
bool TemplatePainter::is_empty_source () const {
	if (m_is_reversed_cycle) {
		return *m_save_cycle_it == m_rend_iterator;
	}
	
	return m_save_cycle_it == m_cycle_end;
}

bool TemplatePainter::is_valid_iterator () const {
	if (m_is_reversed_cycle) {
		return !(m_rend_iterator == **m_cycle_it);
	}

	return !(*m_cycle_it == m_cycle_end);
}

void TemplatePainter::increment_iterator () {
	if (m_is_reversed_cycle) {
		if ((*m_cycle_it == m_cycle_end)) {
			**m_cycle_it = m_rend_iterator;
		} else {
			(**m_cycle_it)--;
		}
	} else {
		(**m_cycle_it)++;
	}
}

void TemplatePainter::decrement_iterator () {
	if (m_is_reversed_cycle) {
		if (**m_cycle_it == m_rend_iterator) {
			*m_cycle_it = m_cycle_end;
		} else {
			(**m_cycle_it)++;
		}
	} else {
		(**m_cycle_it)--;
	}
}
//#UC END# *477606D700B4*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation

const char* TemplatePainter::TemplateCycleIterationBreak::uid () const /*throw ()*/ {
	return "3A66094F-3DA5-41DB-8938-82962CCF5274";
}

const char* TemplatePainter::TemplateCycleIterationBreak::what () const throw () {
	//#UC START# *4BD7B63F0157_WHAT_IMPL*
	return "TemplateCycleIterationBreak (итерация цикла была прервана)";
	//#UC END# *4BD7B63F0157_WHAT_IMPL*
}




TemplatePainter::TemplateBadSyntax::TemplateBadSyntax (const std::string& info)
	: FatalError (info)
//#UC START# *4BE0E9230280_BASE_INIT*
//#UC END# *4BE0E9230280_BASE_INIT*
{
	//#UC START# *4BE0E9230280_BODY*
	//#UC END# *4BE0E9230280_BODY*
}

const char* TemplatePainter::TemplateBadSyntax::uid () const /*throw ()*/ {
	return "650764B3-C062-49A3-B74B-C02EC4994BD4";
}



//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// разбирает выражение expression и возвращает результат в виде строки
// args - аргументы, необходимые для разюора выражения
// main_scope - элемент для которого производится разбор шаблона
const std::string TemplatePainter::resolve_exp (const AbstractDumperBase::CodeTemplate& expression, const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent) {
	//#UC START# *477608BB021C*
	std::ostrstream resolve;
	TemplatePainter tp (args, resolve, main_scope, parent);
	
	AbstractDumperBase::CodeTemplate::const_iterator it_begin = expression.begin();
	AbstractDumperBase::CodeTemplate::const_iterator it_end = expression.end();
	tp.paint (it_begin, it_end);
	resolve << '\0';
	
	char* p = resolve.str ();
	resolve.freeze(false);	
	
	return p ? std::string (p) : std::string ();
	//#UC END# *477608BB021C*
}

// разбирает условное выражение expression и возвращает результат в виде строки
const bool TemplatePainter::resolve_cond (const AbstractDumperBase::CodeTemplate& expression, const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent) {
	//#UC START# *47760997022A*
	return resolve_cond_ex(expression, args, main_scope, NULL, parent);
	//#UC END# *47760997022A*
}

// разбирает условное выражение expression и возвращает результат в виде строки
const bool TemplatePainter::resolve_cond (const AbstractDumperBase::CodeTemplate& expression, TemplatePainter* base) {
	//#UC START# *477C8BA101F0*
	return resolve_cond_ex(expression, TPArgs(), NULL, base, base);
	//#UC END# *477C8BA101F0*
}

// разбирает выражение expression и возвращает результат в виде строки
const std::string TemplatePainter::resolve_exp (const AbstractDumperBase::CodeTemplate& expression, TemplatePainter* base) {
	//#UC START# *477C91110009*
	std::ostrstream resolve;
	TemplatePainter tp (base);
	tp.set_output(resolve);

	AbstractDumperBase::CodeTemplate::const_iterator it_begin = expression.begin();
	AbstractDumperBase::CodeTemplate::const_iterator it_end = expression.end();
	tp.paint(it_begin, it_end);
	resolve << '\0';
	
	char* p = resolve.str ();
	resolve.freeze(false);	
	
	return p ? std::string (p) : std::string ();
	//#UC END# *477C91110009*
}

// возвращает переменную с идентификатором var_id, если такой переменной нет - возвращает 0
const AbstractDumperBase* TemplatePainter::get_var_dumper (const std::string& var_id) {
	//#UC START# *477CAE0500B1*
	AbstractDumperBase::VarDumpers::iterator it = VarDumpersSingleton::instance ()->ptr.find (var_id);
	if (it != VarDumpersSingleton::instance ()->ptr.end()) {
		return it->second.ptr ();
	} else {	
		return 0;
	}
	//#UC END# *477CAE0500B1*
}

// устанавливает переменную с идентифкатором var_id
void TemplatePainter::set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) {
	//#UC START# *477CAE330306*
	if (dumper) {
		dumper->addref ();
	}

	VarDumpersSingleton::instance ()->ptr[var_id] = dumper;
	//#UC END# *477CAE330306*
}

// очищает списки переменных
void TemplatePainter::clear () {
	//#UC START# *477CAE730232*
	if (!VarDumpersSingleton::instance ()->ptr.empty ()) {
		LOG_I (("Global variables map size = %d", VarDumpersSingleton::instance ()->ptr.size ()));
	}

	VarDumpersSingleton::instance ()->ptr.clear();
	DuplicatedNamesSingleton::instance ()->clear ();
	s_resolve_cache.clear ();
	//#UC END# *477CAE730232*
}

// формирует строку - юзер-секцию
const std::string TemplatePainter::make_uc (const std::string& uc_id, const std::string& uc_content, const AbstractDumperBase::TemplateBody& tpl) {
	//#UC START# *4A97C0C103D0*	

	std::stringstream output;
	output << tpl.user_code_open_start_id;
	if (!tpl.user_code_unique) {
		output << uc_id;
	}
	output << tpl.user_code_close_start_id;
	output << uc_content;
	output << tpl.user_code_open_end_id;

	if (!tpl.user_code_unique) {
		output << uc_id;
	}
	output << tpl.user_code_close_end_id;

	return output.str ();
	//#UC END# *4A97C0C103D0*
}

// удаляет переменную из списка глобальных переменных
void TemplatePainter::delete_var_dumper (const std::string& var_id) {
	//#UC START# *4D6CDA7D031C*
	VarDumpersSingleton::instance ()->ptr.erase (var_id);
	//#UC END# *4D6CDA7D031C*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TemplatePainter::TemplatePainter (const TemplatePainter* base)
//#UC START# *477609D401A9_BASE_INIT*
:	m_owner(base->m_owner)
	, m_args(base->m_args)
	, m_output (*base->m_output.m_output, this)
	, m_is_reversed_cycle (base->m_is_reversed_cycle)
	, m_main_scope (base->m_main_scope)
	, m_data (base->m_data)
	, m_cycle_end(base->m_cycle_end)
	, m_cycle_it(base->m_cycle_it)
	, m_save_cycle_it(base->m_save_cycle_it)
	, m_cycle_iteration (base->m_cycle_iteration)
	, m_sorting_type (base->m_sorting_type)
	, m_sort_processed (base->m_sort_processed)
	, m_encoding (base->m_encoding)
	, m_rend_iterator (base->m_rend_iterator)
	, m_parent (base)
//#UC END# *477609D401A9_BASE_INIT*
{
	//#UC START# *477609D401A9_BODY*
	//#UC END# *477609D401A9_BODY*
}

TemplatePainter::TemplatePainter (
	const TPArgs& args
	, std::ostream& output
	, const AbstractDumperBase* main_scope
	, const TemplatePainter* parent
)
//#UC START# *47760A5C014C_BASE_INIT*
:	m_args(args)
	, m_output (output, this)
	, m_main_scope(main_scope)
	, m_is_reversed_cycle (false)
	, m_cycle_iteration (0)
	, m_sorting_type (0)
	, m_sort_processed (true)
	, m_encoding (AbstractDumperBase::s_default_encoding)
	, m_parent (parent)
//#UC END# *47760A5C014C_BASE_INIT*
{
	//#UC START# *47760A5C014C_BODY*
	m_owner = args.size() ? args[0] : 0;
	//#UC END# *47760A5C014C_BODY*
}

// конструктор, поток, в который будет осуществляться вывод создаётся внутри обёртки - т.е поток
// временный
TemplatePainter::TemplatePainter (
	const TPArgs& args
	, const AbstractDumperBase* main_scope
	, const TemplatePainter* parent
)
//#UC START# *477CBC0302BC_BASE_INIT*
:	m_args(args)
	, m_output (this)
	, m_main_scope(main_scope)
	, m_is_reversed_cycle (false)
	, m_cycle_iteration (0)
	, m_sorting_type (0)
	, m_sort_processed (true)
	, m_encoding (AbstractDumperBase::s_default_encoding)
	, m_parent (parent)
//#UC END# *477CBC0302BC_BASE_INIT*
{
	//#UC START# *477CBC0302BC_BODY*
	m_owner = args.size() ? args[0] : 0;
	//#UC END# *477CBC0302BC_BODY*
}

TemplatePainter::~TemplatePainter () {
	//#UC START# *477606D700B4_DESTR_BODY*
	//#UC END# *477606D700B4_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// создает полную копию объекта, при этом для всех переменных типа Box копируется их содержимое
TemplatePainter* TemplatePainter::clone () const {
	//#UC START# *4B29D5650231*	
	TemplatePainter_var clone (new TemplatePainter (this->get_args (), *this->m_output.m_output, this->get_main_scope (), NULL));
	clone->m_owner = this->m_owner;
	clone->m_main_scope = this->m_main_scope;
	clone->m_rend_iterator = this->m_rend_iterator;
	//clone->m_data = this->m_data;
	clone->m_is_reversed_cycle = this->m_is_reversed_cycle;
	clone->m_sorting_type = this->m_sorting_type;
	clone->m_sort_processed = new bool (*this->m_sort_processed);
	clone->m_encoding = this->m_encoding;
	clone->m_cycle_iteration = this->m_cycle_iteration;

	if (!this->m_data.is_nil ()) {
		PainterADData::DataMap::const_iterator it = this->m_data->m_data_map.begin ();
		PainterADData::DataMap::const_iterator it_end = this->m_data->m_data_map.end ();

		clone->m_data.replace (PainterADData::make ());
		clone->m_data->m_data_map = this->m_data->m_data_map;
		for (; it != it_end; ++it) {
			PainterADData::DataPair& data = clone->m_data->m_data_map[it->first];
			if (!it->second.first.is_nil ()) {
				AbstractDumperBase::ADList* list = const_cast<AbstractDumperBase::ADList*> (it->second.first.ptr ());
				data.first = new AbstractDumperBase::ADList (*list);

				if (!it->second.second.is_nil ()) {
					AbstractDumperBase::ADList::iterator curr_pos = *it->second.second;
					AbstractDumperBase::ADList::iterator begin = list->begin ();

					AbstractDumperBase::ADList::iterator pos = data.first->begin ();
					
					std::advance (pos, std::distance (begin, curr_pos));
					data.second = new AbstractDumperBase::ADList::iterator (pos);
				} else {
					data.second = new AbstractDumperBase::ADList::iterator (data.first->begin ());
				}
			}
			
		}
	}

	return clone._sretn ();
	//#UC END# *4B29D5650231*
}

// разворачивает шаблон
bool TemplatePainter::execute_paint (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	, bool if_flag
	, bool cycle_flag
) {
	//#UC START# *47762E5603A6*
	GDS_ASSERT_MSG(!(if_flag && cycle_flag), ("%s bad params combination", GDS_CURRENT_FUNCTION));

	//сохраняем начало строчки, чтобы использовать в сообщении об ошибке
	AbstractDumperBase::CodeTemplate::const_iterator saved_it = it;
	try {
		bool wrap_exception = true;
		bool output_success = false;
		bool end_if_parse = false;
		bool end_cycle_parse = false;
		
		for (; it != it_end; it++ ) {
			switch (*it) {
				case SX_2_ARGUMENT: {
					it++;
					switch (*it) {					
						case SX_3_TRANSFORMATOR: {
							TemplateFunctions::FunctionParams params;
							AbstractDumperBase::TransformatorID t_id = this->extract_transformator (it, it_end, params);
							
							TemplatePainter tp (this);						
							std::string trans_rs = tp.transform (t_id, params);						
							m_output << trans_rs;						
							output_success |= (trans_rs != "");
							break;
						}
						case SX_3_FUNCTION: {
							TemplateFunctions::FunctionParams params;

							AbstractDumperBase::FunctionID f_id = this->extract_function (it, it_end, params);
							std::string func_rs = this->function (f_id, params);
							m_output << func_rs;						
							output_success |= (func_rs != "");
							break;
						}
						case SX_3_USER_CODE: {
							TemplatePainter tp (this);
							it++;
							assert (*it == SX_2_IF_OPEN);
							it++;
							output_success |= tp.paint_user_code(it, it_end);
							break;						
						}
						default: {
							AbstractDumperBase::CodeTemplate::const_iterator s_it = it;
							const AbstractDumperBase* templ_dump = get_dumper_by_template (it, it_end);
							const ContainerDumper* c = dynamic_cast<const ContainerDumper*> (m_owner);
							/*if (c) {
								const AbstractDumperBase* td = get_dumper_by_template (s_it, it_end);
							}*/
							output_success |= this->paint_parameter (it, it_end, templ_dump);						
							//if_statement_scope = templ_dump;
							break;
						}
					}							
					break;
				}
				case SX_2_INTEND:
					if (m_owner) {
						m_output << m_owner->get_intend_str(AbstractDumperBase::s_intend_shift);					
					}
					break;
				case SX_2_SYMBOL: {
					it++;
					switch (*it) {
						case SX_2_INTEND:
						case SX_2_SYMBOL: 
						case SX_2_CYCLE_OPEN:
						case SX_2_CYCLE_CLOSE:
						case SX_2_IF_OPEN: 
						case SX_2_IF_CLOSE:
						case SX_2_IFCYCLE_PARAMS_OPEN:
						case SX_2_IFCYCLE_PARAMS_CLOSE:
						case SX_2_ARGUMENT:
							m_output << *it;						
							break;
						case SX_3_NEW_STR:
							m_output << '\n';						
							break;
						case SX_3_TAB:
							m_output << '\t';					
							break;
						case 10:
							// skip new line
							if (*it == 13) {
								it++;
							}
							break;
						default: {
							char* stop_str;
							std::string hex_code (it, it+2);
							long x = strtol (hex_code.c_str(), &stop_str, 16);
							if (x) {
								m_output << (char)x;							
								it++;
							} else {								
								throw TemplateBadSyntax ("Wrong escape symbol");							
							}
							break;
						}
					}
					break;
				}
				case SX_2_IF_OPEN: {
					TemplatePainter tp (this);
					it++;
					output_success |= tp.paint_if(it, it_end);
					break;
				}			
				case SX_2_IF_CLOSE :
					end_if_parse = true;			
					break;
				case SX_2_CYCLE_OPEN: {
					TemplatePainter tp (this);
					it++;
					output_success |= tp.paint_cycle(it, it_end);
					break;
				}					
				case SX_2_CYCLE_CLOSE :
					end_cycle_parse = true;			
					break;			
				default:
					m_output << *it;				
					break;
				}
			if (if_flag && end_if_parse || cycle_flag && end_cycle_parse) break;
		}
		//m_output.flush_buffer ();
		return output_success;
	} catch (AbstractDumperBase::TemplateResolveException& ex) {
		throw ex;
	} catch (TemplateCycleIterationBreak& ex) {
		throw ex;
	} catch (std::exception& ex) {		
		//из исходной строки "выдираем" кусок в окрестности 
		//[it - range_half_size, it + range_half_size];
		
		const size_t range_half_size = 50;

		size_t distance_from_begin = std::distance(saved_it, it);
		size_t distance_to_end = std::distance(it, it_end);

		size_t range_from_begin = std::min <size_t> (
			distance_from_begin
			, range_half_size > distance_to_end 
				? range_half_size + (range_half_size - distance_to_end) 
				: range_half_size
		);

		size_t range_to_end = std::min <size_t> (
			distance_to_end
			, range_half_size > distance_from_begin 
				? range_half_size + (range_half_size - distance_from_begin) 
				: range_half_size
		);
		
		std::string code_block (
			it - range_from_begin
			, it + range_to_end
		);
		
		std::string mess ("Ошибка в процессе выполнения шаблона: \"");
		mess += ex.what ();
		mess += "\"\r\n";

		if (!code_block.empty ()) {
			mess += "\r\nШаблон: ";
			mess += code_block;
		}

		Core::Aptr<GCL::StrVector> functions_stack (this->get_stack ());
		if (!functions_stack.is_nil () && !functions_stack->empty ()) {
			mess += "\r\n\r\nСтэк вызова функций:\r\n\t ";
			mess += GCL::join (*functions_stack.ptr (), "\r\n\t ");
		}

		const AbstractDumperBase* owner = this->get_owner ();
		mess+= "\r\n\r\nЭлемент: " + owner->get_full_name ();
		mess+= "\r\nСтереотип: " + owner->get_model_stereotype_str ();
		mess+= "\r\nГенератор: " + AbstractDumperBase::s_current_map;

		throw AbstractDumperBase::TemplateResolveException (mess);
	}
	//#UC END# *47762E5603A6*
}

// разбирает выражение заданное [it, it_end], пытается найти идентификатор функции и параметры
// функции
const AbstractDumperBase::FunctionID TemplatePainter::extract_function (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	, TemplateFunctions::FunctionParams& params
) {
	//#UC START# *477629A60120*
	AbstractDumperBase::FunctionID f_id (GCL::part (it, it_end, '('));
	if (it == it_end) {
		std::string mess ("Unclosed function id (started from: \"");
		mess += f_id/*.get ()*/.substr (0, 20);
		mess += "...\")";
		
		throw TemplateBadSyntax (mess);
	}
	std::string params_str = GCL::part (it, it_end, ')', SX_2_SYMBOL, '(');
	if (it == it_end) {
		std::string mess ("Unclosed function params (started from: \"");
		mess += params_str.substr (0, 20);
		mess += "...\") ";
		mess += f_id;

		throw TemplateBadSyntax (mess);
	}
	
	params = GCL::split_string_by (
		params_str.begin()
		, params_str.end()
		, ','
		, "\"("
		, SX_2_SYMBOL
		, "\")"		
	);	
	return f_id;
	//#UC END# *477629A60120*
}

// разбирает выражение заданное [it, it_end], пытается найти идентификатор и параметры
// трансформаторы
const AbstractDumperBase::TransformatorID TemplatePainter::extract_transformator (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	, TemplateFunctions::FunctionParams& params
) {
	//#UC START# *47762A990314*
	AbstractDumperBase::TransformatorID t_id (GCL::part (it, it_end, '('));
	if (it == it_end) {
		std::string mess ("Unclosed transformator id (started from: \"");
		mess += t_id/*.get ()*/.substr (0, 20);
		mess += "...\")";
		
		throw TemplateBadSyntax (mess);
	}

	std::string params_str = GCL::part (it, it_end, ')', SX_2_SYMBOL, '(');
	if (it == it_end) {
		std::string mess ("Unclosed transformator params (started from: \"");
		mess += params_str.substr (0, 20);
		mess += "...\") ";
		mess += t_id;
		
		throw TemplateBadSyntax (mess);
	}

	params = GCL::split_string_by (params_str.begin(), params_str.end(), ',', '"', '\\', '"');

	return t_id;
	//#UC END# *47762A990314*
}

// вычисляет значение функции, заданного идентификатором id, params - список параметров для функции
const std::string TemplatePainter::function (
	const AbstractDumperBase::FunctionID& id
	, const TemplateFunctions::FunctionParams& params
) {
	//#UC START# *4776109A02B4*
#if !defined(GDS_NLOG_DEBUG) || defined(TIME_PROFILING_ENABLED)
	std::string sw_name ("Function: ");
	sw_name += id;
	Core::GDS::StopWatchEx sw (sw_name.c_str ());
#endif

	AbstractDumperBase::Functions::iterator f = AbstractDumperBase::s_functions.find(id);

	AbstractDumperBase::TemplateContext::instance ()->push (
		AbstractDumperBase::ContextData (
			AbstractDumperBase::StereotypeID ("")
			, id
			, AbstractDumperBase::TransformatorID ("")
			, params
		)
	);

	if (f != AbstractDumperBase::s_functions.end()) {
		return pop_context_wrapper (this->resolve_method (f->second, params, 0));
	} {
		try {
			

			//Core::Aptr<TemplateFunctions::InternalFunctionFactory::KeySet> keys = TemplateFunctions::InternalFunctionFactory::keys ();
			/*if (!keys.is_nil () && std::binary_search  (keys->begin (), keys->end (), id))*/ {
				TemplateFunctions::InternalFunction& func = TemplateFunctions::InternalFunctionFactory::make (id);
				return pop_context_wrapper (func.execute (params, this));
			}
		} catch (Core::Root::UnknownFactoryKey&) {
			//т.к функция на самом деле не вызывалась - удаляем её из стэка
			AbstractDumperBase::TemplateContext::instance ()->pop ();
		}
	}

	std::string mess ("use undefined function \"");
	mess += id;
	mess += "\"";
	
	throw TemplateBadSyntax (mess);

	return std::string ();
	//#UC END# *4776109A02B4*
}

// Возвращает элемент дерева генерации, по соответствующему шаблону
const AbstractDumperBase* TemplatePainter::get_dumper_by_template (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
) {
	//#UC START# *477C7C960296*
	if (it == it_end) {
		return 0;
	}

	const AbstractDumperBase* templ_dump = NULL;
	if (!m_data) {
		m_data.replace (PainterADData::make ());
	}

	char map_key = *it;

	Core::Aptr<DumperByTemplateFunc> impl (this->get_dumper_by_template_impl (map_key));
	if (!impl.is_nil ()) {
		PainterADData::DataMap::iterator data = m_data->m_data_map.find (map_key);
		if (data == m_data->m_data_map.end ()) {
			data = m_data->m_data_map.insert (
				PainterADData::DataMap::value_type (
					map_key
					, PainterADData::DataPair (
						m_owner ? (*impl)(m_owner) : new AbstractDumperBase::ADList()
						, AbstractDumperBase::ADListIt_box ()
					)
				)
			).first;
			this->sort (data->second.first);
			data->second.second.replace (data->second.first->begin());
		} else {
			if (this->sort (data->second.first)) {
				data->second.second.replace (data->second.first->begin());
			}
		}
		templ_dump = setup_iterator (data->second.second, data->second.first->end());
	} else {
		switch (*it) {			
			case SX_3_TARGET:
				templ_dump = m_owner ? m_owner->get_target() : NULL;
				break;
			case SX_3_INITIAL_VALUE:
				templ_dump = m_owner ? m_owner->get_initial_value () : NULL;
				break;
			case SX_3_SELF:
				templ_dump = m_owner;
				break;
			case SX_3_MAIN_SCOPE:
				templ_dump = m_main_scope;
				break;
			case SX_3_MAIN_ELEMENT:
				//templ_dump = s_main_element;
				templ_dump = m_owner ? m_owner->get_main_element() : AbstractDumperBase::s_model_main_element;
				break;
			case SX_3_GENERATOR: 
				{
					TemplateDumperDumper* temp_dump = TemplateDumperDumper::get_by_id (AbstractDumperBase::s_current_map);
					templ_dump = temp_dump;
				}
				break;

			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9': {
				char buff[2];
				buff[0] = *it;
				buff[1] = 0;
				unsigned indx = atoi (buff);
				if (m_args.size() > indx) {
					templ_dump = m_args[indx];
				}
				break;
			}
			case '{': {
				std::string var_id = this->resolve_var_id (it, it_end);
				templ_dump = get_var_dumper (var_id);
				break;
			}
			default: {
				char mess[128];
				ACE_OS::snprintf (mess, 128, "Invalid dumper command at: %.20s \n", it);
				throw TemplateBadSyntax (mess);
			}
		}
	}

	while (
		it != it_end
		&& (it+1) != it_end
		&& (it+2) != it_end
		&& *(it+1) == SX_2_ARGUMENT
		&& *(it+2) == '{'
	) {
		it++;
		it++;
		std::string var_id = this->resolve_var_id (it, it_end);

		//возможна конструкция:
		//%C%{VAR}
		const AbstractDumperBase* var_owner = templ_dump != 0 ? templ_dump : this->get_main_scope ();
		if (templ_dump) {
			templ_dump = var_owner->get_var_dumper (var_id);
		} else {
			var_owner->get_var_dumper (var_id); //just skip symbols
		}
	}

	if (
		it != it_end
		&& (it+1) != it_end
		&& (it+2) != it_end
		&& *(it+1) == SX_2_ARGUMENT 
		&& *(it+2) != SX_3_FUNCTION 
		&& *(it+2) != SX_3_TRANSFORMATOR
		&& *(it+2) != SX_3_BASE_STEREOTYPE_ID_OPEN
	) {
		it++;
		it++;

		const AbstractDumperBase* var_owner = templ_dump != 0 ? templ_dump : this->get_main_scope ();
		
		TemplatePainter::TPArgs args;
		args.push_back (var_owner);
		TemplatePainter tp (args, *m_output.m_output, m_main_scope, this);

		if (templ_dump) {
			templ_dump = tp.get_dumper_by_template(it, it_end);
		} else {
			tp.get_dumper_by_template(it, it_end); //just skip symbols
		}
	}
	
	if (!templ_dump || !templ_dump->accepted_generator()) {
		return 0;
	}
	//AbstractDumperBase::TemplateContext::instance ()->set_stereotype (
	//	templ_dump->get_model_stereotype_str ()
	//);
	return templ_dump;
	//#UC END# *477C7C960296*
}

// возвращает реализацию функции для заданной команды (arg)
TemplatePainter::DumperByTemplateFunc* TemplatePainter::get_dumper_by_template_impl (char arg) const {
	//#UC START# *4B5EEC0C0068*
	switch (arg) {
		case SX_3_CONTENTS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_contents, _1)
			);
		case SX_3_ALL_DUPLICATES_BY_NAME:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_all_equals_name, _1)
			);
		case SX_3_ALL_CONTENTS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_all_contents, _1)
			);
		case SX_3_DEPENDENCES:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_dependences, _1)
			);
		case SX_3_REQURSIVE_DEPENDENCES:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_reqursive_dependences, _1)
			);
		case SX_3_REALIZATOR:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_realizator, _1)
			);
		case SX_3_GENERALIZATOR:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_generalizator, _1)
			);
		case SX_3_REQURSIVE_REALIZATOR:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_req_realizator, _1)
			);
		case SX_3_REQURSIVE_GENERALIZATOR:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_req_generalizator, _1)
			);
		case SX_3_SOURCE:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_source, _1)
			);
		case SX_3_NESTED_TOP_SUPPLIERS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_nested_top_suppliers, _1)
			);
		case SX_3_NESTED_BOTOM_CONSUMERS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_nested_botom_consumers, _1)
			);
		case SX_3_ALL_CONSUMERS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_all_consumers, _1)
			);
		case SX_3_REQURCIVE_ALL_CONSUMERS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_requrcive_all_consumers, _1)
			);
		case SX_3_GENERALIZATION:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_generalizations, _1)
			);
		case SX_3_REQURSIVE_GENERALIZATION:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_nested_generalizations, _1)
			);
		case SX_3_REALIZATION:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_realizations, _1)
			);
		case SX_3_REQURSIVE_REALIZATION:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_nested_realizations, _1)
			);
		case SX_3_GET_EXCEPTIONS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_get_exceptions, _1)
			);
		case SX_3_SET_EXCEPTIONS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_set_exceptions, _1)
			);
		case SX_3_SCOPES:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_scopes, _1, m_main_scope)
			);
		case SX_3_INCLUDES: 
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_includes, _1)
			);
		case SX_3_ALL_INCLUDES: 
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_all_includes, _1)
			);
		case SX_3_WITHOUT_NSF_INCLUDES:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_nsf_includes, _1)
			);
		case SX_3_PARENTS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_parents, _1)
			);
		case SX_3_FORWARDED:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_forwarded, _1)
			);
		case SX_3_NO_SCOPE_FORWARDED:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_nsf_forwarded, _1)
			);
		case SX_3_SEQUENCES:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_sequences, _1)
			);
		case SX_3_DIAGRAMS:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_diagrams, _1)
			);
		case SX_3_DERIVED_IMPL:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_derived_impl, _1)
			);
		case SX_3_DERIVED_OVER:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_derived_over, _1)
			);
		case SX_3_NOT_IMPLEMENTED_DERIVED_ABSTRACT:
			return new TemplatePainter::DumperByTemplateFunc (
				boost::bind (&AbstractDumperBase::get_not_implemented_derived_abstract, _1)
			);
		default:
			break;
	}

	return 0;
	//#UC END# *4B5EEC0C0068*
}

// возвращает текущую кодировку
GCL::code_t TemplatePainter::get_encoding () const {
	//#UC START# *47762F80019A*
	return m_encoding;
	//#UC END# *47762F80019A*
}

// возвращает стэк вызовов функций
GCL::StrVector* TemplatePainter::get_stack () const {
	//#UC START# *4B2F84D3034D*
	Core::Aptr<GCL::StrVector> functions_stack (new GCL::StrVector ());
	while (!AbstractDumperBase::TemplateContext::instance ()->empty ()) {
		const AbstractDumperBase::ContextData& data = AbstractDumperBase::TemplateContext::instance ()->top ();
		std::string stack_item;
		if (!data.stereotype_id/*.get ()*/.empty ()) {
			stack_item += data.stereotype_id/*.get ()*/ + "::";

			if (!data.transformator_id/*.get ()*/.empty ()) {
				stack_item += "%t";
			} else if (!data.function_id/*.get ()*/.empty ()) {
				stack_item += "%f";
			}
		} else {
			if (!data.transformator_id/*.get ()*/.empty ()) {
				stack_item += "t";
			} else if (!data.function_id/*.get ()*/.empty ()) {
				stack_item += "f";
			}
		}
		
		stack_item += (data.function_id/*.get ()*/.empty () ? data.transformator_id/*.get ()*/ : data.function_id/*.get ()*/);
		if (!data.args.empty ()) {
			stack_item += "(" + GCL::join (data.args, ",") + ")";
		} else {
			stack_item += "()";
		}

		functions_stack->push_back (stack_item);
		
		AbstractDumperBase::TemplateContext::instance ()->pop ();
	}

	return functions_stack.forget ();
	//#UC END# *4B2F84D3034D*
}

// инвалидирует внутренний кэш для элемента owner. Данный метод нужен для того чтобы сборосить
// закэшированный список, если в него вносятся изменения (при суммонинге)
void TemplatePainter::invalidate_dumpers_list (char list_tpl_command, const AbstractDumper* owner) {
	//#UC START# *4C0DEE1D0168*
	if (this->get_owner() == owner) {
		//TODO: нужно сделать проверку, что мы сейчас не находимся в цикле, если
		//находимся - нужно выбрасывать исключение о том, что нельзя менять дерево генерации
		//в процессе итерации
		PainterADData::DataMap::const_iterator it = this->m_data->m_data_map.find (list_tpl_command);
		PainterADData::DataMap::const_iterator it_end = this->m_data->m_data_map.end ();

		if (
			it != it_end
			&& m_cycle_iteration > 0
			&& this->is_valid_iterator() 
			&& !m_cycle_it.is_nil()
			&& !(*m_cycle_it).is_nil()
			&& !it->second.first.is_nil ()
			&& !it->second.first->empty ()
			&& *m_cycle_it == it->second.second
		) {
			throw std::logic_error ("Нельзя менять список, по которому осуществляется итерирование!");
		}

		m_data->m_data_map.erase (list_tpl_command);
	}

	if (m_parent) {
		//нужно сбросить кэш и на родителе
		(const_cast<TemplatePainter*> (m_parent))->invalidate_dumpers_list (list_tpl_command, owner);
	}
	//#UC END# *4C0DEE1D0168*
}

// формирует список параметров для функции
void TemplatePainter::make_function_args (
	const TemplateFunctions::FunctionParams& params
	, TPArgs& args
	, DumpersHeap& destruct
) {
	//#UC START# *47E33AE100A2*
	for (GCL::StrVector::const_iterator p_it = params.begin(); p_it != params.end(); p_it++) {
		switch ((*p_it)[0]) {
			case SX_2_ARGUMENT: {				
				std::string::const_iterator it_begin = (*p_it).begin();
				std::string::const_iterator it_end = (*p_it).end();
				bool only_dump = true;
				for (; it_begin != it_end; it_begin++) {
					if (*it_begin == SX_2_ARGUMENT) {						
						it_begin++;
						if (
							(*it_begin >= 'A' && *it_begin <= 'Z') 
							|| (*it_begin >= 'a' && *it_begin <= 'z') 
							|| (*it_begin >= '0' && *it_begin <= '9')
						) {
						} else if (*it_begin == '{') {
							for (; it_begin != it_end; it_begin++) {
								if (*it_begin == '}') {
									break;
								}
							}
						} else {
							only_dump = false;
							break;
						}						
					} else {
						only_dump = false;
						break;
					}
				}				
				if (!only_dump) {
					std::string exp ((*p_it).begin (), (*p_it).end ());
					
					std::string s = TemplatePainter::resolve_exp(exp, this);					
					AbstractDumperBase* arg = new TextDumper (s.data());
					args.push_back(arg);
					destruct.push_back(arg);
				} else {
					std::string::const_iterator arg_it = (*p_it).begin(); 
					arg_it++; 
					const AbstractDumperBase* arg = get_dumper_by_template (arg_it, (*p_it).end ());
					args.push_back(arg);

					if (arg) {
						arg->addref ();
						destruct.push_back (const_cast<AbstractDumperBase*> (arg));
					}
				}				
				break; 								
			} 
			case SX_3_SEPARATOR_BEGIN: {
				std::string exp ((*p_it).begin () + 1, (*p_it).end ());

				std::string s = TemplatePainter::resolve_exp(exp, this);
				s.resize(s.size()-1);
				AbstractDumperBase* arg = new TextDumper (s.data());
				args.push_back(arg);
				destruct.push_back(arg);
				break;
			}
		}
	}
	//#UC END# *47E33AE100A2*
}

// формирует список параметров для трансформатора
void TemplatePainter::make_transf_args (
	const TemplateFunctions::FunctionParams& params
	, TPArgs& args
	, DumpersHeap& destruct
) {
	//#UC START# *47E33B2A0296*
	GCL::StrVector::const_iterator p_it = params.begin();
	GCL::StrVector::const_iterator p_it_end = params.end();
	for (; p_it != p_it_end; ++p_it) {
		switch ((*p_it)[0]) {
			case SX_2_ARGUMENT: {
				std::string::const_iterator arg_it  = (*p_it).begin();
				arg_it++;
				const AbstractDumperBase* arg = this->get_dumper_by_template (arg_it, (*p_it).end ());
				if (arg) {
					args.push_back(arg);
					arg->addref ();
					destruct.push_back (const_cast<AbstractDumperBase*> (arg));
				}
				break;
			} 
			case SX_3_SEPARATOR_BEGIN: {
				std::string s = TemplatePainter::resolve_exp(std::string ((*p_it).begin()+1, (*p_it).end()-1), this);
				AbstractDumperBase* arg = new TextDumper (s.data());
				args.push_back(arg);
				destruct.push_back(arg);
				break;
			}
		}
	}
	//#UC END# *47E33B2A0296*
}

// выводит в поток результат разбора шаблона, шаблон задан итераторами it и it_end
bool TemplatePainter::paint (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
) {
	//#UC START# *477621D7026F*
	return execute_paint (it, it_end, false, false);
	//#UC END# *477621D7026F*
}

// выводит результат разбора цикла
bool TemplatePainter::paint_cycle (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
) {
	//#UC START# *4776226C0113*
	class local {
	public:
		//поиск аргумент цикла - ищем первую команду получения дампера
		static const std::string search_cycle_item (const std::string& src) {
			std::string::const_iterator it = src.begin ();
			std::string::const_iterator it_end = src.end ();

			int subcycle_count = 0; //счетчик вложенных циклов - не ищем аргумент во вложенны циклах
			for (; it != it_end; ++it) {
				switch (*it) {
					case SX_2_ARGUMENT: {
							if (subcycle_count == 0) {
								if (++it != it_end) {
									switch (*it) {
										case SX_3_TRANSFORMATOR:
										case SX_3_FUNCTION:
										case SX_3_USER_CODE:
										case '{':
											break;
										default:
											return std::string (it, it + 1);
									}
								} else {
									throw AbstractDumperBase::TemplateResolveException ("TemplateSyntaxError");
								}
							}
						}
						break;
					case SX_2_CYCLE_OPEN:
						subcycle_count++;
						break;
					case SX_2_CYCLE_CLOSE:
						subcycle_count--;
						break;
					case '\\':
						it++;
						break;
				}
			}

			return std::string ();
		}
	};
	(*m_cycle_it).reset();

	std::string cycle_str;
	std::string separator;
	std::string condition;
	std::string params_ex;
	std::string cycle_item;
	m_sorting_type = 0;

	unsigned shift_begin = 0;
	unsigned shift_end = 0;
	bool cycle_count_dump = false;
	bool spec_while_cycle = false;
	bool skip_duplicate = false;
	AbstractDumperBase::CodeTemplate::const_iterator saved_begin = it;
	AbstractDumperBase::CodeTemplate::const_iterator start_cycle_it = it;
	AbstractDumperBase::CodeTemplate::const_iterator end_cycle_it = it_end;
	{
		GCL::StrVector params = GCL::extract_fragments (it, it_end, SX_2_IFCYCLE_PARAMS_OPEN, SX_2_IFCYCLE_PARAMS_CLOSE, '\\');
		it--;
		cycle_str = GCL::part (it, it_end, SX_2_CYCLE_CLOSE, SX_2_SYMBOL, SX_2_CYCLE_OPEN);
		end_cycle_it = it;
		if (it == it_end) {
			char mess[128];
			ACE_OS::snprintf (mess, 128, "Unclosed cycle (started from: \"%.20s...\")\n", saved_begin);
			throw TemplateBadSyntax (mess);
		}
	
		if (params.size() > 2) params_ex = params[2];
		if (params.size() > 1) condition = params[1];
		
		std::string::iterator params_it;
		for (params_it = params_ex.begin(); params_it != params_ex.end(); params_it++) {
			switch (*params_it) {
				case SX_3_CYCLE_COUNT_DUMP:
					cycle_count_dump = true;
					break;
				case SX_3_REVERSE_CYCLE:
					m_is_reversed_cycle = true;
					break;
				case SX_3_SHIFT_BEGIN:
					shift_begin++;
					break;
				case SX_3_SHIFT_END:
					shift_end++;
					break;
				case SX_2_ARGUMENT:
					params_it++;
					cycle_item.assign (params_it, params_it + 1);
					break;
				case SX_3_SORTING_TYPE:
					params_it++;
					m_sorting_type = params_it[0];
					*m_sort_processed = false;
					break;
				case SX_3_WHILE_CYCLE:
					//специальный цикл, который выполняется до тех пор пока истинно условие цикла
					spec_while_cycle = true;
					break;
				case SX_3_SKIP_DUPLICATE:
					skip_duplicate = true;
					break;
			}
		}

		if (!spec_while_cycle && cycle_item.empty () && !cycle_str.empty () && condition.empty ()) {
			//нужно определить список по которому итерируемся, для это пытаемся найти в теле цикла или в условии
			try {
				cycle_item = local::search_cycle_item (cycle_str);
			} catch (AbstractDumperBase::TemplateResolveException&) {
				throw TemplateBadSyntax ("Ошибка при определении параметра цикла: " + std::string (start_cycle_it, end_cycle_it));
			}

		}

		if (!cycle_item.empty ()) {
			AbstractDumperBase::CodeTemplate::const_iterator ci_it = cycle_item.begin();
			// setup iterator
			const AbstractDumperBase* dumper = this->get_dumper_by_template (ci_it, cycle_item.end ());
			if (dumper == 0) {
				//если не нашли элемент - значит цикл пустой
				if (cycle_count_dump) {
					char buf[128];
					cycle_str = itoa (0, buf, 10);
					AbstractDumperBase::CodeTemplate::const_iterator cs_it = cycle_str.begin();
					execute_paint (cs_it, cycle_str.end(), false, true);		
					return true;
				} else {
					return false;
				}
			}
		} else if (!spec_while_cycle && condition.empty ()) {
			//не понятно по кому итерироваться
			std::string mess ("Не удалось определить аргумент цикла. Пожалуйста проверьте шаблон: ");
			mess += std::string (start_cycle_it, end_cycle_it);
			throw TemplateBadSyntax (mess);
		}
		
		if (params.size() > 0) {
			separator = TemplatePainter::resolve_exp(params[0], this); //implicit setup itereator
		}
	}

	bool ret_success = false;
	GCL::StrSet dumped_strs;
	if (spec_while_cycle == false) {
		std::vector<bool> success_iteration;	
		if (!condition.empty ()) {
			bool first_cycle = true;
			AbstractDumperBase::ADList::iterator local_save_cycle_it;

			try {
				do {
					bool success = TemplatePainter::resolve_cond (condition, this); //implicit setup itereator

					if (
						m_cycle_it.is_nil ()
						|| m_cycle_it.ptr ()->is_nil ()
					) {
						//итератор невалидный
						std::string mess ("Не удалось определить аргумент цикла. Пожалуйста проверьте шаблон: ");
						mess += std::string (start_cycle_it, end_cycle_it);
						throw TemplateBadSyntax (mess);
					}

					/////////
					if (this->is_empty_source ()) {
						success = false;
					}
					/////////
					success_iteration.push_back(success);
									
					if (first_cycle) {
						local_save_cycle_it = *this->dereference ();
						first_cycle = false;
					}

					// advance cycle iterator
					if (!this->dereference ()) {
						break;
					}
					
					if (this->is_valid_iterator ()) {
						this->increment_iterator ();
					}
				} while (this->is_valid_iterator ());
			} catch (TemplateCycleIterationBreak&) {
			}
			
			// restore cycle it
			this->replace_iterator (local_save_cycle_it);
		}

		for (
			std::vector<bool>::iterator it3 = success_iteration.begin()
			; it3 != success_iteration.end() && shift_begin
			; it3++
		) {
			if (*it3) {
				shift_begin--;
				*it3 = false;
			}
		}

		for (
			std::vector<bool>::reverse_iterator rit3 = success_iteration.rbegin()
			; rit3 != success_iteration.rend() && shift_end
			; rit3++
		) {
			if (*rit3) {
				shift_end--;
				*rit3 = false;
			}
		}				

		if (cycle_count_dump) {
			unsigned cycle_count = 0;
			if (!success_iteration.empty()) {
				for (
					std::vector<bool>::iterator it3 = success_iteration.begin()
					; it3 != success_iteration.end()
					; it3++
				) {
					if (*it3) {
						cycle_count++;
					}
				}
			} else {
				do {
					if (this->is_valid_iterator ()) {
						cycle_count++;
					}
					if (!this->dereference ()) {
						break;
					}
					
					if (this->is_valid_iterator ()) {
						this->increment_iterator ();
					}
				} while (this->is_valid_iterator ());
		
				if (cycle_count >= shift_begin) {
					cycle_count -= shift_begin;
				} else {
					cycle_count = 0;
				}

				if (cycle_count >= shift_end) {
					cycle_count -= shift_end;
				} else {
					cycle_count = 0;
				}

				// restore cycle it
				this->replace_iterator (*m_save_cycle_it);
			}

			char buf[128];
			cycle_str = itoa (cycle_count, buf, 10);
			AbstractDumperBase::CodeTemplate::const_iterator cs_it = cycle_str.begin();
			execute_paint (cs_it, cycle_str.end(), false, true);		
			ret_success = true;
		} else {
			bool prev_success = false;
			bool need_separator = false;
			bool prev_output = false;

			std::streampos if_pos = m_output.tellp();
			std::streampos afer_separator_pos = m_output.tellp();
			unsigned i = 0;
			m_cycle_iteration = 0;
			
			try {
				do {		
					if (success_iteration.size()) {
						if (success_iteration[i++]) {
							if_pos = m_output.tellp();
							if (need_separator) {
								m_output << separator;
							}

							//запоминаем позицию в стриме перед началом выполнения тела цикла
							afer_separator_pos = m_output.tellp();

							std::streampos temp_pos = m_output.tellp();
							AbstractDumperBase::CodeTemplate::const_iterator cs_it = cycle_str.begin();
							m_cycle_iteration++;

							if (skip_duplicate) {
								m_output.init_buffer ();
							}

							prev_success = execute_paint (cs_it, cycle_str.end(), false, true);						

							if (!this->is_valid_iterator ()) {
								// no cycle item, but sucsess by other template - reset succsess
								prev_success = false;
							}
							if (skip_duplicate) {
								std::string res = m_output.release_buffer ();
								if (prev_success && dumped_strs.insert (res).second == false) {
									//уже есть такой элемент
									prev_success = false;
								}
							}
							//success_output.push_pack (prev_success);
							if (!prev_success && m_output.tellp() <= temp_pos) {
								m_output.seekp(if_pos);
							} else {
								need_separator = true;
							}
						}
					} else {
						if (!shift_begin) {
							if_pos = m_output.tellp();
							if (need_separator) {
								m_output << separator;
							}
							
							afer_separator_pos = m_output.tellp();

							AbstractDumperBase::CodeTemplate::const_iterator cs_it = cycle_str.begin();
							m_cycle_iteration++;

							if (skip_duplicate) {
								m_output.init_buffer ();
							}

							prev_success = execute_paint (cs_it, cycle_str.end(), false, true);

							if (!this->is_valid_iterator ()) {
								// no cycle item, but sucsess by other template - reset succsess
								prev_success = false;
							}
							if (skip_duplicate) {
								std::string res = m_output.release_buffer ();
								if (prev_success && dumped_strs.insert (res).second == false) {
									//уже есть такой элемент
									prev_success = false;
								}
							}
							//success_output.push_pack (prev_success);
							if (!prev_success ) {
								m_output.seekp(if_pos);
							} else {
								need_separator = true;
							}
						} else {
							shift_begin--;
						}
					}

					ret_success |= prev_success;

					// advance cycle iterator
					if (!this->dereference ()) {
						break;
					}

					if (this->is_valid_iterator ()) {
						this->increment_iterator ();
					}
				} while (this->is_valid_iterator ());
			} catch (TemplateCycleIterationBreak&) {
				if (afer_separator_pos == m_output.tellp()) {
					m_output.seekp(if_pos);
				}
			}

			m_cycle_iteration = 0;

			if (shift_end) {
				m_output.seekp(if_pos);
			}
				
			// restore cycle it
			this->replace_iterator (*m_save_cycle_it);
		}
	} else {
		if (condition.empty ()) {
			std::string mess ("Infinite cycle (");			
			mess += std::string (saved_begin, it_end);
			mess += "), special \"while\" cycle must have condition";
			throw TemplateBadSyntax (mess);
		}
		bool prev_success = false;
		unsigned long cycle_count = 0;
		unsigned long iteration = 0;
		const unsigned long max_infinite_iteration = 100000;
		std::streampos if_pos = m_output.tellp();
		std::streampos afer_separator_pos = m_output.tellp();

		m_cycle_iteration = 0;

		try {
			while (true) {
				if (++iteration >= max_infinite_iteration) {
					std::string mess ("Возможно бесконечный цикл: ");			
					mess += std::string (saved_begin, it_end);				
					
					GenSupport::ErrorManagerFactory::get ().fatal_error (this->get_owner (), mess, GDS_CURRENT_FUNCTION);
					GenSupport::LogManagerFactory::get ().log_error (mess);
					
					break;
				}
				if_pos = m_output.tellp();
				
				bool success = TemplatePainter::resolve_cond (condition, this); //implicit setup itereator
				if (success) {
					cycle_count++;
					if (cycle_count_dump == false) {
						if (prev_success) {
							m_output << separator;
						}

						//запоминаем позицию в стриме перед началом выполнения тела цикла
						afer_separator_pos = m_output.tellp();

						AbstractDumperBase::CodeTemplate::const_iterator cs_it = cycle_str.begin();
						m_cycle_iteration++;
						
						if (skip_duplicate) {						
							m_output.init_buffer ();
						}
						prev_success = execute_paint (cs_it, cycle_str.end(), false, true); //implicit setup itereator
						
						if (skip_duplicate) {
							std::string res = m_output.release_buffer ();
							if (prev_success && dumped_strs.insert (res).second == false) {
								//уже есть такой элемент							
								prev_success = false;
							}
						}
						if (!prev_success ) {
							m_output.seekp(if_pos);
						}
					}
				} else {
					break;
				}
				ret_success |= prev_success;
			}
		} catch (TemplateCycleIterationBreak&) {
			if (afer_separator_pos == m_output.tellp()) {
				m_output.seekp(if_pos);
			}
		}

		m_cycle_iteration = 0;
		if (cycle_count_dump) {
			char buf[128];
			cycle_str = itoa (cycle_count, buf, 10);
			AbstractDumperBase::CodeTemplate::const_iterator cs_it = cycle_str.begin();
			execute_paint (cs_it, cycle_str.end(), false, true);		
			ret_success = true;
		}

	}

	return ret_success;
	//#UC END# *4776226C0113*
}

// выводит результат условия
bool TemplatePainter::paint_if (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
) {
	//#UC START# *477622560211*
	AbstractDumperBase::CodeTemplate::const_iterator saved_begin = it;
	GCL::StrVector params = GCL::extract_fragments (it, it_end, SX_2_IFCYCLE_PARAMS_OPEN, SX_2_IFCYCLE_PARAMS_CLOSE, '\\');
	it--;
	std::string if_str = GCL::part (it, it_end, SX_2_IF_CLOSE, SX_2_SYMBOL, SX_2_IF_OPEN);
	if (it == it_end) {
		char mess[256];
		ACE_OS::snprintf (mess, 256, "Unclosed IF statement, started from: \"%.150s...\")\n", saved_begin);
		throw TemplateBadSyntax (mess);
	}

	std::string::const_iterator if_it = if_str.begin ();
	std::string else_str;
	std::string condition;
	
	if (params.size() > 0) {
		condition = params[0];
	}
	if (params.size() > 1) {
		else_str = params[1];
	}
		
	bool success = false;
	if (condition != "") {
		if (TemplatePainter::resolve_cond (condition, this)) {
			success = true;
			execute_paint (if_it, if_str.end (), true, false);
		} else {
			std::string::const_iterator else_it = else_str.begin ();
			success = execute_paint (else_it, else_str.end (), true, false);
		}
	} else {
		std::streampos if_pos = m_output.tellp ();
		success = execute_paint (if_it, if_str.end (), true, false);
		if (!success) {
			m_output.seekp (if_pos);
			std::string::const_iterator else_it = else_str.begin ();
			success = execute_paint (else_it, else_str.end (), true, false);
		} 
	}

	return success;
	//#UC END# *477622560211*
}

// Дампит параметр шаблона, например:
// %SS - выведет стереотип текущего элемента
bool TemplatePainter::paint_parameter (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	, const AbstractDumperBase* templ_dump
) {
	//#UC START# *477C7D02025D*
	bool output_success = false;
	std::streampos pos = m_output.tellp ();
	it++;

	if (*it == SX_4_IS_EXISTS) {
		m_output << (templ_dump ? "true" : "false");
	} else if (templ_dump) {
		switch (*it) {
			case SX_2_ARGUMENT:
			case SX_2_NON_ERROR_FUNCTION:
			{
				bool need_error = (*it == SX_2_NON_ERROR_FUNCTION) ? false : true;

				it++;
								
				AbstractDumperBase::StereotypeID base_st;
				if (it != it_end && *(it) == SX_3_BASE_STEREOTYPE_ID_OPEN) {
					//функция будет вызвана для базового стереотипа
					it++;					
					std::string temp_in (it, it_end);
					std::string::size_type pos = temp_in.find_first_of (SX_3_BASE_STEREOTYPE_ID_CLOSE);
					if (pos != std::string::npos) {
						it += pos + 1;
						base_st = temp_in.substr (0, pos);
					} else {
						std::string error ("Unclosed \"");
						error += SX_3_BASE_STEREOTYPE_ID_CLOSE;
						error += "\" in:\n";
						error += temp_in;
						throw TemplateBadSyntax (error);
					}					
				}
				std::string rs;
				TemplateFunctions::FunctionParams params;			

				if (it != it_end && *it == SX_3_FUNCTION) {
					AbstractDumperBase::FunctionID f_id = this->extract_function (it, it_end, params);
					rs = this->st_method<true> (f_id, params, templ_dump, base_st, need_error, false);
				} else if (it != it_end && *it == SX_3_TRANSFORMATOR) {
					AbstractDumperBase::TransformatorID t_id = this->extract_transformator (it, it_end, params);
					TemplatePainter tp (this);
					rs = tp.st_method<false> (t_id, params, templ_dump, base_st, need_error, false);
				} else if (
					!AbstractDumperBase::TemplateContext::instance ()->top ().function_id/*.get ()*/.empty ()
				) {
					--it;
					const AbstractDumperBase::ContextData& cntx = AbstractDumperBase::TemplateContext::instance ()->top ();
					rs = this->st_method<true> (
						cntx.function_id
						, cntx.args
						, templ_dump
						, base_st
						, need_error
						, true
					);
				} else if (
					!AbstractDumperBase::TemplateContext::instance ()->top ().transformator_id/*.get ()*/.empty ()
				) {
					--it;
					TemplatePainter tp (this);
					const AbstractDumperBase::ContextData& cntx = AbstractDumperBase::TemplateContext::instance ()->top ();
					rs = tp.st_method<false> (
						cntx.transformator_id
						, cntx.args
						, templ_dump
						, base_st
						, need_error
						, true
					);
				} else {
					GDS_ASSERT_MSG (0,("Unknown stereotype function/transformator call"));
					rs = "[ERROR 34]";
				}

				m_output << rs;
				output_success |= (rs != "");

				break;
			}
			case SX_4_PERSISTENT_CREATION_ORDER:
				m_output << boost::lexical_cast<std::string> (templ_dump->elem_creation_order ());
				break;
			case SX_4_TREE_NUMBER:
				m_output << boost::lexical_cast<std::string> (templ_dump->elem_order ());
				break;
			case SX_4_IS_TOP_REG:
				m_output << (templ_dump->has_registred_parent() ? "false" : "true");
				break;
			case SX_4_IS_REG: 
				m_output << (templ_dump->am_i_registred() ? "true" : "false");
				break;
			case SX_4_IS_EXTERNAL_NATIVE: {
				bool b;
				m_output << (templ_dump->is_native (b) ? "true" : "false");
				break;
			}
			case SX_4_IS_FIXED:
				m_output << templ_dump->get_type_fixed_size_str();
				break;		
			case SX_4_NAME:					
				m_output << templ_dump->get_name_str();
				break;
			case SX_4_AUTO_COUNTER:					
				m_output << templ_dump->get_auto_counter_str();
				break;
			case SX_4_INITIAL_VALUE:
				m_output << templ_dump->get_initial_value_str();
				break;
			case SX_4_STEREOTYPE:
				m_output << templ_dump->get_stereotype_str();
				break;
			case SX_4_TARGET_STEREOTYPE:
				m_output << templ_dump->get_target_stereotype_str();
				break;
			case SX_4_MODEL_STEREOTYPE:
				m_output << templ_dump->get_model_stereotype_str();
				break;
			case SX_4_OS_GUID:
				m_output << templ_dump->get_guid_str();
				break;
			case SX_4_MODEL_UNIQUE_ID:
				m_output << templ_dump->get_model_unique_id_str();
				break;
			case SX_4_MODEL_CLASS:
				m_output << templ_dump->get_model_class_str();
				break;
			case SX_4_DOCUMENTATION:
				m_output << templ_dump->get_documentation_str();					
				break;
			case SX_4_FILE_NAME:
				m_output << templ_dump->create_file_name_str();
				break;
			case SX_4_LABLES: {
				Core::Aptr<GCL::StrSet> lbs = templ_dump->get_labels();
				if (!lbs.is_nil () && lbs->size() > 0) {
					m_output << GCL::join (*lbs, ",");
				}
				break;
			}
			case SX_4_LINK_GUID : {
				m_output << templ_dump->get_link_guid ();
				break;
			}
			case SX_4_IMAGE_FILE_NAME:
				m_output << templ_dump->get_image_file ();
				break;
			case SX_4_FILE_PATH:
				m_output << templ_dump->create_file_name();
				break;
			case SX_4_DIR_RELATIVE_PATH:
				m_output << templ_dump->create_relative_dir_name ();
				break;
			case SX_4_FILE_RELATIVE_PATH:
				m_output << templ_dump->create_relative_file_name();
				break;
			case SX_4_FILE_RELATIVE_PATH_WITH_PARENT:
				m_output << templ_dump->create_relative_file_name_with_parent();
				break;
			case SX_4_VISABILITY:
				m_output << templ_dump->get_visability_str();
				break;
			case SX_4_IS_ABSTRACT:
				m_output << templ_dump->get_abstract_str();
				break;
			case SX_4_CLASS_KIND:
				m_output << templ_dump->get_class_kind_str();
				break;				
			case SX_4_LINK_TYPE:
				m_output << templ_dump->get_link_type_str();
				break;
			case SX_4_GEN_INFO:
				m_output << templ_dump->get_generator_info_str();
				break;
			case SX_4_ST_DESC:
				m_output << templ_dump->get_st_desc_str();
				break;
			case SX_4_DUMPING:
				if (
					GenSupport::EnvironmentFactory::get ().get_enable_spell_explicit_call_logging ()
					&& AbstractDumperBase::s_current_map == AbstractDumperBase::SPELL_GENERATOR_ID
				) {
					const AbstractDumperBase* context = this->get_main_scope ();
					GDS_ASSERT((context));
					if (templ_dump->parent () != context) {
						//логируем только если новый элемент не является ребенком текущего
						//контекста генерации
						context->write_warning_log (
							std::string ("явно вызван spell-генератор на элементе: ")
							+ templ_dump->get_full_name ()
						);
					}
				}

				templ_dump->dump(m_output.m_output);
				break;
			case SX_4_OPEN_SCOPE:
				m_output << templ_dump->dump_open_scope();
				break;
			case SX_4_CLOSE_SCOPE:
				m_output << templ_dump->dump_close_scope();
				break;				
			case SX_4_FORWARD: {
				AbstractDumperBase::CodeTemplate templ = templ_dump->get_template_body ().forward_template;		
				TemplatePainter::TPArgs args;
				args.push_back (templ_dump);
				TemplatePainter tp (args, *m_output.m_output, m_main_scope, this);
				AbstractDumperBase::CodeTemplate::const_iterator fwd_it = templ.begin ();
				AbstractDumperBase::CodeTemplate::const_iterator fwd_it_end = templ.end ();
				tp.paint (fwd_it, fwd_it_end);
				break;
			}
			case SX_2_CYCLE_OPEN: {
				it++;
				TemplatePainter::TPArgs args;
				args.push_back (templ_dump);
				args.insert (args.end(), m_args.begin(), m_args.end());
				TemplatePainter tp (args, *m_output.m_output, m_main_scope, this);
				output_success |= tp.paint_cycle(it, it_end);
				break;
			}
			case SX_2_IF_OPEN: {
				it++;
				TemplatePainter::TPArgs args;
				args.push_back (templ_dump);
				args.insert (args.end(), m_args.begin(), m_args.end());
				TemplatePainter tp (args, *m_output.m_output, m_main_scope, this);
				output_success |= tp.paint_if(it, it_end);				
				break;				
			}
			case SX_2_USER_PROP_OPEN: {
				std::string up_name = GCL::part (it, it_end, SX_2_USER_PROP_CLOSE);
				if (it == it_end) {
					char mess[128];
					ACE_OS::snprintf (mess, 128, "Unclosed user propery name (started from: \"%.20s...\")\n", up_name.c_str());
					throw TemplateBadSyntax (mess);
				}
				if (up_name[0] != '!') {
					std::string prop = templ_dump->get_user_property_str(up_name);
					if (prop != "") {
						m_output << prop;
					}
				} else {
					up_name.erase (0,1);
					const AbstractDumperBase::Template& tpl = templ_dump->get_template ();
					if (tpl.user_properties_group.is_nil () == false) {
						const AbstractDumperBase::UserPropertyMap& props = tpl.user_properties_group->get_properties ();
						AbstractDumperBase::UserPropertyMap::const_iterator f 
							= props.find (up_name);
						if (f != props.end ()) {
							if (f->second.def_value != "") {
								m_output << f->second.def_value;
							}
						}
					}
				}
				break;
			}
			case SX_4_ROOT_DIR: {
				m_output << templ_dump->get_root_dir(true);				
				break;
			}
			case SX_4_CYCLE_NUM: {
				char buf[32];
				itoa(m_cycle_iteration, buf, 10);
				m_output << buf;
				break;
			}
			default: {
				char mess[128];
				ACE_OS::snprintf (mess, 128, "Invalid argument at: %.20s \n", it);
				throw TemplateBadSyntax (mess);
			}
		}
	} else {
		AbstractDumperBase::CodeTemplate::const_iterator saved_begin = it;
		switch (*it) {
			case SX_2_CYCLE_OPEN:
				GCL::part (it, it_end, SX_2_CYCLE_CLOSE, SX_2_SYMBOL, SX_2_CYCLE_OPEN);
				if (it == it_end) {
					char mess[128];
					ACE_OS::snprintf (mess, 128, "Unclosed cycle (started from: \"%.20s...\")\n", saved_begin);
					throw TemplateBadSyntax (mess);
				}
				break;
			case SX_2_IF_OPEN:
				GCL::part (it, it_end, SX_2_IF_CLOSE, SX_2_SYMBOL, SX_2_IF_OPEN);
				if (it == it_end) {
					char mess[128];
					ACE_OS::snprintf (mess, 128, "Unclosed IF-statement (started from: \"%.20s...\")\n", saved_begin);
					throw TemplateBadSyntax (mess);
				}
				break;
			case SX_2_USER_PROP_OPEN:
				GCL::part (it, it_end, SX_2_USER_PROP_CLOSE, SX_2_SYMBOL, SX_2_USER_PROP_OPEN);
				if (it == it_end) {
					char mess[128];
					ACE_OS::snprintf (mess, 128, "Unclosed user property id (started from: \"%.20s...\")\n", saved_begin);
					throw TemplateBadSyntax (mess);
				}
				break;
			case SX_2_ARGUMENT:
			case SX_2_NON_ERROR_FUNCTION:
			{				
				TemplateFunctions::FunctionParams params;
				bool need_error = (*it == SX_2_NON_ERROR_FUNCTION) ? false : true;
				bool is_func = false;

				std::string id;
				if ((it+1) != it_end && *(it+1) == SX_3_FUNCTION) {
					it++;
					id = this->extract_function (it, it_end, params);
					is_func = true;
				} else if ((it+1) != it_end && *(it+1) == SX_3_TRANSFORMATOR) {
					it++;
					id = this->extract_transformator (it, it_end, params);
				} else {
					need_error = false;
				}

				if (need_error && GenSupport::EnvironmentFactory::get ().get_scold_if_call_tpl_function_on_null ()) {
					char mess[128];
					ACE_OS::snprintf (mess, 128, "(started from: \"%.20s...\")\n", saved_begin);
					const AbstractDumperBase* context = this->get_owner ();
					
					context->write_error_log (
						std::string ("Попытка вызывать ")
						+ (is_func ? std::string ("функцию \"") : std::string ("трансформатор \""))
						+ id
						+ std::string ("\" на отсутствующем элементе ")
						+ std::string (mess)
						, true
					);
				}
				break;
			}
			break;			
		}
	}
		
	output_success |= pos != m_output.tellp();
	return output_success;
	//#UC END# *477C7D02025D*
}

// выводит результат разбора шаблона вывода пользователькой секции
bool TemplatePainter::paint_user_code (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
) {
	//#UC START# *4776228E032E*
	class UCParser {
	public:
		UCParser (const std::string& current_uc_id, const AbstractDumperBase* owner) 
			: m_current_uc_id (current_uc_id)
			, m_owner (owner)
			, m_content (0)
			, m_callback (boost::bind (&UCParser::callback, this, _1, _2, _3))
		{
		}
		
		void parse (
			const std::string& element_uid
			, const AbstractDumperBase::TemplateBody& tp 
			, std::string& content
		) {
			m_content = &content;

			UserCodeExtractor uc_extractor;
			uc_extractor.process (std::string (content), tp, element_uid, m_callback);
		}

		void callback (
			const std::string& uc_id
			, const AbstractDumperBase::UserCode& uc_content
			, const std::string& gen_id
		) {
			//TODO: по-хорошему нужно тут делать paint_user_code
			
			//обрабатываем ситуацию, когда по ключу m_current_uc_id находится другая юзер-секция
			//например:
			// //UC_BEGIN *ID1*
			// //UC_BEGIN *ID2*
			// //UC_END *ID2*
			// //UC_END *ID1*
			
			AbstractDumperBase::UserCode_map& user_codes_for_gen = AbstractDumperBase::s_user_code[gen_id];
			AbstractDumperBase::UserCode_map::iterator it = user_codes_for_gen.find (uc_id);
			
			if (it != user_codes_for_gen.end () && !(it->second.uc.empty () && !it->second.is_loaded)) {
				//если нашли содержимое юзер-секции и оно не пустое или из файла - заменяем
				it->second.used = true;
				GCL::str_replace (*m_content, uc_content.c_str (), it->second.uc.c_str ());
			} else {
				//если не нашли содержимое для юзер-секции - нужно залезть в модель
				std::string from_model = m_owner->get_user_code (gen_id, uc_id);
				if (!from_model.empty ()) {
					GCL::str_replace (*m_content, uc_content.c_str (), from_model.c_str ());
				}
			}
		}
	private:
		std::string m_current_uc_id;
		std::string* m_content;
		UserCodeExtractor::Callback m_callback;
		const AbstractDumperBase* m_owner;
	};
	bool res;
	
	GCL::StrVector params = GCL::extract_fragments (it, it_end, SX_2_IFCYCLE_PARAMS_OPEN, SX_2_IFCYCLE_PARAMS_CLOSE, '\\');
	it--;
	std::string uc_str = GCL::part(it, it_end, ']', '\\', '[');	
	if (it == it_end) {
		char mess[256];
		ACE_OS::snprintf (mess, 256, "Unclosed user code section (started from: \"%.20s...\")\n", uc_str.c_str());
		throw TemplateBadSyntax (mess);
	}
	
	std::string current_map = AbstractDumperBase::s_current_map;
	std::string uc_sufix;	
	if (params.size() > 0) {
		uc_sufix = TemplatePainter::resolve_exp(params[0], this);
		
		GCL::StrVector gen_ids = GCL::split_string_by_fragment (uc_sufix.data(), '!', '!');
		if (gen_ids.size() == 1) {
			// need to check id for existance			
			current_map = gen_ids[0];
			std::string to_remove = "!";
			to_remove += gen_ids[0] + "!";
			GCL::str_replace (uc_sufix, to_remove.data(), "");
		}
	}
	
	AbstractDumperBase::UserCode user_code;
	std::string pre_uc_content;
	std::string post_uc_content;

	std::string uc_id_templ = "*%SU"+ uc_sufix +"*";
	AbstractDumperBase::UserCodeId uc_id = resolve_exp (uc_id_templ, this);

	if (!GenSupport::EnvironmentFactory::get ().get_rewrite_user_code ()) {
		AbstractDumperBase::UserCode_map& user_codes_for_gen = AbstractDumperBase::s_user_code[current_map];
		AbstractDumperBase::UserCode_map::iterator uc_it = user_codes_for_gen.find (uc_id);
		if (uc_it != user_codes_for_gen.end()) {
			AbstractDumperBase::UserCodeData& uc_data = uc_it->second;
			user_code = uc_data.uc;

			if (uc_data.uc.empty () && !uc_data.is_loaded) {
				//если юзерсекция не из файла и пустая - пытаемся получить содержимое секции из модели
				user_code = m_owner->get_user_code (current_map, uc_id);
			}

			pre_uc_content = uc_data.pre_uc_content;
			post_uc_content = uc_data.post_uc_content;

			AbstractDumperBase::s_user_code [current_map][uc_id].used = true;
		} else {
			user_code = m_owner->get_user_code (current_map, uc_id);
			if (!user_code.empty ()) {
				//в модели есть содержимое юзер-секции - надо положить в мапу и выставить флаг used
				AbstractDumperBase::UserCodeData& uc_data = AbstractDumperBase::s_user_code [current_map][uc_id];
				uc_data.uc = user_code;
				uc_data.used = true;
			}
		}
	}

	std::string element_uid = m_owner->get_model_unique_id_str ();
	
	UCParser uc_parser (uc_id, m_owner);
	
	const AbstractDumperBase::TemplateBody& tp = m_owner->get_template_body ();
	if (!pre_uc_content.empty ()) {
		uc_parser.parse (element_uid, tp, pre_uc_content);
		m_output << pre_uc_content;
	}
	
	if (!user_code.empty ()) {
		uc_parser.parse (element_uid, tp, user_code);
		m_output << user_code;
		
		res = true;
	} else {
		std::string uc_content = TemplatePainter::resolve_exp (uc_str, this);
		res = !uc_content.empty ();
		m_output << TemplatePainter::make_uc (uc_id, uc_content, tp);
	}
	if (current_map != AbstractDumperBase::s_current_map) {
		m_output << "*";
		m_output << current_map;
		m_output << "*";
	}

	if (!post_uc_content.empty ()) {
		uc_parser.parse (element_uid, tp, post_uc_content);
		m_output << post_uc_content;
	}

	return res;
	//#UC END# *4776228E032E*
}

// вычисляет результат шаблона функции
const std::string TemplatePainter::resolve_method (
	const AbstractDumperBase::Function& function
	, const TemplateFunctions::FunctionParams& params
	, const AbstractDumperBase* context
) {
	//#UC START# *477628D4032D*
	if (
		params.size () >= 3
		&& (
			function.id == "_override_opfunction"
			|| function.id == "_override_attrfunction"
			|| function.id == "_override_set_attrfunction"
			|| function.id == "_override_get_attrfunction"
		)
	) {
		TemplatePainter::DelayedFunctionParams_box func_params (
			new TemplatePainter::DelayedFunctionParams (this->get_owner (), params, this)
		);

		GDS_ASSERT(func_params->get_painter ());
		func_params->set_context (context);

		AbstractDumper::UCModificationfunction_var func (
			new AbstractDumper::UCModificationFunction (
				boost::bind (
					static_cast<void (TemplatePainter::*) (const AbstractDumperBase::Function&, DelayedFunctionParams_box&)> (
						&TemplatePainter::resolve_method
					)
					, func_params->get_painter ()
					, function
					, func_params
				)
			)
		);

		AbstractDumper::add_uc_modification_function (func);
	} else {
		DumpersHeap destruct;
		TPArgs args;
		if (context) {
			args.push_back (context);
			context->addref ();
			destruct.push_back (const_cast<AbstractDumperBase*> (context));
		}

		this->make_function_args (params, args, destruct);
		return this->resolve_method (function, args, context);
	}

	return std::string ();
	//#UC END# *477628D4032D*
}

// вычисляет результат шаблона трансформатора
const std::string TemplatePainter::resolve_method (
	const AbstractDumperBase::Transformator& transformator
	, const TemplateFunctions::FunctionParams& params
	, const AbstractDumperBase* context
) {
	//#UC START# *4776293000F5*
	TPArgs args;	
	DumpersHeap destruct;
	if (context) {
		args.push_back (context);
		context->addref ();
		destruct.push_back (const_cast<AbstractDumperBase*> (context));
	}

	this->make_transf_args (params, args, destruct);

	return this->resolve_method (transformator, args, context);
	//#UC END# *4776293000F5*
}

// вычисляет результат работы функции
const std::string TemplatePainter::resolve_method (
	const AbstractDumperBase::Function& function
	, const TPArgs& args
	, const AbstractDumperBase* context
) {
	//#UC START# *4B2B04E4021C*
	std::string cache_key;
	if (
		function.key_tpl.empty () == false
		&& args.empty () == false
		&& args[0]
	) {
		cache_key = TemplatePainter::resolve_exp (function.key_tpl, args, m_main_scope, this);
	}
	std::string res;
	if (
		cache_key.empty () == false
		&& args.empty () == false
		&& args[0]
	) {
		cache_key += function.id;
		ResolveCache::iterator it = s_resolve_cache.find (cache_key);
		if (it == s_resolve_cache.end ()) {
			it = s_resolve_cache.insert (
				ResolveCache::value_type (
					cache_key
					, TemplatePainter::resolve_exp(function.function_tpl, args, m_main_scope, this)
				)
			).first;
		}
		res = it->second;
	} else {
		if (args.size() && args[0]) {
			res = TemplatePainter::resolve_exp(function.function_tpl, args, m_main_scope, this);
		}
	}
	return res;
	//#UC END# *4B2B04E4021C*
}

// вычисляет результат работы трансформатора
const std::string TemplatePainter::resolve_method (
	const AbstractDumperBase::Transformator& transformator
	, const TPArgs& args
	, const AbstractDumperBase* context
) {
	//#UC START# *4B2B05290322*
	class local {
	public:
		static std::string impl (
			TemplatePainter* this_
			, const AbstractDumperBase::Transformator& transformator
			, const TPArgs& args
			, const AbstractDumperBase* context
		) {
			std::string first_arg_str;
			if (args.size() > 1) {
				first_arg_str = args[1]->get_name_str ();
			}

			bool we_find_row = false;
			AbstractDumperBase::TransformatorBodyList::const_iterator finded_row = transformator.rows.end();
			for (
				AbstractDumperBase::TransformatorBodyList::const_iterator tbl_it = transformator.rows.begin()
				; tbl_it != transformator.rows.end() && finded_row == transformator.rows.end()
				; tbl_it++
			) {	
				if (TemplatePainter::resolve_cond((*tbl_it).row_exp, args, context ? context : this_->m_main_scope, this_)) {
					finded_row = tbl_it;
				}
			}

			if (finded_row != transformator.rows.end()) {		
				AbstractDumperBase::TransformatorRow::const_iterator f = (*finded_row).row.find(first_arg_str);
				if (f == (*finded_row).row.end()) {
					f = (*finded_row).row.find("");
				}

				if (f != (*finded_row).row.end()) {
					AbstractDumperBase::TransformatorTemplate templ = (*f).second;
					return TemplatePainter::resolve_exp(templ, args, context ? context : this_->m_main_scope, this_);
				}
			}

			return std::string ("");
		}
	};

	std::string cache_key;
	if (
		transformator.key_tpl.empty () == false
	) {
		cache_key = TemplatePainter::resolve_exp (transformator.key_tpl, args, context ? context : m_main_scope, this);
	}
	std::string res;
	if (
		cache_key.empty () == false
		&& args.empty () == false
		&& args[0]
	) {
		cache_key += transformator.id;
		ResolveCache::iterator it = s_resolve_cache.find (cache_key);
		if (it == s_resolve_cache.end ()) {
			it = s_resolve_cache.insert (
				ResolveCache::value_type (
					cache_key
					, local::impl (this, transformator, args, context)
				)
			).first;
		}
		res = it->second;
	} else {
		res = local::impl (this, transformator, args, context);
	}
	
	return res;
	//#UC END# *4B2B05290322*
}

// выполнение функции с отложенными параметрами
void TemplatePainter::resolve_method (
	const AbstractDumperBase::Function& function
	, DelayedFunctionParams_box& params
) {
	//#UC START# *4B62D02C0025*
	TemplatePainter::set_var_dumpers (params->get_var_dumpers ());

	DumpersHeap destruct;
	TPArgs args;
	const AbstractDumperBase* context = params->get_context ();
	if (context) {
		args.push_back (context);
		context->addref ();
		destruct.push_back (const_cast<AbstractDumperBase*> (context));
	}

	params->get_painter ()->make_function_args (params->get_params (), args, destruct);
	params->get_painter ()->resolve_method (function, args, context);
	//#UC END# *4B62D02C0025*
}

// возвращает идентификатор запрошенное переменной it должен указывать на строчку, удовлетворяющую
// рег.выражению: "^{[^{]*}.*"
const std::string TemplatePainter::resolve_var_id (
	AbstractDumperBase::CodeTemplate::const_iterator& it
	, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
) {
	//#UC START# *4B211A8D0384*
	std::string var_id = GCL::part(it, it_end, '}', 0, '{');
	if (it == it_end) {
		std::string mess ("Unclosed VAR id (started from: \"");
		mess += var_id.substr (0, 20);
		mess += "...\")";
		
		throw TemplateBadSyntax (mess);
	}
	var_id = TemplatePainter::resolve_exp (var_id, this);

	return var_id;
	//#UC END# *4B211A8D0384*
}

// устанавливает кодировку
void TemplatePainter::set_encoding (GCL::code_t encoding) {
	//#UC START# *47762F500273*
	m_encoding = encoding;
	//#UC END# *47762F500273*
}

// устанавливает поток, в который будет происходить запись
void TemplatePainter::set_output (std::ostream& out) {
	//#UC START# *477C91DA00F5*
	set_encoding (AbstractDumperBase::s_default_encoding);
	m_output.set_output (out);
	//#UC END# *477C91DA00F5*
}

// устанавливает итератор цикла
const AbstractDumperBase* TemplatePainter::setup_iterator (
	AbstractDumperBase::ADListIt_box& it_begin
	, AbstractDumperBase::ADList::iterator& it_end
) {
	//#UC START# *477C96F102BC*
	if (!(*m_cycle_it)) {	//empty link to cycle it
		m_save_cycle_it.replace (*it_begin);
		if (m_is_reversed_cycle) {
			m_cycle_end.replace (*it_begin); //empty link to cycle end, copy link list it (begin)
			//(*m_cycle_end)--; //move to top of begin

			it_begin.replace (it_end); // link list it (begin) capture NEW it (end)
			(*it_begin)--; // move to top of end (last el)
		} else {
			m_cycle_end.replace (it_end); //empty link to cycle end, copy NEW it (end)
		}

		m_rend_iterator = it_end;
		//(*m_rend_iterator).replace (it_end);

		*m_cycle_it = it_begin; // empty link to cycle it, capture link
		//m_save_cycle_it = **m_cycle_it;
	}
	return it_begin == it_end ? NULL : **it_begin;
	//#UC END# *477C96F102BC*
}

// сортирует список
bool TemplatePainter::sort (AbstractDumperBase::ADList_box& list) {
	//#UC START# *477C97390371*
	if (*m_sort_processed == false) {
		*m_sort_processed = true;
		switch (m_sorting_type) {
		case SX_4_ST_BY_NAME:
			list->sort (AbstractDumperBase::SortByName());
			break;
		case SX_4_ST_BY_GUID:
			list->sort (AbstractDumperBase::SortByUID());
			break;
		case SX_4_ST_BY_PARENT_AND_NAME:
			list->sort (AbstractDumperBase::SortByParentAndName());
			break;
		case SX_4_ST_BY_POSITION:
			if (list->empty () == false) {
				std::vector<AbstractDumperBase::ADList::value_type> ad_vector (list->begin (), list->end ());
				GCL::uqsort (
					&ad_vector[0]
					, ad_vector.size ()
					, sizeof (ad_vector[0])
					, odp_compare_adapter
				);
				list->assign (ad_vector.begin (), ad_vector.end ());
			}
			break;
		case SX_4_ST_BY_ORDER:
			if (list->empty () == false) {
				std::vector<AbstractDumperBase::ADList::value_type> ad_vector (list->begin (), list->end ());
				GCL::uqsort (
					&ad_vector[0]
					, ad_vector.size ()
					, sizeof (ad_vector[0])
					, compare_by_order
				);
				list->assign (ad_vector.begin (), ad_vector.end ());
			}
			break;
		case SX_4_ST_BY_CREATION_ORDER:
			if (list->empty () == false) {
				std::vector<AbstractDumperBase::ADList::value_type> ad_vector (list->begin (), list->end ());
				GCL::uqsort (
					&ad_vector[0]
					, ad_vector.size ()
					, sizeof (ad_vector[0])
					, compare_by_creation_order
				);
				list->assign (ad_vector.begin (), ad_vector.end ());
			}
			break;
		default:
			return false;
		}
		return true;
	} else {
		return false;
	}
	//#UC END# *477C97390371*
}

// вычисляет значение трансформатора, заданного идентификатором id, params - список параметров для
// трансформатора
const std::string TemplatePainter::transform (
	const AbstractDumperBase::TransformatorID& id
	, const TemplateFunctions::FunctionParams& params
) {
	//#UC START# *4776102C03B2*
	class local {
	public:
		static std::string resolve_transform (
			TemplatePainter* this_
			, const AbstractDumperBase::TransformatorID& id
			, const TPArgs& args
		) {
			GDS_ASSERT(this_);			

			std::string first_arg_str;
			if (args.size() > 1) {
				first_arg_str = args[1]->get_name_str ();
			}

			bool we_find_row = false;
			AbstractDumperBase::TransformatorBodyList::iterator finded_row 
				= AbstractDumperBase::s_transformators[id].rows.end();
			for (
				AbstractDumperBase::TransformatorBodyList::iterator tbl_it 
					= AbstractDumperBase::s_transformators[id].rows.begin()
				; tbl_it != AbstractDumperBase::s_transformators[id].rows.end() 
					&& finded_row == AbstractDumperBase::s_transformators[id].rows.end()
				; tbl_it++
			) {	
				if (TemplatePainter::resolve_cond((*tbl_it).row_exp, args, this_->m_main_scope, this_)) {
					finded_row = tbl_it;
				}
			}

			if (finded_row != AbstractDumperBase::s_transformators[id].rows.end()) {		
				AbstractDumperBase::TransformatorRow::iterator f = (*finded_row).row.find(first_arg_str);
				if (f == (*finded_row).row.end()) {
					f = (*finded_row).row.find("");
				}

				if (f != (*finded_row).row.end()) {
					AbstractDumperBase::TransformatorTemplate templ = (*f).second;			
					return TemplatePainter::resolve_exp (templ, args, this_->m_main_scope, this_);
				}
			}

			return std::string ("");
		}
	};
#if !defined(GDS_NLOG_DEBUG) || defined(TIME_PROFILING_ENABLED)
	std::string mess ("Transformator: ");
	mess += id;
	Core::GDS::StopWatchEx sw (mess.c_str ());
#endif

	AbstractDumperBase::Transformators::iterator f = AbstractDumperBase::s_transformators.find(id);

	if (f == AbstractDumperBase::s_transformators.end()) {
		std::string mess ("use undefined transformator \"");
		mess += id;
		mess += "\"";
		
		throw TemplateBadSyntax (mess);
	}
	
	AbstractDumperBase::TemplateContext::instance ()->push (
		AbstractDumperBase::ContextData (
			AbstractDumperBase::StereotypeID ("")
			, AbstractDumperBase::FunctionID ("")
			, id
			, params
		)
	);

	TPArgs args;
	DumpersHeap destruct;
	this->make_transf_args (params, args, destruct);

	std::string cache_key;
	if (f->second.key_tpl.empty () == false) {
		cache_key = TemplatePainter::resolve_exp (f->second.key_tpl, args, this->m_main_scope, this);
	}
	std::string res;
	if (cache_key.empty () == false) {
		cache_key += f->second.id;
		ResolveCache::iterator it = s_resolve_cache.find (cache_key);
		if (it == s_resolve_cache.end ()) {
			it = s_resolve_cache.insert (
				ResolveCache::value_type (
					cache_key
					, local::resolve_transform (this, id, args)
				)
			).first;
		}
		res = it->second;
	} else {
		res = local::resolve_transform (this, id, args);
	}

	return pop_context_wrapper (res);
	//#UC END# *4776102C03B2*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const TemplatePainter::TPArgs& TemplatePainter::get_args () const {
	//#UC START# *477C7D92003F_GET_ACCESSOR*
	return m_args;
	//#UC END# *477C7D92003F_GET_ACCESSOR*
}

void TemplatePainter::set_args (const TPArgs& args) {
	//#UC START# *477C7D92003F_SET_ACCESSOR*
	m_args = args;
	//#UC END# *477C7D92003F_SET_ACCESSOR*
}

const AbstractDumperBase* TemplatePainter::get_main_scope () const {
	//#UC START# *477C8958039D_GET_ACCESSOR*
	return m_main_scope;
	//#UC END# *477C8958039D_GET_ACCESSOR*
}

const AbstractDumperBase* TemplatePainter::get_owner () const {
	//#UC START# *477C893B02E1_GET_ACCESSOR*
	return m_owner;
	//#UC END# *477C893B02E1_GET_ACCESSOR*
}

//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors

const AbstractDumperBase::VarDumpers& TemplatePainter::get_var_dumpers () {
	//#UC START# *477CAD8F00B5_GET_ACCESSOR*
	return VarDumpersSingleton::instance ()->ptr;
	//#UC END# *477CAD8F00B5_GET_ACCESSOR*
}
void TemplatePainter::set_var_dumpers (const AbstractDumperBase::VarDumpers& var_dumpers) {
	//#UC START# *477CAD8F00B5_SET_ACCESSOR*
	VarDumpersSingleton::instance ()->ptr = var_dumpers;
	//#UC END# *477CAD8F00B5_SET_ACCESSOR*
}

//////////////////////////////////////////////////////////////////////////////////////////
// template methods implementation

// Вычисление результата шаблона функции или трансформатора (в зависимости от параметра
// IsFunction), определенного на стереотипе.  Если  такой функции (или трансформатора) не
// определено бросается исключение.
template <bool IsFunction, class ID>
const std::string TemplatePainter::st_method (
	const ID& id
	, const TemplateFunctions::FunctionParams& params
	, const AbstractDumperBase* context
	, const AbstractDumperBase::StereotypeID& base_stereotype
	, bool need_error
	, bool use_self_args
) {
	//#UC START# *4951EEB400B2_477606D700B4*
	//тип метода: функция, стереотип
	std::string method_type (IsFunction ? "function" : "transformator");

#if !defined(GDS_NLOG_DEBUG) || defined(TIME_PROFILING_ENABLED)
	std::string mess ("Stereotype");
	mess += method_type;
	mess += ": ";
	mess += id;
	Core::GDS::StopWatchEx sw (mess.c_str ());
#endif

	//нужно определить реальный контекст вызова (из какого стереотипа вызывается функция)
	//например, если вызов был как %S%[inherited] - нужно взять стереотип с вершины стэка
	AbstractDumperBase::StereotypeID real_context_model_stereotype 
		= (base_stereotype == s_inherited_flag || !base_stereotype/*.get ()*/.empty ()) && !AbstractDumperBase::TemplateContext::instance ()->empty () 			
			? AbstractDumperBase::TemplateContext::instance ()->top ().stereotype_id
			: AbstractDumperBase::EMPTY_STEREOTYPE_ID;
	
	if (real_context_model_stereotype/*.get ()*/.empty ()) {
		real_context_model_stereotype = context->get_model_stereotype_str ();
	}
	
	AbstractDumperBase::TemplateContext::instance ()->push (
		AbstractDumperBase::ContextData (
			real_context_model_stereotype
			, IsFunction ? AbstractDumperBase::FunctionID (id) : AbstractDumperBase::EMPTY_FUNCTION_ID
			, IsFunction ? AbstractDumperBase::EMPTY_TRANSFORMATOR_ID : AbstractDumperBase::TransformatorID (id)
			, params
		)
	);

	
	bool finded = false;	
	
	const AbstractDumperBase::Template& context_tpl = AbstractDumperBase::get_template (real_context_model_stereotype);
	bool from_base = base_stereotype/*.get ()*/.empty () == false && base_stereotype != real_context_model_stereotype;
	AbstractDumperBase::StereotypeID main_base_stereotype = context_tpl.main_base_stereotype;

	typedef Finder<IsFunction> StFinder;
	StFinder::OuputIterator f;

	if (from_base == false) {
		finded = StFinder::find_in (id, context_tpl, f);
		from_base = !finded;
	}
	if (from_base) {		
		if (base_stereotype/*.get ()*/.empty () || base_stereotype == s_inherited_flag) {
			//ищем среди базовых классов функцию
			StFinder::FindedMap finded_map;
			AbstractDumperBase::StereotypeIDVector main_base_stereotypes;
			main_base_stereotypes.push_back (main_base_stereotype);

			StFinder::find (id, context_tpl, finded_map, main_base_stereotypes);			
			size_t finded_count = finded_map.size (); //количество базовых сереотипов, которые содержать функцию f_id					
			if (finded_count > 1) {
				StFinder::FindedMap::const_iterator base_f_it = finded_map.end ();				
				
				if (base_stereotype == s_inherited_flag) {
					//пытаемся найти среди списка найденных стереотипов стереотип с именем
					//"_b_" + real_context_model_stereotype
					//или "_b_" + "_b_" +  real_context_model_stereotype
					//или "_b_" + "_b_" + "_b_" + real_context_model_stereotype
					//и т.д, при этом выбирается ближайший родитель, ближайший родитель - это родитель
					//с минимальным количеством перфиксов
					std::string finded_base_st = AbstractDumperBase::s_redefinition_postfix + real_context_model_stereotype/*.get ()*/;
					StFinder::FindedMap::value_type finded_base;
					size_t min_len = finded_base_st.size ();

					for (
						StFinder::FindedMap::const_iterator it = finded_map.begin ()
						; it != finded_map.end ()
						; ++it
					) {
						if (
							it->first/*.get ()*/.find (finded_base_st) != std::string::npos
							&& (it->first/*.get ()*/.size () <= min_len || base_f_it == finded_map.end ())
						) {
							base_f_it = it;
							min_len = it->first/*.get ()*/.size ();
						}
					}
				}
				for (
					AbstractDumperBase::StereotypeIDVector::const_iterator it = main_base_stereotypes.begin ()
					; it != main_base_stereotypes.end () && base_f_it == finded_map.end ()
					; ++it
				) {
					base_f_it = finded_map.find (*it);
				}

				if (base_f_it != finded_map.end ()) {
					finded = true;
					f = base_f_it->second;
					AbstractDumperBase::TemplateContext::instance ()->rewrite_top (
						base_f_it->first
						, IsFunction ? AbstractDumperBase::FunctionID (id) : AbstractDumperBase::EMPTY_FUNCTION_ID
						, IsFunction ? AbstractDumperBase::EMPTY_TRANSFORMATOR_ID : AbstractDumperBase::TransformatorID (id)
					);
				} else {
					//нашли больше одного стереотипа				
					std::string mess ("(");
					mess += real_context_model_stereotype;
					mess += ")Error while dump inherited ";
					mess += method_type;
					mess += "\"";				
					mess += id;
					mess += "\", because more than one base stereotype contain it, please secify base stereotype";
					
					GenSupport::ErrorManagerFactory::get ().fatal_error (this->get_owner (), mess, GDS_CURRENT_FUNCTION);
					GenSupport::LogManagerFactory::get ().log_error (mess);
					
					//берем первую попавшуюся функцию
					finded_count = 1;
					finded = true;

					f = finded_map.begin ()->second;
					AbstractDumperBase::TemplateContext::instance ()->rewrite_top (
						finded_map.begin ()->first
						, IsFunction ? AbstractDumperBase::FunctionID (id) : AbstractDumperBase::EMPTY_FUNCTION_ID
						, IsFunction ? AbstractDumperBase::EMPTY_TRANSFORMATOR_ID : AbstractDumperBase::TransformatorID (id)
					);
				}
			} else if (finded_count == 1) {
				finded = true;
				f = finded_map.begin ()->second;
				AbstractDumperBase::TemplateContext::instance ()->rewrite_top (
					finded_map.begin ()->first
					, IsFunction ? AbstractDumperBase::FunctionID (id) : AbstractDumperBase::EMPTY_FUNCTION_ID
					, IsFunction ? AbstractDumperBase::EMPTY_TRANSFORMATOR_ID : AbstractDumperBase::TransformatorID (id)
				);
			} else if (base_stereotype == s_inherited_flag) {
				//ничего не нашли
				std::string mess ("(");
				mess += real_context_model_stereotype;
				mess += ")Error while dump inherited ";
				mess += method_type;
				mess += "\"";
				mess += id;
				mess += "\", because none base stereotype contain it";

				throw TemplateBadSyntax (mess);
			}
		} else {
			AbstractDumperBase::TemplateContext::instance ()->rewrite_top (
				base_stereotype
				, AbstractDumperBase::FunctionID (id)
				, AbstractDumperBase::EMPTY_TRANSFORMATOR_ID
			);

			//проверяем наследуется элемент от base_stereotype:
			//: A::Class //real_context_model_stereotype
			//= B::Class //base_stereotype

			StFinder::FindedMap finded_map;
			StFinder::find_with_base (id, base_stereotype, context_tpl, finded_map);
			if (finded_map.size () == 1) {
				finded = true;
				AbstractDumperBase::TemplateContext::instance ()->rewrite_top (
					finded_map.begin ()->first
					, AbstractDumperBase::FunctionID (id)
					, AbstractDumperBase::EMPTY_TRANSFORMATOR_ID
				);

				f = finded_map.begin ()->second;
			} else if (finded_map.size () > 1) {
				//ошибка - функция наследуется более чем от одного класса
				std::string mess ("Error while dump ");
				mess += method_type;
				mess += "\"";
				mess += id;
				mess += "\", because stereotype \"";
				mess += real_context_model_stereotype;
				mess += "\" inherited from \"";
				mess += base_stereotype;
				mess += "\" inherid function from more than one stereotype";

				throw TemplateBadSyntax (mess);
			} else {
				//ошибка - класс не наследует от base_stereotype
				std::string mess ("Error while dump ");
				mess += method_type;
				mess += "\"";
				mess += id;
				mess += "\", because stereotype \"";
				mess += real_context_model_stereotype;
				mess += "\" not inherited from \"";
				mess += base_stereotype;
				mess += "\"";

				throw TemplateBadSyntax (mess);
			}
		}
	}
	if (finded == false && IsFunction) {
		try {
			//Core::Aptr<TemplateFunctions::InternalStereotypeFunctionFactory::KeySet> keys = TemplateFunctions::InternalStereotypeFunctionFactory::keys ();
			/*if (!keys.is_nil () && std::binary_search  (keys->begin (), keys->end (), id))*/ {
				TemplateFunctions::InternalStereotypeFunction& st_func = TemplateFunctions::InternalStereotypeFunctionFactory::make (id);
				finded = true;
				TPArgs args (this->m_args);

				if (context) {
					args.insert (args.begin (), context);
				}
				
				TemplatePainter tp (this);
				tp.set_args (args);

				return pop_context_wrapper (st_func.execute (params, &tp));
			}
		} catch (Core::Root::UnknownFactoryKey&) {
			//AbstractDumperBase::TemplateContext::instance ()->pop ();
		}

	}

	if (finded == false) {
		if (need_error) {
			std::string mess ("use undefined stereotype (");
			mess += base_stereotype/*.get ()*/.empty () ? real_context_model_stereotype/*.get ()*/ : base_stereotype/*.get ()*/;
			mess += ") ";
			mess += method_type;
			mess += " \"";
			mess += id;
			mess += "\"";

			throw TemplateBadSyntax (mess);
		}
		return pop_context_wrapper ("");
	}

	return use_self_args 
		? pop_context_wrapper (this->resolve_method (f->second, this->m_args, context)) 
		: pop_context_wrapper (this->resolve_method (f->second, params, context));
	//#UC END# *4951EEB400B2_477606D700B4*
}




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

