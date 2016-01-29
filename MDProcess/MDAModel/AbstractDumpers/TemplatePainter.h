////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplatePainter
//
// Собственно класс, реализующие основные операции вывода шаблона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEPAINTER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEPAINTER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include <vector>
#include <list>
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/str/str_conv.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
#include <ostream>
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/Base/Base.h"

//#UC START# *477606D700B4_CUSTOM_INCLUDES*
//#define ZombieEnabled 1
//#UC END# *477606D700B4_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace SystemFunctionsImpl {
	class CycleBreak;
} // namespace SystemFunctionsImpl

class TemplatePainter;	class OutputWrapper;

namespace VirtualElementsFuncionsImpl {
	class UCModificationBase;
} // namespace VirtualElementsFuncionsImpl



// Собственно класс, реализующие основные операции вывода шаблона
class TemplatePainter;
typedef Core::Var<TemplatePainter> TemplatePainter_var;
typedef Core::Var<const TemplatePainter> TemplatePainter_cvar;

class TemplatePainter :
	public Base::AbstractTemplatePainter
	, public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TemplatePainter)
	friend class SystemFunctionsImpl::CycleBreak; // defined friend
	friend class OutputWrapper; // defined friend
	friend class VirtualElementsFuncionsImpl::UCModificationBase; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// контэйнер параметеров для вывода шаблона
	typedef std::vector < const AbstractDumperBase* > TPArgs;

	// контейнер для хранения созданных экземпляров AbstractDumperBase
	typedef std::list < AbstractDumperBase_var > DumpersHeap;

	// Дампер для работы со строками
	class TextDumper;
	typedef Core::Var<TextDumper> TextDumper_var;
	typedef Core::Var<const TextDumper> TextDumper_cvar;

	class TextDumper :
		virtual public AbstractSingleDumperBase
	{
		SET_OBJECT_COUNTER (TextDumper)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// конструктор
		explicit TextDumper (const char* str);

	public:
		virtual ~TextDumper ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// имя дампера
		std::string m_name;

	//////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	public:

	// implemented method from AbstractDumperBase
	// возвращает имя
	virtual const std::string get_name_str () const;
	//////////////////////////////////////////////////////////////////////////////////////////
	// overloaded base methods

	protected:

	// overloaded method from Base::NamedElement
	// возвращает полное имя элемента
	virtual const std::string get_full_name () const;


	//#UC START# *47836F7C0343*
#if (defined(ZombieEnabled) && (ZombieEnabled == 1))
		void delete_obj () {
			m_deleted = true;
		}

		const std::string get_model_class_str () const {
			GDS_ASSERT(!m_deleted);
			return AbstractSingleDumperBase::get_model_class_str ();
		}

		void set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) const {
			GDS_ASSERT(!m_deleted);
			return AbstractSingleDumperBase::set_var_dumper (var_id, dumper);
		}

		const AbstractDumperBase* get_var_dumper (const std::string& var_id) const {
			GDS_ASSERT(!m_deleted);
			return AbstractSingleDumperBase::get_var_dumper (var_id);
		}
#endif
        bool operator == (const AbstractDumperBase& c) const;
	//#UC END# *47836F7C0343*
	}; // class TextDumper

	// дампер представляющий собой контэйнер - список
	class ContainerDumper;
	typedef Core::Var<ContainerDumper> ContainerDumper_var;
	typedef Core::Var<const ContainerDumper> ContainerDumper_cvar;

	class ContainerDumper :
		virtual public TextDumper
	{
		SET_OBJECT_COUNTER (ContainerDumper)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit ContainerDumper (const std::string& name);

		ContainerDumper (const ContainerDumper& copy);

	public:
		virtual ~ContainerDumper ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// добавляет элемент с в контэйнер
		virtual void add (const AbstractDumperBase* item);

		// добавляет все элементы из списка
		virtual void add (const AbstractDumperBase::VarList& items);

		// очищает контэйнер
		virtual void clear ();

		// возвращает количество элементов в списке
		virtual size_t count (const AbstractDumperBase* item) const;

		// удалить элемент из контэйнера
		virtual void erase (const AbstractDumperBase* item);

		// сравниваем содержимое двух контэйнеров
		virtual bool is_equal (const ContainerDumper* cont) const;

		// удаляет элемент с конца списка
		virtual void pop_back ();

		// удаляет элемент с начала списка
		virtual void pop_front ();

		// размер списка
		virtual size_t size () const;

		// удаляет содержимое контэйнера arg
		virtual void substract (const ContainerDumper* arg);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// элементы списка
		AbstractDumperBase::VarList m_items;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
		virtual const AbstractDumperBase::VarList& get_items () const;


	//////////////////////////////////////////////////////////////////////////////////////////
	// overloaded base methods
	public:

	// overloaded method from AbstractDumperBase
	// массив всех вложенных элементов (рекурсивно)
	virtual AbstractDumperBase::ADList* get_all_contents () const;

	// overloaded method from AbstractDumperBase
	// массив вложенных элементов
	virtual AbstractDumperBase::ADList* get_contents () const;

	}; // class ContainerDumper

	// интерфейс функции для выполнения команды шаблона
	typedef boost::function<AbstractDumperBase::ADList* (const AbstractDumperBase*)> DumperByTemplateFunc;

	// обертка над потоком, в который будет записываться результат
	class OutputWrapper {
		SET_OBJECT_COUNTER (OutputWrapper)
		friend class TemplatePainter; // defined friend
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// конструктор, out - поток, над которым делается обёртка
		OutputWrapper (std::ostream& out, const TemplatePainter* owner);

		explicit OutputWrapper (const TemplatePainter* owner);

	public:
		virtual ~OutputWrapper ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// инициализирует внутренний буфер
		virtual void init_buffer ();

		// очищает внутренний буфер, возвращает в качестве результата значение буфера перед очисткой
		virtual const std::string release_buffer ();

		// установить поток
		virtual void set_output (std::ostream& out);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// внутренний буфер
		std::string m_buffer;

		// флаг - нужен ли внутренний буфер
		bool m_need_buffer;

		// оборачиваемый поток
		std::ostream* m_output;

		// флаг - является ли обертка владельцем потока
		bool m_own_output;

	//#UC START# *47762FB2013A*
			const TemplatePainter& m_owner;
		public:
			OutputWrapper& operator << (const char* str);
			OutputWrapper& operator << (const std::string& str);
			OutputWrapper& operator << (const char& str);
			void seekp (std::streampos pos);
			std::streampos tellp () const;
		//#UC END# *47762FB2013A*
	}; // class OutputWrapper

	// параметры отложенной функции
	class DelayedFunctionParams {
		SET_OBJECT_COUNTER (DelayedFunctionParams)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		DelayedFunctionParams (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, const TemplatePainter* painter
	);

	public:
		virtual ~DelayedFunctionParams ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		virtual TemplatePainter* get_painter () const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// контекст
		AbstractDumperBase_cvar m_context;

		DumpersHeap m_local_args;

		TemplatePainter_var m_painter;

		TemplateFunctions::FunctionParams m_params;

		const AbstractDumperBase* m_self;

		AbstractDumperBase::VarDumpers m_var_dumpers;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
		virtual const AbstractDumperBase* get_context () const;

		virtual void set_context (const AbstractDumperBase* context);

		virtual const DumpersHeap& get_local_args () const;

		virtual const TemplateFunctions::FunctionParams& get_params () const;

		virtual const AbstractDumperBase* get_self () const;

		virtual const AbstractDumperBase::VarDumpers& get_var_dumpers () const;
	}; // class DelayedFunctionParams

	typedef ::Core::Box<DelayedFunctionParams> DelayedFunctionParams_box;


	// итерация цикла была прервана
	class TemplateCycleIterationBreak : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

	// Неверный синтаксис шаблона
	class TemplateBadSyntax : public Base::FatalError {
	public:
		TemplateBadSyntax (const std::string& info);

	private:
		const char* uid () const /*throw ()*/;

	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// очищает списки переменных
	static void clear ();

	// удаляет переменную из списка глобальных переменных
	static void delete_var_dumper (const std::string& var_id);

	// возвращает переменную с идентификатором var_id, если такой переменной нет - возвращает 0
	static const AbstractDumperBase* get_var_dumper (const std::string& var_id);

	// формирует строку - юзер-секцию
	static const std::string make_uc (const std::string& uc_id, const std::string& uc_content, const AbstractDumperBase::TemplateBody& tpl);

	// разбирает условное выражение expression и возвращает результат в виде строки
	static const bool resolve_cond (const AbstractDumperBase::CodeTemplate& expression, const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent);

	// разбирает условное выражение expression и возвращает результат в виде строки
	static const bool resolve_cond (const AbstractDumperBase::CodeTemplate& expression, TemplatePainter* base);

	// разбирает выражение expression и возвращает результат в виде строки
	// args - аргументы, необходимые для разюора выражения
	// main_scope - элемент для которого производится разбор шаблона
	static const std::string resolve_exp (const AbstractDumperBase::CodeTemplate& expression, const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent);

	// разбирает выражение expression и возвращает результат в виде строки
	static const std::string resolve_exp (const AbstractDumperBase::CodeTemplate& expression, TemplatePainter* base);

	// устанавливает переменную с идентифкатором var_id
	static void set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper);

private:
	// множество переменных, обявленных в шаблоне
	struct VarDumpersSingletonDataType {
		AbstractDumperBase::VarDumpers ptr;
	};
	
	typedef ACE_Singleton <
		VarDumpersSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> VarDumpersSingleton;


//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors
private:
	static const AbstractDumperBase::VarDumpers& get_var_dumpers ();
	static void set_var_dumpers (const AbstractDumperBase::VarDumpers& var_dumpers);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit TemplatePainter (const TemplatePainter* base);

	TemplatePainter (
		const TPArgs& args
		, std::ostream& output
		, const AbstractDumperBase* main_scope
		, const TemplatePainter* parent
	);

	// конструктор, поток, в который будет осуществляться вывод создаётся внутри обёртки - т.е поток
	// временный
	TemplatePainter (const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent);

public:
	virtual ~TemplatePainter ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// создает полную копию объекта, при этом для всех переменных типа Box копируется их содержимое
	virtual TemplatePainter* clone () const;

	// разбирает выражение заданное [it, it_end], пытается найти идентификатор функции и параметры
	// функции
	virtual const AbstractDumperBase::FunctionID extract_function (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, TemplateFunctions::FunctionParams& params
	);

	// разбирает выражение заданное [it, it_end], пытается найти идентификатор и параметры
	// трансформаторы
	virtual const AbstractDumperBase::TransformatorID extract_transformator (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, TemplateFunctions::FunctionParams& params
	);

	// вычисляет значение функции, заданного идентификатором id, params - список параметров для функции
	virtual const std::string function (
		const AbstractDumperBase::FunctionID& id
		, const TemplateFunctions::FunctionParams& params
	);

	// Возвращает элемент дерева генерации, по соответствующему шаблону
	virtual const AbstractDumperBase* get_dumper_by_template (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// возвращает текущую кодировку
	virtual GCL::code_t get_encoding () const;

	// возвращает стэк вызовов функций
	virtual GCL::StrVector* get_stack () const;

	// инвалидирует внутренний кэш для элемента owner. Данный метод нужен для того чтобы сборосить
	// закэшированный список, если в него вносятся изменения (при суммонинге)
	virtual void invalidate_dumpers_list (char list_tpl_command, const AbstractDumper* owner);

	// выводит в поток результат разбора шаблона, шаблон задан итераторами it и it_end
	virtual bool paint (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// выводит результат разбора цикла
	virtual bool paint_cycle (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// выводит результат условия
	virtual bool paint_if (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// выводит результат разбора шаблона вывода пользователькой секции
	virtual bool paint_user_code (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// вычисляет результат шаблона функции
	virtual const std::string resolve_method (
		const AbstractDumperBase::Function& function
		, const TemplateFunctions::FunctionParams& params
		, const AbstractDumperBase* context
	);

	// вычисляет результат шаблона трансформатора
	virtual const std::string resolve_method (
		const AbstractDumperBase::Transformator& transformator
		, const TemplateFunctions::FunctionParams& params
		, const AbstractDumperBase* context
	);

	// устанавливает кодировку
	virtual void set_encoding (GCL::code_t encoding);

	// устанавливает поток, в который будет происходить запись
	virtual void set_output (std::ostream& out);

	// вычисляет значение трансформатора, заданного идентификатором id, params - список параметров для
	// трансформатора
	virtual const std::string transform (
		const AbstractDumperBase::TransformatorID& id
		, const TemplateFunctions::FunctionParams& params
	);

protected:
	// разворачивает шаблон
	virtual bool execute_paint (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, bool if_flag
		, bool cycle_flag
	);

	// Дампит параметр шаблона, например:
	// %SS - выведет стереотип текущего элемента
	virtual bool paint_parameter (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, const AbstractDumperBase* templ_dump
	);

	// устанавливает итератор цикла
	virtual const AbstractDumperBase* setup_iterator (
		AbstractDumperBase::ADListIt_box& it_begin
		, AbstractDumperBase::ADList::iterator& it_end
	);

	// сортирует список
	virtual bool sort (AbstractDumperBase::ADList_box& list);

private:
	// возвращает реализацию функции для заданной команды (arg)
	virtual DumperByTemplateFunc* get_dumper_by_template_impl (char arg) const;

	// формирует список параметров для функции
	virtual void make_function_args (
		const TemplateFunctions::FunctionParams& params
		, TPArgs& args
		, DumpersHeap& destruct
	);

	// формирует список параметров для трансформатора
	virtual void make_transf_args (const TemplateFunctions::FunctionParams& params, TPArgs& args, DumpersHeap& destruct);

	// вычисляет результат работы функции
	virtual const std::string resolve_method (
		const AbstractDumperBase::Function& function
		, const TPArgs& args
		, const AbstractDumperBase* context
	);

	// вычисляет результат работы трансформатора
	virtual const std::string resolve_method (
		const AbstractDumperBase::Transformator& transformator
		, const TPArgs& args
		, const AbstractDumperBase* context
	);

	// выполнение функции с отложенными параметрами
	virtual void resolve_method (const AbstractDumperBase::Function& function, DelayedFunctionParams_box& params);

	// возвращает идентификатор запрошенное переменной it должен указывать на строчку, удовлетворяющую
	// рег.выражению: "^{[^{]*}.*"
	virtual const std::string resolve_var_id (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);


//////////////////////////////////////////////////////////////////////////////////////////
// template methods
public:
	// Вычисление результата шаблона функции или трансформатора (в зависимости от параметра
	// IsFunction), определенного на стереотипе.  Если  такой функции (или трансформатора) не
	// определено бросается исключение.
	template <bool IsFunction, class ID>
	const std::string st_method (
		const ID& id
		, const TemplateFunctions::FunctionParams& params
		, const AbstractDumperBase* context
		, const AbstractDumperBase::StereotypeID& base_stereotype
		, bool need_error
		, bool use_self_args
	);



//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// аргументы
	TPArgs m_args;

	// итератор указывающий на конец цикла
	AbstractDumperBase::ADListIt_box m_cycle_end;

	// текущий итератор цикла
	Core::Box<AbstractDumperBase::ADListIt_box> m_cycle_it;

	// номер итерации цикла
	unsigned long m_cycle_iteration;

	// кодировка потока
	GCL::code_t m_encoding;

	// флаг - реверсивный цикл или нет
	bool m_is_reversed_cycle;

	const AbstractDumperBase* m_main_scope;

	// обертка над потоком
	OutputWrapper m_output;

	// владелец
	const AbstractDumperBase* m_owner;

	// родитель парсера - парсеры могут образовывать иерархию, соответствующую вызовам в шаблоне
	const TemplatePainter* m_parent;

	// указатель на конец последовательности при реверсивном проходе
	AbstractDumperBase::ADList::iterator m_rend_iterator;

	// сохранённый итератор цикла
	AbstractDumperBase::ADListIt_box m_save_cycle_it;

	// флаг - была ли уже сортировка списка
	Core::Box<bool> m_sort_processed;

	// тип сортировки
	char m_sorting_type;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const TPArgs& get_args () const;

	virtual void set_args (const TPArgs& args);

	virtual const AbstractDumperBase* get_main_scope () const;

	virtual const AbstractDumperBase* get_owner () const;

//#UC START# *477606D700B4*
	struct PainterADData {
	protected:
		PainterADData () {				
		};
		~PainterADData () {				
		};
	public:
		static inline PainterADData* make () {
			//Core::GDS::StopWatchEx sw ("PainterADData::PainterADData ()");
			PainterADData* tmp = new PainterADData ();
			return tmp;
		}
		struct PainterADDataDestructor {
			static inline void destroy (PainterADData* t) {
				//Core::GDS::StopWatchEx sw ("PainterADData::~PainterADData ()");
				delete t;
			}
		};
		typedef std::pair<AbstractDumperBase::ADList_box, AbstractDumperBase::ADListIt_box> DataPair;
		typedef std::map<char, DataPair> DataMap;
		DataMap m_data_map;			
	};
	Core::Box<PainterADData, PainterADData::PainterADDataDestructor> m_data;

public:
	typedef std::map<std::string, AbstractDumperBase::ADList> DuplicatedNames;
	typedef ACE_Singleton <DuplicatedNames, ACE_SYNCH_RECURSIVE_MUTEX> DuplicatedNamesSingleton;

private:
	static bool resolve_cond_ex (
		const AbstractDumperBase::CodeTemplate& exp
		, const TPArgs& args
		, const AbstractDumperBase* main_scope
		, TemplatePainter* base
		, const TemplatePainter* parent
	);

	typedef std::map<std::string, std::string> ResolveCache;
	static ResolveCache s_resolve_cache;
	
	static const AbstractDumperBase::StereotypeID s_inherited_flag;

private:
	void replace_iterator (const AbstractDumperBase::ADList::iterator& iter);
	AbstractDumperBase::ADListIt_box& dereference ();
	bool is_valid_iterator () const;
	bool is_empty_source () const; //пустая ли была исходная последовательность

	void increment_iterator ();
	void decrement_iterator ();
	//#UC END# *477606D700B4*
}; // class TemplatePainter



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEPAINTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

