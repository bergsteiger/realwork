////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseOverridenElementDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseOverridenElementDumper
//
// демпер для переопределяемого элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEOVERRIDENELEMENTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEOVERRIDENELEMENTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"


// демпер для переопределяемого элемента
class RoseOverridenElementDumper;
typedef Core::Var<RoseOverridenElementDumper> RoseOverridenElementDumper_var;
typedef Core::Var<const RoseOverridenElementDumper> RoseOverridenElementDumper_cvar;

class RoseOverridenElementDumper :
	virtual public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseOverridenElementDumper)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// блок констант
	static const std::string OWNER_VAR_ID; // идентификатор переменной, обозначающий владельца переопределенного элемента (владелец - элемент, который собствено переопределяет/реализует этот элемент)

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// создает враппер на основе реального дампера сохраненного состояния переопределенного элемента
	RoseOverridenElementDumper (
		const RoseAbstractDumper* from
		, const InheritedItem* state
		, const RoseAbstractDumper* owner
	);

public:
	virtual ~RoseOverridenElementDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void update (const RoseAbstractDumper* from, const InheritedItem* state);

private:
	virtual RoseAbstractDumper* get_wrapped_object ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// элемент, над которым обертка
	RoseAbstractDumper* m_wrapped_object;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	virtual const RoseAbstractDumper* get_wrapped_object () const;

	virtual void set_wrapped_object (RoseAbstractDumper* wrapped_object);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// возвращает класс
	virtual const std::string get_model_class_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumper
	// возвращает true, если использование стереотипа разрешено правилами родителя, иначе false
	virtual bool check_stereotype_use () const;

	// overloaded method from AbstractDumper
	// Начинает генерацию, от данного узла
	virtual void dump_start () const;

	// overloaded method from AbstractDumper
	// заполняет кэш флагов генерит ли элемент собственный файл
	virtual void prepare_output_cache () const;

	// overloaded method from AbstractDumperBase
	// добавляет юзер секцию
	virtual void add_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
		, const AbstractDumperBase::UserCode& uc
	) const;

	// overloaded method from AbstractDumperBase
	// зарегистрирован или нет
	virtual bool am_i_registred () const;

	// overloaded method from AbstractDumperBase
	// очищаем список связанных элементов
	virtual void clear_var_dumpers (AbstractDumperBase::LocalVarType type) const;

	// overloaded method from AbstractDumperBase
	// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
	// items - коллекция элементов даграммы, для формирования навигационной мапы
	// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

	// overloaded method from AbstractDumperBase
	// порядковый номер элемента (устанавливается ОДИН раз при построении дерева генерации и хранится
	// в модели)
	virtual unsigned long long elem_creation_order () const;

	// overloaded method from AbstractDumperBase
	// порядковый номер элемента (устанавливается при построении дерева генерации)
	virtual unsigned int elem_order () const;

	// overloaded method from AbstractDumperBase
	// regular/abstract/final - тип абстрактности элемента.
	virtual const std::string get_abstract_str () const;

	// overloaded method from AbstractDumperBase
	// ВСЕ элементы которые используют текущий
	virtual AbstractDumperBase::ADList* get_all_consumers () const;

	// overloaded method from AbstractDumperBase
	// массив всех вложенных элементов (рекурсивно)
	virtual AbstractDumperBase::ADList* get_all_contents () const;

	// overloaded method from AbstractDumperBase
	// Возвращает список элементов,  у которых имя совпадает с текущим элементом
	virtual AbstractDumperBase::ADList* get_all_equals_name () const;

	// overloaded method from AbstractDumperBase
	// массив всех включаемых элементов (папок) рекурсивно
	virtual AbstractDumperBase::ADList* get_all_includes () const;

	// overloaded method from AbstractDumperBase
	// возвращает список разрешенных генераторов
	virtual AbstractDumperBase::Selections* get_applied_gens () const;

	// overloaded method from AbstractDumperBase
	// авто инкрементирующийся счетчик на элементе.
	virtual const std::string get_auto_counter_str () const;

	// overloaded method from AbstractDumperBase
	// вид элемента
	virtual const std::string get_class_kind_str () const;

	// overloaded method from AbstractDumperBase
	// массив вложенных элементов
	virtual AbstractDumperBase::ADList* get_contents () const;

	// overloaded method from AbstractDumperBase
	// возвращает список элементов, от которых зависит данный
	virtual AbstractDumperBase::ADList* get_dependences () const;

	// overloaded method from AbstractDumperBase
	// массив реализующих методов и\или атрибутов (реализуемых данным элементом относительно
	// абстрактных членов своих базовых классов)
	virtual AbstractDumperBase::ADList* get_derived_impl () const;

	// overloaded method from AbstractDumperBase
	// массив перегруженных методов и\или атрибутов (перегруженных данным элементом относительно своих
	// базовых классов)
	virtual AbstractDumperBase::ADList* get_derived_over () const;

	// overloaded method from AbstractDumperBase
	// массив диаграмм
	virtual AbstractDumperBase::ADList* get_diagrams () const;

	// overloaded method from AbstractDumperBase
	// получение докуентации к элементу
	virtual const std::string get_documentation_str () const;

	// overloaded method from AbstractDumperBase
	// массив элементов, которые необходимо forward-декларировать для текущего элемента.
	virtual AbstractDumperBase::ADList* get_forwarded () const;

	// overloaded method from AbstractDumperBase
	// массив базовых элементов (от которых унаследован текущий)
	virtual AbstractDumperBase::ADList* get_generalizations () const;

	// overloaded method from AbstractDumperBase
	// массив объектов наследующихся от данного
	virtual AbstractDumperBase::ADList* get_generalizator () const;

	// overloaded method from AbstractDumperBase
	// массив элементов являющихся исключениями для операций  или get-исключениями для атрибутов
	virtual AbstractDumperBase::ADList* get_get_exceptions () const;

	// overloaded method from AbstractDumperBase
	// возвращает COM GUID
	virtual const std::string get_guid_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает имя файла с изображением, связанного с элементом
	virtual const std::string get_image_file () const;

	// overloaded method from AbstractDumperBase
	// массив включаемых элементов (папок)
	// Включаемые папки определяются на основе зависимостей элемента. Если элемент или его вложенные
	// части используют как-либо (наследуется, реализует, имеет атрибуты данного типа и т.д.) другой
	// элемент, то папка, в которой содержится используемый элемент, попадет в список зависимости. Из
	// результирующего списка исключаются элементы попавшие в форвард-декларирование (F)
	virtual AbstractDumperBase::ADList* get_includes () const;

	// overloaded method from AbstractDumperBase
	// возвращает дампер для вывода значения по-умолчанию
	virtual AbstractDumperBase* get_initial_value () const;

	// overloaded method from AbstractDumperBase
	// значение по умолчанию (для атрибутов и аргументов операции)
	virtual const std::string get_initial_value_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает строку для сдвига
	virtual const std::string get_intend_str (short intend_shift) const;

	// overloaded method from AbstractDumperBase
	// возвращает ГУИД, который используется при создании навигационной мапы диаграммы
	virtual const std::string get_link_guid () const;

	// overloaded method from AbstractDumperBase
	// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
	virtual const std::string get_link_type_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает мэйн элемент
	virtual AbstractDumperBase* get_main_element () const;

	// overloaded method from AbstractDumperBase
	// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает GUID элемента
	virtual const std::string& get_model_unique_id_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает имя
	virtual const std::string get_name_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает native-путь к элементу, прописанный в настройках
	virtual const std::string get_native_path_str () const;

	// overloaded method from AbstractDumperBase
	// все элементы которые используют без учета форвард-декларирования данный (циклически) в одном
	// пакете
	virtual AbstractDumperBase::ADList* get_nested_botom_consumers () const;

	// overloaded method from AbstractDumperBase
	// массив всех (рекурсивно) базовых элементов (от которых унаследован текущий)
	virtual AbstractDumperBase::ADList* get_nested_generalizations () const;

	// overloaded method from AbstractDumperBase
	// массив всех (рекурсивно) реализуемых элементов (которые реализует текущий)
	virtual AbstractDumperBase::ADList* get_nested_realizations () const;

	// overloaded method from AbstractDumperBase
	// все элементы которые используются без учета форвард-декларирования данным (циклически) в одном
	// пакете
	virtual AbstractDumperBase::ADList* get_nested_top_suppliers () const;

	// overloaded method from AbstractDumperBase
	// возвращает список абстрактных операций/атрибутов базовых или реализуемых классов, который НЕ
	// реализует данный элемент
	virtual AbstractDumperBase::ADList* get_not_implemented_derived_abstract () const;

	// overloaded method from AbstractDumperBase
	// то же что и Forwarded но без исключения элементов декларированных выше в предполагаемой (в
	// области пакета) видимости
	virtual AbstractDumperBase::ADList* get_nsf_forwarded () const;

	// overloaded method from AbstractDumperBase
	// массив включаемых элементов (папок), но исключаются все форвард декларированные элементы без
	// учета ранней форвард деклорации (W). Кроме того, в место элементов НЕ имеющих выходных файлов,
	// в список попадают, их родители (рекурсивно) имеющие таковые
	virtual AbstractDumperBase::ADList* get_nsf_includes () const;

	// overloaded method from AbstractDumperBase
	// возвращает кодировку, с которой должен генерится файл
	virtual GCL::code_t get_output_coding () const;

	// overloaded method from AbstractDumperBase
	// возвращает ID страницы в конфлюенсе
	virtual const std::string get_page_id () const;

	// overloaded method from AbstractDumperBase
	// возвращает путь страницы, прописанный в свйоствах элемента
	virtual const std::string get_page_path () const;

	// overloaded method from AbstractDumperBase
	// массив родительских элементов
	// Первым элементов в массиве является ближайший родитель
	virtual AbstractDumperBase::ADList* get_parents () const;

	// overloaded method from AbstractDumperBase
	// массив реализуемых элементов (которые реализует текущий)
	virtual AbstractDumperBase::ADList* get_realizations () const;

	// overloaded method from AbstractDumperBase
	// массив объектов реализующих данный
	virtual AbstractDumperBase::ADList* get_realizator () const;

	// overloaded method from AbstractDumperBase
	// массив объектов наследующихся от данного (рекурсивно)
	virtual AbstractDumperBase::ADList* get_req_generalizator () const;

	// overloaded method from AbstractDumperBase
	// массив объектов реализующих данный (рекурсивно)
	virtual AbstractDumperBase::ADList* get_req_realizator () const;

	// overloaded method from AbstractDumperBase
	// ВСЕ элементы которые используют текущий (циклически)
	virtual AbstractDumperBase::ADList* get_requrcive_all_consumers () const;

	// overloaded method from AbstractDumperBase
	// возвращает рекурсивно список элементов, от которых зависит данный
	virtual AbstractDumperBase::ADList* get_reqursive_dependences () const;

	// overloaded method from AbstractDumperBase
	// значение рутовой дирректории для генерации
	virtual const std::string get_root_dir (bool direct_get) const;

	// overloaded method from AbstractDumperBase
	// возвращает информацию о ранее сгенерированном файле
	virtual AbstractDumperBase::GenSourceInfo* get_self_generated_source () const;

	// overloaded method from AbstractDumperBase
	// массив элементов последовательности вызовов (для операций)
	virtual AbstractDumperBase::ADList* get_sequences () const;

	// overloaded method from AbstractDumperBase
	// массив элементов являющихся set-исключениями для атрибутов
	virtual AbstractDumperBase::ADList* get_set_exceptions () const;

	// overloaded method from AbstractDumperBase
	// массив объектов использующих данный в качестве своих атрибутов
	virtual AbstractDumperBase::ADList* get_source () const;

	// overloaded method from AbstractDumperBase
	// возвращает тип сгенерированного артефакта
	virtual AbstractDumperBase::GenSourceType get_source_type () const;

	// overloaded method from AbstractDumperBase
	// возвращает стереотип элемента
	virtual const std::string get_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает цель
	virtual AbstractDumperBase* get_target () const;

	// overloaded method from AbstractDumperBase
	// стереотип «цели» (const, var, ...)
	virtual const std::string get_target_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает "true", если элемент фиксированного размера
	virtual const std::string get_type_fixed_size_str () const;

	// overloaded method from AbstractDumperBase
	// получить юзер секцию
	virtual const AbstractDumperBase::UserCode get_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
	) const;

	// overloaded method from AbstractDumperBase
	// выводит значение пользовательского свойства «prop_name»
	virtual const std::string get_user_property_str (const std::string& prop_name) const;

	// overloaded method from AbstractDumperBase
	// возвращает дампер по id-шнику, связанные с элементом
	virtual const AbstractDumperBase* get_var_dumper (const std::string& var_id) const;

	// overloaded method from AbstractDumperBase
	// строка определяющая видимость элемента.
	// Может принимать значения: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
	virtual const std::string get_visability_str () const;

	// overloaded method from AbstractDumperBase
	// имеет ли зарегистрированного родителя
	virtual bool has_registred_parent () const;

	// overloaded method from AbstractDumperBase
	// возвращает true, если элемент был изменён (используется дл определения того, что диаграмма была
	// изменена)
	virtual bool is_changed () const;

	// overloaded method from AbstractDumperBase
	// возвращает true, если страница для элемента может быть Home - страницей, иначе - false
	virtual bool is_home () const;

	// overloaded method from AbstractDumperBase
	// определяет имеет ли элемент собственный поток вывода
	virtual bool own_output () const;

	// overloaded method from AbstractDumperBase
	// возвращает родителя
	virtual AbstractDumperBase* parent () const;

	// overloaded method from AbstractDumperBase
	// удаляет из модели информацию об ранее сгенерированном источнике артефакта, возвращает true в
	// случае успеха.
	virtual bool remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// overloaded method from AbstractDumperBase
	// сбрасывает информацию об изменённости
	virtual void reset_changed () const;

	// overloaded method from AbstractDumperBase
	// Вызывает внешний обработчик измененного файла
	virtual void run_post_command () const;

	// overloaded method from AbstractDumperBase
	// записывает на модели информацию о сгенерированном файле, возвращает true в случае успеха.
	virtual bool set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// overloaded method from AbstractDumperBase
	// устанавливает дампер по id-шнику, связанный с элементом
	virtual void set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) const;

	// overloaded method from AbstractDumperBase
	// логирование ошибок в шаблоне
	virtual void write_template_error_log (const char* log) const;

	// overloaded method from AbstractDumperBase
	// логирование предупреждений
	virtual void write_template_warning_log (const char* log) const;

	// overloaded method from AbstractLogger
	// метод для логирования ошибок
	virtual void write_error_log (const std::string& mess, bool fatal) const;

	// overloaded method from AbstractLogger
	// логирование информационных сообщений
	virtual void write_info_log (const std::string& mess) const;

	// overloaded method from AbstractLogger
	// логирование предупреждений
	virtual void write_warning_log (const std::string& mess) const;

	// overloaded method from ObjectTreeResolver
	// возвращает список элементов от которых зависит данный, список без дубликатов
	virtual void collect_suppliers_by_type (
		ObjectTreeResolver::SupplierType type
		, ObjectTreeResolver::OTRVector& collection
	) const;

	// overloaded method from ObjectTreeResolver
	// рекурсивно формирует список элементов от которых зависит данный, список без дубликатов
	virtual void collect_suppliers_by_type_recursive (
		ObjectTreeResolver::SupplierType type
		, ObjectTreeResolver::OTRVector& collection
	) const;

	// overloaded method from ObjectTreeResolver
	// сравнивнение элементов дерева
	virtual int compare (const ObjectTreeResolver* od) const;

	// overloaded method from ObjectTreeResolver
	// возвращает true, если элемент виден из любого места модели, например лежит в глобальном пакете
	virtual bool is_global_visible () const;

	// overloaded method from ObjectTreeResolver
	// является ли obj supplier'ем с заданным стереотипом
	virtual bool is_supplier_with_stereotype (const ObjectTreeResolver* obj, const std::string& stereotype) const;

	// overloaded method from ObjectTreeResolver
	// связывает с элементом всех supplier
	virtual void link_suppliers ();

	// overloaded method from ObjectTreeResolver
	// разрывает связь заданного типа и заданного стереотипа
	virtual void remove_supplier (
		const ObjectTreeResolver* supplier
		, ObjectTreeResolver::SupplierType type
		, const std::string& stereotype
	);

	// overloaded method from ObjectTreeResolver
	// Алгоритм простановки связей между родителями элементов source и target
	virtual void set_dependencies (
		const ObjectTreeResolver* target
		, const ObjectTreeResolver::AddDependencyFunctor& add_dep
	) const;

	// overloaded method from RoseAbstractDumper
	// копирует временные свойства с заданного элемента
	virtual void copy_temporary_properties_from (const RoseAbstractDumper* rad);

	// overloaded method from RoseAbstractDumper
	// возвращает знечение свойства - сначала ищет во временном хранилище, а затем в модели
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name) const;

	// overloaded method from RoseAbstractDumper
	// сбрасывает закэшированный model stereotype
	virtual void reset_model_stereotype ();

	// overloaded method from RoseAbstractDumper
	// записать свойство во временное хранилище
	virtual bool set_temporary_property (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	) const;

	// overloaded method from RoseAbstractDumper
	// метод вызывается, когда нужно обновить, закэшированные на дампере значения атрибутов
	virtual void update_cached_attrs () const;
protected:

	// overloaded method from AbstractDumper
	// инициирует удаление элемента из кэшей
	virtual void delete_from_cache () const;

	// overloaded method from AbstractDumper
	// метод вызываемые на каждом элементе перед запуском спела)
	virtual void spell_generation_prepare ();

	// overloaded method from AbstractDumperBase
	// добавить элемент для отложенного dump'а
	virtual void add_dumper_for_delay_dump (const AbstractDumperBase* adb) const;

	// overloaded method from AbstractDumperBase
	// возвращает true, если элемент можно "дампить"
	virtual bool can_dump () const;

	// overloaded method from AbstractDumperBase
	// возвращает информацию об тех файлах которые были сгенерированны
	// ранее, а теперь "исчезли" из списка генерации. Т.е. о тех файлы,
	// который фактически удалились из репазитария
	virtual AbstractDumperBase::GenSourceInfoSet* get_deleted_child_generated_source () const;

	// overloaded method from AbstractDumperBase
	// возвращает список лэйблов (меток) соответствующих стереотипу
	virtual GCL::StrSet* get_labels () const;

	// overloaded method from Base::NamedElement
	// возвращает полное имя элемента
	virtual const std::string get_full_name () const;

	// overloaded method from ObjectTreeResolver
	// уровень видимости детей, если -1 - значит уровень не задан
	virtual int get_childs_visibility_level () const;

	// overloaded method from ObjectTreeResolver
	// возвращает вес форвард декларации
	virtual long get_fwd_weight () const;

	// overloaded method from ObjectTreeResolver
	// возвращает true, если элемент нельяз форвард декларировать
	virtual bool is_forbiden_forward_dcl () const;

	// overloaded method from ObjectTreeResolver
	// Сортируется ли элементы в порядке создания (в порядке указания на модели) - такие элементы не
	// нужно помещать в граф.
	virtual bool sort_in_model_order () const;
private:

	// overloaded method from AbstractDumper
	// Закрывает выходной поток и "обрезает" выходной файл до нужного размера (т.к в конце потока
	// может находится мусор)
	virtual void close_output (std::ofstream& file) const;

	// overloaded method from AbstractDumper
	// Пост-обработка сгенерированного файла:
	// заменяет символ переноса строки (если это необходимо) на тот, что прописан в шаблоне
	// стереотипа. file_path - путь к файлу, в котором нужно провести изменения, также конвертит файл
	// в нужную кодировку
	virtual void file_post_process (const std::string& file_path) const;

	// overloaded method from ObjectTreeResolver
	// Cвойство локальной глобальности - если у пакета выставлено такое свойство, то считается, всем
	// пакетам - соседям доступны элементы из него и его детям доступны элементы соседей, т.е как буд-
	// то между ними протянута связь в обе стороны
	virtual bool is_global_locally () const;

}; // class RoseOverridenElementDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEOVERRIDENELEMENTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

