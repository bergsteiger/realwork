////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseOverridenElementDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseOverridenElementDumper
//
// демпер для переопределяемого элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseOverridenElementDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// by <<friend>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// блок констант
const std::string RoseOverridenElementDumper::OWNER_VAR_ID = "owner"; // идентификатор переменной, обозначающий владельца переопределенного элемента (владелец - элемент, который собствено переопределяет/реализует этот элемент)

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создает враппер на основе реального дампера сохраненного состояния переопределенного элемента
RoseOverridenElementDumper::RoseOverridenElementDumper (
	const RoseAbstractDumper* from
	, const InheritedItem* state
	, const RoseAbstractDumper* owner
)
//#UC START# *4C1F0482000E_BASE_INIT*
	: RoseAbstractDumper (
		0
		, InheritedItemHelperFactory::get ().make_wrapper (from->rose_element (), state)
		, from->get_model_stereotype_str ()
	)
//#UC END# *4C1F0482000E_BASE_INIT*
{
	//#UC START# *4C1F0482000E_BODY*
	set_wrapped_object (const_cast<RoseAbstractDumper*> (from));
	AbstractDumper::m_outputs = from->m_outputs;
	RoseAbstractDumper::copy_temporary_properties_from (from);

	RoseAbstractDumper::set_var_dumper (OWNER_VAR_ID, owner);
	//#UC END# *4C1F0482000E_BODY*
}

RoseOverridenElementDumper::~RoseOverridenElementDumper () {
	//#UC START# *4C1F04520166_DESTR_BODY*
	//#UC END# *4C1F04520166_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

RoseAbstractDumper* RoseOverridenElementDumper::get_wrapped_object () {
	//#UC START# *4C1F16F00202*
	return m_wrapped_object;
	//#UC END# *4C1F16F00202*
}

void RoseOverridenElementDumper::update (const RoseAbstractDumper* from, const InheritedItem* state) {
	//#UC START# *4C219125006D*
	GDS_ASSERT((from));
	set_wrapped_object (const_cast<RoseAbstractDumper*> (from));
	AbstractDumper::m_outputs = from->m_outputs;
	RoseAbstractDumper::copy_temporary_properties_from (from);

	//TODO: возможно имеет смысл проверять, текщая обертка не над тем же элементом - если да,
	//то не нужно создавать новый - съэкономим на аллокациях..., но при этом надо как-то узнать
	//что состояние элемента соответтвует... как вариант - кастить к RoseOverridenElement и явно
	//переинициализировать его...
	m_rose_element = InheritedItemHelperFactory::get ().make_wrapper (from->rose_element (), state);
	//#UC END# *4C219125006D*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const RoseAbstractDumper* RoseOverridenElementDumper::get_wrapped_object () const {
	//#UC START# *4C1F05610185_GET_ACCESSOR*
	return const_cast<RoseOverridenElementDumper*> (this)->get_wrapped_object ();
	//#UC END# *4C1F05610185_GET_ACCESSOR*
}

void RoseOverridenElementDumper::set_wrapped_object (RoseAbstractDumper* wrapped_object) {
	//#UC START# *4C1F05610185_SET_ACCESSOR*
	m_wrapped_object = wrapped_object;
	//#UC END# *4C1F05610185_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseOverridenElementDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4C1F04520166*
	return get_wrapped_object ()->get_model_class_str ();
	//#UC END# *465EA35D005D_4C1F04520166*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumper
// возвращает true, если использование стереотипа разрешено правилами родителя, иначе false
bool RoseOverridenElementDumper::check_stereotype_use () const {
	//#UC START# *4AC358F50359_4C1F04520166*
	return get_wrapped_object ()->check_stereotype_use ();
	//#UC END# *4AC358F50359_4C1F04520166*
}

// overloaded method from AbstractDumper
// Закрывает выходной поток и "обрезает" выходной файл до нужного размера (т.к в конце потока может
// находится мусор)
void RoseOverridenElementDumper::close_output (std::ofstream& file) const {
	//#UC START# *49EE99220008_4C1F04520166*
	get_wrapped_object ()->close_output (file);
	//#UC END# *49EE99220008_4C1F04520166*
}

// overloaded method from AbstractDumper
// инициирует удаление элемента из кэшей
void RoseOverridenElementDumper::delete_from_cache () const {
	//#UC START# *4C219598003F_4C1F04520166*
	RoseAbstractDumper::delete_from_cache ();
	//#UC END# *4C219598003F_4C1F04520166*
}

// overloaded method from AbstractDumper
// Начинает генерацию, от данного узла
void RoseOverridenElementDumper::dump_start () const {
	//#UC START# *45C9CDE70157_4C1F04520166*
	get_wrapped_object ()->dump_start ();
	//#UC END# *45C9CDE70157_4C1F04520166*
}

// overloaded method from AbstractDumper
// Пост-обработка сгенерированного файла:
// заменяет символ переноса строки (если это необходимо) на тот, что прописан в шаблоне стереотипа.
// file_path - путь к файлу, в котором нужно провести изменения, также конвертит файл в нужную
// кодировку
void RoseOverridenElementDumper::file_post_process (const std::string& file_path) const {
	//#UC START# *49EE997301EE_4C1F04520166*
	get_wrapped_object ()->file_post_process (file_path);
	//#UC END# *49EE997301EE_4C1F04520166*
}

// overloaded method from AbstractDumper
// заполняет кэш флагов генерит ли элемент собственный файл
void RoseOverridenElementDumper::prepare_output_cache () const {
	//#UC START# *4ACC6BDB02A1_4C1F04520166*
	get_wrapped_object ()->prepare_output_cache ();
	//#UC END# *4ACC6BDB02A1_4C1F04520166*
}

// overloaded method from AbstractDumper
// метод вызываемые на каждом элементе перед запуском спела)
void RoseOverridenElementDumper::spell_generation_prepare () {
	//#UC START# *4AFD27ED017D_4C1F04520166*
	RoseAbstractDumper::spell_generation_prepare ();
	//#UC END# *4AFD27ED017D_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// добавить элемент для отложенного dump'а
void RoseOverridenElementDumper::add_dumper_for_delay_dump (const AbstractDumperBase* adb) const {
	//#UC START# *4AEFD5A800F2_4C1F04520166*
	get_wrapped_object ()->add_dumper_for_delay_dump (adb);
	//#UC END# *4AEFD5A800F2_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// добавляет юзер секцию
void RoseOverridenElementDumper::add_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
	, const AbstractDumperBase::UserCode& uc
) const {
	//#UC START# *4666BE6D01C5_4C1F04520166*
	get_wrapped_object ()->add_user_code (gen_id, uc_id, uc);
	//#UC END# *4666BE6D01C5_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// зарегистрирован или нет
bool RoseOverridenElementDumper::am_i_registred () const {
	//#UC START# *4665554F00BB_4C1F04520166*
	return get_wrapped_object ()->am_i_registred ();
	//#UC END# *4665554F00BB_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает true, если элемент можно "дампить"
bool RoseOverridenElementDumper::can_dump () const {
	//#UC START# *4AB372760177_4C1F04520166*
	return get_wrapped_object ()->can_dump ();
	//#UC END# *4AB372760177_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// очищаем список связанных элементов
void RoseOverridenElementDumper::clear_var_dumpers (AbstractDumperBase::LocalVarType type) const {
	//#UC START# *4B21183703AA_4C1F04520166*
	AbstractDumperBase::clear_var_dumpers (type);
	//get_wrapped_object ()->clear_var_dumpers (type);
	//#UC END# *4B21183703AA_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
// items - коллекция элементов даграммы, для формирования навигационной мапы
// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
CxMemFile* RoseOverridenElementDumper::dump_diagram (
	AbstractDumperBase::DiagramItemCollection& items
	, std::string& diagram_hash
) const {
	//#UC START# *4642AC6B0138_4C1F04520166*
	return get_wrapped_object ()->dump_diagram (items, diagram_hash);
	//#UC END# *4642AC6B0138_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// порядковый номер элемента (устанавливается ОДИН раз при построении дерева генерации и хранится в
// модели)
unsigned long long RoseOverridenElementDumper::elem_creation_order () const {
	//#UC START# *4CA290A1031C_4C1F04520166*
	return get_wrapped_object ()->elem_creation_order ();
	//#UC END# *4CA290A1031C_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// порядковый номер элемента (устанавливается при построении дерева генерации)
unsigned int RoseOverridenElementDumper::elem_order () const {
	//#UC START# *4C174C9C0184_4C1F04520166*
	return get_wrapped_object ()->elem_order ();
	//#UC END# *4C174C9C0184_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// regular/abstract/final - тип абстрактности элемента.
const std::string RoseOverridenElementDumper::get_abstract_str () const {
	//#UC START# *4666BBA801A5_4C1F04520166*
	return RoseAbstractDumper::get_abstract_str ();
	//#UC END# *4666BBA801A5_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// ВСЕ элементы которые используют текущий
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_all_consumers () const {
	//#UC START# *46663374004E_4C1F04520166*
	return get_wrapped_object ()->get_all_consumers ();
	//#UC END# *46663374004E_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив всех вложенных элементов (рекурсивно)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_all_contents () const {
	//#UC START# *4666369E01D4_4C1F04520166*
	return get_wrapped_object ()->get_all_contents ();
	//#UC END# *4666369E01D4_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// Возвращает список элементов,  у которых имя совпадает с текущим элементом
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_all_equals_name () const {
	//#UC START# *47A01E5102D1_4C1F04520166*
	return get_wrapped_object ()->get_all_equals_name ();
	//#UC END# *47A01E5102D1_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив всех включаемых элементов (папок) рекурсивно
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_all_includes () const {
	//#UC START# *4666371701F4_4C1F04520166*
	return get_wrapped_object ()->get_all_includes ();
	//#UC END# *4666371701F4_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает список разрешенных генераторов
AbstractDumperBase::Selections* RoseOverridenElementDumper::get_applied_gens () const {
	//#UC START# *46678131036B_4C1F04520166*
	return get_wrapped_object ()->get_applied_gens ();
	//#UC END# *46678131036B_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// авто инкрементирующийся счетчик на элементе.
const std::string RoseOverridenElementDumper::get_auto_counter_str () const {
	//#UC START# *4666BCB7033C_4C1F04520166*
	return get_wrapped_object ()->get_auto_counter_str ();
	//#UC END# *4666BCB7033C_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// вид элемента
const std::string RoseOverridenElementDumper::get_class_kind_str () const {
	//#UC START# *465FE63402FD_4C1F04520166*
	return get_wrapped_object ()->get_class_kind_str ();
	//#UC END# *465FE63402FD_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив вложенных элементов
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_contents () const {
	//#UC START# *4666367C01D4_4C1F04520166*
	return get_wrapped_object ()->get_contents ();
	//#UC END# *4666367C01D4_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает информацию об тех файлах которые были сгенерированны
// ранее, а теперь "исчезли" из списка генерации. Т.е. о тех файлы,
// который фактически удалились из репазитария
AbstractDumperBase::GenSourceInfoSet* RoseOverridenElementDumper::get_deleted_child_generated_source () const {
	//#UC START# *459D2DD40228_4C1F04520166*
	return get_wrapped_object ()->get_deleted_child_generated_source ();
	//#UC END# *459D2DD40228_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает список элементов, от которых зависит данный
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_dependences () const {
	//#UC START# *46655D1D03D8_4C1F04520166*
	return get_wrapped_object ()->get_dependences ();
	//#UC END# *46655D1D03D8_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив реализующих методов и\или атрибутов (реализуемых данным элементом относительно
// абстрактных членов своих базовых классов)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_derived_impl () const {
	//#UC START# *4666379A0222_4C1F04520166*
	return get_wrapped_object ()->get_derived_impl ();
	//#UC END# *4666379A0222_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив перегруженных методов и\или атрибутов (перегруженных данным элементом относительно своих
// базовых классов)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_derived_over () const {
	//#UC START# *466637C50399_4C1F04520166*
	return get_wrapped_object ()->get_derived_over ();
	//#UC END# *466637C50399_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив диаграмм
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_diagrams () const {
	//#UC START# *46663777001F_4C1F04520166*
	return get_wrapped_object ()->get_diagrams ();
	//#UC END# *46663777001F_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// получение докуентации к элементу
const std::string RoseOverridenElementDumper::get_documentation_str () const {
	//#UC START# *4666BA670109_4C1F04520166*
	return get_wrapped_object ()->get_documentation_str ();
	//#UC END# *4666BA670109_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив элементов, которые необходимо forward-декларировать для текущего элемента.
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_forwarded () const {
	//#UC START# *4666357500FA_4C1F04520166*
	return get_wrapped_object ()->get_forwarded ();
	//#UC END# *4666357500FA_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив базовых элементов (от которых унаследован текущий)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_generalizations () const {
	//#UC START# *46655E5B01F4_4C1F04520166*
	return get_wrapped_object ()->get_generalizations ();
	//#UC END# *46655E5B01F4_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив объектов наследующихся от данного
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_generalizator () const {
	//#UC START# *46655DC401C5_4C1F04520166*
	return get_wrapped_object ()->get_generalizator ();
	//#UC END# *46655DC401C5_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив элементов являющихся исключениями для операций  или get-исключениями для атрибутов
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_get_exceptions () const {
	//#UC START# *466636210271_4C1F04520166*
	return get_wrapped_object ()->get_get_exceptions ();
	//#UC END# *466636210271_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает COM GUID
const std::string RoseOverridenElementDumper::get_guid_str () const {
	//#UC START# *4666AA6D02EE_4C1F04520166*
	return get_wrapped_object ()->get_guid_str ();
	//#UC END# *4666AA6D02EE_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает имя файла с изображением, связанного с элементом
const std::string RoseOverridenElementDumper::get_image_file () const {
	//#UC START# *46970F8401A5_4C1F04520166*
	return get_wrapped_object ()->get_image_file ();
	//#UC END# *46970F8401A5_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив включаемых элементов (папок)
// Включаемые папки определяются на основе зависимостей элемента. Если элемент или его вложенные
// части используют как-либо (наследуется, реализует, имеет атрибуты данного типа и т.д.) другой
// элемент, то папка, в которой содержится используемый элемент, попадет в список зависимости. Из
// результирующего списка исключаются элементы попавшие в форвард-декларирование (F)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_includes () const {
	//#UC START# *466636DB035B_4C1F04520166*
	return get_wrapped_object ()->get_includes ();
	//#UC END# *466636DB035B_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает дампер для вывода значения по-умолчанию
AbstractDumperBase* RoseOverridenElementDumper::get_initial_value () const {
	//#UC START# *473D7883037A_4C1F04520166*
	return get_wrapped_object ()->get_initial_value ();
	//#UC END# *473D7883037A_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// значение по умолчанию (для атрибутов и аргументов операции)
const std::string RoseOverridenElementDumper::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_4C1F04520166*
	return get_wrapped_object ()->get_initial_value_str ();
	//#UC END# *4666BA9F03D8_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает строку для сдвига
const std::string RoseOverridenElementDumper::get_intend_str (short intend_shift) const {
	//#UC START# *4666BAFD038A_4C1F04520166*
	return get_wrapped_object ()->get_intend_str (intend_shift);
	//#UC END# *4666BAFD038A_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает список лэйблов (меток) соответствующих стереотипу
GCL::StrSet* RoseOverridenElementDumper::get_labels () const {
	//#UC START# *46515F8B038A_4C1F04520166*
	return get_wrapped_object ()->get_labels ();
	//#UC END# *46515F8B038A_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает ГУИД, который используется при создании навигационной мапы диаграммы
const std::string RoseOverridenElementDumper::get_link_guid () const {
	//#UC START# *4677CE2F006D_4C1F04520166*
	return get_wrapped_object ()->get_link_guid ();
	//#UC END# *4677CE2F006D_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
const std::string RoseOverridenElementDumper::get_link_type_str () const {
	//#UC START# *4666BBD903B9_4C1F04520166*
	return get_wrapped_object ()->get_link_type_str ();
	//#UC END# *4666BBD903B9_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает мэйн элемент
AbstractDumperBase* RoseOverridenElementDumper::get_main_element () const {
	//#UC START# *4665552403B9_4C1F04520166*
	return get_wrapped_object ()->get_main_element ();
	//#UC END# *4665552403B9_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
const AbstractDumperBase::StereotypeID& RoseOverridenElementDumper::get_model_stereotype_str () const {
	//#UC START# *4666AB4D0109_4C1F04520166*
	return get_wrapped_object ()->get_model_stereotype_str ();
	//#UC END# *4666AB4D0109_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает GUID элемента
const std::string& RoseOverridenElementDumper::get_model_unique_id_str () const {
	//#UC START# *465E51860213_4C1F04520166*
	return get_wrapped_object ()->get_model_unique_id_str ();
	//#UC END# *465E51860213_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает имя
const std::string RoseOverridenElementDumper::get_name_str () const {
	//#UC START# *466554D9006D_4C1F04520166*
	return get_wrapped_object ()->get_name_str ();
	//#UC END# *466554D9006D_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает native-путь к элементу, прописанный в настройках
const std::string RoseOverridenElementDumper::get_native_path_str () const {
	//#UC START# *4666BD0F01C5_4C1F04520166*
	return get_wrapped_object ()->get_native_path_str ();
	//#UC END# *4666BD0F01C5_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// все элементы которые используют без учета форвард-декларирования данный (циклически) в одном
// пакете
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_nested_botom_consumers () const {
	//#UC START# *4666333A0261_4C1F04520166*
	return get_wrapped_object ()->get_nested_botom_consumers ();
	//#UC END# *4666333A0261_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив всех (рекурсивно) базовых элементов (от которых унаследован текущий)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_nested_generalizations () const {
	//#UC START# *46655EC401E4_4C1F04520166*
	return get_wrapped_object ()->get_nested_generalizations ();
	//#UC END# *46655EC401E4_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив всех (рекурсивно) реализуемых элементов (которые реализует текущий)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_nested_realizations () const {
	//#UC START# *46655ED0006D_4C1F04520166*
	return get_wrapped_object ()->get_nested_realizations ();
	//#UC END# *46655ED0006D_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// все элементы которые используются без учета форвард-декларирования данным (циклически) в одном
// пакете
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_nested_top_suppliers () const {
	//#UC START# *466635470186_4C1F04520166*
	return get_wrapped_object ()->get_nested_top_suppliers ();
	//#UC END# *466635470186_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает список абстрактных операций/атрибутов базовых или реализуемых классов, который НЕ
// реализует данный элемент
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_not_implemented_derived_abstract () const {
	//#UC START# *4B5EE7570302_4C1F04520166*
	return get_wrapped_object ()->get_not_implemented_derived_abstract ();
	//#UC END# *4B5EE7570302_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// то же что и Forwarded но без исключения элементов декларированных выше в предполагаемой (в
// области пакета) видимости
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_nsf_forwarded () const {
	//#UC START# *466635AB02AF_4C1F04520166*
	return get_wrapped_object ()->get_nsf_forwarded ();
	//#UC END# *466635AB02AF_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив включаемых элементов (папок), но исключаются все форвард декларированные элементы без
// учета ранней форвард деклорации (W). Кроме того, в место элементов НЕ имеющих выходных файлов, в
// список попадают, их родители (рекурсивно) имеющие таковые
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_nsf_includes () const {
	//#UC START# *466637380203_4C1F04520166*
	return get_wrapped_object ()->get_nsf_includes ();
	//#UC END# *466637380203_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает кодировку, с которой должен генерится файл
GCL::code_t RoseOverridenElementDumper::get_output_coding () const {
	//#UC START# *4B5EDADC01FF_4C1F04520166*
	return get_wrapped_object ()->get_output_coding ();
	//#UC END# *4B5EDADC01FF_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает ID страницы в конфлюенсе
const std::string RoseOverridenElementDumper::get_page_id () const {
	//#UC START# *4639BED10119_4C1F04520166*
	return get_wrapped_object ()->get_page_id ();
	//#UC END# *4639BED10119_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает путь страницы, прописанный в свйоствах элемента
const std::string RoseOverridenElementDumper::get_page_path () const {
	//#UC START# *4640808A0119_4C1F04520166*
	return get_wrapped_object ()->get_page_path ();
	//#UC END# *4640808A0119_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив родительских элементов
// Первым элементов в массиве является ближайший родитель
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_parents () const {
	//#UC START# *466636560261_4C1F04520166*
	return get_wrapped_object ()->get_parents ();
	//#UC END# *466636560261_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив реализуемых элементов (которые реализует текущий)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_realizations () const {
	//#UC START# *46655E930261_4C1F04520166*
	return get_wrapped_object ()->get_realizations ();
	//#UC END# *46655E930261_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив объектов реализующих данный
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_realizator () const {
	//#UC START# *46655DAA008C_4C1F04520166*
	return get_wrapped_object ()->get_realizator ();
	//#UC END# *46655DAA008C_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив объектов наследующихся от данного (рекурсивно)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_req_generalizator () const {
	//#UC START# *46655E0C0242_4C1F04520166*
	return get_wrapped_object ()->get_req_generalizator ();
	//#UC END# *46655E0C0242_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив объектов реализующих данный (рекурсивно)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_req_realizator () const {
	//#UC START# *46655DF500AB_4C1F04520166*
	return get_wrapped_object ()->get_req_realizator ();
	//#UC END# *46655DF500AB_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// ВСЕ элементы которые используют текущий (циклически)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_requrcive_all_consumers () const {
	//#UC START# *466635050213_4C1F04520166*
	return get_wrapped_object ()->get_requrcive_all_consumers ();
	//#UC END# *466635050213_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает рекурсивно список элементов, от которых зависит данный
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_reqursive_dependences () const {
	//#UC START# *46655D480261_4C1F04520166*
	return get_wrapped_object ()->get_reqursive_dependences ();
	//#UC END# *46655D480261_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// значение рутовой дирректории для генерации
const std::string RoseOverridenElementDumper::get_root_dir (bool direct_get) const {
	//#UC START# *4666BC450203_4C1F04520166*
	return get_wrapped_object ()->get_root_dir (direct_get);
	//#UC END# *4666BC450203_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает информацию о ранее сгенерированном файле
AbstractDumperBase::GenSourceInfo* RoseOverridenElementDumper::get_self_generated_source () const {
	//#UC START# *459D2DA9011E_4C1F04520166*
	return get_wrapped_object ()->get_self_generated_source ();
	//#UC END# *459D2DA9011E_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив элементов последовательности вызовов (для операций)
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_sequences () const {
	//#UC START# *466635D401C5_4C1F04520166*
	return get_wrapped_object ()->get_sequences ();
	//#UC END# *466635D401C5_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив элементов являющихся set-исключениями для атрибутов
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_set_exceptions () const {
	//#UC START# *4666362C01A5_4C1F04520166*
	return get_wrapped_object ()->get_set_exceptions ();
	//#UC END# *4666362C01A5_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// массив объектов использующих данный в качестве своих атрибутов
AbstractDumperBase::ADList* RoseOverridenElementDumper::get_source () const {
	//#UC START# *46663318034B_4C1F04520166*
	return get_wrapped_object ()->get_source ();
	//#UC END# *46663318034B_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает тип сгенерированного артефакта
AbstractDumperBase::GenSourceType RoseOverridenElementDumper::get_source_type () const {
	//#UC START# *46678170007D_4C1F04520166*
	return get_wrapped_object ()->get_source_type ();
	//#UC END# *46678170007D_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает стереотип элемента
const std::string RoseOverridenElementDumper::get_stereotype_str () const {
	//#UC START# *465FE0B403D8_4C1F04520166*
	return get_wrapped_object ()->get_stereotype_str ();
	//#UC END# *465FE0B403D8_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает цель
AbstractDumperBase* RoseOverridenElementDumper::get_target () const {
	//#UC START# *466554FF030D_4C1F04520166*
	return get_wrapped_object ()->get_target ();
	//#UC END# *466554FF030D_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// стереотип «цели» (const, var, ...)
const std::string RoseOverridenElementDumper::get_target_stereotype_str () const {
	//#UC START# *4666BCE003D8_4C1F04520166*
	return get_wrapped_object ()->get_target_stereotype_str ();
	//#UC END# *4666BCE003D8_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает "true", если элемент фиксированного размера
const std::string RoseOverridenElementDumper::get_type_fixed_size_str () const {
	//#UC START# *4666BB64029F_4C1F04520166*
	return get_wrapped_object ()->get_type_fixed_size_str ();
	//#UC END# *4666BB64029F_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// получить юзер секцию
const AbstractDumperBase::UserCode RoseOverridenElementDumper::get_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
) const {
	//#UC START# *4666BEAB0138_4C1F04520166*
	return get_wrapped_object ()->get_user_code (gen_id, uc_id);
	//#UC END# *4666BEAB0138_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// выводит значение пользовательского свойства «prop_name»
const std::string RoseOverridenElementDumper::get_user_property_str (const std::string& prop_name) const {
	//#UC START# *4666BC09003E_4C1F04520166*
	return RoseAbstractDumper::get_user_property_str (prop_name);
	//#UC END# *4666BC09003E_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает дампер по id-шнику, связанные с элементом
const AbstractDumperBase* RoseOverridenElementDumper::get_var_dumper (const std::string& var_id) const {
	//#UC START# *4B2113FE000C_4C1F04520166*
	if (var_id == OWNER_VAR_ID) {
		return RoseAbstractDumper::get_var_dumper (OWNER_VAR_ID);
	}

	return get_wrapped_object ()->get_var_dumper (var_id);
	//#UC END# *4B2113FE000C_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// строка определяющая видимость элемента.
// Может принимать значения: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
const std::string RoseOverridenElementDumper::get_visability_str () const {
	//#UC START# *4666BAC60177_4C1F04520166*
	return RoseAbstractDumper::get_visability_str ();
	//#UC END# *4666BAC60177_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// имеет ли зарегистрированного родителя
bool RoseOverridenElementDumper::has_registred_parent () const {
	//#UC START# *466555EA009C_4C1F04520166*
	return get_wrapped_object ()->has_registred_parent ();
	//#UC END# *466555EA009C_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает true, если элемент был изменён (используется дл определения того, что диаграмма была
// изменена)
bool RoseOverridenElementDumper::is_changed () const {
	//#UC START# *4745846E0191_4C1F04520166*
	return get_wrapped_object ()->is_changed ();
	//#UC END# *4745846E0191_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает true, если страница для элемента может быть Home - страницей, иначе - false
bool RoseOverridenElementDumper::is_home () const {
	//#UC START# *46712F9C0177_4C1F04520166*
	return get_wrapped_object ()->is_home ();
	//#UC END# *46712F9C0177_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// определяет имеет ли элемент собственный поток вывода
bool RoseOverridenElementDumper::own_output () const {
	//#UC START# *4666BD680128_4C1F04520166*
	return get_wrapped_object ()->own_output ();
	//#UC END# *4666BD680128_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// возвращает родителя
AbstractDumperBase* RoseOverridenElementDumper::parent () const {
	//#UC START# *4665549F0251_4C1F04520166*
	return get_wrapped_object ()->parent ();
	//#UC END# *4665549F0251_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// удаляет из модели информацию об ранее сгенерированном источнике артефакта, возвращает true в
// случае успеха.
bool RoseOverridenElementDumper::remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5AE03B9_4C1F04520166*
	return get_wrapped_object ()->remove_generated_source (src);
	//#UC END# *45C9F5AE03B9_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// сбрасывает информацию об изменённости
void RoseOverridenElementDumper::reset_changed () const {
	//#UC START# *474584AB02B6_4C1F04520166*
	return get_wrapped_object ()->reset_changed ();
	//#UC END# *474584AB02B6_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// Вызывает внешний обработчик измененного файла
void RoseOverridenElementDumper::run_post_command () const {
	//#UC START# *45C9F5EB003E_4C1F04520166*
	return get_wrapped_object ()->run_post_command ();
	//#UC END# *45C9F5EB003E_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// записывает на модели информацию о сгенерированном файле, возвращает true в случае успеха.
bool RoseOverridenElementDumper::set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5490109_4C1F04520166*
	return get_wrapped_object ()->set_self_generated_source (src);
	//#UC END# *45C9F5490109_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// устанавливает дампер по id-шнику, связанный с элементом
void RoseOverridenElementDumper::set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) const {
	//#UC START# *4B21147F0088_4C1F04520166*
	if (var_id == OWNER_VAR_ID) {
		throw Base::FatalError ("Нельзя перезаписывать владельца переопределенного/реализуемого элемента");
	}

	return get_wrapped_object ()->set_var_dumper (var_id, dumper);
	//#UC END# *4B21147F0088_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// логирование ошибок в шаблоне
void RoseOverridenElementDumper::write_template_error_log (const char* log) const {
	//#UC START# *46655433001F_4C1F04520166*
	return get_wrapped_object ()->write_template_error_log (log);
	//#UC END# *46655433001F_4C1F04520166*
}

// overloaded method from AbstractDumperBase
// логирование предупреждений
void RoseOverridenElementDumper::write_template_warning_log (const char* log) const {
	//#UC START# *466554660000_4C1F04520166*
	return get_wrapped_object ()->write_template_warning_log (log);
	//#UC END# *466554660000_4C1F04520166*
}

// overloaded method from AbstractLogger
// метод для логирования ошибок
void RoseOverridenElementDumper::write_error_log (const std::string& mess, bool fatal) const {
	//#UC START# *46823C1003A9_4C1F04520166*
	return get_wrapped_object ()->write_error_log (mess, fatal);
	//#UC END# *46823C1003A9_4C1F04520166*
}

// overloaded method from AbstractLogger
// логирование информационных сообщений
void RoseOverridenElementDumper::write_info_log (const std::string& mess) const {
	//#UC START# *46823BFE004E_4C1F04520166*
	return get_wrapped_object ()->write_info_log (mess);
	//#UC END# *46823BFE004E_4C1F04520166*
}

// overloaded method from AbstractLogger
// логирование предупреждений
void RoseOverridenElementDumper::write_warning_log (const std::string& mess) const {
	//#UC START# *46823BE0038A_4C1F04520166*
	return get_wrapped_object ()->write_warning_log (mess);
	//#UC END# *46823BE0038A_4C1F04520166*
}

// overloaded method from Base::NamedElement
// возвращает полное имя элемента
const std::string RoseOverridenElementDumper::get_full_name () const {
	//#UC START# *4AF93E9E0166_4C1F04520166*
	return get_wrapped_object ()->get_full_name ();
	//#UC END# *4AF93E9E0166_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// возвращает список элементов от которых зависит данный, список без дубликатов
void RoseOverridenElementDumper::collect_suppliers_by_type (
	ObjectTreeResolver::SupplierType type
	, ObjectTreeResolver::OTRVector& collection
) const {
	//#UC START# *4B34A4420128_4C1F04520166*
	return get_wrapped_object ()->collect_suppliers_by_type (type, collection);
	//#UC END# *4B34A4420128_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// рекурсивно формирует список элементов от которых зависит данный, список без дубликатов
void RoseOverridenElementDumper::collect_suppliers_by_type_recursive (
	ObjectTreeResolver::SupplierType type
	, ObjectTreeResolver::OTRVector& collection
) const {
	//#UC START# *4B34A68C010C_4C1F04520166*
	return get_wrapped_object ()->collect_suppliers_by_type_recursive (type, collection);
	//#UC END# *4B34A68C010C_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// сравнивнение элементов дерева
int RoseOverridenElementDumper::compare (const ObjectTreeResolver* od) const {
	//#UC START# *4A489BAB00DE_4C1F04520166*
	return get_wrapped_object ()->compare (od);
	//#UC END# *4A489BAB00DE_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// уровень видимости детей, если -1 - значит уровень не задан
int RoseOverridenElementDumper::get_childs_visibility_level () const {
	//#UC START# *4AAF10C300D1_4C1F04520166*
	return get_wrapped_object ()->get_childs_visibility_level ();
	//#UC END# *4AAF10C300D1_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// возвращает вес форвард декларации
long RoseOverridenElementDumper::get_fwd_weight () const {
	//#UC START# *4A489B430198_4C1F04520166*
	return get_wrapped_object ()->get_fwd_weight ();
	//#UC END# *4A489B430198_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// возвращает true, если элемент нельяз форвард декларировать
bool RoseOverridenElementDumper::is_forbiden_forward_dcl () const {
	//#UC START# *4A489B1602BA_4C1F04520166*
	return get_wrapped_object ()->is_forbiden_forward_dcl ();
	//#UC END# *4A489B1602BA_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// Cвойство локальной глобальности - если у пакета выставлено такое свойство, то считается, всем
// пакетам - соседям доступны элементы из него и его детям доступны элементы соседей, т.е как буд-
// то между ними протянута связь в обе стороны
bool RoseOverridenElementDumper::is_global_locally () const {
	//#UC START# *4B4DB9F00341_4C1F04520166*
	return get_wrapped_object ()->is_global_locally ();
	//#UC END# *4B4DB9F00341_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// возвращает true, если элемент виден из любого места модели, например лежит в глобальном пакете
bool RoseOverridenElementDumper::is_global_visible () const {
	//#UC START# *4B0A2F9D02C0_4C1F04520166*
	return get_wrapped_object ()->is_global_visible ();
	//#UC END# *4B0A2F9D02C0_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// является ли obj supplier'ем с заданным стереотипом
bool RoseOverridenElementDumper::is_supplier_with_stereotype (
	const ObjectTreeResolver* obj
	, const std::string& stereotype
) const {
	//#UC START# *4B1CD55E02F5_4C1F04520166*
	return get_wrapped_object ()->is_supplier_with_stereotype (obj, stereotype);
	//#UC END# *4B1CD55E02F5_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseOverridenElementDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4C1F04520166*
	get_wrapped_object ()->link_suppliers ();
	//#UC END# *465E57F1029F_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// разрывает связь заданного типа и заданного стереотипа
void RoseOverridenElementDumper::remove_supplier (
	const ObjectTreeResolver* supplier
	, ObjectTreeResolver::SupplierType type
	, const std::string& stereotype
) {
	//#UC START# *4B1CD6F8009C_4C1F04520166*
	get_wrapped_object ()->remove_supplier (supplier, type, stereotype);
	//#UC END# *4B1CD6F8009C_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// Алгоритм простановки связей между родителями элементов source и target
void RoseOverridenElementDumper::set_dependencies (
	const ObjectTreeResolver* target
	, const ObjectTreeResolver::AddDependencyFunctor& add_dep
) const {
	//#UC START# *4B568C5F0079_4C1F04520166*
	get_wrapped_object ()->set_dependencies (target, add_dep);
	//#UC END# *4B568C5F0079_4C1F04520166*
}

// overloaded method from ObjectTreeResolver
// Сортируется ли элементы в порядке создания (в порядке указания на модели) - такие элементы не
// нужно помещать в граф.
bool RoseOverridenElementDumper::sort_in_model_order () const {
	//#UC START# *4AB0CD170066_4C1F04520166*
	return get_wrapped_object ()->sort_in_model_order ();
	//#UC END# *4AB0CD170066_4C1F04520166*
}

// overloaded method from RoseAbstractDumper
// копирует временные свойства с заданного элемента
void RoseOverridenElementDumper::copy_temporary_properties_from (const RoseAbstractDumper* rad) {
	//#UC START# *4B99D0BC015E_4C1F04520166*
	RoseAbstractDumper::copy_temporary_properties_from (rad);
	//#UC END# *4B99D0BC015E_4C1F04520166*
}

// overloaded method from RoseAbstractDumper
// возвращает знечение свойства - сначала ищет во временном хранилище, а затем в модели
const std::string RoseOverridenElementDumper::get_property_value (
	const std::string& tool_name
	, const std::string& prop_name
) const {
	//#UC START# *4AFD03F200BC_4C1F04520166*
	return RoseAbstractDumper::get_property_value (tool_name, prop_name);
	//#UC END# *4AFD03F200BC_4C1F04520166*
}

// overloaded method from RoseAbstractDumper
// сбрасывает закэшированный model stereotype
void RoseOverridenElementDumper::reset_model_stereotype () {
	//#UC START# *4AC35B0500E2_4C1F04520166*
	return get_wrapped_object ()->reset_model_stereotype ();
	//#UC END# *4AC35B0500E2_4C1F04520166*
}

// overloaded method from RoseAbstractDumper
// записать свойство во временное хранилище
bool RoseOverridenElementDumper::set_temporary_property (
	const std::string& tool_name
	, const std::string& prop_name
	, const std::string& value
) const {
	//#UC START# *4AFD0404034D_4C1F04520166*
	return RoseAbstractDumper::set_temporary_property (tool_name, prop_name, value);
	//#UC END# *4AFD0404034D_4C1F04520166*
}

// overloaded method from RoseAbstractDumper
// метод вызывается, когда нужно обновить, закэшированные на дампере значения атрибутов
void RoseOverridenElementDumper::update_cached_attrs () const {
	//#UC START# *4B98C3A50072_4C1F04520166*
	get_wrapped_object ()->update_cached_attrs ();
	//#UC END# *4B98C3A50072_4C1F04520166*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

