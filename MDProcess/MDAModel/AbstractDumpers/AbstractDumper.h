////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumper
//
// Класс реализующий основную логику Дампера, не зависящую от реализации конткретной модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include <set>
#include <vector>
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include <fstream>
#include "MDProcess/MDAModel/AbstractDumpers/AbstractLogger.h"

//#UC START# *4571A2CB02DE_CUSTOM_INCLUDES*
class RegistredSupplierSt: public GCL::StrSet {
public:
	RegistredSupplierSt () {
		this->insert(ST_LINK_INH);
		this->insert(ST_LINK_DEP);
		this->insert(ST_LINK_REL);
		this->insert(ST_SET_EXCEPTION);
		this->insert(ST_GET_EXCEPTION);
		this->insert(ST_TARGET);
		this->insert(ST_CATEGORY_NESTED_DEPENDENCE);
		this->insert(ST_INIT_VALUE);
	}
};
//#UC END# *4571A2CB02DE_CUSTOM_INCLUDES*

// forward decls for defined friends
	class RoseOverridenElementDumper;



// Класс реализующий основную логику Дампера, не зависящую от реализации конткретной модели
class AbstractDumper;
typedef Core::Var<AbstractDumper> AbstractDumper_var;
typedef Core::Var<const AbstractDumper> AbstractDumper_cvar;

class AbstractDumper :
	public ObjectTreeResolver
	, public AbstractDumperBase
{
	SET_OBJECT_COUNTER (AbstractDumper)
	friend class RoseOverridenElementDumper; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// Статус изменения источника генерации
	enum SourceStatus {
		SS_EQ // Не изменившейся
		, SS_CHG // Измененнный
		, SS_NEW // Новый
		, SS_DEL // Удаленный
	};

	// информация об генерируемом артефакте
	struct GenArtData {
		// какой Дампер сгенерировал данный артефакт
		const AbstractDumperBase* dumper;
		// статус сгенерированного артефакта
		SourceStatus status;
		// информация об источнике артефакта
		AbstractDumperBase::GenSourceInfo source_info;

		GenArtData (
			const AbstractDumperBase* dumper_
			, SourceStatus status_
			, const AbstractDumperBase::GenSourceInfo& source_info_
		);

		GenArtData (const GenArtData& copy);

		GenArtData& operator = (const GenArtData& copy);
		bool operator < (const GenArtData& y) const;
	};

	// множество артефактов
	typedef std::set < const GenArtData* > ArtefactSet;

	class GenArtefacts;
	typedef ::Core::Var<GenArtefacts> GenArtefacts_var;
	typedef ::Core::Var<const GenArtefacts> GenArtefacts_cvar;
	// Информация об сгенерированных артефактах. Заполняется в процессе генерации, затем используется
	// для отображения статистики и для сохранения подтвержденных изменений
	class GenArtefacts
		: virtual public ::Core::IObject
	{
	public:
		// добавляет в список сгенеррованных артефактов новый
		virtual void add (const GenArtData& art) = 0;

		// изменяет статус сгенерированного элемента
		virtual void change_status (const GenArtData& art, SourceStatus stat) = 0;

		// корректирует список сгенернированных артефактов, выделяя псевдо-удаленные
		virtual void correct_data () = 0;

		// возвращает подмножетсво сгенерированных артефактов по их статусу
		virtual ArtefactSet* get_by_status (SourceStatus stat) const = 0;

		// возвращает псевдо-удаленные артефакты, как правило это те артефакты, у которых изменился
		// дампер или генератор, при этом сам артефакт созранил свое местоположение и имя
		virtual ArtefactSet* get_fake_deleted () const = 0;

		// восстанавливает артефакт (новый\изменный\удаленный)
		virtual void restore (const GenArtData& art) = 0;
	};

	// множество артефактов
	typedef std::set < GenArtData > ArtefactSetUnic;

protected:
	// реализация GenArtefacts
	class GenArtefacts_i;
	typedef Core::Var<GenArtefacts_i> GenArtefacts_i_var;
	typedef Core::Var<const GenArtefacts_i> GenArtefacts_i_cvar;

	class GenArtefacts_i :
		virtual public GenArtefacts
		, virtual public Core::RefCountObjectBase
	{
		SET_OBJECT_COUNTER (GenArtefacts_i)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// Сбрасываем данные
		void reset ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		ArtefactSetUnic m_data;

		// множество элементов, у которых изменился родитель, но не поменялся путь к файлу генерации.
		ArtefactSetUnic m_fake_deleted;

	//////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	protected:

		// implemented method from GenArtefacts
		// добавляет в список сгенеррованных артефактов новый
		void add (const GenArtData& art);

		// implemented method from GenArtefacts
		// изменяет статус сгенерированного элемента
		void change_status (const GenArtData& art, SourceStatus stat);

		// implemented method from GenArtefacts
		// корректирует список сгенернированных артефактов, выделяя псевдо-удаленные
		void correct_data ();

		// implemented method from GenArtefacts
		// возвращает подмножетсво сгенерированных артефактов по их статусу
		ArtefactSet* get_by_status (SourceStatus stat) const;

		// implemented method from GenArtefacts
		// возвращает псевдо-удаленные артефакты, как правило это те артефакты, у которых изменился
		// дампер или генератор, при этом сам артефакт созранил свое местоположение и имя
		ArtefactSet* get_fake_deleted () const;

		// implemented method from GenArtefacts
		// восстанавливает артефакт (новый\изменный\удаленный)
		void restore (const GenArtData& art);
	}; // class GenArtefacts_i

public:
	// функция модификации юзер-секций - выполняется  в конце суммонинга
	typedef boost::function<void ()> UCModificationFunction;

	// контэйнер со счетчиком ссылок
	typedef ::Core::Box<UCModificationFunction> UCModificationfunction_var;


	// список функций, для модификации юзер-свойств
	typedef std::vector < UCModificationfunction_var > UCModificationFunctionList;

	// информация связях
	struct RelationInfo {
		std::string stereotype;
		AbstractDumper* source;
		AbstractDumper* target;
		// тип связи
		ObjectTreeResolver::SupplierType type;
		bool operator < (const RelationInfo& y) const;
	};

	typedef std::set < RelationInfo > RelationsSet;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// добавить связь для восстановления перед следующим запуска спела
	static void add_relation_for_restore (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// добавить функцию
	static void add_uc_modification_function (const UCModificationfunction_var& func);

	// добавляет виртуальный дампер в спец. список
	static void add_virtual_dumper (const ObjectTreeResolver* rad, const AbstractDumperBase* context);

	// добавить виртуальную связь между двумя элементами
	static void add_virtual_relation (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// должен вызываться перед запуском генерации!
	static void before_dump ();

	// проверяет, что никакие два различных элемента не порождают однаковый артефакт генерации (т.е
	// один и тот же файл, страницу в К)
	static void check_unique_outputs (const AbstractLogger* logger);

	// релизует dump_commit для конкретного элемента
	static bool commit (const GenArtData& art);

	// создает имя для файла временной генерации
	static const std::string create_gen_file_name (const std::string& fn);

	// удаляет вирутальный элемент
	static void delete_virtual_dumper (const ObjectTreeResolver* otr);

	// Завершает генерацию (всех элементов дерева),  применяя все ее результаты на файловую систему
	// и, сохраняя информацию о сгенерированных артефактах на модели
	static void dump_commit (const AbstractLogger* logger);

	// Доступ к информации о сгенерированных артефактах
	static GenArtefacts& get_artefacts ();

	// возвращает имформацию о связи для восстановления (результат БЕЗ увеличения счетчика ссылок)
	static RelationInfo* get_relation_for_restore (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// вызывается при окончании генерации в К (после всех вызовов commit и rollback)
	static void on_end_wiki_generation ();

	// метод вызываетя при начале генерации в К (до первого обращения к странице К)
	static void on_start_wiki_generation ();

	// сохраняет все сделанные за сеанс изменения в общем репозитрарии. Для фаловой генерации в CVS,
	// для генерации страниц в MDKnow на сервере. Кроме сохранения артефактов, сохраняет в CVS
	// изменения модели (после чего разлочивает модель). По событию "постоянного коммита", другие
	// активные клиенты MDGen должны обновить свое состояние модели (и артефактов).
	static void persistent_commit (bool is_minor);

	// подготавливает элемент к генерации (иницилизирует внутренний кэш элемента и всех его детей
	// рекурсивно)
	static void prepare ();

	// удалять виртуальную связь
	static void remove_virtual_relation (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// сбрасывает кэши
	static void reset ();

protected:
	// очищает список дамперов связанных с каждым элементов дерева, должен вызываться при старте
	// генерации
	static void clear_all_var_dumpers (AbstractDumperBase::LocalVarType by_type);

	// отключить кэш для функций
	static void disable_functions_cache ();

	// активировать кэш для фукнций
	static void enable_functions_cache ();

	// включен ли кэш для функций
	static bool is_functions_cache_enabled ();

	// вызывается при подготовке к генерации перед проверкой констрэйнтов
	static void prepare_internal ();

	// запускает генерацию виртуальных элементов
	static void run_spell ();

private:
	// удаляет витруальные элементы из дерева
	static void delete_virtuals_from_tree ();

	// Сброс данных о сгенерированных артефактах
	static void reset_artefacts ();

	// очищает список артефактов, подлежащих коммиту, предварительно вызывая на них
	// rollback_all_changes на случай если остались не закрытые транзакции
	static void reset_arts_for_commit ();

	// запускает операции, которые нужн выполнить сразу после ссумонинга (вызывается внутри run_spell)
	static void run_post_spell ();

	// запускает алгоритм поготовки данных для сортировки элементов
	static void run_sort (const AbstractDumper* from_node);

	// метод отправляет на сервер список меток, присутствующих в шаблоне
	static void send_labels_list ();

	// множество сгенернных артефактов, которые нужно покоммитеть
	struct ArtsForCommitSingletonDataType {
		ArtefactSetUnic ptr;
	};
	
	typedef ACE_Singleton <
		ArtsForCommitSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> ArtsForCommitSingleton;

	// флаг - включен или нет кэш для функций
	static bool s_functions_cache_enabled;

	struct GenArtsSingletonDataType {
		GenArtefacts_i ptr;
	};
	
	typedef ACE_Singleton <
		GenArtsSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> GenArtsSingleton;

	// список связей, который нужно восстановить, перед перезапуском спела
	struct RelationsForRestoreSingletonDataType {
		RelationsSet ptr;
	};
	
	typedef ACE_Singleton <
		RelationsForRestoreSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> RelationsForRestoreSingleton;

	// флаг сигнализирующий о том отправлен список лэйблов на сервер или нет
	static bool s_sent_labels_list;

	// функции модификации юзер-свойств, вызываются в самом конце сумонинга.
	static UCModificationFunctionList s_uc_modification_functions;

	// список виртуальных элементов, которые должны быть удалены из дерева после окончания генерации
	struct VirtualDumpersSingletonDataType {
		ObjectTreeResolver::UnorderedOTRSet ptr;
	};
	
	typedef ACE_Singleton <
		VirtualDumpersSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> VirtualDumpersSingleton;

	// список виртульных связей, которые нужно разорвать перед повторной генерацией
	struct VirtualRelationsSingletonDataType {
		RelationsSet ptr;
	};
	
	typedef ACE_Singleton <
		VirtualRelationsSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> VirtualRelationsSingleton;

	// началась ли генерация в К
	static bool s_wiki_generation_started;


//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors
public:
	static const RelationsSet& get_relations_for_restore ();

	static const ObjectTreeResolver::UnorderedOTRSet& get_virtual_dumpers ();
	static void set_virtual_dumpers (const ObjectTreeResolver::UnorderedOTRSet& virtual_dumpers);

	static const RelationsSet& get_virtual_relations ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~AbstractDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возвращает true, если использование стереотипа разрешено правилами родителя, иначе false
	virtual bool check_stereotype_use () const;

	// Начинает генерацию, от данного узла
	virtual void dump_start () const;

	// заполняет кэш флагов генерит ли элемент собственный файл
	virtual void prepare_output_cache () const;

	// фиксирует и сбрасывает на диск все сгенерированные артефакты, анализируя характер изменений и
	// заполняя информацию о сгенерированных артефактах
	void push_changes () const;

protected:
	// инициирует удаление элемента из кэшей
	virtual void delete_from_cache () const;

	// метод вызываемые на каждом элементе перед запуском спела)
	virtual void spell_generation_prepare ();

private:
	// Закрывает выходной поток и "обрезает" выходной файл до нужного размера (т.к в конце потока
	// может находится мусор)
	virtual void close_output (std::ofstream& file) const;

	// Пост-обработка сгенерированного файла:
	// заменяет символ переноса строки (если это необходимо) на тот, что прописан в шаблоне
	// стереотипа. file_path - путь к файлу, в котором нужно провести изменения, также конвертит файл
	// в нужную кодировку
	virtual void file_post_process (const std::string& file_path) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// зарегистрирован или нет
	virtual bool am_i_registred () const;

	// implemented method from AbstractDumperBase
	// regular/abstract/final - тип абстрактности элемента.
	virtual const std::string get_abstract_str () const;

	// implemented method from AbstractDumperBase
	// ВСЕ элементы которые используют текущий
	virtual AbstractDumperBase::ADList* get_all_consumers () const;

	// implemented method from AbstractDumperBase
	// массив всех вложенных элементов (рекурсивно)
	virtual AbstractDumperBase::ADList* get_all_contents () const;

	// implemented method from AbstractDumperBase
	// Возвращает список элементов,  у которых имя совпадает с текущим элементом
	virtual AbstractDumperBase::ADList* get_all_equals_name () const;

	// implemented method from AbstractDumperBase
	// массив всех включаемых элементов (папок) рекурсивно
	virtual AbstractDumperBase::ADList* get_all_includes () const;

	// implemented method from AbstractDumperBase
	// вид элемента
	virtual const std::string get_class_kind_str () const;

	// implemented method from AbstractDumperBase
	// массив вложенных элементов
	virtual AbstractDumperBase::ADList* get_contents () const;

	// implemented method from AbstractDumperBase
	// возвращает список элементов, от которых зависит данный
	virtual AbstractDumperBase::ADList* get_dependences () const;

	// implemented method from AbstractDumperBase
	// массив диаграмм
	virtual AbstractDumperBase::ADList* get_diagrams () const;

	// implemented method from AbstractDumperBase
	// массив элементов, которые необходимо forward-декларировать для текущего элемента.
	virtual AbstractDumperBase::ADList* get_forwarded () const;

	// implemented method from AbstractDumperBase
	// массив базовых элементов (от которых унаследован текущий)
	virtual AbstractDumperBase::ADList* get_generalizations () const;

	// implemented method from AbstractDumperBase
	// массив объектов наследующихся от данного
	virtual AbstractDumperBase::ADList* get_generalizator () const;

	// implemented method from AbstractDumperBase
	// массив элементов являющихся исключениями для операций  или get-исключениями для атрибутов
	virtual AbstractDumperBase::ADList* get_get_exceptions () const;

	// implemented method from AbstractDumperBase
	// массив включаемых элементов (папок)
	// Включаемые папки определяются на основе зависимостей элемента. Если элемент или его вложенные
	// части используют как-либо (наследуется, реализует, имеет атрибуты данного типа и т.д.) другой
	// элемент, то папка, в которой содержится используемый элемент, попадет в список зависимости. Из
	// результирующего списка исключаются элементы попавшие в форвард-декларирование (F)
	virtual AbstractDumperBase::ADList* get_includes () const;

	// implemented method from AbstractDumperBase
	// возвращает строку для сдвига
	virtual const std::string get_intend_str (short intend_shift) const;

	// implemented method from AbstractDumperBase
	// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
	virtual const std::string get_link_type_str () const;

	// implemented method from AbstractDumperBase
	// все элементы которые используют без учета форвард-декларирования данный (циклически) в одном
	// пакете
	virtual AbstractDumperBase::ADList* get_nested_botom_consumers () const;

	// implemented method from AbstractDumperBase
	// массив всех (рекурсивно) базовых элементов (от которых унаследован текущий)
	virtual AbstractDumperBase::ADList* get_nested_generalizations () const;

	// implemented method from AbstractDumperBase
	// массив всех (рекурсивно) реализуемых элементов (которые реализует текущий)
	virtual AbstractDumperBase::ADList* get_nested_realizations () const;

	// implemented method from AbstractDumperBase
	// все элементы которые используются без учета форвард-декларирования данным (циклически) в одном
	// пакете
	virtual AbstractDumperBase::ADList* get_nested_top_suppliers () const;

	// implemented method from AbstractDumperBase
	// то же что и Forwarded но без исключения элементов декларированных выше в предполагаемой (в
	// области пакета) видимости
	virtual AbstractDumperBase::ADList* get_nsf_forwarded () const;

	// implemented method from AbstractDumperBase
	// массив включаемых элементов (папок), но исключаются все форвард декларированные элементы без
	// учета ранней форвард деклорации (W). Кроме того, в место элементов НЕ имеющих выходных файлов,
	// в список попадают, их родители (рекурсивно) имеющие таковые
	virtual AbstractDumperBase::ADList* get_nsf_includes () const;

	// implemented method from AbstractDumperBase
	// массив родительских элементов
	// Первым элементов в массиве является ближайший родитель
	virtual AbstractDumperBase::ADList* get_parents () const;

	// implemented method from AbstractDumperBase
	// массив реализуемых элементов (которые реализует текущий)
	virtual AbstractDumperBase::ADList* get_realizations () const;

	// implemented method from AbstractDumperBase
	// массив объектов реализующих данный
	virtual AbstractDumperBase::ADList* get_realizator () const;

	// implemented method from AbstractDumperBase
	// массив объектов наследующихся от данного (рекурсивно)
	virtual AbstractDumperBase::ADList* get_req_generalizator () const;

	// implemented method from AbstractDumperBase
	// массив объектов реализующих данный (рекурсивно)
	virtual AbstractDumperBase::ADList* get_req_realizator () const;

	// implemented method from AbstractDumperBase
	// ВСЕ элементы которые используют текущий (циклически)
	virtual AbstractDumperBase::ADList* get_requrcive_all_consumers () const;

	// implemented method from AbstractDumperBase
	// возвращает рекурсивно список элементов, от которых зависит данный
	virtual AbstractDumperBase::ADList* get_reqursive_dependences () const;

	// implemented method from AbstractDumperBase
	// массив элементов последовательности вызовов (для операций)
	virtual AbstractDumperBase::ADList* get_sequences () const;

	// implemented method from AbstractDumperBase
	// массив элементов являющихся set-исключениями для атрибутов
	virtual AbstractDumperBase::ADList* get_set_exceptions () const;

	// implemented method from AbstractDumperBase
	// массив объектов использующих данный в качестве своих атрибутов
	virtual AbstractDumperBase::ADList* get_source () const;

	// implemented method from AbstractDumperBase
	// возвращает стереотип элемента
	virtual const std::string get_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// возвращает цель
	virtual AbstractDumperBase* get_target () const;

	// implemented method from AbstractDumperBase
	// возвращает "true", если элемент фиксированного размера
	virtual const std::string get_type_fixed_size_str () const;

	// implemented method from AbstractDumperBase
	// имеет ли зарегистрированного родителя
	virtual bool has_registred_parent () const;

	// implemented method from AbstractDumperBase
	// определяет имеет ли элемент собственный поток вывода
	virtual bool own_output () const;

	// implemented method from AbstractDumperBase
	// возвращает родителя
	virtual AbstractDumperBase* parent () const;
protected:

	// implemented method from ObjectTreeResolver
	// возвращает вес форвард декларации
	virtual long get_fwd_weight () const;

	// implemented method from ObjectTreeResolver
	// возвращает true, если элемент нельяз форвард декларировать
	virtual bool is_forbiden_forward_dcl () const;

//#UC START# *4571A2CB02DE*
public:
	typedef std::map<const AbstractDumper*, bool> IsFixedTypeMap;
	static IsFixedTypeMap s_is_fixed_type_map;
	
	//функции, кэш, которых НУЖНО чистить при начале генерации
	enum CleanOnStartFunctionsType {
		FT_GET_ALL_CONTENTS
		, FT_GET_CONTENTS
		, FT_GET_SORTED_CHILDS
		, FT_GET_DERIVED_OVER
		, FT_GET_DERIVED_IMPL
		, FT_GET_NOT_DERIVED_ABSTRACT
	};

	//функции, кэш, которых не нужно чистить при начале генерации
	enum FunctionsType {
		FT_GET_PARENTS
		, FT_GET_ALL_CONSUMERS		
		, FT_GET_ALL_EQUALS_NAME
		, FT_GET_ALL_INCLUDES
		, FT_GET_DEPENDENCES
		, FT_GET_FORWARDED
		, FT_GET_GENERALIZATIONS
		, FT_GET_GENERALIZATOR
		, FT_GET_GET_EXCEPTIONS
		, FT_GET_INCLUDES
		, FT_GET_NESTED_BOTOM_CONSUMERS
		, FT_GET_NESTED_GENERALIZATIONS
		, FT_GET_NESTED_REALIZATIONS
		, FT_GET_NESTED_TOP_SUPPLIERS
		, FT_GET_NSF_FORWARDED
		, FT_GET_REALIZATIONS
		, FT_GET_REALIZATOR
		, FT_GET_REQ_GENERALIZATOR
		, FT_GET_REQURCIVE_ALL_CONSUMERS
		, FT_GET_REQURSIVE_DEPENDENCES
		, FT_GET_SET_EXCEPTIONS
		, FT_GET_SOURCE
		, FT_GET_NSF_INCLUDES
		, FT_GET_REQ_REALIZATOR
	};

	typedef std::map<std::pair<const AbstractDumperBase*, size_t>, AbstractDumperBase::ADList> FunctionsCache;	
	static FunctionsCache s_functions_cache;

	//кэш функций, который ОБЯЗАТЕЛЬНО нужно почистить при пересортировыке графа
	typedef std::map<std::pair<const AbstractDumperBase*, CleanOnStartFunctionsType>, AbstractDumperBase::ADList> CleanOnStartFunctionsCache;
	static CleanOnStartFunctionsCache s_clean_on_start_list_functions_cache;
public:
	//static methods


	void init (const AbstractDumper* parent );

	virtual void add_sequence (ADVector aads);
	virtual bool is_type_fixed_size () const;
	virtual void collect_include (OTRSet& col) const;
	virtual void collect_all_include (OTRSet& col) const;
	
	virtual std::ostream* get_output () const;

	void collect_reqursive_dependences (OTRSet& res) const;
	void collect_reqursive_generalization (OTRSet& res) const;	
	void collect_requrcive_all_consumers (OTRSet& col) const;

	void add_diagram(AbstractDumperBase* ad);
	
	bool is_child_of (const AbstractDumperBase* parent) const;
	bool is_it_registred_supplied_by (const ObjectTreeResolver* supplier) const;

	std::string file_name () const;
	const std::string temp_file_name () const;

protected:
	void check_perent_st_constraint () const;
	void own_output (bool oo);
	std::ostream* output () const;	
	virtual void clean_forward ( OTRSet& scope);

	virtual AbstractDumper::ADList* get_sorted_childs () const;
	AbstractDumperBase::ADList* get_req_generalizator_impl () const;
private:
	struct OutputDesc {
		std::string file_name;
		std::string temp_file_name;
		std::ostream* file;
		bool own_output;
		unsigned intend;
		bool is_plain;

		OutputDesc ()  {
			file = NULL;
			own_output = false;
			intend = 0;
			is_plain = false;
		}
	};
	typedef std::map <GenID, OutputDesc> OutputMap;

protected:
	static void log_mem_info (const std::string& prefix);

	mutable OutputMap m_outputs;
	ADVector m_activity_seq;
	ADList m_diagrams;

protected:
	unsigned intend () const;
	void inc_intend ();
	void dec_intend ();
//#UC END# *4571A2CB02DE*
}; // class AbstractDumper



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

