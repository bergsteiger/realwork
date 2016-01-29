////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::ContainerTemplateOperationsImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerOperationsImpl.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerOperationsImpl.h"
#include "boost/lexical_cast.hpp"
#include "shared/GCL/str/str_op.h"
#include "boost/function.hpp"
#include "boost/bind.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "shared/GCL/alg/sorting.h"

namespace ContainerOperationsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ContainerTemplateOperationsImpl::ContainerTemplateOperationsImpl ()
//#UC START# *4B7533750299_4B75374D03C0_4B7539FC025B_BASE_INIT*
//#UC END# *4B7533750299_4B75374D03C0_4B7539FC025B_BASE_INIT*
{
	//#UC START# *4B7533750299_4B75374D03C0_4B7539FC025B_BODY*
	//#UC END# *4B7533750299_4B75374D03C0_4B7539FC025B_BODY*
}

ContainerTemplateOperationsImpl::~ContainerTemplateOperationsImpl () {
	//#UC START# *4B7539FC025B_DESTR_BODY*
	//#UC END# *4B7539FC025B_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает дампер, по команде в шаблоне, результат функции должен быть положен в Var
const AbstractDumperBase* ContainerTemplateOperationsImpl::get_dumper_by_param (
	const std::string& param
	, TemplatePainter* painter
) const {
	//#UC START# *4B755AC40325*
	AbstractDumperBase_cvar ret;
	if (GCL::border_with (param.c_str (), "\"")) {
		std::string resolved_param = TemplatePainter::resolve_exp (param, painter);
		std::string text (resolved_param.begin () + 1, resolved_param.end () - 1);
		ret = new TemplatePainter::TextDumper (text.data());
	} else {
		std::string::const_iterator it = param.begin();
		const AbstractDumperBase* ad = painter->get_dumper_by_template(it, param.end ());

		if (ad) {
			ad->addref ();
		}

		ret = ad;
		////нужно проверить, если это текстовый дампер - нужно увеличить на нем счетчик ссылок,
		////иначе он может протухнуть
		//const TemplatePainter::TextDumper* text_dumper = dynamic_cast<const TemplatePainter::TextDumper*> (ad);
		//if (text_dumper) {
		//	text_dumper->addref ();
		//	TemplatePainter::dumpers_heap ().push_back (const_cast<TemplatePainter::TextDumper*> (text_dumper));
		//}
	}

	return ret._sretn ();
	//#UC END# *4B755AC40325*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContainerOperations::ContainerTemplateOperations
// добавление элемента в список unresolved_param содержит либо шаблон для получения элемента
// (например: S%T), либо строка-шаблон в кавычках
void ContainerTemplateOperationsImpl::add (
	TemplatePainter::ContainerDumper* container
	, const std::string& unresolved_param
	, TemplatePainter* painter
) const {
	//#UC START# *4B7537E8015A_4B7539FC025B*	
	AbstractDumperBase_cvar ad = get_dumper_by_param (unresolved_param, painter);
	
	if (!ad.is_nil ()) {
		container->add (ad.ptr ());
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += " - can't add null dumper (";
		mess += unresolved_param;
		mess += ")";
		throw Base::FatalError (mess);
	}
	//#UC END# *4B7537E8015A_4B7539FC025B*
}

// implemented method from ContainerOperations::ContainerTemplateOperations
// возвращает количество вхождений элемента в список, unresolved_param содержит либо шаблон для
// получения элемента (например: S%T), либо строка-шаблон в кавычках
const std::string ContainerTemplateOperationsImpl::count (
	const TemplatePainter::ContainerDumper* container
	, const std::string& unresolved_param
	, TemplatePainter* painter
) const {
	//#UC START# *4B7539360231_4B7539FC025B*
	AbstractDumperBase_cvar ad = get_dumper_by_param (unresolved_param, painter);

	return boost::lexical_cast<std::string> (
		(!ad.is_nil ()) ? container->count (ad.ptr ()) : 0
	);
	//#UC END# *4B7539360231_4B7539FC025B*
}

// implemented method from ContainerOperations::ContainerTemplateOperations
// возвращает true, если элемент присутствует в списке, иначе false, unresolved_param содержит либо
// шаблон для получения элемента (например: S%T), либо строка-шаблон в кавычках
const std::string ContainerTemplateOperationsImpl::find (
	const TemplatePainter::ContainerDumper* container
	, const std::string& unresolved_param
	, TemplatePainter* painter
) const {
	//#UC START# *4B75394C02D7_4B7539FC025B*	
	std::string count = this->count (container, unresolved_param, painter);
	return count == "0" ? "false" : "true";	
	//#UC END# *4B75394C02D7_4B7539FC025B*
}

// implemented method from ContainerOperations::ContainerTemplateOperations
void ContainerTemplateOperationsImpl::pop_first_to_var (
	TemplatePainter::ContainerDumper* container
	, const std::string& var_id
) const {
	//#UC START# *4B75399E0024_4B7539FC025B*
	if (container->size () > 0) {
		const AbstractDumperBase* ad = container->get_items ().front ().ptr ();
		if (ad != 0) {
			TemplatePainter::set_var_dumper (var_id, ad); 
		}

		container->pop_front ();
	}
	//#UC END# *4B75399E0024_4B7539FC025B*
}

// implemented method from ContainerOperations::ContainerTemplateOperations
void ContainerTemplateOperationsImpl::pop_last_to_var (
	TemplatePainter::ContainerDumper* container
	, const std::string& var_id
) const {
	//#UC START# *4B7539AC0270_4B7539FC025B*
	if (container->size () > 0) {
		const AbstractDumperBase* ad = container->get_items ().back ().ptr ();
		if (ad != 0) {
			TemplatePainter::set_var_dumper (var_id, ad); 
		}

		container->pop_back ();

	}
	//#UC END# *4B7539AC0270_4B7539FC025B*
}

// implemented method from ContainerOperations::ContainerTemplateOperations
// удаляет элемент из списка, unresolved_param содержит либо шаблон для получения элемента
// (например: S%T), либо строка-шаблон в кавычках
void ContainerTemplateOperationsImpl::remove (
	TemplatePainter::ContainerDumper* container
	, const std::string& unresolved_param
	, TemplatePainter* painter
) const {
	//#UC START# *4B753849004D_4B7539FC025B*
	GDS_ASSERT(container);
	
	AbstractDumperBase_cvar ad = get_dumper_by_param (unresolved_param, painter);
	if (!ad.is_nil ()) {
		container->erase (ad.ptr ());
	}	
	//#UC END# *4B753849004D_4B7539FC025B*
}

// implemented method from ContainerOperations::ContainerTemplateOperations
void ContainerTemplateOperationsImpl::sort (
	TemplatePainter::ContainerDumper* container
	, const std::string& unresolved_param
	, TemplatePainter* painter
	, const TemplatePainter::ContainerDumper* key_list
) const {
	//#UC START# *4B7539DF01B0_4B7539FC025B*
	struct ConainerAdder {
		void operator () (TemplatePainter::ContainerDumper& container, AbstractDumperBase::VarList::value_type& value) {
			container.add (value.ptr ());
		}
	};
	
	if (container->size () > 0) {
		bool sort_with_functor = false;
		boost::function<bool (const AbstractDumperBase*, const AbstractDumperBase*)> sort_functor;
		char sorting_type;

		if (GCL::border_with (unresolved_param.data(), '"')) {
			std::string command (unresolved_param, 1, unresolved_param.size () - 2);
			sort_functor = LessByTemplateCommand (command, painter);
			sort_with_functor = true;
		} else {
			std::string sorting_type_str = TemplatePainter::resolve_exp (unresolved_param, painter);
			if (!sorting_type_str.empty ()) {
				sorting_type = *sorting_type_str.begin ();					
				switch (sorting_type) {
					case SX_4_ST_BY_NAME:
						sort_with_functor = true;
						sort_functor = AbstractDumperBase::SortByName();
						break;
					case SX_4_ST_BY_GUID:
						sort_with_functor = true;
						sort_functor = AbstractDumperBase::SortByUID();
						break;
					case SX_4_ST_BY_PARENT_AND_NAME:
						sort_with_functor = true;
						sort_functor = AbstractDumperBase::SortByParentAndName();
						break;
					default:
						break;
				}
			}
		}

		typedef AbstractDumperBase::VarList::value_type VarListValueType;
		if (sort_with_functor) {
			AbstractDumperBase::VarList list (container->get_items ());
			list.sort (
				boost::bind (
				sort_functor
					, boost::bind (
						static_cast<const AbstractDumperBase* (VarListValueType::*) () const> (&VarListValueType::ptr)
						, _1
					)
					, boost::bind (
						static_cast<const AbstractDumperBase* (VarListValueType::*) () const> (&VarListValueType::ptr)
						, _2
					)
				)
			);
			container->clear ();
			container->add (list);
		} else {
			switch (sorting_type) {
				case SX_4_ST_BY_ORDER:
					{
						std::vector<AbstractDumperBase::VarList::value_type> var_vector (
							container->get_items ().begin ()
							, container->get_items ().end ()
						);
						GCL::uqsort (
							&var_vector[0]
							, var_vector.size()
							, sizeof(var_vector[0])
							, adb_cvar_compare_by_order
						);
						container->clear ();

						std::for_each (
							var_vector.begin ()
							, var_vector.end ()
							, boost::bind<void> (
								ConainerAdder ()
								, boost::ref (*container)
								, _1
							)
							
						);
					}
					break;
				case SX_4_ST_BY_CREATION_ORDER:
					{
						std::vector<AbstractDumperBase::VarList::value_type> var_vector (
							container->get_items ().begin ()
							, container->get_items ().end ()
						);
						GCL::uqsort (
							&var_vector[0]
							, var_vector.size()
							, sizeof(var_vector[0])
							, adb_cvar_compare_by_creation_order
						);
						container->clear ();

						std::for_each (
							var_vector.begin ()
							, var_vector.end ()
							, boost::bind<void> (
								ConainerAdder ()
								, boost::ref (*container)
								, _1
							)
						);
					}
					break;
				case SX_4_ST_BY_POSITION:
					{
						std::vector<AbstractDumperBase::VarList::value_type> var_vector (
							container->get_items ().begin ()
							, container->get_items ().end ()
						);
						
						GCL::uqsort (
							&var_vector[0]
							, var_vector.size()
							, sizeof(var_vector[0])
							, adb_cvar_compare_adapter
						);
						container->clear ();

						std::for_each (
							var_vector.begin ()
							, var_vector.end ()
							, boost::bind<void> (
								ConainerAdder ()
								, boost::ref (*container)
								, _1
							)
						);
					}
					break;
				case 'k': //сортировка по внешним ключам
					{
						//получаем список ключей как дополнительный список
						if (!key_list) {
							std::string mess (GDS_CURRENT_FUNCTION);
							mess += " - wrong parametr count, need key list for sorting by external keys";
							throw Base::FatalError (mess);
						} else {
							if (key_list->size () != container->size ()) {
								std::string mess (GDS_CURRENT_FUNCTION);
								mess += " - key list size must be equal source list size";
								throw Base::FatalError (mess);
							}
						}

						struct ADBWithKey {
							ADBWithKey (VarListValueType& key_adb_, VarListValueType& adb_) 
								: key_adb (key_adb_), adb (adb_)
							{
							};

							VarListValueType key_adb;
							VarListValueType adb;

							bool operator < (const ADBWithKey& rhs) const {
								return this->key_adb->get_name_str() < rhs.key_adb->get_name_str();
							}
						};
						std::vector<AbstractDumperBase::VarList::value_type> adb_vector (
							container->get_items ().begin ()
							, container->get_items ().end ()
						);

						std::vector<AbstractDumperBase::VarList::value_type> key_vector (
							key_list->get_items ().begin ()
							, key_list->get_items ().end ()
						);
						//сортированное множество
						std::set<ADBWithKey> adb_set;
						std::vector<AbstractDumperBase::VarList::value_type> sorted_adb_vector;

						for (size_t i = 0; i < key_vector.size (); ++i) {
							adb_set.insert (ADBWithKey (key_vector[i], adb_vector[i]));
						}
						if (adb_set.size () != key_vector.size ()) {
							//список ключей оказался неуникальным
							std::string mess (GDS_CURRENT_FUNCTION);
							mess += " - key list must be unique";
							LOG_D (("Key list size = %d, sorted source list size = %d", key_vector.size (), adb_set.size ()));
							throw Base::FatalError (mess);
						}

						std::set<ADBWithKey>::iterator it = adb_set.begin ();
						std::set<ADBWithKey>::iterator it_end = adb_set.end ();
						
						for (; it != it_end; ++it) {
							sorted_adb_vector.push_back ((*it).adb);
						}
						
						container->clear ();
						std::for_each (
							sorted_adb_vector.begin ()
							, sorted_adb_vector.end ()
							, boost::bind<void> (
								ConainerAdder ()
								, boost::ref (*container)
								, _1
							)
						);
					}
					break;
				default:
					break;
			}
		}
	}
	//#UC END# *4B7539DF01B0_4B7539FC025B*
}

// implemented method from ContainerOperations::ContainerTemplateOperations
void ContainerTemplateOperationsImpl::unique (
	TemplatePainter::ContainerDumper* container
	, const std::string& command
	, TemplatePainter* painter
) const {
	//#UC START# *4B7539E8013D_4B7539FC025B*
	boost::function<bool (const AbstractDumperBase*, const AbstractDumperBase*)> sort_functor;
	boost::function<bool (const AbstractDumperBase*, const AbstractDumperBase*)> unique_functor;
	
	if (!command.empty ()) {
		sort_functor = LessByTemplateCommand (command, painter);
		unique_functor = EqualByTemplateCommand (command, painter);
	} else {
		sort_functor = AbstractDumperBase::SortByUIDAndName ();
		unique_functor = AbstractDumperBase::IsEqual ();
	}
	
	AbstractDumperBase::VarList list (container->get_items ());
	typedef AbstractDumperBase::VarList::value_type VarListValueType;

	list.sort (
		boost::bind (
			sort_functor
				, boost::bind (
				static_cast<const AbstractDumperBase* (VarListValueType::*) () const> (&VarListValueType::ptr)
				, _1
			)
			, boost::bind (
				static_cast<const AbstractDumperBase* (VarListValueType::*) () const> (&VarListValueType::ptr)
				, _2
			)
		)
	);
	list.unique (
		boost::bind (
			unique_functor
			, boost::bind (
				static_cast<const AbstractDumperBase* (VarListValueType::*) () const> (&VarListValueType::ptr)
				, _1
			)
			, boost::bind (
				static_cast<const AbstractDumperBase* (VarListValueType::*) () const> (&VarListValueType::ptr)
				, _2
			)
		)
	);
	
	container->clear ();
	container->add (list);
	//#UC END# *4B7539E8013D_4B7539FC025B*
}
} // namespace ContainerOperationsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

