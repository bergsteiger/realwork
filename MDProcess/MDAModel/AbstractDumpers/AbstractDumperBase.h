////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase
//
// Класс реализующий базовую логику Дампера. Дампер - элемент вирутального дерева модели обладающий
// знаниями о себе, своих свойствах, данных, свяызях с другими элементами. Иерархия дамперов в
// сових листьях определяет конкроетныен типы элементов модели.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPERBASE_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPERBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include <map>
#include <vector>
#include <list>
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/data/StaticNode.h"
#include "shared/GCL/str/str_conv.h"
#include "xmemfile.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractLogger.h"
#include "boost/regex.hpp"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

//#UC START# *4571A2EF02CE_CUSTOM_INCLUDES*
#include <comutil.h>
#include <algorithm>
#include <bitset>
#include "shared/Core/data/unsorted_containers.h"

int odp_compare_adapter (const void *a1, const void *a2);
int adb_cvar_compare_adapter (const void *a1, const void *a2);

int compare_by_order (const void *a1, const void *a2);
int adb_cvar_compare_by_order (const void *a1, const void *a2);

//сортировка по порядку создания элемента
int compare_by_creation_order (const void *a1, const void *a2);
int adb_cvar_compare_by_creation_order (const void *a1, const void *a2);
//#UC END# *4571A2EF02CE_CUSTOM_INCLUDES*

// forward decls for defined friends
	class TemplatePainter;

namespace VirtualElementsFuncionsImpl {
	class VirtualFunctionsHelper;
} // namespace VirtualElementsFuncionsImpl



// Класс реализующий базовую логику Дампера. Дампер - элемент вирутального дерева модели обладающий
// знаниями о себе, своих свойствах, данных, свяызях с другими элементами. Иерархия дамперов в
// сових листьях определяет конкроетныен типы элементов модели.
class AbstractDumperBase;
typedef Core::Var<AbstractDumperBase> AbstractDumperBase_var;
typedef Core::Var<const AbstractDumperBase> AbstractDumperBase_cvar;

class AbstractDumperBase :
	virtual public Base::Dumper
	, virtual public AbstractLogger
{
	SET_OBJECT_COUNTER (AbstractDumperBase)
	friend class TemplatePainter; // defined friend
	friend class VirtualElementsFuncionsImpl::VirtualFunctionsHelper; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// Элемент дерева отчетов (сейчас интерфейсно набор отчетов представляет из себе линейный список,
	// но теоритическт он может быть деревом, как список генераторов)
	class ReportsTreeItem;
	typedef Core::Var<ReportsTreeItem> ReportsTreeItem_var;
	typedef Core::Var<const ReportsTreeItem> ReportsTreeItem_cvar;

	class ReportsTreeItem :
		virtual public GCL::StaticNode
	{
		SET_OBJECT_COUNTER (ReportsTreeItem)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	public:
		virtual ~ReportsTreeItem ();


	//#UC START# *458E8E730132*
	public:
		struct ViewData {
			ViewData (const std::string& name_, const std::string& exp, unsigned len) : name (name_), expression(exp), view_length(len) {
			}
			std::string name;
			std::string expression;
			unsigned view_length;
		};

		typedef std::vector<ViewData> Views;

	public:
		ReportsTreeItem (const char* name): m_item_name (name) {
		}
		
		const std::string& name () const {
			return m_item_name;
		}
		
		void query (const std::string& q) {
			m_query = q;
		}
		
		const std::string& query () const {
			return m_query;
		}
		
		void set_view (const std::string& view_name, const std::string& view_value, unsigned len) {
			m_views.push_back (ViewData (view_name, view_value, len));
		}

		const Views& get_views () const{
			return m_views;
		}

		void set_auto (const std::string& auto_type) {
			m_auto = auto_type;
		}

		const std::string& get_auto () const {
			return m_auto;
		}

	private:
		std::string m_item_name;
		std::string m_query;
		std::string m_auto;

		Views m_views;
	//#UC END# *458E8E730132*
	}; // class ReportsTreeItem

	// Типы источников генерации
	enum GenSourceType {
		GST_FILE // Обычный внешний файл
		, GST_WIKI // Внешний wiki-server
	};

	// Источник в который происходит генерация. Может быть фалом или каким-либюо другим внешним
	// источником.
	/*union*/ class GenSource {
	public:
		class InvalidDiscrimenant: public Core::Exception {
			const char* what () const throw () {
				return "GenSource - access to data by invalid discrimenant";
			}

			const char* uid () const /*throw ()*/ {
				return "GenSource::InvalidDiscrimenant";
			}
		};

		GenSource () : m_d ((GenSourceType)-1) {
		}

		GenSource (const GenSource& c) : m_d ((GenSourceType)-1) {
				switch (c.m_d) {
				case GST_FILE:
					this->file_name (c.file_name());
					break;
				
				case GST_WIKI:
					this->wiki_page (c.wiki_page());
					break;
				}
		}

		~GenSource () {
			this->reset();
		}

		bool operator < (const GenSource& c) const {
			if (m_d != c.m_d) {
				return m_d < c.m_d;
			} else {
				switch (m_d) {
				case GST_FILE:
					return *m_u.file_name < *c.m_u.file_name;
				case GST_WIKI:
					return m_u.wiki_page < c.m_u.wiki_page;
				
				}
				return false;
			}
		}

		GenSourceType d_ () const {
			return m_d;
		}

		const std::string& file_name () const /*throw (GenSource::InvalidDiscrimenant)*/ {
			if (m_d != GST_FILE) {
				throw InvalidDiscrimenant ();
			} else {
				return *m_u.file_name;
			}
		}

		std::string& file_name () /*throw (GenSource::InvalidDiscrimenant)*/ {
			if (m_d != GST_FILE) {
				throw InvalidDiscrimenant ();
			} else {
				return *m_u.file_name;
			}
		}
			
		void file_name (const std::string& val) {
			this->reset ();
			m_d = GST_FILE;
			m_u.file_name = new std::string (val);
		}

		GenSupport::PageProxy* wiki_page () const /*throw (GenSource::InvalidDiscrimenant)*/ {
			if (m_d != GST_WIKI) {
				throw InvalidDiscrimenant ();
			} else {
				return m_u.wiki_page;
			}
		}
			
		void wiki_page (GenSupport::PageProxy* val) {
			this->reset ();
			m_d = GST_WIKI;
			m_u.wiki_page = GenSupport::PageProxy::_duplicate (val);
		}

	private:
		void reset () {
			switch (m_d) {
			case GST_FILE:
				if(m_u.file_name) {
					delete m_u.file_name;
				}
				break;
			
			case GST_WIKI:
				if(m_u.wiki_page) {
					m_u.wiki_page->release();
				}
				break;
			}
		}
	
	private:
		GenSourceType m_d;
	
		union {
			std::string* file_name;
			GenSupport::PageProxy* wiki_page;
		} m_u;
	};

	// Идентификатор генератора
	typedef std::string GenID;

	// данные об источнике артефакте (возможно сгенерированном ранее)
	struct GenSourceInfo {
		// источник артефакта (место его хранения)
		GenSource source;
		// идентификатор генератора создавшего данный источник артефакта
		GenID gen_id;

		GenSourceInfo (const GenSource& source_, const GenID& gen_id_);

		GenSourceInfo (const GenSourceInfo& copy);

		GenSourceInfo& operator = (const GenSourceInfo& copy);

		// инициализирующий конструктор
		GenSourceInfo ();
		bool operator < (const GenSourceInfo& y) const;
	};

	// множество ранее сгенерированных источников
	typedef std::set < GenSourceInfo > GenSourceInfoSet;

	// элемент - на диаграмме - хранит координаты элемента диаграмме и гуид соответствующего элемента
	struct DiagramItem {
		// координата элемента на дигаграмме
		long x1;
		// координата элемента на дигаграмме
		long y1;
		// координата элемента на дигаграмме
		long x2;
		// координата элемента на дигаграмме
		long y2;
		// координата элемента на дигаграмме
		long x3;
		// координата элемента на дигаграмме
		long y3;
		// координата элемента на дигаграмме
		long x4;
		// координата элемента на дигаграмме
		long y4;
		// UID связанного элемента
		std::string uid;
	};

	// множество элементов диаграммы
	typedef std::vector < DiagramItem > DiagramItemCollection;

	// множество выбранных генераторов
	typedef GCL::StrSet Selections;

	// идентификатор юзер-секции
	typedef std::string UserCodeId;

	// содержимое юзер секции
	typedef std::string UserCode;

	// идентификатор стереотипа
	typedef std::string StereotypeID;

	// класс для работы с объектами, открывающими транзакции
	class TransactionContainer {
		SET_OBJECT_COUNTER (TransactionContainer)

		// singleton declaration
		typedef ACE_Singleton <TransactionContainer, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <TransactionContainer, ACE_SYNCH_RECURSIVE_MUTEX>;
	public:
		static TransactionContainer* instance () {
			return Singleton::instance();
		}
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	protected:
		virtual ~TransactionContainer ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// добавить источник генерации
		virtual void add_source (const GenSourceInfo& source);

		// закрывает транзакции на всех объектах
		virtual void close_all ();

		// удалить источник
		virtual void remove_source (const GenSourceInfo& source);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// множество источников генерации
		GenSourceInfoSet m_sources;
	}; // class TransactionContainer



	// структура поисывающая файл, хранит имя файла и файловый дискриптор
	struct FileDesc {
		// имя файла
		std::string name;
		// файл
		FILE* file;
	};

	// данные файла шаблона
	typedef std::list < std::string > TemplateData;

	// тип юзер-свойства
	enum UserPropertyType {
		UPT_STRING // строковый тип
		, UPT_BOOL // булевый тип
		, UPT_LIST // тип - список
		, UPT_COLOR // тип - цвет
		, UPT_FILE // тип файл
		, UPT_TRIBOOL // свойства с 3-мя состояними: true, false, undefined
		, UPT_TEXT // текстовое свойство - аналог строкового, но позволяет вводить многострочный текст
	};

	// идентификатор трансформатора
	typedef std::string TransformatorID;

	// данный юзер-свойства
	struct UserPropertyData {
		// тип юзер-свойства
		UserPropertyType type;
		// дефолтное значение
		std::string def_value;
		// список значений
		GCL::StrVector value_list;
		// описание
		std::string description;
	};

	// класс для загрузки и парсинга шаблона
	class TemplateLoader {
		SET_OBJECT_COUNTER (TemplateLoader)

		// singleton declaration
		typedef ACE_Singleton <TemplateLoader, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <TemplateLoader, ACE_SYNCH_RECURSIVE_MUTEX>;
	public:
		static TemplateLoader* instance () {
			return Singleton::instance();
		}
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	protected:
		virtual ~TemplateLoader ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// метод проверяет менялся ли шаблон со времени последнего вычитывания
		// возвращает true, если менялся, иначе - false
		// \template_path - полный путь к шаблону
		virtual bool check_template_changed (const std::string& template_path);

		// возвращает прочитанный шаблон в виде списка строк
		virtual const TemplateData get_template_data ();

	private:
		// считывает файл в буфер, included_files - содержит список файлов включенных в шаблон (через
		// дериктиву #)
		virtual void load_template_data (const std::string& template_path, TemplateData& data, GCL::StrSet& included_files);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// прочитанный и склеенный из разных tpl/tpi шаблон храним в массива строк
		TemplateData m_template_data;
	}; // class TemplateLoader

	// идентификатор функции
	typedef std::string FunctionID;

	// мапа юзер-свойств
	typedef std::map < std::string, UserPropertyData > UserPropertyMap;

	// данные контекста
	struct ContextData {
		// идентификатор текущего стереотипа
		StereotypeID stereotype_id;
		// идентифиактор функции контекста
		FunctionID function_id;
		// идентифиактор трансформатора контекста
		TransformatorID transformator_id;
		// параметры функции или трансформатора
		TemplateFunctions::FunctionParams args;

		ContextData (
			const StereotypeID& stereotype_id_
			, const FunctionID& function_id_
			, const TransformatorID& transformator_id_
			, const TemplateFunctions::FunctionParams& args_
		);
	};

	// группа свойств - элемент дерева, объединяет (группирует) пользовательские свойства
	class PropertyGroupTreeItem;
	typedef Core::Var<PropertyGroupTreeItem> PropertyGroupTreeItem_var;
	typedef Core::Var<const PropertyGroupTreeItem> PropertyGroupTreeItem_cvar;

	class PropertyGroupTreeItem :
		virtual public GCL::StaticNode
	{
		SET_OBJECT_COUNTER (PropertyGroupTreeItem)

	//////////////////////////////////////////////////////////////////////////////////////////
	// nested declorations
public:
		// Исключение возникает при попытке добавить в группу свойство, уже присутствующее в другой
		// группе. В пределах одного дерева имена свойств должны быть уникальны.
		class PropertyAlreadyExist : public ::Core::Exception {
		public:
			const char* what () const throw ();

		private:
			const char* uid () const /*throw ()*/;

		};

	//////////////////////////////////////////////////////////////////////////////////////////
	// static member methods and data
	public:
		// метод для копирования узла дерева
		static PropertyGroupTreeItem* make_copy (const PropertyGroupTreeItem* source);

	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// конструктор.
		// \group_name - имя группы
		explicit PropertyGroupTreeItem (const std::string& group_name);

	public:
		virtual ~PropertyGroupTreeItem ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// добавляет свойство в список, если свойство уже есть - перезаписывает его
		virtual void add_property (const std::string& name, const UserPropertyData& data) /*throw (PropertyAlreadyExist)*/;

		// возвращает имя группы
		virtual const std::string& get_name () const;

		// возвращает свойства в группе
		virtual const UserPropertyMap& get_properties () const;

		// Добавляет свойства, азданные диапазоном итераторов. Если свойство уде существует, то ничего не
		// делаем (никаких исключений не летит)
		virtual void insert_properties (
		const UserPropertyMap::const_iterator& begin
		, const UserPropertyMap::const_iterator& end
	);

		// т.к имена свойств в пределах стереотипа должны быть уникальными - нужно проверить нет ли уже в
		// дереве свойства с именем prop_name, если нет - возвращает false, иначе true
		virtual bool is_exists (const std::string& prop_name) const;

		// устанавливает имя группы
		virtual void set_name (const std::string& name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// имя группы
		std::string m_group_name;

		// множество свойств
		UserPropertyMap m_user_properties;
	}; // class PropertyGroupTreeItem

	// множество стереотипов
	typedef std::set < StereotypeID > StereotypeSet;

	// код шаблона
	typedef std::string CodeTemplate;

	// функттор подаваемый при обходе дерева, собирает все юзер-свойства в одну мапу
	class CollectUserProperty {
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	public:
		virtual ~CollectUserProperty ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// фукнция, вызываемая на кождом элементе дерева
		virtual void each_func (const GCL::StaticNode* item, UserPropertyMap& prop_map);

	}; // class CollectUserProperty

	// стэк контекста
	typedef std::vector < ContextData > ContextStack;

	// шаблон функции
	typedef CodeTemplate FunctionTemplate;

	// контекст генерации шаблона - задаёт текущее "место" генерации (функция, генератор,
	// трансформатор...)
	class TemplateContext {
		SET_OBJECT_COUNTER (TemplateContext)

		// singleton declaration
		typedef ACE_Singleton <TemplateContext, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <TemplateContext, ACE_SYNCH_RECURSIVE_MUTEX>;
	public:
		static TemplateContext* instance () {
			return Singleton::instance();
		}

	//////////////////////////////////////////////////////////////////////////////////////////
	// nested declorations
public:
		// блок констант для контекста
		static const long INIT_STACK_SIZE; // начальный размер стэка

	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	protected:
		// конструктор, по умолчанию резервируем INIT_STACK_SIZE элементов для стэка
		TemplateContext ();

		virtual ~TemplateContext ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// очистка стэка
		virtual void clear ();

		// пустой ли стэк
		virtual bool empty () const;

		// удаляет элемент вершины стэка
		virtual void pop ();

		// помещение данных на вершину стэка
		virtual void push (const ContextData& data);

		// переписываем верхушку стэка
		virtual void rewrite_top (const StereotypeID& st, const FunctionID& fn, const TransformatorID& tr);

		// возвращает данные на вершине стэка
		virtual const ContextData& top () const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// стэк контекста
		ContextStack m_stack;
	}; // class TemplateContext

	// шаблон трансформатора
	typedef CodeTemplate TransformatorTemplate;

	// строка в таблице представляющей собой трансформатор
	typedef std::map < std::string, TransformatorTemplate > TransformatorRow;

	// тело трансформатора
	struct TransformatorBody {
		// условие в строке трансформатора
		std::string row_exp;
		// собственно строка
		TransformatorRow row;
	};

	// список "тел" трансформатора
	typedef std::list < TransformatorBody > TransformatorBodyList;

	// трансформатор - фактически представляет собой таблицу - первая колонка которой, условие, при
	// выполнении которого выполняется шаблон на пересечении строки и заданного столбца
	struct Transformator {
		// имя трансформатора
		std::string name;
		// шаблон для ключа, идентифицирующего результат работы данного трансформатора в кэше
		CodeTemplate key_tpl;
		// идентификатор трансформатора - состоит из имени трансформатора и признака - глобальный
		// трансформатор или трансформатор стереотипа
		TransformatorID id;
		// список строк трансформатора
		TransformatorBodyList rows;
	};

	// стукртура, описывающая шаблонную функцию - состоит из собственно шаблона - тела функции и из
	// шаблона, описывающего ключ для кэширования функции (если этот шаблон пустой - результат функции
	// не кэшируется)
	struct Function {
		// шаблон функции
		FunctionTemplate function_tpl;
		// шаблон для ключа, идентифицирующего результат работы данной функции в кэше
		CodeTemplate key_tpl;
		// идентификатор функции - состоит из имени функции и признака - глобальная функция или функция
		// стереотипа
		FunctionID id;
	};

	// собственно метаданные
	typedef std::string MetaDataValue;

	// тип ключа метаданных
	typedef std::string MetaDataKey;

	// мапа трансформаторов шаблона
	typedef std::map < TransformatorID, Transformator > Transformators;

	// список мета-данных
	typedef std::vector < MetaDataValue > MetaDataList;

	// мапа ключ метаданных -> список значений метаданных
	typedef std::map < MetaDataKey, MetaDataList > MetaDataMap;

	// мапа функций шаблона
	typedef std::map < FunctionID, Function > Functions;


	class SourceTypeConvertor : 
		public Core::UnsortedTypeConverter<GenSourceType, std::string> {
		protected:
			void fill_array () {
				//#UC START# *497425AA022B_FILL_ARRAY_IMPLEMENTATION*
				this->add (GST_WIKI, "wiki");
				this->add (GST_FILE, "file");
				//#UC END# *497425AA022B_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class SourceTypeConvertor

	typedef ACE_Singleton<SourceTypeConvertor, ACE_SYNCH_NULL_MUTEX> SourceTypeConvertorSingleton;

	// место инициализации
	enum LocalVarType {
		LVT_IN_SPELL // локальная переменная инициализированная при спелле
		, LVT_OTHER
		, LVT_ALL
	};



	// локальная переменная
	struct LocalVar {
		// тип
		LocalVarType type;
		// Значение
		AbstractDumperBase_cvar value;
	};

	// локальные переменные
	typedef std::map < std::string, LocalVar > LocalVars;

	// список дамперов
	typedef std::list < const AbstractDumperBase* > ADList;

	// блок констант
	static const GenID SPELL_GENERATOR_ID; // идентификатор предустановленного генератора для формирования виртуальных элементов
	static const StereotypeID DEFAULT_STEREOTYPE_ID; // константа для обозначения стереотипа по-умолчанию
	static const StereotypeID EMPTY_STEREOTYPE_ID; // константа для обозначения пустого стереотипа
	static const FunctionID EMPTY_FUNCTION_ID; // константа для обозначения пустого идентификатора функции
	static const TransformatorID EMPTY_TRANSFORMATOR_ID; // константа для обозначения пустого идентификатора для трансформатора
	static const StereotypeID UNSTEREOTYPED_ID; // константа для обозначения отсутствия стереотипа у элемента



	// мапа связывающая данные об источнике генерации и набор дамперов
	typedef std::map < const GenSourceInfo, ADList > GenSourceInfoToDumpersMap;

	// исключение выбрасывается при ошибки в процессе выполнения шаблона
	class TemplateResolveException : public Base::FatalError {
	public:
		TemplateResolveException (const std::string& info);

	private:
		const char* uid () const /*throw ()*/;

	};

	// тип кэша для алгоритма нахождения элемента по имени
	typedef std::map < std::string, const AbstractDumperBase* > ResolveTypeCacheType;

	// бокс для хранения итераторов на список дамперов
	typedef ::Core::Box<ADList::iterator> ADListIt_box;


	typedef std::vector < const AbstractDumperBase* > ADVector;

	// бокс для хранения списка дамперов
	typedef ::Core::Box<ADList> ADList_box;


	// Превышен лимит для вложенных генераций (возможно рекурсия при запуске генерации SX)
	class DumpRecursion : public Base::FatalError {
	public:
		DumpRecursion (const std::string& info);

	private:
		const char* uid () const /*throw ()*/;

	};

	// парсер шаблона
	class TemplateParser {
		SET_OBJECT_COUNTER (TemplateParser)

	//////////////////////////////////////////////////////////////////////////////////////////
	// nested declorations
public:
		// регульярные выражения, используемы при парсинге шаблона
		static const std::string group_regex_str; // регульярное выражение для определения начала группы свойств
		static const std::string property_regex_str; // регулярное выражение для юзер-свойства

	//////////////////////////////////////////////////////////////////////////////////////////
	// static member methods and data
	private:
		// возвращает true, если name - это "Attribute" или "Operation", или "Class", или "Category", или
		// "Parameter", или "ClassDepenedency", иначе false
		static bool is_it_classtype_name (const std::string& name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// конструктор
		TemplateParser ();

	public:
		virtual ~TemplateParser ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// парсит шаблон, в случае ошибки при разборе шаблона выбрасывается исключение.
		// \template_data - скленный в один массив строк шаблон
		virtual void parse (const TemplateData& template_data);

	private:
		// запускает алгоритм автоматического формирования подстереотипов на основе информации о
		// наследовании
		virtual void build_substereotypes () const;

		// обработчик начала нового стереотипа - если предыдущий стереотип был переопределением,
		// обновляет шаблон для всех его наследников рекурсивно
		virtual void on_new_stereotype (const StereotypeID& prev_stereotype, bool prev_was_redefinition);

		// разбирает строку, поределяющую юзер-свойство и добавляет его в текущую группу свойств
		virtual void process_property (const std::string& prop_line);

		// запускает процес разбора свойств
		// по завершении scopes содержит количество не закрытых скобо "{"
		virtual void process_property_group (
		const std::string& group_name
		, TemplateData::const_iterator& it_in
		, const TemplateData::const_iterator& it_end
		, long& scopes
	);

		// обновляет шаблон наследников (рекурсивно) стереотипа base - присваивает шаблону наследника
		// шаблон базового класса, аналогично тому, как если бы в шаблоне еще раз было объявлено
		// наследование:
		// {code}
		// : DescendantStereotype
		// = base
		// {code}
		virtual void update_descendants_recursively (const StereotypeID& base) const;


	//////////////////////////////////////////////////////////////////////////////////////////
	// template methods
private:
		// функция для копирования одной мапы в другую
		template <class IteratorType, class OutputType>
		static void copy_map (const IteratorType& begin, const IteratorType& end, OutputType& dest);



	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// текущий стереотип
		std::string m_cur_stereotype;

		// текущий стереотип является переопределением
		bool m_cur_stereotype_is_redefinition;

		// текущая группа свойств
		PropertyGroupTreeItem_var m_current_prop_item;

		// список стереотипов (подстереотипов), которые должны быть исключены из общего списка
		StereotypeSet m_excluded_stereotypes;

		// реуглярное выражение для группы свойств
		boost::regex m_group_regex;

		// регулярное выражение для свойств
		boost::regex m_property_regex;
	}; // class TemplateParser

	// вектор идентификаторов стереотипа
	typedef std::vector < StereotypeID > StereotypeIDVector;

	// контэйнер для хранения переменных шаблона
	typedef std::list < AbstractDumperBase_cvar > VarList;

	// мапа для хранения переменны шаблона
	typedef std::map < std::string, AbstractDumperBase_cvar > VarDumpers;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// метод формирует строку, которую можно записать в свойства элемента
	static const std::string create_page_property (const char* page_id, const char* page_path);

	// удаляет из кэша данные об испточнике генерации
	static void erase_source (const GenSourceInfo& arg);

	// извлекает id и path из строки
	static void extract_from_page_property (const std::string& prop_str, std::string& page_id, std::string& page_path);

	// возвращает список файлов, в которых есть неиспользуемые пользовательские секции
	static GCL::StrSet* get_file_with_unused_user_code ();

	// мапа данные о источнике генерации -> список дамперов
	static GenSourceInfoToDumpersMap& get_source_to_dumpers ();

protected:
	// удалить элемент из списка элементов для отложенного dump'а
	static void remove_dumper_for_delay_dump (const AbstractDumperBase* adb);

private:
	// возвращает true, если выполняется spell
	static bool s_in_spell;

	// кэш для алгоритма связывания элемента с его типом (тип атрибута/операции/параметра) по имени
	struct ResolveTypeCacheSingletonDataType {
		ResolveTypeCacheType ptr;
	};
	
	typedef ACE_Singleton <
		ResolveTypeCacheSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> ResolveTypeCacheSingleton;

	// мапа данные о источнике генерации -> список дамперов
	struct SourceToDumpersSingletonDataType {
		GenSourceInfoToDumpersMap ptr;
	};
	
	typedef ACE_Singleton <
		SourceToDumpersSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> SourceToDumpersSingleton;


//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors
protected:
	static bool get_in_spell ();
	static void set_in_spell (bool in_spell);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~AbstractDumperBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавляет список значений метаданных по ключу
	void add_metadata (const MetaDataKey& key, const MetaDataList& values);

	// добавляет метаданные по ключу
	void add_metadata (const MetaDataKey& key, const MetaDataValue& value);

	// очищает список метаданных, связанных с элементом
	void clear_metadata ();

	// очищаем список связанных элементов
	virtual void clear_var_dumpers (LocalVarType type) const;

	// порядковый номер элемента (устанавливается ОДИН раз при построении дерева генерации и хранится
	// в модели)
	virtual unsigned long long elem_creation_order () const;

	// порядковый номер элемента (устанавливается при построении дерева генерации)
	virtual unsigned int elem_order () const;

	// находит метаданные по ключу
	const MetaDataMap::const_iterator find_metadata (const MetaDataKey& key) const;

	// возвращает имя файла с изображением, связанного с элементом
	virtual const std::string get_image_file () const;

	// возвращает дампер для вывода значения по-умолчанию
	virtual AbstractDumperBase* get_initial_value () const;

	// возвращает ГУИД, который используется при создании навигационной мапы диаграммы
	virtual const std::string get_link_guid () const;

	// возвращает мэйн элемент
	virtual AbstractDumperBase* get_main_element () const;

	// возвращает кодировку, с которой должен генерится файл
	virtual GCL::code_t get_output_coding () const;

	// возвращает тип сгенерированного артефакта
	virtual GenSourceType get_source_type () const;

	// возвращает дампер по id-шнику, связанные с элементом
	virtual const AbstractDumperBase* get_var_dumper (const std::string& var_id) const;

	// возвращает true, если элемент был изменён (используется дл определения того, что диаграмма была
	// изменена)
	virtual bool is_changed () const;

	// возвращает true, если страница для элемента может быть Home - страницей, иначе - false
	virtual bool is_home () const;

	// возвращает true, если генератор имеет свойство "User" - результирующий файл НЕ будет/будет
	// переписываться при повторной генерации
	bool is_user_file () const;

	// сбрасывает информацию об изменённости
	virtual void reset_changed () const;

	// Вызывает внешний обработчик измененного файла
	virtual void run_post_command () const;

	// устанавливает дампер по id-шнику, связанный с элементом
	virtual void set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) const;

	// логирование ошибок в шаблоне
	virtual void write_template_error_log (const char* log) const;

	// логирование предупреждений
	virtual void write_template_warning_log (const char* log) const;

protected:
	// добавить элемент для отложенного dump'а
	virtual void add_dumper_for_delay_dump (const AbstractDumperBase* adb) const;

	// возвращает true, если элемент можно "дампить"
	virtual bool can_dump () const;

	// возвращает список лэйблов (меток) соответствующих стереотипу
	virtual GCL::StrSet* get_labels () const;

	// возвращает итератор на начало метаданных
	const MetaDataMap::const_iterator metadatas_begin () const;

	// возвращает итератор на конец метаданных
	const MetaDataMap::const_iterator metadatas_end () const;


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// добавляет юзер секцию
	virtual void add_user_code (const GenID& gen_id, const UserCodeId& uc_id, const UserCode& uc) const = 0;

	// зарегистрирован или нет
	virtual bool am_i_registred () const = 0;

	// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
	// items - коллекция элементов даграммы, для формирования навигационной мапы
	// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
	virtual CxMemFile* dump_diagram (DiagramItemCollection& items, std::string& diagram_hash) const = 0;

	// regular/abstract/final - тип абстрактности элемента.
	virtual const std::string get_abstract_str () const = 0;

	// ВСЕ элементы которые используют текущий
	virtual ADList* get_all_consumers () const = 0;

	// массив всех вложенных элементов (рекурсивно)
	virtual ADList* get_all_contents () const = 0;

	// Возвращает список элементов,  у которых имя совпадает с текущим элементом
	virtual ADList* get_all_equals_name () const = 0;

	// массив всех включаемых элементов (папок) рекурсивно
	virtual ADList* get_all_includes () const = 0;

	// возвращает список разрешенных генераторов
	virtual Selections* get_applied_gens () const = 0;

	// авто инкрементирующийся счетчик на элементе.
	virtual const std::string get_auto_counter_str () const = 0;

	// вид элемента
	virtual const std::string get_class_kind_str () const = 0;

	// массив вложенных элементов
	virtual ADList* get_contents () const = 0;

	// возвращает список элементов, от которых зависит данный
	virtual ADList* get_dependences () const = 0;

	// массив реализующих методов и\или атрибутов (реализуемых данным элементом относительно
	// абстрактных членов своих базовых классов)
	virtual ADList* get_derived_impl () const = 0;

	// массив перегруженных методов и\или атрибутов (перегруженных данным элементом относительно своих
	// базовых классов)
	virtual ADList* get_derived_over () const = 0;

	// массив диаграмм
	virtual ADList* get_diagrams () const = 0;

	// получение докуентации к элементу
	virtual const std::string get_documentation_str () const = 0;

	// массив элементов, которые необходимо forward-декларировать для текущего элемента.
	virtual ADList* get_forwarded () const = 0;

	// массив базовых элементов (от которых унаследован текущий)
	virtual ADList* get_generalizations () const = 0;

	// массив объектов наследующихся от данного
	virtual ADList* get_generalizator () const = 0;

	// массив элементов являющихся исключениями для операций  или get-исключениями для атрибутов
	virtual ADList* get_get_exceptions () const = 0;

	// возвращает COM GUID
	virtual const std::string get_guid_str () const = 0;

	// массив включаемых элементов (папок)
	// Включаемые папки определяются на основе зависимостей элемента. Если элемент или его вложенные
	// части используют как-либо (наследуется, реализует, имеет атрибуты данного типа и т.д.) другой
	// элемент, то папка, в которой содержится используемый элемент, попадет в список зависимости. Из
	// результирующего списка исключаются элементы попавшие в форвард-декларирование (F)
	virtual ADList* get_includes () const = 0;

	// значение по умолчанию (для атрибутов и аргументов операции)
	virtual const std::string get_initial_value_str () const = 0;

	// возвращает строку для сдвига
	virtual const std::string get_intend_str (short intend_shift) const = 0;

	// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
	virtual const std::string get_link_type_str () const = 0;

	// возвращает класс
	virtual const std::string get_model_class_str () const = 0;

	// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
	virtual const StereotypeID& get_model_stereotype_str () const = 0;

	// возвращает GUID элемента
	virtual const std::string& get_model_unique_id_str () const = 0;

	// возвращает имя
	virtual const std::string get_name_str () const = 0;

	// возвращает native-путь к элементу, прописанный в настройках
	virtual const std::string get_native_path_str () const = 0;

	// все элементы которые используют без учета форвард-декларирования данный (циклически) в одном
	// пакете
	virtual ADList* get_nested_botom_consumers () const = 0;

	// массив всех (рекурсивно) базовых элементов (от которых унаследован текущий)
	virtual ADList* get_nested_generalizations () const = 0;

	// массив всех (рекурсивно) реализуемых элементов (которые реализует текущий)
	virtual ADList* get_nested_realizations () const = 0;

	// все элементы которые используются без учета форвард-декларирования данным (циклически) в одном
	// пакете
	virtual ADList* get_nested_top_suppliers () const = 0;

	// возвращает список абстрактных операций/атрибутов базовых или реализуемых классов, который НЕ
	// реализует данный элемент
	virtual ADList* get_not_implemented_derived_abstract () const = 0;

	// то же что и Forwarded но без исключения элементов декларированных выше в предполагаемой (в
	// области пакета) видимости
	virtual ADList* get_nsf_forwarded () const = 0;

	// массив включаемых элементов (папок), но исключаются все форвард декларированные элементы без
	// учета ранней форвард деклорации (W). Кроме того, в место элементов НЕ имеющих выходных файлов,
	// в список попадают, их родители (рекурсивно) имеющие таковые
	virtual ADList* get_nsf_includes () const = 0;

	// возвращает ID страницы в конфлюенсе
	virtual const std::string get_page_id () const = 0;

	// возвращает путь страницы, прописанный в свйоствах элемента
	virtual const std::string get_page_path () const = 0;

	// массив родительских элементов
	// Первым элементов в массиве является ближайший родитель
	virtual ADList* get_parents () const = 0;

	// массив реализуемых элементов (которые реализует текущий)
	virtual ADList* get_realizations () const = 0;

	// массив объектов реализующих данный
	virtual ADList* get_realizator () const = 0;

	// массив объектов наследующихся от данного (рекурсивно)
	virtual ADList* get_req_generalizator () const = 0;

	// массив объектов реализующих данный (рекурсивно)
	virtual ADList* get_req_realizator () const = 0;

	// ВСЕ элементы которые используют текущий (циклически)
	virtual ADList* get_requrcive_all_consumers () const = 0;

	// возвращает рекурсивно список элементов, от которых зависит данный
	virtual ADList* get_reqursive_dependences () const = 0;

	// значение рутовой дирректории для генерации
	virtual const std::string get_root_dir (bool direct_get) const = 0;

	// возвращает информацию о ранее сгенерированном файле
	virtual GenSourceInfo* get_self_generated_source () const = 0;

	// массив элементов последовательности вызовов (для операций)
	virtual ADList* get_sequences () const = 0;

	// массив элементов являющихся set-исключениями для атрибутов
	virtual ADList* get_set_exceptions () const = 0;

	// массив объектов использующих данный в качестве своих атрибутов
	virtual ADList* get_source () const = 0;

	// возвращает стереотип элемента
	virtual const std::string get_stereotype_str () const = 0;

	// возвращает цель
	virtual AbstractDumperBase* get_target () const = 0;

	// стереотип «цели» (const, var, ...)
	virtual const std::string get_target_stereotype_str () const = 0;

	// возвращает "true", если элемент фиксированного размера
	virtual const std::string get_type_fixed_size_str () const = 0;

	// получить юзер секцию
	virtual const UserCode get_user_code (const GenID& gen_id, const UserCodeId& uc_id) const = 0;

	// выводит значение пользовательского свойства «prop_name»
	virtual const std::string get_user_property_str (const std::string& prop_name) const = 0;

	// строка определяющая видимость элемента.
	// Может принимать значения: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
	virtual const std::string get_visability_str () const = 0;

	// имеет ли зарегистрированного родителя
	virtual bool has_registred_parent () const = 0;

	// определяет имеет ли элемент собственный поток вывода
	virtual bool own_output () const = 0;

	// возвращает родителя
	virtual AbstractDumperBase* parent () const = 0;

	// удаляет из модели информацию об ранее сгенерированном источнике артефакта, возвращает true в
	// случае успеха.
	virtual bool remove_generated_source (const GenSourceInfo& src) const = 0;

	// записывает на модели информацию о сгенерированном файле, возвращает true в случае успеха.
	virtual bool set_self_generated_source (const GenSourceInfo& src) const = 0;

protected:
	// возвращает информацию об тех файлах которые были сгенерированны
	// ранее, а теперь "исчезли" из списка генерации. Т.е. о тех файлы,
	// который фактически удалились из репазитария
	virtual GenSourceInfoSet* get_deleted_child_generated_source () const = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// метаданные, связанные с элементом
	MetaDataMap m_metadatas;

	// локальные переменные
	mutable LocalVars m_var_dumpers;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractLogger
	// метод для логирования ошибок
	virtual void write_error_log (const std::string& mess, bool fatal) const;

	// implemented method from AbstractLogger
	// логирование информационных сообщений
	virtual void write_info_log (const std::string& mess) const;

	// implemented method from AbstractLogger
	// логирование предупреждений
	virtual void write_warning_log (const std::string& mess) const;

//#UC START# *4571A2EF02CE*
public:
	static void clean_up ();
	
public:
	typedef std::map<std::string, std::string> GenFileMap;

	typedef std::list<const AbstractDumperBase*> ADList;
	typedef Core::Box<ADList> ADList_box;
	typedef Core::Aptr<ADList> ADList_aptr;
	typedef Core::Box<ADList::iterator> ADListIt_box;
	typedef Core::Var<AbstractDumperBase> AbstractDumper_box;

	class IsEqual: 
		public std::binary_function<const AbstractDumperBase*, const AbstractDumperBase*, bool>
	{
	public:
		bool operator () (const AbstractDumperBase* const first, const AbstractDumperBase* const second) const {
			return *first == *second;
		}
	};

	struct SortByUID {
		bool operator()(const AbstractDumperBase* const x, const AbstractDumperBase* const y) const {
			return strcmp (x->get_model_unique_id_str().data(), y->get_model_unique_id_str().data()) < 0;
		}
    };
	
	struct SortByUIDAndName {
		bool operator()(const AbstractDumperBase* const x, const AbstractDumperBase* const y) const {
			int res = strcmp (x->get_model_unique_id_str().data(), y->get_model_unique_id_str().data());
			if (res == 0) {
				res = strcmp (x->get_name_str().data(), y->get_name_str().data());
			}
			return res < 0;
		}
    };

	struct SortByName {
		bool operator()(const AbstractDumperBase* const x, const AbstractDumperBase* const y) const {
			int res = strcmp (x->get_name_str().data(), y->get_name_str().data());
			if (res == 0) {
				res = strcmp (x->get_model_unique_id_str().data(), y->get_model_unique_id_str().data());
			}
			return res < 0;
		}
    };

	struct SortByParentAndName {
		bool operator()(const AbstractDumperBase* const x, const AbstractDumperBase* const y) const {
			const AbstractDumperBase* x_parent = x->parent();
			const AbstractDumperBase* y_parent = y->parent();
			int pc = strcmp (x_parent->get_name_str().data(), y_parent->get_name_str().data());
			if (pc == 0) {
				pc = strcmp (x_parent->get_model_unique_id_str().data(), y_parent->get_model_unique_id_str().data());
				if (pc == 0) {
					pc = strcmp (x->get_name_str().data(), y->get_name_str().data());
					if (pc == 0) {
						pc = strcmp (x->get_model_unique_id_str().data(), y->get_model_unique_id_str().data());
					}
				}
			}
			return  pc < 0;
		}
    };
	
	class GenTreeItem : public virtual GCL::StaticNode {
	public:
		static GenTreeItem* make_copy(const GenTreeItem* source) {
			if (!source) {
				return 0;
			}

			Core::Var<GenTreeItem> ret = new GenTreeItem (source->name().data());
			ret->m_item_desc = source->m_item_desc;
			ret->m_item_props = source->m_item_props;
			return ret._retn();
		}

		GenTreeItem (const char* name): m_item_name (name) {
		}
		
		const std::string& name () const {
			return m_item_name;
		}
		
		void description (const std::string& desc) {
			m_item_desc = desc;
		}
		
		const std::string& description () const {
			return m_item_desc;
		}
		
		void set_property (const std::string& prop_id, const std::string& prop_value) {
			m_item_props[prop_id] = prop_value;
		}

		bool get_property (const std::string& prop_id, std::string& ret_value) const {
			std::map<std::string, std::string>::const_iterator f = m_item_props.find (prop_id);
			if (f != m_item_props.end()) {
				ret_value = f->second;
				return true;
			} else {
				return false;
			}
		}

	private:
		std::string m_item_name;
		std::string m_item_desc;
		std::map<std::string, std::string> m_item_props;
	};

	typedef Core::Var<GenTreeItem> GeneratorTree;
	typedef std::map<GenID, GenTreeItem*> GenInfos;

	typedef Core::Var<ReportsTreeItem> ReportsTree;

	typedef std::string ReportID;
	typedef std::map<ReportID, ReportsTreeItem*> ReportInfos;
	//////////////  end of reports tree
	
	typedef std::string CodeTemplate;
	typedef std::string FileTemplate;

	struct TemplateBody {
		TemplateBody ();

		void reset () {
			code_template = "";
		}
		
		bool is_empty () const;
	public:
		CodeTemplate code_template;
		CodeTemplate open_scope_template;
		CodeTemplate close_scope_template;
		CodeTemplate forward_template;		
		FileTemplate file_template;
		FileTemplate dir_template;
		FileTemplate post_command_template;
		CodeTemplate generator_info;

		CodeTemplate user_file_template; //шаблон для свойства "User" - результирующий файл НЕ будет/будет переписываться при повторной генерации
		CodeTemplate output_coding_template;; //шаблон для кодировки файла
		bool plain;
		bool file_create;
		
		std::string tab_replacer;
		std::string newline_replacer;
		
		CodeTemplate user_code_open_start_id;
		CodeTemplate user_code_close_start_id;
		CodeTemplate user_code_open_end_id;
		CodeTemplate user_code_close_end_id;
		bool user_code_unique;
		bool use_current_root;
	};		
	
	struct UserPropertyDef {
		UserPropertyType type;
		std::string def_value;
		GCL::StrVector value_list;
		std::string description;
	};
	
	typedef std::map<std::string, UserPropertyDef> UserPoperty_map;
	
	typedef std::map<GenID, TemplateBody> GT_map;	
	
	enum ConsraintType {
		CSCT_UNDEFINED
		, CSCT_INCLUDED
		, CSCT_EXCLUDED
	};
	
	/*enum AbstractionType {
		ATF_ABSTRACT = 1
		, ATF_REGULAR = 2
		, ATF_FINAL = 4
		, ATF_OPTIONAL = 8
	};*/
	typedef char AbstractionType;

	static const AbstractionType ATF_UNDEFINED = 0;
	static const AbstractionType ATF_ABSTRACT = 1;
	static const AbstractionType ATF_REGULAR = 2;
	static const AbstractionType ATF_FINAL = 4;
	static const AbstractionType ATF_OPTIONAL = 8;

/*	#define ATF_REGULAR  2
	#define ATF_FINAL    4
//	#define ATF_INLINE   8
	#define ATF_OPTIONAL   8

/*	#define ATF_ABSTRACT 1
	#define ATF_REGULAR  2
	#define ATF_FINAL    4
//	#define ATF_INLINE   8
	#define ATF_OPTIONAL   8
*/
	#define VTF_PUBLIC    1
	#define VTF_PROTECTED 2
	#define VTF_PRIVATE   4
	#define VTF_IMPL      8

	#define LTF_AGR    1
	#define LTF_REF    2
	#define LTF_LNK    4
	
	static const size_t MAX_PICTURE_SIZE;

	enum IconViewType {
		IVT_ICON
		, IVT_DECOR
		, IVT_NONE
		, IVT_ST
	};
	
	//номер бита, соответствующего свойства шаблона
	enum TeplatePropertyMask {
		TP_ALLOW_EMPTY_TARGET
		, TP_FORBIDEN_FORWARD_DECL
		, TP_SKIPED_ITEM
		, TP_IS_HOME
		, TP_ABSTRACTION_TYPE
		, TP_VISABILITY_TYPE
		, TP_DEF_ABSTRACTION_TYPE
		, TP_DEF_VISABILITY_TYPE
		, TP_DEF_LINK_TYPE
		, TP_ST_DESCRIPTION_HEADER
		, TP_ST_DESCRIPTION
		, TP_FWD_WEIGHT
		, TP_AVAILABLE_TARGET_STEREOTYPES
		, TP_PARENT_VISABILITY
		, TP_LABELS
		, TP_LINK_GUID_TEMPLATE
		, TP_IMAGE_FILE_NAME
		, TP_IMPLEMENTATION_TYPE
		, TP_PARAMETERIZATION_TYPE
		, TP_HAS_DERIVED_IMPL
		, TP_MAIN_ST
		, TP_HAS_SET_EXCEPT
		, TP_HAS_GET_EXCEPT
		, TP_CLRZ_SUPPRES_OPERATION
		, TP_CLRZ_ICONIC_VIEW
		, TP_CLRZ_SUPPRES_ATRIBUTE
		, TP_CLRZ_FILL_COLOR
		, TP_CLRZ_LINE_COLOR
		, TP_CLRZ_FONT_COLOR
		, TP_CLRZ_FORIEN_LINE_COLOR
		, TP_CLRZ_FORIEN_FONT_COLOR
		, TP_LINK_TYPE
		, TP_VISIBILITY_LEVEL_SETTABLE
		, TP_ALL_COUNT
	};
	

	struct Template {
		Template ();
		Template& operator = (const Template& t);
		
		Template& inherite (const Template& t);
		//обработчик события установки свойства
		void on_property_set (unsigned int prop_id, bool is_seted = true);
	public:
		bool inherit_child_constraint; // нужно ли наследовать список констрэйнтов
		bool allow_empty_target;
		bool forbiden_forward_decl;
		bool skiped_item;
		bool is_home;
		bool is_internal; //признак, что стереотип является внутренним, т.е его нельзя использовать
						  //для создания элементов на модели, признак не наследуется!

		AbstractionType abstraction_type;
		char visability_type;
		char link_type;
		
		std::string def_abstraction_type;
		std::string def_visability_type;
		std::string def_link_type;
		std::string st_description_header;
		std::string st_description;
		
		long fwd_weight;
		
		GT_map generators;
		Functions functions;
		Transformators transformators;
		
		PropertyGroupTreeItem_var user_properties_group;
		
		GCL::StrVector available_target_stereotypes;
		GCL::StrSet parent_visability;
		GCL::StrSet labels;
		CodeTemplate link_guid_template;
		std::string image_file_name;
		char implementation_type;
		bool parameterization_type;
		bool has_derived_impl;
		ConsraintType child_st_constarint_type;
		GCL::StrSet child_st_constraints;
		GCL::StrSet child_internal_st_constraints; //стереотипы, которые можно использовать внутри элемента
												   //только при суммонинге

		bool main_st;
		bool has_set_except;
		bool has_get_except;
		bool visibility_level_settable;

		bool clrz_suppres_operation;
		IconViewType clrz_iconic_view;
		bool clrz_suppres_atribute;

		std::vector<unsigned char> clrz_fill_color;
		std::vector<unsigned char> clrz_line_color;
		std::vector<unsigned char> clrz_font_color;
		std::vector<unsigned char> clrz_forien_line_color;
		std::vector<unsigned char> clrz_forien_font_color;

		std::string classtype_name;
		std::string stereotype_name;

		StereotypeSet base_stereotypes; //список базовых стереотипов
		StereotypeID main_base_stereotype; //имя "главного" базового стереотипа, используется для разрешения
										  //неоднозначности при множественном наследовании
	private:
		std::bitset<TP_ALL_COUNT> m_seted_values;
	};

	//typedef std::string StereotypeID;
	typedef std::map<StereotypeID, Template> Templates;

	struct UserCodeData {
		UserCodeData ();
		UserCodeData (const UserCodeData& copy);

		UserCode uc;
		bool used;
		bool is_loaded; //заточка!!! флаг определяет была ли юзер-секция загружена из файла
						//нужен, чтобы отличать такие UC от установленных через суммонинг

		bool is_default; //флаг, что юзер-секция на является дефолтной 
						 //(нужно, чтобы отличить такие секции при загрузке юзер-секций из файла)
		std::string file_name;
		std::string pre_uc_content; //данные, которые выводятся до юзер секции
		std::string post_uc_content; //данные, которые выводятся после юзер секции
	};

	typedef std::map<UserCodeId, UserCodeData> UserCode_map;
	typedef std::map<GenID, UserCode_map> UserCode_map_mapGenId;	

public:
	static bool is_it_registred (const StereotypeID& st);
	static bool has_template (const StereotypeID& st);
	static void add_active_map (const GenID& gen_id);
	static void clean_active_map ();
	static void get_gen_ids (GCL::StrSet& ret);
	static void has_error (bool error = true);
	static bool is_has_error ();
	static GCL::StrSet& exception_stereotypes();
	static bool is_stereotype_exception (const std::string& stereotype);
	// доступ к темплейтам
	static Template& get_template (const StereotypeID& st);
	static Templates::const_iterator find_template (const StereotypeID& st);
	static Templates::const_iterator templates_begin ();
	static const Templates::const_iterator templates_end ();
	// доступ к UC
	static UserCode_map_mapGenId::const_iterator uc_begin ();
	static const UserCode_map_mapGenId::const_iterator uc_end ();
	
	static void reset_accepted_gens ();
	static void reset_accepted_generator (const AbstractDumperBase* adb);

	static const GCL::code_t s_default_encoding;
public:
	static GCL::StrSet s_active_map;
	static GenID s_current_map;
	static FILE* s_log_file;
	
	static GenInfos s_gen_infos;
	static GeneratorTree s_gen_tree;
	static ReportInfos s_report_infos;
	static ReportsTree s_reports_tree;

	static const AbstractDumperBase* s_gen_root_element; // element from wich generation was started
	static const AbstractDumperBase* s_model_main_element; // element on model marked as MAIN

	typedef std::map <std::string, StereotypeID> RoseStereotypeMap;
	static RoseStereotypeMap s_stereotypes; //cache of result create_gen_stereotype

	static Templates s_templates;
	static short s_intend_shift;
	static bool s_shift_scope; //нужно ли сдвинуть scope на один уровень
	
	static bool s_need_run_spell; //флаг нужно ли запускать spell

	static const UserCodeData* get_uc_data (
		const GenID& gen_id
		, const UserCodeId& uc_id
	);

	static void set_user_code (const GenID& gen_id, const UserCodeId& uc_id, const UserCodeData& uc_data);

protected:
	static void clear_user_code_from_file ();
	static void clear_user_code ();
	static void dump_prepare ();

private:
	static Transformators s_transformators;
	static Functions s_functions;
	static UserCode_map_mapGenId s_user_code;
	static GCL::StrSet s_exception_stereotypes;
	static bool s_has_error;
	static unsigned long s_error_count; //счетчик ошибок
	static unsigned long s_dump_depth_entry_count; //счетчик входов в метод dump


public:
	virtual bool operator == (const AbstractDumperBase& c) const = 0;

	std::string resolve_expression (const std::string& exp) const;
	
public:
	const Template& get_template () const;
	const TemplateBody& get_template_body () const;


	typedef std::map<std::string, unsigned long> Counters;
	static Counters s_counters_value;
	mutable Counters m_counters;

	static const std::string s_redefinition_postfix;

	std::string element_counter (const std::string& counter_id) const {
		unsigned long ret = 0;
		Counters::iterator f = m_counters.find(counter_id);
		if (f != m_counters.end()) {
			ret = f->second;
		} else {		
			f = s_counters_value.find(counter_id);
			if (f != s_counters_value.end()) {
				f->second++;			
				m_counters[counter_id] = f->second;
				ret = f->second;
			} else {
				s_counters_value[counter_id] = 0;
				m_counters[counter_id] = 0;				
			}
		}
		char buf [32];
		return itoa (ret, buf, 10);
	}

	virtual std::ostream* get_output () const = 0;

	virtual bool is_native (bool &wilth_parent) const {
		wilth_parent = false;
		return false;
	}
	virtual std::string get_post_command_str () const;
	virtual std::string create_file_name_str () const;
	virtual std::string get_generator_info_str () const;
	virtual std::string get_st_desc_str () const;
	virtual std::string create_dir_name_str () const;
	virtual std::string create_file_name() const;

	bool accepted_generator() const;

	std::string create_relative_dir_name () const;
	std::string create_relative_file_name () const;
	std::string create_normolized_path (const char* target_path, const char* target_root) const;

	std::string create_relative_file_name_with_parent () const;
protected:
	struct AcceptedGenKey {
		const AbstractDumperBase* adb;
		std::string gen_id;
		
		AcceptedGenKey (const AcceptedGenKey& c) : adb (c.adb), gen_id(c.gen_id) {
		}
		AcceptedGenKey (const AbstractDumperBase* _adb, const std::string& _gen_id) : adb (_adb), gen_id(_gen_id) {
		}

		bool operator < (const AcceptedGenKey& c) const {
			return adb == c.adb ? gen_id < c.gen_id : adb < c.adb;
		}
	};

	typedef std::map<AcceptedGenKey, bool> AcceptedGenMap;

	static AcceptedGenMap s_accepted_gens;

	
	std::string create_scoped_dir_name (const AbstractDumperBase* main_scope) const;	


	virtual void dump (std::ostream* output = NULL) const /*throw AbstractDumperBase::DumpRescursion*/;
	virtual std::string create_dir_name () const;
	virtual std::string dump_open_scope () const;
	virtual std::string dump_close_scope () const; 

protected:	
	void load_user_code (FILE* in_file, const std::string& in_file_name) const;
	bool is_forbiden_forward_dcl () const;
	const long get_fwd_weight () const;
	bool is_plain () const;
	bool is_allow_empty_target() const;
	bool is_parent_visability_stereotype (const StereotypeID& st) const;
	ADList* get_scopes(const AbstractDumperBase* main_scope) const;
	void write_debug_log (const std::string& mess) const;

protected:
	typedef std::map<const AbstractDumperBase*, std::string> StringResultCache;

	typedef std::pair<const AbstractDumperBase*, std::string> CacheKey;
	typedef std::map<CacheKey, std::string> ResolveFunctionsCache;

	static ResolveFunctionsCache s_resolve_functions_cache;
	static StringResultCache s_get_full_name_cache;

	typedef std::pair<AbstractDumperBase::ADList_box, AbstractDumperBase::ADListIt_box> DataPair;
	typedef std::map<CacheKey, std::pair<AbstractDumperBase::ADList_box, AbstractDumperBase::ADListIt_box>> ListFunctionsCache;
	
	static ListFunctionsCache s_list_functions_cache;

private:
	void dump_delayed () const;

protected:
	typedef std::set <const AbstractDumperBase*, SortByUID> AbstractDumperBaseSet;
	typedef std::map <const AbstractDumperBase*, AbstractDumperBaseSet> AbstractDumperBaseToSet;

	struct AlreadySpelledDumpers {
		AbstractDumperBaseSet ptr;
	};

	typedef ACE_Singleton <AlreadySpelledDumpers, ACE_SYNCH_RECURSIVE_MUTEX> AlreadySpelledDumpersSingleton;
	
	struct ForDelayDumpDumpers {
		AbstractDumperBaseToSet ptr;
	};

	typedef ACE_Singleton <ForDelayDumpDumpers, ACE_SYNCH_RECURSIVE_MUTEX> ForDelayDumpDumpersSingleton;
	
//#UC END# *4571A2EF02CE*
}; // class AbstractDumperBase



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPERBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

