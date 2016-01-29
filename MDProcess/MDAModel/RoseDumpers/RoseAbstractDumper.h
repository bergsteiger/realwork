////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractDumper
//
// базовый дампер для всех элементов модели Розы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "shared/Core/data/unsorted_containers.h"
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/Base/Base.h"

//#UC START# *4571D1A5009C_CUSTOM_INCLUDES*
//#UC END# *4571D1A5009C_CUSTOM_INCLUDES*

// forward decls for defined friends
	class RoseOverridenElementDumper;



class RoseOverridenElementDumper;
// базовый дампер для всех элементов модели Розы
class RoseAbstractDumper;
typedef Core::Var<RoseAbstractDumper> RoseAbstractDumper_var;
typedef Core::Var<const RoseAbstractDumper> RoseAbstractDumper_cvar;

class RoseAbstractDumper :
	public AbstractDumper
{
	SET_OBJECT_COUNTER (RoseAbstractDumper)
	friend class RoseOverridenElementDumper; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// Врапер над КОМ-овским объектом для помещения егшо в stl-вектор
	struct IRoseItemWrapper {
		// COM-объект
		IRoseItemPtr m_rose_item;

		IRoseItemWrapper (IRoseItemPtr m_rose_item_);
	};

	// Диалог выбора элмента при необнозначности имени
	class IChoiceDlg {
	// virtual void destructor
	public:
		virtual ~IChoiceDlg () {};

	//////////////////////////////////////////////////////////////////////////////////////////
	// abstarct methods
	public:
		// выполнить выбор конкретного элемента
		virtual const std::string make_choice (const GCL::StrSet& ch_list, const std::string& for_item_name) = 0;

	}; // class IChoiceDlg

	// Класс-фабрика создающий конкретный Dumper объект для класса по его стереотипу
	class DumpersFactory {
	// virtual void destructor
	public:
		virtual ~DumpersFactory () {};

	//////////////////////////////////////////////////////////////////////////////////////////
	// abstarct methods
	public:
		// проверяет правильность указания стереотип, возвращает true, если все хорошо, иначе false
		virtual bool check_stereotype (IRoseElementPtr elem) const = 0;

		// создает дампер как рутовый элемент
		virtual RoseAbstractDumper* create_by_root (IRoseItemPtr cls) = 0;

		// создать дампер на основе родителя и розовского элмента
		virtual RoseAbstractDumper* create_by_stereotype (const RoseAbstractDumper* parent, IRoseElementPtr cls) = 0;


	//#UC START# *4571E05D02EE*
	//#UC END# *4571E05D02EE*
	}; // class DumpersFactory

	// вектор розовских элементов
	typedef std::vector < IRoseItemWrapper > IRoseItemPtr_vector;

	// список дамперов
	typedef std::vector < const RoseAbstractDumper* > RADVector;

	// множжество элементов
	typedef boost::unordered_set <const RoseAbstractDumper*> UnorderedRADSet;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// находит элемент в дереве по его UID
	static RoseAbstractDumper* find_in_tree (const std::string& uid);

	// возвращает true, если модель генерации построена
	static bool is_model_tree_initialized ();

	// создает экземпляр дампера-обертки, связывая его с владельцем (with_owner)
	static RoseAbstractDumper& make_overriden_wrapper (const RoseAbstractDumper* from, const InheritedItem* state, const RoseAbstractDumper* with_owner);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// копирует временные свойства с заданного элемента
	virtual void copy_temporary_properties_from (const RoseAbstractDumper* rad);

	// возвращает знечение свойства - сначала ищет во временном хранилище, а затем в модели
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name) const;

	// сбрасывает закэшированный model stereotype
	virtual void reset_model_stereotype ();

	// записать свойство во временное хранилище
	virtual bool set_temporary_property (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	) const;

	// метод вызывается, когда нужно обновить, закэшированные на дампере значения атрибутов
	virtual void update_cached_attrs () const;

private:
	// Добавляет обертку, связывая ее с владельцем, таким образом обеспечивается гарантия, что для
	// одного элемента, который переопределяет (или реализует) другой элемент существует только одна
	// обертка (т.е они не пложятся бесконтрольно)
	void add_wrapper (RoseOverridenElementDumper* wrapper, const RoseAbstractDumper* for_owner);

	// возвращает обертку, связанную с владельцем, если обертки не найдено - возвращает 0
	const RoseOverridenElementDumper* get_wrapper (const RoseAbstractDumper* for_owner) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// порядковый номер элемента при его создании
	unsigned long long m_creation_order;

	// документация элемента
	mutable std::string m_documentation;

	IRoseElementPtr m_rose_element;

	// временное хранилище свойств
	mutable Base::ToolPropertyMap m_temporary_properties;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_documentation () const;

	void set_documentation (const std::string& documentation) const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// добавляет юзер секцию
	virtual void add_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
		, const AbstractDumperBase::UserCode& uc
	) const;

	// implemented method from AbstractDumperBase
	// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
	// items - коллекция элементов даграммы, для формирования навигационной мапы
	// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

	// implemented method from AbstractDumperBase
	// возвращает список разрешенных генераторов
	virtual AbstractDumperBase::Selections* get_applied_gens () const;

	// implemented method from AbstractDumperBase
	// авто инкрементирующийся счетчик на элементе.
	virtual const std::string get_auto_counter_str () const;

	// implemented method from AbstractDumperBase
	// массив реализующих методов и\или атрибутов (реализуемых данным элементом относительно
	// абстрактных членов своих базовых классов)
	virtual AbstractDumperBase::ADList* get_derived_impl () const;

	// implemented method from AbstractDumperBase
	// массив перегруженных методов и\или атрибутов (перегруженных данным элементом относительно своих
	// базовых классов)
	virtual AbstractDumperBase::ADList* get_derived_over () const;

	// implemented method from AbstractDumperBase
	// получение докуентации к элементу
	virtual const std::string get_documentation_str () const;

	// implemented method from AbstractDumperBase
	// возвращает COM GUID
	virtual const std::string get_guid_str () const;

	// implemented method from AbstractDumperBase
	// значение по умолчанию (для атрибутов и аргументов операции)
	virtual const std::string get_initial_value_str () const;

	// implemented method from AbstractDumperBase
	// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// возвращает GUID элемента
	virtual const std::string& get_model_unique_id_str () const;

	// implemented method from AbstractDumperBase
	// возвращает имя
	virtual const std::string get_name_str () const;

	// implemented method from AbstractDumperBase
	// возвращает native-путь к элементу, прописанный в настройках
	virtual const std::string get_native_path_str () const;

	// implemented method from AbstractDumperBase
	// возвращает список абстрактных операций/атрибутов базовых или реализуемых классов, который НЕ
	// реализует данный элемент
	virtual AbstractDumperBase::ADList* get_not_implemented_derived_abstract () const;

	// implemented method from AbstractDumperBase
	// возвращает ID страницы в конфлюенсе
	virtual const std::string get_page_id () const;

	// implemented method from AbstractDumperBase
	// возвращает путь страницы, прописанный в свйоствах элемента
	virtual const std::string get_page_path () const;

	// implemented method from AbstractDumperBase
	// значение рутовой дирректории для генерации
	virtual const std::string get_root_dir (bool direct_get) const;

	// implemented method from AbstractDumperBase
	// возвращает информацию о ранее сгенерированном файле
	virtual AbstractDumperBase::GenSourceInfo* get_self_generated_source () const;

	// implemented method from AbstractDumperBase
	// стереотип «цели» (const, var, ...)
	virtual const std::string get_target_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// получить юзер секцию
	virtual const AbstractDumperBase::UserCode get_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
	) const;

	// implemented method from AbstractDumperBase
	// выводит значение пользовательского свойства «prop_name»
	virtual const std::string get_user_property_str (const std::string& prop_name) const;

	// implemented method from AbstractDumperBase
	// строка определяющая видимость элемента.
	// Может принимать значения: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
	virtual const std::string get_visability_str () const;

	// implemented method from AbstractDumperBase
	// удаляет из модели информацию об ранее сгенерированном источнике артефакта, возвращает true в
	// случае успеха.
	virtual bool remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// implemented method from AbstractDumperBase
	// записывает на модели информацию о сгенерированном файле, возвращает true в случае успеха.
	virtual bool set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// implemented method from ObjectTreeResolver
	// связывает с элементом всех supplier
	virtual void link_suppliers ();
protected:

	// implemented method from AbstractDumperBase
	// возвращает информацию об тех файлах которые были сгенерированны
	// ранее, а теперь "исчезли" из списка генерации. Т.е. о тех файлы,
	// который фактически удалились из репазитария
	virtual AbstractDumperBase::GenSourceInfoSet* get_deleted_child_generated_source () const;

	// implemented method from Base::NamedElement
	// возвращает полное имя элемента
	virtual const std::string get_full_name () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// очищаем список связанных элементов
	virtual void clear_var_dumpers (AbstractDumperBase::LocalVarType type) const;

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
	// возвращает тип сгенерированного артефакта
	virtual AbstractDumperBase::GenSourceType get_source_type () const;

	// overloaded method from AbstractDumperBase
	// возвращает стереотип элемента
	virtual const std::string get_stereotype_str () const;
protected:

	// overloaded method from AbstractDumper
	// инициирует удаление элемента из кэшей
	virtual void delete_from_cache () const;

	// overloaded method from AbstractDumper
	// метод вызываемые на каждом элементе перед запуском спела)
	virtual void spell_generation_prepare ();

	// overloaded method from ObjectTreeResolver
	// уровень видимости детей, если -1 - значит уровень не задан
	virtual int get_childs_visibility_level () const;


//#UC START# *4571D1A5009C*
public:
	//static methods
	static const RoseAbstractDumper& get_model_tree_root (bool auto_spell = true);
	static void reset_model_tree_root ();
	static void lock_reset ();
	static void unlock_reset ();

private:
	static RoseAbstractDumper* s_model_tree_root;
	static RoseAbstractDumper* s_void_rad;
	static unsigned s_lock_reset;
	static bool s_attempt_reset_while_locked;

public:
	class auto_locker {
	public:
		auto_locker () {
			RoseAbstractDumper::lock_reset();
		}

		~auto_locker () {
			RoseAbstractDumper::unlock_reset();
		}
	};

	typedef std::list<const RoseAbstractDumper*> RADList;
	
	class IMissedGenFileDlg {
	public:
		virtual bool do_remove (const std::string& file_name) = 0;
	};

public:
	static void set_choice_dlg (IChoiceDlg* dlg);
	static void set_missed_gen_file_dlg (IMissedGenFileDlg* dlg);
	static RADList& global_cats();
	static DumpersFactory* dump_factory();	
	static void set_dumper_factory (DumpersFactory* factory);

	static RoseAbstractDumper* find_in_tree (IRoseElementPtr item);	
	static void reset_all ();

private:	
	static IMissedGenFileDlg* s_missed_gen_file_dlg;
	static IChoiceDlg* s_choice_dlg;
	static DumpersFactory* s_dump_factory;
	static RADList s_global_cats;
	static unsigned s_current_elem_order;

public:	
	bool operator == (const AbstractDumperBase& c) const;
	
	//ищет элемент-класс по его строковому представлению
	const RoseAbstractDumper* resolve (std::string& type) const;
		
	IRoseElementPtr rose_element () const;

	virtual VisibilityType get_visibility_type () const;
	static void force_applied_gens_to_all (bool set);

	void fill_sequence_data ();
	bool RoseAbstractDumper::is_native (bool& wilth_parent) const;
	
	// конструктор - в нем выполняется добавление элемента в дерево parent
	// - родительский элемент item - розовский элемент, связанный с элементом
	// дерева st - стереотип на модели
	RoseAbstractDumper (const RoseAbstractDumper* parent, IRoseElementPtr item, const AbstractDumperBase::StereotypeID& st = AbstractDumperBase::StereotypeID (""));
protected:
	virtual int compare (const ObjectTreeResolver* od) const;
	virtual const ObjectTreeResolver* get_parent_category () const;
	virtual const ObjectTreeResolver* get_nearest_container () const;
	virtual const ObjectTreeResolver* get_parent_container () const;

private:
	typedef std::string SeqId;
	struct MessTreeNode {
		SeqId id;
		IRoseMessagePtr mess;

		MessTreeNode (const SeqId a_id);
		MessTreeNode (const char* a_id);
		MessTreeNode (const SeqId a_id, IRoseMessagePtr a_mess);
		bool operator < (const MessTreeNode& c) const;

		struct Sort: public std::binary_function<const MessTreeNode, const MessTreeNode, bool> {
			bool operator()(const MessTreeNode* const x, const MessTreeNode* const y) const {
				return *x < *y;
			}
		};
	};
	typedef GCL::Tree<MessTreeNode> MessTree;

protected:
	mutable std::string m_model_unique_id;

private:
	//мапа оберток над элементом, каждая обертка связана с "владельцем", т.е объектом, который инициировал
	//создание этой обертки
	typedef std::map<const RoseAbstractDumper*, Core::Var<RoseOverridenElementDumper> > WrappersMap;
	WrappersMap m_wrappers;

	AbstractDumperBase::StereotypeID m_model_stereotype;
	
	mutable char m_is_native;
	mutable bool m_native_with_parent;

	unsigned m_elem_order;

	static bool s_force_applied_gens_to_all;

public:

	typedef std::map<const RoseAbstractDumper*, AbstractDumperBase::Selections> SelectionsMap;
	static SelectionsMap s_selections_map;
//#UC END# *4571D1A5009C*
}; // class RoseAbstractDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

