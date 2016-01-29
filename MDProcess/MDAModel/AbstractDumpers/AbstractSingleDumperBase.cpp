////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSingleDumperBase
//
// Базовый класс для "псевдо" дамперов - как правило эмулирующих элемент модели, а не являющихся им.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"

//#UC START# *4571A32201A5_CUSTOM_INCLUDES*
#include <limits>
//#UC END# *4571A32201A5_CUSTOM_INCLUDES*


//#UC START# *4571A32201A5*
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_scopes(const AbstractDumperBase* main_scope) const {
	ADList* ret = new ADList ();
	return ret;
}

std::ostream* AbstractSingleDumperBase::get_output () const {
	return NULL;
}


//#UC END# *4571A32201A5*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractSingleDumperBase::~AbstractSingleDumperBase () {
	//#UC START# *4571A32201A5_DESTR_BODY*
	//#UC END# *4571A32201A5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// добавляет юзер секцию
void AbstractSingleDumperBase::add_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
	, const AbstractDumperBase::UserCode& uc
) const {
	//#UC START# *4666BE6D01C5_4571A32201A5*
	//#UC END# *4666BE6D01C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// зарегистрирован или нет
bool AbstractSingleDumperBase::am_i_registred () const {
	//#UC START# *4665554F00BB_4571A32201A5*
	return true;
	//#UC END# *4665554F00BB_4571A32201A5*
}

// implemented method from AbstractDumperBase
// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
// items - коллекция элементов даграммы, для формирования навигационной мапы
// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
CxMemFile* AbstractSingleDumperBase::dump_diagram (
	AbstractDumperBase::DiagramItemCollection& items
	, std::string& diagram_hash
) const {
	//#UC START# *4642AC6B0138_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4642AC6B0138_4571A32201A5*
}

// implemented method from AbstractDumperBase
// regular/abstract/final - тип абстрактности элемента.
const std::string AbstractSingleDumperBase::get_abstract_str () const {
	//#UC START# *4666BBA801A5_4571A32201A5*
	return "false";
	//#UC END# *4666BBA801A5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ВСЕ элементы которые используют текущий
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_consumers () const {
	//#UC START# *46663374004E_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46663374004E_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив всех вложенных элементов (рекурсивно)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_contents () const {
	//#UC START# *4666369E01D4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666369E01D4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// Возвращает список элементов,  у которых имя совпадает с текущим элементом
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_equals_name () const {
	//#UC START# *47A01E5102D1_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *47A01E5102D1_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив всех включаемых элементов (папок) рекурсивно
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_includes () const {
	//#UC START# *4666371701F4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666371701F4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает список разрешенных генераторов
AbstractDumperBase::Selections* AbstractSingleDumperBase::get_applied_gens () const {
	//#UC START# *46678131036B_4571A32201A5*
	return new Selections ();
	//#UC END# *46678131036B_4571A32201A5*
}

// implemented method from AbstractDumperBase
// авто инкрементирующийся счетчик на элементе.
const std::string AbstractSingleDumperBase::get_auto_counter_str () const {
	//#UC START# *4666BCB7033C_4571A32201A5*
	return "";
	//#UC END# *4666BCB7033C_4571A32201A5*
}

// implemented method from AbstractDumperBase
// вид элемента
const std::string AbstractSingleDumperBase::get_class_kind_str () const {
	//#UC START# *465FE63402FD_4571A32201A5*
	return "";
	//#UC END# *465FE63402FD_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив вложенных элементов
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_contents () const {
	//#UC START# *4666367C01D4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666367C01D4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает информацию об тех файлах которые были сгенерированны
// ранее, а теперь "исчезли" из списка генерации. Т.е. о тех файлы,
// который фактически удалились из репазитария
AbstractDumperBase::GenSourceInfoSet* AbstractSingleDumperBase::get_deleted_child_generated_source () const {
	//#UC START# *459D2DD40228_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *459D2DD40228_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает список элементов, от которых зависит данный
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_dependences () const {
	//#UC START# *46655D1D03D8_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655D1D03D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив реализующих методов и\или атрибутов (реализуемых данным элементом относительно
// абстрактных членов своих базовых классов)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_derived_impl () const {
	//#UC START# *4666379A0222_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666379A0222_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив перегруженных методов и\или атрибутов (перегруженных данным элементом относительно своих
// базовых классов)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_derived_over () const {
	//#UC START# *466637C50399_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466637C50399_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив диаграмм
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_diagrams () const {
	//#UC START# *46663777001F_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46663777001F_4571A32201A5*
}

// implemented method from AbstractDumperBase
// получение докуентации к элементу
const std::string AbstractSingleDumperBase::get_documentation_str () const {
	//#UC START# *4666BA670109_4571A32201A5*
	return "";
	//#UC END# *4666BA670109_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив элементов, которые необходимо forward-декларировать для текущего элемента.
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_forwarded () const {
	//#UC START# *4666357500FA_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666357500FA_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив базовых элементов (от которых унаследован текущий)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_generalizations () const {
	//#UC START# *46655E5B01F4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655E5B01F4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив объектов наследующихся от данного
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_generalizator () const {
	//#UC START# *46655DC401C5_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655DC401C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив элементов являющихся исключениями для операций  или get-исключениями для атрибутов
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_get_exceptions () const {
	//#UC START# *466636210271_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466636210271_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает COM GUID
const std::string AbstractSingleDumperBase::get_guid_str () const {
	//#UC START# *4666AA6D02EE_4571A32201A5*
	return "";
	//#UC END# *4666AA6D02EE_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив включаемых элементов (папок)
// Включаемые папки определяются на основе зависимостей элемента. Если элемент или его вложенные
// части используют как-либо (наследуется, реализует, имеет атрибуты данного типа и т.д.) другой
// элемент, то папка, в которой содержится используемый элемент, попадет в список зависимости. Из
// результирующего списка исключаются элементы попавшие в форвард-декларирование (F)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_includes () const {
	//#UC START# *466636DB035B_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466636DB035B_4571A32201A5*
}

// implemented method from AbstractDumperBase
// значение по умолчанию (для атрибутов и аргументов операции)
const std::string AbstractSingleDumperBase::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_4571A32201A5*
	return "";
	//#UC END# *4666BA9F03D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает строку для сдвига
const std::string AbstractSingleDumperBase::get_intend_str (short intend_shift) const {
	//#UC START# *4666BAFD038A_4571A32201A5*
	return "";
	//#UC END# *4666BAFD038A_4571A32201A5*
}

// implemented method from AbstractDumperBase
// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
const std::string AbstractSingleDumperBase::get_link_type_str () const {
	//#UC START# *4666BBD903B9_4571A32201A5*
	return "";
	//#UC END# *4666BBD903B9_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает класс
const std::string AbstractSingleDumperBase::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571A32201A5*
	return "";
	//#UC END# *465EA35D005D_4571A32201A5*
}

// implemented method from AbstractDumperBase
// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
const AbstractDumperBase::StereotypeID& AbstractSingleDumperBase::get_model_stereotype_str () const {
	//#UC START# *4666AB4D0109_4571A32201A5*
	return AbstractDumperBase::EMPTY_STEREOTYPE_ID;
	//#UC END# *4666AB4D0109_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает GUID элемента
const std::string& AbstractSingleDumperBase::get_model_unique_id_str () const {
	//#UC START# *465E51860213_4571A32201A5*
	return m_model_unique_id;
	//#UC END# *465E51860213_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает native-путь к элементу, прописанный в настройках
const std::string AbstractSingleDumperBase::get_native_path_str () const {
	//#UC START# *4666BD0F01C5_4571A32201A5*
	return "";
	//#UC END# *4666BD0F01C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// все элементы которые используют без учета форвард-декларирования данный (циклически) в одном
// пакете
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_botom_consumers () const {
	//#UC START# *4666333A0261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666333A0261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив всех (рекурсивно) базовых элементов (от которых унаследован текущий)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_generalizations () const {
	//#UC START# *46655EC401E4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655EC401E4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив всех (рекурсивно) реализуемых элементов (которые реализует текущий)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_realizations () const {
	//#UC START# *46655ED0006D_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655ED0006D_4571A32201A5*
}

// implemented method from AbstractDumperBase
// все элементы которые используются без учета форвард-декларирования данным (циклически) в одном
// пакете
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_top_suppliers () const {
	//#UC START# *466635470186_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635470186_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает список абстрактных операций/атрибутов базовых или реализуемых классов, который НЕ
// реализует данный элемент
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_not_implemented_derived_abstract () const {
	//#UC START# *4B5EE7570302_4571A32201A5*
	return new ADList ();
	//#UC END# *4B5EE7570302_4571A32201A5*
}

// implemented method from AbstractDumperBase
// то же что и Forwarded но без исключения элементов декларированных выше в предполагаемой (в
// области пакета) видимости
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nsf_forwarded () const {
	//#UC START# *466635AB02AF_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635AB02AF_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив включаемых элементов (папок), но исключаются все форвард декларированные элементы без
// учета ранней форвард деклорации (W). Кроме того, в место элементов НЕ имеющих выходных файлов, в
// список попадают, их родители (рекурсивно) имеющие таковые
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nsf_includes () const {
	//#UC START# *466637380203_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466637380203_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает ID страницы в конфлюенсе
const std::string AbstractSingleDumperBase::get_page_id () const {
	//#UC START# *4639BED10119_4571A32201A5*
	return "";
	//#UC END# *4639BED10119_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает путь страницы, прописанный в свйоствах элемента
const std::string AbstractSingleDumperBase::get_page_path () const {
	//#UC START# *4640808A0119_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4640808A0119_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив родительских элементов
// Первым элементов в массиве является ближайший родитель
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_parents () const {
	//#UC START# *466636560261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466636560261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив реализуемых элементов (которые реализует текущий)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_realizations () const {
	//#UC START# *46655E930261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655E930261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив объектов реализующих данный
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_realizator () const {
	//#UC START# *46655DAA008C_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655DAA008C_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив объектов наследующихся от данного (рекурсивно)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_req_generalizator () const {
	//#UC START# *46655E0C0242_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655E0C0242_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив объектов реализующих данный (рекурсивно)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_req_realizator () const {
	//#UC START# *46655DF500AB_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655DF500AB_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ВСЕ элементы которые используют текущий (циклически)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_requrcive_all_consumers () const {
	//#UC START# *466635050213_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635050213_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает рекурсивно список элементов, от которых зависит данный
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_reqursive_dependences () const {
	//#UC START# *46655D480261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655D480261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// значение рутовой дирректории для генерации
const std::string AbstractSingleDumperBase::get_root_dir (bool direct_get) const {
	//#UC START# *4666BC450203_4571A32201A5*
	return "";
	//#UC END# *4666BC450203_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает информацию о ранее сгенерированном файле
AbstractDumperBase::GenSourceInfo* AbstractSingleDumperBase::get_self_generated_source () const {
	//#UC START# *459D2DA9011E_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *459D2DA9011E_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив элементов последовательности вызовов (для операций)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_sequences () const {
	//#UC START# *466635D401C5_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635D401C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив элементов являющихся set-исключениями для атрибутов
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_set_exceptions () const {
	//#UC START# *4666362C01A5_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666362C01A5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// массив объектов использующих данный в качестве своих атрибутов
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_source () const {
	//#UC START# *46663318034B_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46663318034B_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает стереотип элемента
const std::string AbstractSingleDumperBase::get_stereotype_str () const {
	//#UC START# *465FE0B403D8_4571A32201A5*
	return "";
	//#UC END# *465FE0B403D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает цель
AbstractDumperBase* AbstractSingleDumperBase::get_target () const {
	//#UC START# *466554FF030D_4571A32201A5*
	return NULL;
	//#UC END# *466554FF030D_4571A32201A5*
}

// implemented method from AbstractDumperBase
// стереотип «цели» (const, var, ...)
const std::string AbstractSingleDumperBase::get_target_stereotype_str () const {
	//#UC START# *4666BCE003D8_4571A32201A5*
	return "";
	//#UC END# *4666BCE003D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает "true", если элемент фиксированного размера
const std::string AbstractSingleDumperBase::get_type_fixed_size_str () const {
	//#UC START# *4666BB64029F_4571A32201A5*
	return "";
	//#UC END# *4666BB64029F_4571A32201A5*
}

// implemented method from AbstractDumperBase
// получить юзер секцию
const AbstractDumperBase::UserCode AbstractSingleDumperBase::get_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
) const {
	//#UC START# *4666BEAB0138_4571A32201A5*
	return "";
	//#UC END# *4666BEAB0138_4571A32201A5*
}

// implemented method from AbstractDumperBase
// выводит значение пользовательского свойства «prop_name»
const std::string AbstractSingleDumperBase::get_user_property_str (const std::string& prop_name) const {
	//#UC START# *4666BC09003E_4571A32201A5*
	return "";
	//#UC END# *4666BC09003E_4571A32201A5*
}

// implemented method from AbstractDumperBase
// строка определяющая видимость элемента.
// Может принимать значения: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
const std::string AbstractSingleDumperBase::get_visability_str () const {
	//#UC START# *4666BAC60177_4571A32201A5*
	return "";
	//#UC END# *4666BAC60177_4571A32201A5*
}

// implemented method from AbstractDumperBase
// имеет ли зарегистрированного родителя
bool AbstractSingleDumperBase::has_registred_parent () const {
	//#UC START# *466555EA009C_4571A32201A5*
	return false;
	//#UC END# *466555EA009C_4571A32201A5*
}

// implemented method from AbstractDumperBase
// определяет имеет ли элемент собственный поток вывода
bool AbstractSingleDumperBase::own_output () const {
	//#UC START# *4666BD680128_4571A32201A5*
	return false;
	//#UC END# *4666BD680128_4571A32201A5*
}

// implemented method from AbstractDumperBase
// возвращает родителя
AbstractDumperBase* AbstractSingleDumperBase::parent () const {
	//#UC START# *4665549F0251_4571A32201A5*
	return NULL;
	//#UC END# *4665549F0251_4571A32201A5*
}

// implemented method from AbstractDumperBase
// удаляет из модели информацию об ранее сгенерированном источнике артефакта, возвращает true в
// случае успеха.
bool AbstractSingleDumperBase::remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5AE03B9_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45C9F5AE03B9_4571A32201A5*
}

// implemented method from AbstractDumperBase
// записывает на модели информацию о сгенерированном файле, возвращает true в случае успеха.
bool AbstractSingleDumperBase::set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5490109_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45C9F5490109_4571A32201A5*
}

// implemented method from Base::NamedElement
// возвращает полное имя элемента
const std::string AbstractSingleDumperBase::get_full_name () const {
	//#UC START# *4AF93E9E0166_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4AF93E9E0166_4571A32201A5*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

