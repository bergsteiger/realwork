////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSingleDumperBase
//
// Базовый класс для "псевдо" дамперов - как правило эмулирующих элемент модели, а не являющихся им.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSINGLEDUMPERBASE_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSINGLEDUMPERBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"

//#UC START# *4571A32201A5_CUSTOM_INCLUDES*
//#UC END# *4571A32201A5_CUSTOM_INCLUDES*


// Базовый класс для "псевдо" дамперов - как правило эмулирующих элемент модели, а не являющихся им.
class AbstractSingleDumperBase;
typedef Core::Var<AbstractSingleDumperBase> AbstractSingleDumperBase_var;
typedef Core::Var<const AbstractSingleDumperBase> AbstractSingleDumperBase_cvar;

class AbstractSingleDumperBase :
	virtual public AbstractDumperBase
{
	SET_OBJECT_COUNTER (AbstractSingleDumperBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~AbstractSingleDumperBase ();


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
	// зарегистрирован или нет
	virtual bool am_i_registred () const;

	// implemented method from AbstractDumperBase
	// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
	// items - коллекция элементов даграммы, для формирования навигационной мапы
	// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

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
	// возвращает список разрешенных генераторов
	virtual AbstractDumperBase::Selections* get_applied_gens () const;

	// implemented method from AbstractDumperBase
	// авто инкрементирующийся счетчик на элементе.
	virtual const std::string get_auto_counter_str () const;

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
	// массив реализующих методов и\или атрибутов (реализуемых данным элементом относительно
	// абстрактных членов своих базовых классов)
	virtual AbstractDumperBase::ADList* get_derived_impl () const;

	// implemented method from AbstractDumperBase
	// массив перегруженных методов и\или атрибутов (перегруженных данным элементом относительно своих
	// базовых классов)
	virtual AbstractDumperBase::ADList* get_derived_over () const;

	// implemented method from AbstractDumperBase
	// массив диаграмм
	virtual AbstractDumperBase::ADList* get_diagrams () const;

	// implemented method from AbstractDumperBase
	// получение докуентации к элементу
	virtual const std::string get_documentation_str () const;

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
	// возвращает COM GUID
	virtual const std::string get_guid_str () const;

	// implemented method from AbstractDumperBase
	// массив включаемых элементов (папок)
	// Включаемые папки определяются на основе зависимостей элемента. Если элемент или его вложенные
	// части используют как-либо (наследуется, реализует, имеет атрибуты данного типа и т.д.) другой
	// элемент, то папка, в которой содержится используемый элемент, попадет в список зависимости. Из
	// результирующего списка исключаются элементы попавшие в форвард-декларирование (F)
	virtual AbstractDumperBase::ADList* get_includes () const;

	// implemented method from AbstractDumperBase
	// значение по умолчанию (для атрибутов и аргументов операции)
	virtual const std::string get_initial_value_str () const;

	// implemented method from AbstractDumperBase
	// возвращает строку для сдвига
	virtual const std::string get_intend_str (short intend_shift) const;

	// implemented method from AbstractDumperBase
	// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
	virtual const std::string get_link_type_str () const;

	// implemented method from AbstractDumperBase
	// возвращает класс
	virtual const std::string get_model_class_str () const;

	// implemented method from AbstractDumperBase
	// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// возвращает GUID элемента
	virtual const std::string& get_model_unique_id_str () const;

	// implemented method from AbstractDumperBase
	// возвращает native-путь к элементу, прописанный в настройках
	virtual const std::string get_native_path_str () const;

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
	// возвращает список абстрактных операций/атрибутов базовых или реализуемых классов, который НЕ
	// реализует данный элемент
	virtual AbstractDumperBase::ADList* get_not_implemented_derived_abstract () const;

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
	// возвращает ID страницы в конфлюенсе
	virtual const std::string get_page_id () const;

	// implemented method from AbstractDumperBase
	// возвращает путь страницы, прописанный в свйоствах элемента
	virtual const std::string get_page_path () const;

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
	// значение рутовой дирректории для генерации
	virtual const std::string get_root_dir (bool direct_get) const;

	// implemented method from AbstractDumperBase
	// возвращает информацию о ранее сгенерированном файле
	virtual AbstractDumperBase::GenSourceInfo* get_self_generated_source () const;

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
	// стереотип «цели» (const, var, ...)
	virtual const std::string get_target_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// возвращает "true", если элемент фиксированного размера
	virtual const std::string get_type_fixed_size_str () const;

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
	// имеет ли зарегистрированного родителя
	virtual bool has_registred_parent () const;

	// implemented method from AbstractDumperBase
	// определяет имеет ли элемент собственный поток вывода
	virtual bool own_output () const;

	// implemented method from AbstractDumperBase
	// возвращает родителя
	virtual AbstractDumperBase* parent () const;

	// implemented method from AbstractDumperBase
	// удаляет из модели информацию об ранее сгенерированном источнике артефакта, возвращает true в
	// случае успеха.
	virtual bool remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// implemented method from AbstractDumperBase
	// записывает на модели информацию о сгенерированном файле, возвращает true в случае успеха.
	virtual bool set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;
protected:

	// implemented method from AbstractDumperBase
	// возвращает информацию об тех файлах которые были сгенерированны
	// ранее, а теперь "исчезли" из списка генерации. Т.е. о тех файлы,
	// который фактически удалились из репазитария
	virtual AbstractDumperBase::GenSourceInfoSet* get_deleted_child_generated_source () const;

	// implemented method from Base::NamedElement
	// возвращает полное имя элемента
	virtual const std::string get_full_name () const;

//#UC START# *4571A32201A5*
protected:	
	virtual ADList* get_scopes(const AbstractDumperBase* main_scope) const;	
	virtual std::ostream* get_output () const;

protected:
	mutable std::string m_model_unique_id;
//#UC END# *4571A32201A5*
}; // class AbstractSingleDumperBase



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSINGLEDUMPERBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

