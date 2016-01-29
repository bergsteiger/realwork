////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseDumpers::RoseHelper
// Файл реализации утилитного набора RoseHelper
//
// вспомогательные функции в основном для работы с интерфейсов Розы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
// by <<uses>> dependencies
#include "shared/GCL/alg/CycleChecker.h"
#include "shared/GCL/alg/container_op.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "boost/algorithm/string/erase.hpp"
#include "shared/GCL/os/FileOp.h"
#include "shared/WinGUI/Helpers/WindowHelper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
#include "MDProcess/MDAModel/RoseDumpers/DiagramColorizer.h"
#include "MDProcess/MDAModel/RoseDumpers/ModelStamp.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseCopyHelper.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "boost/regex.hpp"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

//#UC START# *4571F040008C_CUSTOM_INCLUDES*
#include <afxdlgs.h>
#include <sstream>
#include <boost/token_iterator.hpp>
#include "MDProcess/MDAGenerator/MDAGenerator.h"
#include "shared/GCL/math/NumericTraits.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
#include "MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"
#include "boost/lambda/lambda.hpp"
#include "boost/lambda/bind.hpp"
#include "boost/lambda/if.hpp"
#include "boost/lambda/casts.hpp"
#include "boost/bind.hpp"
//#UC END# *4571F040008C_CUSTOM_INCLUDES*

namespace RoseHelper {

//#UC START# *4571F040008C*
typedef std::vector <IRoseClassDiagramPtr> Diagrams;
typedef std::set<std::string> UndeletebleItems;
typedef std::set<std::string> UnmanagedDeps;
typedef GCL::CycleChecker<std::string> AllVisibleItemCC;

static AllVisibleItemCC g_all_visible_item_cc;
static IRoseApplicationPtr s_rose_app = NULL;
static bool s_template_is_loaded = false;
static GCL::StrSet s_incremented_counters;

typedef ACE_Singleton <WinGUI::CImageListEx, ACE_SYNCH_RECURSIVE_MUTEX> RoseImageListSingleton;

AvailableParentByConstrMap g_available_parent_by_constr_map;
//////////////////////////////////////////////////
// private declaration

void find_all_visible_item (IRoseCategoryPtr from, const std::string& stereotype, GCL::StrSet& result, bool is_root = 1);

void find_all_child_item (IRoseElementPtr from, const std::string& stereotype, GCL::StrSet& result);

RoseItemMap uids_to_items (IRoseCategoryPtr from, GCL::StrSet& uids);

//////////////////////////////////////////////////
// all definitions

GCL::StrSet& get_changed_diags () {
	static GCL::StrSet res;
	return res;
}

void clear_incremented_counters () {
	RoseHelper::s_incremented_counters.clear();
}

IRoseApplicationPtr rose_app () {
	return s_rose_app;
}

void set_rose_app (IRoseApplicationPtr app) {
	s_rose_app = app;
}

const std::string make_template_file (const std::string& file_name) {
	std::string drive;
	std::string dir;
	std::string fname;
	std::string ext;

	GCL::FileOp::splitpath (file_name, drive, dir, fname, ext, false);
	if (drive.empty () == false) {
		return file_name;
	} else {
		std::string templ_dir = MDAModelParams::get_templates_dir();
		return templ_dir + file_name;
	}
	return std::string ();
}
//фукция проверяет нужно ли перечитывать шаблон
//сначала пытаемся открыть файл шаблона, если это не удаётся - выбрасывается исключение
//если файл открыть удалось
void reset_template () {
	if (!GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()) {
		GenSupport::ErrorManagerFactory::get ().clear_errors ();
	}

	size_t errors_before_parse = GenSupport::ErrorManagerFactory::get ().get_errors ().size ();

	{
		GenSupport::AutoErrorSuppress auto_suppress (false);
		bool reset = false;
		
		bool by_parent;
		IRoseElementPtr root = RoseHelper::s_rose_app->CurrentModel->GetRootCategory();
		//std::string templ_dir = Core::ParamManagerFactory::get ().get_string ("-TemplatesDir");
		//std::string template_file_path = templ_dir + ;
		std::string template_file_path = RoseHelper::make_template_file (get_template_file (root, by_parent));
		
		std::ifstream templ_file (template_file_path.c_str (), std::ios::in);
		if (!templ_file.is_open ()) {
			//пытаемся открыть файл с диска
			std::string file_name = RoseHelper::open_template_file (false);
			template_file_path = RoseHelper::make_template_file (file_name);
			templ_file.open (template_file_path.c_str (), std::ios::in);
			if (templ_file.is_open ()) {
				//удалось открыть файл с диска - нужно записать в настройки
				RoseHelper::set_template_file (root, file_name);			
			} else {
				std::string mess ("Не удалось открыть шаблон: " + file_name);
				
				GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
				GenSupport::LogManagerFactory::get ().log_error (mess);
			}
		}
		if (templ_file.is_open ()) {
			//файл существует
			templ_file.close ();
			reset = AbstractDumperBase::TemplateLoader::instance ()->check_template_changed (template_file_path);		
		}
		if (reset) {
			s_template_is_loaded = false;
			
			g_available_parent_by_constr_map.clear ();
			AbstractDumperBase::clean_up ();
		}
	}

	if (
		errors_before_parse < GenSupport::ErrorManagerFactory::get ().get_errors ().size ()
		&& !GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()
	) {
		throw Base::FatalError ("В процессе загрузки шаблона возникли ошибки");
	}
}

bool load_template () {
	if (!s_template_is_loaded) {
		size_t errors_before_parse = GenSupport::ErrorManagerFactory::get ().get_errors ().size ();

		{
			if (!GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()) {
				GenSupport::ErrorManagerFactory::get ().clear_errors ();
			}

			GenSupport::AutoErrorSuppress auto_suppress (false);

			bool reset = false;

			g_available_parent_by_constr_map.clear ();
			AbstractDumperBase::clean_up ();

			const AbstractDumperBase::TemplateData data 
				= AbstractDumperBase::TemplateLoader::instance ()->get_template_data ();
			AbstractDumperBase::TemplateParser parser;
			
			parser.parse (data);
			s_template_is_loaded = errors_before_parse >= GenSupport::ErrorManagerFactory::get ().get_errors ().size ();
		}
		
		if (
			errors_before_parse < GenSupport::ErrorManagerFactory::get ().get_errors ().size ()
			&& !GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()
		) {
			throw Base::FatalError ("В процессе разбора шаблона возникли ошибки");
		}

		return true;
	} else {
		return true;
	}	
}

//сбрасывает кэш для элемента и всех его детей
void reset_gen_stereotype (IRoseElementPtr item) {
	AbstractDumperBase::s_stereotypes.erase (get_rose_element_uid(item));
	
	Core::Aptr<RoseElementSet> childs = RoseHelper::get_all_childs (item);
	if (!childs.is_nil ()) {
		for (
			RoseElementSet::iterator it = childs->begin ()
			; it != childs->end ()
			; ++it
		) {
			RoseHelper::reset_gen_stereotype (it->element);
		}
	}
}

AbstractDumperBase::StereotypeID create_gen_stereotype (IRoseElementPtr item) {
#if !defined (GDS_NLOG_DEBUG)
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);	
#endif
	if (item == 0) {
		return AbstractDumperBase::StereotypeID ("bad item");
	}

	AbstractDumperBase::RoseStereotypeMap::iterator stereotype = AbstractDumperBase::s_stereotypes.find (get_rose_element_uid(item));
	if (stereotype == AbstractDumperBase::s_stereotypes.end ()) {
		std::string ret;
		
		//std::string item_stereotype (static_cast<const char*> (rose_item->Stereotype));
		IRoseItemPtr rose_item = item;
		if (
			item->IsClass (CATEGORY_TYPE) 
			|| item->IsClass (CLASS_TYPE)			
		) {
			ret = rose_item->Stereotype;
						
			if (ret.empty ()) {
				ret = AbstractDumperBase::UNSTEREOTYPED_ID;
			}		
		} else {
			IRoseElementPtr par;
			if (item->IsClass ("StateMachine")) {
				par = ((IRoseStateMachinePtr)item)->StateMachineOwner->GetParentItem ();
			} else if (item->IsClass ("Event")) {
				par = ((IRoseEventPtr)item)->GetAction ();
			} else if (rose_item) {
				par = RoseHelper::get_context (rose_item);
			}
					
			if (item->IsClass ("Role")) {
				IRoseClassPtr cls = ((IRoseRolePtr)item)->Class;
				if (cls) {
					ret = create_gen_stereotype (				
						((IRoseRolePtr)item)->Association->GetOtherRole(cls)->Class
					);
				} else {
					ret = AbstractDumperBase::UNSTEREOTYPED_ID;
				}
			} else if (item->IsClass ("State")) {
				IRoseStatePtr state = item;
				IRoseItemPtr parent = state->GetContext ();				
				ret = create_gen_stereotype (
					parent
				);
				if (ret.empty ()) {
					ret = AbstractDumperBase::UNSTEREOTYPED_ID;
				}
			} else {
				ret = create_gen_stereotype (par);
			}
		}
		if (
			rose_item
			&& rose_item->Stereotype != _bstr_t("")
			&& rose_item->Stereotype != _bstr_t("<default>")			
			&&	(
				item->IsClass ("Role") 
				|| item->IsClass (CLASS_DEPENDENCY_TYPE) 
				|| item->IsClass (ATTRIBUTE_TYPE) 
				|| item->IsClass (OPERATION_TYPE)
				|| item->IsClass ("State")
				|| item->IsClass ("Transition")
			)
			
			
		) {
			ret += "::" + std::string (static_cast<const char*> (rose_item->Stereotype));
		}

		if (item->IsClass ("Role")) {
			ret += "::Attribute";
		} else {
			ret += "::" + std::string (static_cast<const char*> (item->IdentifyClass()));
		}

		stereotype = AbstractDumperBase::s_stereotypes.insert (
			AbstractDumperBase::RoseStereotypeMap::value_type (get_rose_element_uid(item), AbstractDumperBase::StereotypeID (ret))
		).first;
	}
	
	return stereotype->second;
}
AbstractDumperBase::StereotypeID get_gen_stereotype (IRoseElementPtr item) {
	AbstractDumperBase::StereotypeID ret (create_gen_stereotype (item));

	if (!AbstractDumperBase::has_template(ret)) {		
		GCL::StrVector part = GCL::split_string_by_sub_string (ret/*.get ()*/.data(), "::");
		part[0] = "default";
		ret = GCL::join(part, "::");
	}

	return ret;
}

IRoseCategoryPtr get_parent_category (IRoseElementPtr item) {
	if (item == 0) {
		return 0;
	}
	if ( item->IsClass(CATEGORY_TYPE) ) {
		return ((IRoseCategoryPtr)item)->GetParentCategory();
	}

	IRoseElementPtr parent_item = RoseHelper::get_context(item);
	
	if (parent_item == 0) {
		return 0;
	}
	if (parent_item->IsClass(CATEGORY_TYPE) ) {
		return parent_item;
	}
	return get_parent_category (parent_item);
}

IRoseItemPtr get_nearest_container (IRoseElementPtr item) {
	//TRACE ("Item name - %s, st - %s, class  - %s\n", (const char*)item->Name, (const char*)item->Stereotype, (const char*)item->IdentifyClass());
	if (item == 0) {
		return NULL;
	}
	if (
		item->IsClass(CLASS_TYPE) 
		|| item->IsClass(CATEGORY_TYPE)
		|| item->IsClass("State")
		|| item->IsClass("Transition")
	) {
		return item;
	}

	IRoseElementPtr parent_item = RoseHelper::get_context (item);
	if (parent_item == NULL) {
		return NULL;
	}

//	if (parent_item->IsClass(CLASS_TYPE) || item->IsClass(CATEGORY_TYPE)) {
//		return parent_item;
//	}
	return get_nearest_container (parent_item);
}

void find_all_visible_item (IRoseCategoryPtr from, const std::string& stereotype, GCL::StrSet& result, bool is_root) {
	if (from == NULL) {
		return;
	}

	AllVisibleItemCC::Iteration iteration (g_all_visible_item_cc, get_rose_element_uid(from));
	if (iteration.is_cycled()) {
		return;
	}	

	if (is_root) {
		IRoseCategoryPtr par = from->GetParentCategory();
		if (par) { 
			IRoseClassCollectionPtr dep_clss = par->Classes;
			short dep_clss_count = dep_clss->Count;
			for (short l = 1; l <= dep_clss_count; l++) {
				IRoseClassPtr dep_cls = dep_clss->GetAt(l);
				if ( dep_cls->Stereotype == _bstr_t (stereotype.data()) ) {			
					result.insert (get_rose_element_uid(dep_cls));
				}				
			}
		}
	}

	IRoseClassCollectionPtr dep_clss = from->Classes;
	short dep_clss_count = dep_clss->Count;
	for (int l=1; l <= dep_clss_count; l++) {
		IRoseClassPtr dep_cls = dep_clss->GetAt(l);
		if (RoseHelper::get_gen_stereotype (dep_cls) == stereotype) {
			result.insert (get_rose_element_uid(dep_cls));			
		}
		find_all_child_item (dep_cls, stereotype, result);
	}

	IRoseCategoryDependencyCollectionPtr deps = from->GetCategoryDependencies();
	short i;
	short deps_count = deps->Count;
	for (i = 1; i <= deps_count; i++) {
		IRoseCategoryDependencyPtr dep = deps->GetAt(i);
		try {
			IRoseCategoryPtr supl_cat = dep->GetSupplierCategory();
			find_all_visible_item (supl_cat, stereotype, result, 0);
		} catch (...) {
			//shit
			std::string message ("Неудачный вызов GetSupplierCategory для элемента: ");
			message += RoseHelper::get_full_name (from);
			message += ". Возможно неправильно проведена стрелка зависимости (нельзя проводить стрелку от пакета к классу, и наоборот)";
			GenSupport::LogManagerFactory::get ().log_error (message.c_str ());
			throw;
		}
	}
}

void find_all_child_item (IRoseElementPtr from, const std::string& stereotype, GCL::StrSet& result) {
	TRACE("find_all_child_item: %s\n", (const char*)from->GetName ());
	if (from == NULL) {
		return;
	}

	if (from->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr from_cat = (IRoseCategoryPtr) from;

		IRoseCategoryCollectionPtr cats = from_cat->GetCategories();
		short cats_count = cats->Count;
		for (short l=1; l <= cats_count; l++) {
			IRoseCategoryPtr cat = cats->GetAt(l);
			if (RoseHelper::get_gen_stereotype (cat) == stereotype) {
				result.insert (get_rose_element_uid(cat));
			}
			find_all_child_item (cat, stereotype, result);
		}

		IRoseClassCollectionPtr clss = from_cat->Classes;
		short clss_count = clss->Count;
		for (short l=1; l <= clss_count; l++) {
			IRoseClassPtr cls = clss->GetAt(l);
			if (RoseHelper::get_gen_stereotype (cls) == stereotype) {
				result.insert (get_rose_element_uid(cls));
			}
			find_all_child_item (cls, stereotype, result);
		}		
	} else if (from->IsClass (CLASS_TYPE)) {
		IRoseClassPtr from_cls = (IRoseClassPtr) from;

		IRoseClassCollectionPtr clss = from_cls->GetNestedClasses();
		short clss_count = clss->Count;
		for (short l=1; l <= clss_count; l++) {
			IRoseClassPtr cls = clss->GetAt(l);
			if (RoseHelper::get_gen_stereotype (cls) == stereotype) {
				result.insert (get_rose_element_uid(cls));
			}
			find_all_child_item (cls, stereotype, result);
		}
	}	
}

RoseItemMap find_all_visible_ex (IRoseElementPtr from, const GCL::StrSet& stereotypes) {
	IRoseCategoryPtr from_cat = RoseHelper::get_parent_category (from);
	if (from_cat == NULL) {
		return RoseItemMap();
	}

	IRoseItemPtr from_cont = RoseHelper::get_nearest_container (from);
	if (from_cont == NULL) {
		return RoseItemMap();
	}

	GCL::StrSet uids;
	for (GCL::StrSet::const_iterator it = stereotypes.begin(); it != stereotypes.end(); it++) {
		find_all_visible_item (from_cat, *it, uids);
		find_all_child_item (from_cont, *it, uids);
		if (get_rose_element_uid(from_cont) != get_rose_element_uid(from_cat)) {
			find_all_child_item (from_cat, *it, uids);
		}
	}

	return uids_to_items (from_cat, uids);
}
RoseItemMap find_all_visible_item (IRoseElementPtr from, const GCL::StrSet& stereotypes) {
	IRoseCategoryPtr from_cat = RoseHelper::get_parent_category (from);
	if (from_cat == NULL) {
		return RoseItemMap();
	}

	IRoseItemPtr from_cont = RoseHelper::get_nearest_container (from);
	if (from_cont == NULL) {
		return RoseItemMap();
	}

	GCL::StrSet uids;
	for (GCL::StrSet::const_iterator it = stereotypes.begin(); it != stereotypes.end(); it++) {
		find_all_visible_item (from_cat, *it, uids);
		find_all_child_item (from_cont, *it, uids);
	}

	return uids_to_items (from_cat, uids);
}

//всопомогательный алгоритм для сбора идентификаторов реализуемых элементов
template <class Collection, class Result, typename Predicate>
struct UIDCollector {
	static void apply (const Collection& collection, Result& res, Predicate filter = Predicate ()) {
		short count = collection->Count;

		for (short i = 1; i <= count; i++) {
			IRoseElementPtr elem = collection->GetAt(i);
			if (filter (elem)) {
			//if (RoseHelper::is_metatype_derivedable_or_implementable (elem) & RoseHelper::is_it_abstract (elem)) {
				GCL::ContainerTraits<Result>::append (res, get_rose_element_uid(elem));
			}
		}
	}
};

bool is_metatype_derivedable_or_implementable (const RoseAbstractDumper* rad) {
	std::string model_class_str =  rad->get_model_class_str ();
	return RoseHelper::is_it_implementable (rad) && (
		model_class_str == std::string (ATTRIBUTE_TYPE)
		|| model_class_str == std::string (OPERATION_TYPE)
		|| model_class_str == std::string (CLASS_TYPE)
	);
}

bool is_metatype_derivedable_or_implementable (IRoseElementPtr elem) {
	return RoseHelper::is_it_implementable (elem) && (
		elem->IsClass (ATTRIBUTE_TYPE)
		|| elem->IsClass (OPERATION_TYPE)
		|| elem->IsClass (CLASS_TYPE)
		|| (
			elem->IsClass ("Role")
			&& ((IRoseRolePtr)elem)->HasSupplier ()
			&& RoseHelper::is_attribute_role ((IRoseRolePtr)elem)
		)
	);
}

//TODO: перенести на InheritedItemHelper
void get_derived_methods_from_prop (IRoseElementPtr item, _bstr_t& prop_name, GCL::StrSet& methods) {
	Core::Aptr<InheritedItemSet> from_prop = InheritedItemHelperFactory::get ().get_stored_inherited_items (
		item
		, std::string (static_cast<const char*> (prop_name))
	);

	ModelSearcher* searcher = &ModelSearcherFactory::get ();
	for (InheritedItemSet::const_iterator it = from_prop->begin (); it != from_prop->end (); ++it) {
		IRoseItemPtr prop_item = searcher->search ((*it)->get_uid ());
		if (prop_item) {
			if (prop_item->IsClass (CLASS_TYPE) && (*it)->get_need_collect_children ()) {
				//если в настройках был записан гуид класса -
				//собираем все его операции и атрибуты

				IRoseClassPtr cls = prop_item;

				IRoseAttributeCollectionPtr attrs = cls->GetAttributes();
				IRoseOperationCollectionPtr ops = cls->GetOperations();
				IRoseClassCollectionPtr clss = cls->GetNestedClasses ();
				
				typedef boost::function<bool (IRoseElementPtr)> Filter;
				Filter filter = boost::lambda::constant (true);
				/*Filter filter = boost::lambda::if_then_else (
					boost::lambda::bind (&IRoseElement::IsClass, boost::lambda::_1)
					, boost::lambda::ll_static_cast<bool> (
						boost::lambda::bind (&IRoseRole::HasSupplier, boost::lambda::ll_static_cast<IRoseRolePtr> (boost::lambda::_1))
						&& boost::lambda::bind (&is_attribute_role, boost::lambda::ll_static_cast<IRoseRolePtr> (boost::lambda::_1))
					)
					, boost::lambda::constant (true)
				);*/

				UIDCollector<IRoseAttributeCollectionPtr, GCL::StrSet, Filter>::apply (attrs, methods, filter);
				UIDCollector<IRoseOperationCollectionPtr, GCL::StrSet, Filter>::apply (ops, methods, filter);
				UIDCollector<IRoseClassCollectionPtr, GCL::StrSet, Filter>::apply (clss, methods, filter);

				IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
				int rl_attrs_count = rl_attrs->Count;
				for (short i = 1; i <= rl_attrs_count; i++) {
					IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
					if (
						rl_attr->HasSupplier () //проверяем, что связь к чему-то идёт, 
												//иначе нет смысла её добавлять в дерево
						&& RoseHelper::is_attribute_role (rl_attr)
					) {
						std::string uid (get_rose_element_uid(rl_attr));
						methods.insert (uid);
					}
				}
			} else {
				methods.insert ((*it)->get_uid ());
			}
		}
	}
}

//TODO: перенести на InheritedItemHelper
void get_derived_methods_from_prop (const RoseAbstractDumper* item, _bstr_t& prop_name, RoseAbstractDumper::UnorderedRADSet& methods) {
	Core::Aptr<InheritedItemSet> from_prop = InheritedItemHelperFactory::get ().get_stored_inherited_items (
		item
		, std::string (static_cast<const char*> (prop_name))
	);

	for (InheritedItemSet::const_iterator it = from_prop->begin (); it != from_prop->end (); ++it) {
		RoseAbstractDumper* prop_item = RoseAbstractDumper::find_in_tree ((*it)->get_uid ());
		if (prop_item) {
			if (prop_item->get_model_class_str () == CLASS_TYPE && (*it)->get_need_collect_children ()) {
				//если в настройках был записан гуид класса -
				//собираем все его операции и атрибуты
				Core::Aptr<AbstractDumperBase::ADList> contents = prop_item->get_contents ();
				if (!contents.is_nil ()) {
					for (
						AbstractDumperBase::ADList::const_iterator c_it = contents->begin ()
						; c_it != contents->end ()
						; ++c_it
					) {
						const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (*c_it);
						
						if (is_metatype_derivedable_or_implementable (rad)) {
							methods.insert (rad);
						}
					}
				}
			} else {
				methods.insert (prop_item);
			}
		}
	}
}

RoseItemMap find_all_derived_abstract (IRoseElementPtr from) {
	if (from == NULL) {
		return RoseItemMap();
	}

	GCL::StrSet uids;
	RoseHelper::find_all_derived_abstract (from, uids);

	return uids_to_items (RoseHelper::get_parent_category(from), uids);
}

void get_self_abstract (const RoseAbstractDumper* self, RoseAbstractDumper::UnorderedRADSet& res) {
	// self
	Core::Aptr<AbstractDumperBase::ADList> contents = self->get_contents ();
	if (!contents.is_nil ()) {
		for (
			AbstractDumperBase::ADList::const_iterator it = contents->begin ()
			; it != contents->end ()
			; ++it
		) {
			const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (*it);
			std::string rad_class_str = rad->get_model_class_str ();
			if (
				is_metatype_derivedable_or_implementable (rad)
				& RoseHelper::is_it_abstract (rad)
			) {
				res.insert (rad);
			}
		}
	}
}

//TODO: перенести на InheritedItemHelper
void find_all_derived_abstract (const RoseAbstractDumper* from, RoseAbstractDumper::UnorderedRADSet& res) {
	class local {
	public:
		static void fill (const AbstractDumperBase::ADList& list, RoseAbstractDumper::UnorderedRADSet& result) {
			for (
				AbstractDumperBase::ADList::const_iterator it = list.begin ()
				; it != list.end ()
				; ++it
			) {
				const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (*it);
				fill (rad, result);
			}
		}

		static void fill (const RoseAbstractDumper* base, RoseAbstractDumper::UnorderedRADSet& result) {
			if (base != 0) {
				RoseHelper::find_all_derived_abstract (base, result);
				get_self_abstract (base, result);								
			}
		}
	};
	if (from != 0) {
		Core::Aptr<AbstractDumperBase::ADList> realizations =  from->get_realizations ();
		if (!realizations.is_nil ()) {
			local::fill (*realizations, res);
		}
		Core::Aptr<AbstractDumperBase::ADList> generalizations =  from->get_generalizations ();
		if (!generalizations.is_nil ()) {
			local::fill (*generalizations, res);
		}
	}
}

template <class Type>
struct ImplementedFilter : public std::unary_function<Type, bool> {
	bool operator () (const Type& arg) {
		return is_metatype_derivedable_or_implementable (arg) && is_it_abstract (arg);
	}
};

//всопомогательный алгоритм для сбора идентификаторов перегружаемых элементов
//возвращает true, если был добавлен опциональный элемент
template <class Collection, class Result>
bool collect_derived_items (const Collection& collection, bool has_it_derived_impl, Result& res) {
	bool has_optional = false;
	short count = collection->Count;
	for (short i = 1; i <= count; i++) {
		IRoseElementPtr elem = collection->GetAt(i);
		if (RoseHelper::is_metatype_derivedable_or_implementable (elem) && !RoseHelper::is_it_abstract (elem)) {			
			if (is_it_optional (elem)) {
				has_optional |= true;
				GCL::ContainerTraits<Result>::append (res, get_rose_element_uid(elem));
			} else if (has_it_derived_impl) {
				GCL::ContainerTraits<Result>::append (res, get_rose_element_uid(elem));
			}
		}
	}

	return has_optional;
}

//TODO: перенести на InheritedItemHelper
void find_all_derived_abstract (IRoseElementPtr from, GCL::StrSet& res) {
	class _local_fill_result {
	public:
		static void fill (IRoseClassPtr base, GCL::StrSet& res) {
			if (base != 0) {
				RoseHelper::find_all_derived_abstract (base, res);

				// self		
				
				IRoseAttributeCollectionPtr attrs = base->GetAttributes();
				IRoseOperationCollectionPtr ops = base->GetOperations();
				IRoseRoleCollectionPtr rl_attrs = base->GetAssociateRoles();
				IRoseClassCollectionPtr clss = base->GetNestedClasses ();

				UIDCollector<IRoseAttributeCollectionPtr, GCL::StrSet, ImplementedFilter<IRoseElementPtr> >::apply (attrs, res);
				UIDCollector<IRoseRoleCollectionPtr, GCL::StrSet, ImplementedFilter<IRoseElementPtr> >::apply (rl_attrs, res);
				UIDCollector<IRoseOperationCollectionPtr, GCL::StrSet, ImplementedFilter<IRoseElementPtr> >::apply (ops, res);
				UIDCollector<IRoseClassCollectionPtr, GCL::StrSet, ImplementedFilter<IRoseElementPtr> >::apply (clss, res);
			}
		}
	};

	if (from != 0 && from->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = from;
		IRoseRealizeRelationCollectionPtr rs = cls->GetRealizeRelations ();

		short i;
		short count = rs->Count;
		for (i = 1; i <= count; i++) {
			IRoseRealizeRelationPtr rel = rs->GetAt(i);
			if (rel) {
				_local_fill_result::fill (rel->GetSupplierClass(), res);
			}
		}
		
		IRoseInheritRelationCollectionPtr is = cls->GetInheritRelations ();
		count = is->Count;
		for (i = 1; i <= count; i++) {
			IRoseInheritRelationPtr rel = is->GetAt(i);
			if (rel) {
				_local_fill_result::fill (rel->GetSupplierClass(), res);
			}
		}
	}
}

RoseItemMap find_all_derived_impl (IRoseElementPtr from) {
	if (from == NULL) {
		return RoseItemMap();
	}

	GCL::StrSet uids;
	RoseHelper::find_all_derived_impl (from, uids);

	return uids_to_items (RoseHelper::get_parent_category(from), uids);
}

//TODO: перенести на InheritedItemHelper
template <typename ResultT>
ResultT& get_implemented_methods (IRoseElementPtr elem, ResultT& res) {
	//ResultT temp;
	Core::Aptr<ImplementedItemSet> implemented = InheritedItemHelperFactory::get ().get_stored_implemented (elem);

	//GCL::split_string_by (temp, static_cast<const char*> (elem->GetPropertyValue(TOOL_NAME, PROP_DERIVED_IMPLEMENT)), ',');
	ModelSearcher* searcher = &ModelSearcherFactory::get ();

	for (ImplementedItemSet::const_iterator it = implemented->begin (); it != implemented->end (); ++it) {
		IRoseItemPtr item = searcher->search ((*it)->get_uid ());
		if (item) {
			if (item->IsClass (CLASS_TYPE) && (*it)->get_need_collect_children ()) {
				IRoseClassPtr cls = item;

				IRoseAttributeCollectionPtr attrs = cls->GetAttributes();
				IRoseOperationCollectionPtr ops = cls->GetOperations();
				IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
				IRoseClassCollectionPtr clss = cls->GetNestedClasses ();

				UIDCollector<IRoseAttributeCollectionPtr, ResultT, ImplementedFilter<IRoseElementPtr> >::apply (attrs, res);
				UIDCollector<IRoseRoleCollectionPtr, ResultT, ImplementedFilter<IRoseElementPtr> >::apply (rl_attrs, res);
				UIDCollector<IRoseOperationCollectionPtr, ResultT, ImplementedFilter<IRoseElementPtr> >::apply (ops, res);
				UIDCollector<IRoseClassCollectionPtr, ResultT, ImplementedFilter<IRoseElementPtr> >::apply (clss, res);
			} else {
				GCL::ContainerTraits<ResultT>::append (res, (*it)->get_uid ());
			}
		}
	}

	return res;
}

//TODO: перенести на InheritedItemHelper
template <typename ResultT>
ResultT& get_implemented_methods_impl (const RoseAbstractDumper* elem, ResultT& res) {
	Core::Aptr<ImplementedItemSet> implemented = InheritedItemHelperFactory::get ().get_stored_implemented (elem->rose_element ());
	
	ImplementedFilter<const RoseAbstractDumper*> filter;
	for (ImplementedItemSet::const_iterator it = implemented->begin (); it != implemented->end (); ++it) {
		RoseAbstractDumper* item = RoseAbstractDumper::find_in_tree ((*it)->get_uid ());
		if (item) {
			if (item->get_model_class_str () == CLASS_TYPE && (*it)->get_need_collect_children ()) {
				Core::Aptr<AbstractDumperBase::ADList> contents = item->get_contents ();
				if (!contents.is_nil ()) {
					for (
						AbstractDumperBase::ADList::const_iterator c_it = contents->begin ()
						; c_it != contents->end ()
						; ++c_it
					) {
						const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (*c_it);
						if (filter (rad)) {
							GCL::ContainerTraits<ResultT>::append (res, rad);
						}
					}
				}
			} else {
				GCL::ContainerTraits<ResultT>::append (res, item);
			}
		}		
	}

	return res;
}

//TODO: перенести на InheritedItemHelper
void get_implemented_methods (const RoseAbstractDumper* elem, RoseAbstractDumper::UnorderedRADSet& res) {
	get_implemented_methods_impl (elem, res);
}

//TODO: перенести на InheritedItemHelper
void find_all_derived_impl (const RoseAbstractDumper* from, RoseAbstractDumper::UnorderedRADSet& res) {
	class local {
	public:
		static void fill (const AbstractDumperBase::ADList& list, RoseAbstractDumper::UnorderedRADSet& result) {
			for (
				AbstractDumperBase::ADList::const_iterator it = list.begin ()
				; it != list.end ()
				; ++it
			) {
				const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (*it);
				fill (rad, result);
			}
		}

		static void fill (const RoseAbstractDumper* base, RoseAbstractDumper::UnorderedRADSet& result) {
			if (base != 0) {
				RoseHelper::find_all_derived_impl (base, result);

				RoseAbstractDumper::UnorderedRADSet temporary;
				bool has_optional_methods = false;
				bool has_it_derived_impl = RoseHelper::has_it_derived_impl (base->rose_element ());
				
				// self
				Core::Aptr<AbstractDumperBase::ADList> contents = base->get_contents ();
				if (!contents.is_nil ()) {
					for (
						AbstractDumperBase::ADList::const_iterator it = contents->begin ()
						; it != contents->end ()
						; ++it
					) {
						const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (*it);
						std::string rad_class_str = rad->get_model_class_str ();
						if (
							RoseHelper::is_metatype_derivedable_or_implementable (rad)
							&& !RoseHelper::is_it_abstract (rad)
						) {
							if (is_it_optional (rad)) {
								has_optional_methods |= true;
								temporary.insert (rad);
							} else if (has_it_derived_impl) {
								temporary.insert (rad);
							}
						}
					}
				}

				result.insert (temporary.begin (), temporary.end ());
				if (has_it_derived_impl) {
					std::string sel_type = RoseHelper::get_implement_select_type (base);
					if (sel_type == "exclude") {
						RoseAbstractDumper::UnorderedRADSet all_abstr;
						RoseHelper::find_all_derived_abstract (base, all_abstr);
						
						RoseAbstractDumper::UnorderedRADSet implemented;
						get_implemented_methods_impl (base, implemented);
						
						for (
							RoseAbstractDumper::UnorderedRADSet::iterator it = all_abstr.begin()
							; it != all_abstr.end()
							; ++it
						) {
							if (implemented.find (*it) == implemented.end ()) {
								result.insert (*it);
							}
						}
					} else if (sel_type == "include") {
						RoseAbstractDumper::UnorderedRADSet implemented;
						get_implemented_methods_impl (base, implemented);
						
						result.insert (implemented.begin(), implemented.end());						
					} else {
						//если All		
						RoseAbstractDumper::UnorderedRADSet all_abstr;
						RoseHelper::find_all_derived_abstract (base, all_abstr);

						result.insert (all_abstr.begin(), all_abstr.end());
					}
				}
			}
		}
	};
	if (from != 0) {
		Core::Aptr<AbstractDumperBase::ADList> realizations =  from->get_realizations ();
		if (!realizations.is_nil ()) {
			local::fill (*realizations, res);
		}
		Core::Aptr<AbstractDumperBase::ADList> generalizations =  from->get_generalizations ();
		if (!generalizations.is_nil ()) {
			local::fill (*generalizations, res);
		}
	}
}

//TODO: перенести на InheritedItemHelper
void find_all_derived_impl (IRoseElementPtr from, GCL::StrSet& res) {
	class _local_fill_result {
	public:
		static void fill (IRoseClassPtr base, GCL::StrSet& res) {
			if (base == 0) {
				return;
			}
			
			RoseHelper::find_all_derived_impl (base, res);
			
			GCL::StrSet temporary;
			bool has_optional_methods = false;
			bool has_it_derived_impl = RoseHelper::has_it_derived_impl (base);

			//self
			IRoseAttributeCollectionPtr attrs = base->GetAttributes();
			IRoseRoleCollectionPtr rl_attrs = base->GetAssociateRoles();
			IRoseOperationCollectionPtr ops = base->GetOperations();
			IRoseClassCollectionPtr clss = base->GetNestedClasses ();

			has_optional_methods |= collect_derived_items (attrs, has_it_derived_impl, temporary);
			has_optional_methods |= collect_derived_items (rl_attrs, has_it_derived_impl, temporary);
			has_optional_methods |= collect_derived_items (ops, has_it_derived_impl, temporary);
			has_optional_methods |= collect_derived_items (clss, has_it_derived_impl, temporary);


			res.insert (temporary.begin (), temporary.end ());

			if (has_it_derived_impl) {
				std::string sel_type = RoseHelper::get_implement_select_type (base);
				if (sel_type == "exclude") {
					GCL::StrSet all_abstr;
					RoseHelper::find_all_derived_abstract (base, all_abstr);
					
					GCL::StrVector implemented;
					get_implemented_methods (base, implemented);
					
					for (GCL::StrSet::iterator it = all_abstr.begin(); it != all_abstr.end(); it++) {
						if (std::find (implemented.begin(), implemented.end(), *it) == implemented.end()) {
							res.insert (*it);
						}
					}
				} else if (sel_type == "include") {
					GCL::StrVector implemented;
					get_implemented_methods (base, implemented);
								
					for (GCL::StrVector::iterator it = implemented.begin(); it != implemented.end(); it++) {
						res.insert (*it);
					}
				} else {
					//если 					
					GCL::StrSet all_abstr;
					RoseHelper::find_all_derived_abstract (base, all_abstr);
					for (GCL::StrSet::iterator it = all_abstr.begin(); it != all_abstr.end(); it++) {
						res.insert (*it);
					}
				}
			}
		}
	};

	if (from != 0 && from->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = from;
		IRoseRealizeRelationCollectionPtr rs = cls->GetRealizeRelations ();
		short i;
		short count = rs->Count;
		for (i = 1; i <= count; i++) {
			IRoseRealizeRelationPtr rel = rs->GetAt(i);
			if (rel) {
				_local_fill_result::fill (rel->GetSupplierClass(), res);
			}
		}
		
		IRoseInheritRelationCollectionPtr is = cls->GetInheritRelations ();
		count = is->Count;
		for (i = 1; i <= count; i++) {
			IRoseInheritRelationPtr rel = is->GetAt(i);
			if (rel) {
				_local_fill_result::fill (rel->GetSupplierClass(), res);
			}
		}
	}
}

//TODO: перенести на InheritedItemHelper
const std::string get_implement_select_type (const RoseAbstractDumper* elem) {
	return elem->get_property_value (std::string (_bstr_t(TOOL_NAME)), std::string (_bstr_t(PROP_IMPLEMENT_SELECT_TYPE)));
}

//TODO: перенести на InheritedItemHelper
std::string get_implement_select_type (const IRoseElementPtr elem) {
	std::string sel_type = static_cast<const char*> (elem->GetPropertyValue(TOOL_NAME, PROP_IMPLEMENT_SELECT_TYPE));	

	///откатили в связи с: http://mdp.garant.ru/pages/viewpage.action?pageId=134316253

	////если элемент абстрактный и для него явно не задано свойство PROP_IMPLEMENT_SELECT_TYPE
	////и он может сам реализовывать абстрактные методы!
	////то считаем его установленным в "include"
	//if (sel_type.empty () && RoseHelper::has_it_derived_impl (elem)) {
	//	std::string abstract_type = RoseHelper::get_abstraction_type_str (elem);
	//	if (abstract_type == "abstract") {
	//		sel_type = "include";
	//	}
	//}

	return sel_type;
}


const std::string get_visibility_type (IRoseElementPtr item) {
	if (item->IsClass(CLASS_TYPE)) {
		return (char*) ((IRoseClassPtr)item)->ExportControl->Name;
	} else if (item->IsClass(ATTRIBUTE_TYPE)) {
		return (char*) ((IRoseAttributePtr)item)->ExportControl->Name;
	} else if (item->IsClass("HasRelationship")) {
		return (char*) ((IRoseHasRelationshipPtr)item)->ExportControl->Name;
	} else if (item->IsClass(OPERATION_TYPE)) {
		return (char*) ((IRoseOperationPtr)item)->ExportControl->Name;
	} else if (item->IsClass("Role")) {
		return (char*) ((IRoseRolePtr)item)->ExportControl->Name;
	} else {
		std::string ret = item->GetPropertyValue(TOOL_NAME, Base::VISIBILITY_TYPE);
		if (ret.empty ()) {			
			AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);	
			char vt = AbstractDumperBase::get_template (stereotype).visability_type;

			if (vt & VTF_PUBLIC) {
				return "PublicAccess";
			} else if (vt & VTF_PROTECTED) {
				return "ProtectedAccess";
			} else if (vt & VTF_PRIVATE) {
				return "PrivateAccess";
			} else if (vt & VTF_IMPL) {
				return "ImplementationAccess";
			} else {
				return "PublicAccess";
			}
		} else {
			return ret;
		}
	}
}

const std::string get_visibility_type(const RoseAbstractDumper* item) {
	std::string ret = item->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (Base::VISIBILITY_TYPE))
	);

	if (ret.empty ()) {
		return get_visibility_type (item->rose_element ());
	}

	return ret;
}

void set_visibility_type (const RoseAbstractDumper* item, const std::string& vt, bool persist) {
	if (persist) {
		set_visibility_type (item->rose_element (), vt);
	}

	item->set_temporary_property (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (Base::VISIBILITY_TYPE))
		, vt
	);
}

void set_visibility_type (IRoseElementPtr item, const std::string& vt) {
	if (item->IsClass(CLASS_TYPE)) {
		((IRoseClassPtr)item)->ExportControl->Name = vt.data();
	} else if (item->IsClass(ATTRIBUTE_TYPE)) {
		((IRoseAttributePtr)item)->ExportControl->Name = vt.data();
	} else if (item->IsClass("HasRelationship")) {
		((IRoseHasRelationshipPtr)item)->ExportControl->Name = vt.data();
	} else if (item->IsClass(OPERATION_TYPE)) {
		((IRoseOperationPtr)item)->ExportControl->Name = vt.data();
	} else if (item->IsClass("Role")) {
		((IRoseRolePtr)item)->ExportControl->Name = vt.data();
	} else {
		override_property(item, TOOL_NAME, Base::VISIBILITY_TYPE, vt.data());
	}	
}

void set_default_abstraction_type(IRoseElementPtr item) {
	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);
	AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);
	RoseHelper::override_property(item, TOOL_NAME, Base::ABSTRACTION_TYPE, tpl.def_abstraction_type/*.get ()*/.c_str ());
}

void set_abstraction_type (const RoseAbstractDumper* item, AbstractDumperBase::AbstractionType type) {
}

void set_abstraction_type (IRoseElementPtr item, AbstractDumperBase::AbstractionType type) {
	std::string abstr_type;
	switch (type) {
		case AbstractDumperBase::ATF_REGULAR:
			abstr_type = "regular";
			break;
		case AbstractDumperBase::ATF_ABSTRACT:
			abstr_type = "abstract";
			break;
		case AbstractDumperBase::ATF_FINAL:
			abstr_type = "final";
			break;
		case AbstractDumperBase::ATF_OPTIONAL:
			abstr_type = "optional";
			break;
	}

	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);
	AbstractDumperBase::Template& tplt = AbstractDumperBase::get_template (stereotype);
	char at = tplt.abstraction_type;
	
	if (!(at & type) || !(at & (~type))) {
		abstr_type = tplt.def_abstraction_type;
	}

	RoseHelper::override_property(item, TOOL_NAME, Base::ABSTRACTION_TYPE, abstr_type.c_str ());
}

const std::string get_abstraction_type_str (const RoseAbstractDumper* item) {
	std::string ret = item->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (Base::ABSTRACTION_TYPE))
	);

	if (ret.empty ()) {
		return get_abstraction_type_str (item->rose_element ());
	} else if (ret == "true") {
		ret = "abstract";
	}

	return ret;
}

const std::string get_abstraction_type_str (IRoseElementPtr item) {
	std::string ret = static_cast<const char*> (item->GetPropertyValue(TOOL_NAME, Base::ABSTRACTION_TYPE));
	if (ret == "true") {
		ret = "abstract";
	} else if (ret == "false" || ret.empty ()) {
		if (item->IsClass (CLASS_TYPE)) {
			if (((IRoseClassPtr)item)->Abstract) {
				return "abstract";
			}
		}
		
		AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);	
		char at = AbstractDumperBase::get_template (stereotype).abstraction_type;

		if (at & AbstractDumperBase::ATF_REGULAR) {
			ret = "regular";
		} else if (at & AbstractDumperBase::ATF_ABSTRACT) {
			ret = "abstract";
		} else if (at & AbstractDumperBase::ATF_FINAL) {
			ret = "final";
		} else if (at & AbstractDumperBase::ATF_OPTIONAL) {
			ret = "optional";
		}
	}

	return ret;
}

AbstractDumperBase::AbstractionType get_abstraction_type (IRoseElementPtr item) {

	std::string ret = static_cast<const char*> (item->GetPropertyValue(TOOL_NAME, Base::ABSTRACTION_TYPE));
	if (ret == "true") {
		return AbstractDumperBase::ATF_ABSTRACT;
	} else if (ret == "false" || ret.empty ()) {
		if (item->IsClass (CLASS_TYPE)) {
			if (((IRoseClassPtr)item)->Abstract) {
				return AbstractDumperBase::ATF_ABSTRACT;
			}
		}
		
		AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);	
		char at = AbstractDumperBase::get_template (stereotype).abstraction_type;

		if (at & AbstractDumperBase::ATF_REGULAR) {
			return AbstractDumperBase::ATF_REGULAR;
		} else if (at & AbstractDumperBase::ATF_ABSTRACT) {
			return AbstractDumperBase::ATF_ABSTRACT;
		} else if (at & AbstractDumperBase::ATF_FINAL) {
			return AbstractDumperBase::ATF_FINAL;
		} else if (at & AbstractDumperBase::ATF_OPTIONAL) {
			return AbstractDumperBase::ATF_OPTIONAL;
		}
	}
	
	if (ret == "regular") {
		return AbstractDumperBase::ATF_REGULAR; 
	} else if (ret == "abstract") {
		return AbstractDumperBase::ATF_ABSTRACT; 
	} else if (ret == "final") {
		return AbstractDumperBase::ATF_FINAL; 
	} else if (ret == "optional") {
		return AbstractDumperBase::ATF_OPTIONAL; 
	}

	GDS_ASSERT_MSG(0,("Unknown abstraction type %s", ret.c_str ()));
	return AbstractDumperBase::ATF_UNDEFINED;
}

bool is_abstraction_type (
	const AbstractDumperBase::StereotypeID& model_stereotype
	, const std::string& abstraction_type_from_property
	, AbstractDumperBase::AbstractionType abstraction_type
	, const std::string& abstraction_type_str
) {
	AbstractDumperBase::Template& tplt = AbstractDumperBase::get_template (model_stereotype);
	char at = tplt.abstraction_type;
	
	if (at & abstraction_type) {
		if (at & (~abstraction_type)) {
			std::string abstr (abstraction_type_from_property);
			if (abstr.empty ()) {
				abstr = tplt.def_abstraction_type;
			}
			return abstr == abstraction_type_str;
		} else {
			return true;
		}
	} else {
		return false;
	}
}

bool is_abstraction_type (
	const IRoseElementPtr& item
	, AbstractDumperBase::AbstractionType abstraction_type
	, const std::string& abstraction_type_str
) {
	AbstractDumperBase::StereotypeID model_stereotype = RoseHelper::get_gen_stereotype(item);
	std::string abstr (static_cast<const char*> (item->GetPropertyValue(TOOL_NAME, Base::ABSTRACTION_TYPE)));

	return is_abstraction_type (model_stereotype, abstr, abstraction_type, abstraction_type_str);
}

bool is_it_abstract (IRoseElementPtr item) {
	return is_abstraction_type (item, AbstractDumperBase::ATF_ABSTRACT, "abstract");
}

bool is_it_optional (IRoseElementPtr item) {
	return is_abstraction_type (item, AbstractDumperBase::ATF_OPTIONAL, "optional");
}

bool is_it_abstract (const RoseAbstractDumper* item) {
	const AbstractDumperBase::StereotypeID& model_stereotype (item->get_model_stereotype_str ());
	std::string abstr = item->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (Base::ABSTRACTION_TYPE))
	);

	return is_abstraction_type (model_stereotype, abstr, AbstractDumperBase::ATF_ABSTRACT, "abstract");
}

bool is_it_optional (const RoseAbstractDumper* item) {
	const AbstractDumperBase::StereotypeID& model_stereotype (item->get_model_stereotype_str ());
	std::string abstr = item->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (Base::ABSTRACTION_TYPE))
	);

	return is_abstraction_type (model_stereotype, abstr, AbstractDumperBase::ATF_OPTIONAL, "optional");
}

bool is_it_implementable (const AbstractDumperBase::StereotypeID& gen_stereotype, const std::string& abstract_property) {
	AbstractDumperBase::Template& tplt = AbstractDumperBase::get_template (gen_stereotype);
	if (tplt.implementation_type == SX_IT_TRUE) {
		typedef std::pair<AbstractDumperBase::AbstractionType, std::string> AbstractionInfo;
		typedef std::vector<AbstractionInfo> AbstractionInfos;
		
		AbstractionInfos abstraction_infos (3);
		abstraction_infos.push_back (std::make_pair (AbstractDumperBase::ATF_ABSTRACT, "abstract"));
		abstraction_infos.push_back (std::make_pair (AbstractDumperBase::ATF_REGULAR, "regular"));
		abstraction_infos.push_back (std::make_pair (AbstractDumperBase::ATF_OPTIONAL, "optional"));

		for (AbstractionInfos::const_iterator it = abstraction_infos.begin (); it != abstraction_infos.end (); ++it) {
			if (tplt.abstraction_type & it->first) {
				if (tplt.abstraction_type & (~it->first)) {
					std::string abstr (abstract_property);
					if (abstr.empty ()) {
						abstr = tplt.def_abstraction_type;
					}
					if (abstr == it->second) {
						return true;
					}
				} else {
					return true;
				}
			}
		}
	}

	return false;
}

bool is_it_implementable (const RoseAbstractDumper* item) {
	const AbstractDumperBase::StereotypeID& stereotype (item->get_model_stereotype_str ());
	std::string abstr = item->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (Base::ABSTRACTION_TYPE))
	);
	
	return is_it_implementable (stereotype, abstr);
}


bool is_it_implementable (IRoseElementPtr item) {
	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);	
	std::string abstr = static_cast<const char*> (item->GetPropertyValue(TOOL_NAME, Base::ABSTRACTION_TYPE));
	
	return is_it_implementable (stereotype, abstr);	
}

bool has_it_derived_impl (IRoseElementPtr item) {
	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);	
	return AbstractDumperBase::get_template (stereotype).has_derived_impl;
}

RoseItemMap uids_to_items (IRoseCategoryPtr from, GCL::StrSet& uids) {
	RoseItemMap res;
	GCL::StrVector base_path = GCL::split_string_by_sub_string (RoseHelper::get_full_name (from).data(), "::");

	ModelSearcher* searcher = &ModelSearcherFactory::get ();
	for (GCL::StrSet::iterator it = uids.begin(); it != uids.end(); it++) {
		IRoseItemPtr item = searcher->search (*it);
		if (item != 0) {
			GCL::StrVector target_path = GCL::split_string_by_sub_string (
				RoseHelper::get_full_name(item).data(), 
				"::"
			);
			
			std::string norm_name;

			if (
				item->IsClass(OPERATION_TYPE) 
				|| item->IsClass(ATTRIBUTE_TYPE)
				|| item->IsClass("Role")
			) {
				if (item->Stereotype != _bstr_t("")) {
					norm_name += "<<";
					norm_name += (const char*)item->Stereotype;
					norm_name += ">>";					
				}
			}

			target_path = GCL::normalize (base_path, target_path);
			norm_name += GCL::join (target_path, "::");
		
			RoseItemMap::value_type ri ( norm_name, (*it) );
			res.insert(ri);
		}
	}
	return res;
}

std::string get_full_name (IRoseElementPtr item) {
	if (!item->IsClass("Role")) {
		return (char*) item->GetQualifiedName();
	} else {		
		IRoseAssociationPtr cl = ((IRoseRolePtr)item)->Association;
		
		std::string cl_path;
		if (get_rose_element_uid(cl->Role1) != get_rose_element_uid(item)) {
			cl_path = cl->Role1->Class->GetQualifiedName();
		} else {
			cl_path = cl->Role2->Class->GetQualifiedName();
		}
		cl_path += "::" + item->GetName();
		return cl_path;
	}
}

std::string get_template_file(IRoseElementPtr item, bool& by_parent) {
	std::string ret;
	by_parent = false;
	std::string template_dir = MDAModelParams::get_templates_dir();
	while (ret == "" && item != NULL) {
		ret = (const char*)item->GetPropertyValue(TOOL_NAME, PROP_TEMPLATE_FILE);

		if (ret != "") {
			FILE* templ_file = fopen (RoseHelper::make_template_file (ret).c_str(), "r");
			if (templ_file) {
				fclose (templ_file);
				return ret;
			} 
			RoseHelper::override_property (item, TOOL_NAME, PROP_TEMPLATE_FILE, _bstr_t(""));
			ret = "";			
		}
		item = RoseHelper::get_context (item);
		by_parent = true;
	}

	return ret;
}

std::string get_root_dir(IRoseElementPtr item) {	
	if (item) {
		return (char*)item->GetPropertyValue(TOOL_NAME, PROP_ROOTDIR);
	} else {
		return "";
	}
}

void set_root_dir(IRoseElementPtr item, const std::string& value) {
	if (value != get_root_dir(item)) {
		RoseHelper::override_property(item, TOOL_NAME, PROP_ROOTDIR, value.data());
	}
}

void set_template_file(IRoseElementPtr item, const std::string& value) {		
	RoseHelper::override_property(item, TOOL_NAME, PROP_TEMPLATE_FILE, value.data());
}

bool get_is_native(IRoseElementPtr item) {
	if (item) {
		std::string ret;
		ret = (char*)item->GetPropertyValue(TOOL_NAME, PROP_IS_NATIVE);
		
		return ret == "true";
	} else {
		return false;
	}
}

bool get_is_native_with_parent(IRoseElementPtr item) {
	bool b;
	return get_is_native_with_parent(item, b);
}

bool get_is_native_with_parent(IRoseElementPtr item, bool& with_parent) {
	bool ret = get_is_native(item);
	if (!ret) {
		IRoseElementPtr par = RoseHelper::get_context (item);
		if (par) {
			if (par->IsClass (MODEL_TYPE)) {
				ret = false;
			} else {
				with_parent = ret = get_is_native_with_parent (par);
			}
		} else {
			ret = false;
		}
	} else {
		with_parent = false;
	}
	
	return ret;
}

bool set_is_native(IRoseElementPtr item, bool value) {	
	std::string str;
	if (value) {
		str = "true";
	} else {
		str = "false";
	}

	bool ret = RoseHelper::override_property(item, TOOL_NAME, PROP_IS_NATIVE, str.data());
	if (ret) {
		RoseAbstractDumper::reset_model_tree_root ();
	}

	return ret;
}

void set_parameterized(IRoseItemPtr item, bool value) {	
	IRoseClassPtr cls = (IRoseClassPtr)item;
	if (cls == 0) {
		return;
	}
	if (value && (cls->ClassKind->Name != _bstr_t("ParameterizedClass"))) {
		cls->ClassKind->PutValue(1);
	} else if (!value && cls->ClassKind->Name != _bstr_t(CLASS_TYPE)) {
		cls->ClassKind->PutValue(0);
	}
}

bool override_property (IRoseElementPtr item, _bstr_t tool_name, _bstr_t prop_name, _bstr_t value) {
	_bstr_t prev_value = item->GetPropertyValue(tool_name, prop_name);
	if (prev_value != value) {
		if (false == can_modify_elem (item)) {
			return false;
		}
		bool res = item->OverrideProperty(tool_name, prop_name, value);
		return true;
	} else {
		return false;
	}
}

bool force_override_property (IRoseElementPtr item, _bstr_t tool_name, _bstr_t prop_name, _bstr_t value) {
	_bstr_t prev_value = item->GetPropertyValue(tool_name, prop_name);
	if (prev_value != value) {
		FORCE_MODEL_EDIT(item, item->OverrideProperty(tool_name, prop_name, value));
		return true;
	} else {
		return false;
	}
}

bool is_it_available_by_type (
	IRoseItemPtr item, IRoseItemPtr item_context, const AbstractDumperBase::StereotypeID& st_tp
) {

	GCL::StrVector parts = GCL::split_string_by_sub_string (st_tp/*.get ()*/.data(), "::");
	
	if (parts[0] == "default") {
		return false;
	}

	if (item == 0) {
		//AbstractDumperBase::Template& t = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(item_context));
		if (parts.size() >= 3) {
			if (item_context && parts[0] == (const char*)item_context->Stereotype) {
				if (item_context->IsClass(parts[1].data())) {
					//MySt::Class::Opertaion
					//MySt::Class::Opertaion::Parameter
					//MySt::Class::OpSt::Opertaion
					//MySt::Class::OpSt::Opertaion::Parameter
					if (parts.size() < 5) {
						//MySt::Class::Opertaion
						//MySt::Class::Opertaion::Parameter
						//MySt::Class::OpSt::Opertaion						
						if (parts[2] != "ClassDependency" && (parts.size() < 4 || parts[3] != "ClassDependency")) {
							if (parts[2] != "Parameter" && (parts.size() < 4 || parts[3] != "Parameter")) {
								if (
									!(
										parts.size() == 4
										&& (parts[3] == parts[2] || parts[2] == "Attribute")
									)
								) {
									return true;
								}
							}
						}
					}
				}
			}
			return false;
		} else {
			return true;
		}
	}

	//AbstractDumperBase::Template& t = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(item));
	
	if (parts.size() == 2 && item->IsClass(parts[1].data())) {
		return true;
	} else if (
		(
			parts.size() == 4 && (
				((item->IsClass(parts[3].data()) && (parts[3] != parts[2] || parts[2] != "Attribute")))
				|| (parts[3] == "Attribute" && item->IsClass("Role") && (parts[3] != parts[2] || parts[2] != "Attribute"))
			)
		)
		|| (
			parts.size() == 3 && (
				item->IsClass(parts[2].data())
				|| (parts[2] == "Attribute" && item->IsClass("Role"))
			)
		)
	) {
		IRoseItemPtr item_context = RoseHelper::get_context(item);		
		if (
			item_context
			&& item_context->IsClass(parts[1].data()) 
			&& item_context->GetStereotype() == _bstr_t(parts[0].data())
		) {
			return true;
		} else {
			return false;
		}
	} else {
		return false;			
	}
}

IRoseElementPtr get_context(IRoseElementPtr item) {
	if (item) {
		try {
			if (item->IsClass("Role")) {
				IRoseRolePtr rr = IRoseRolePtr(item);
				IRoseAssociationPtr ra = rr->Association;
				rr = ra->GetOtherRole(rr->Class);
				return rr->AssociateItem;
			} else if (item->IsClass ("Transition")) {
				return ((IRoseTransitionPtr)item)->GetSourceState ();
			} else if (item->IsClass ("State")) {
				IRoseStatePtr state = item;				
				IRoseStateMachinePtr machine = state->GetParentStateMachine ();
				IRoseStateMachineOwnerPtr machine_owner = machine->GetStateMachineOwner ();
				return machine_owner->GetParentItem ();	
			} else if (item->IsClass ("StateMachine")) {
				IRoseStateMachinePtr machine = item;
				IRoseStateMachineOwnerPtr machine_owner = machine->GetStateMachineOwner ();
				return machine_owner->GetParentItem ();	
			} else if (item->IsClass (ROSE_ITEM_TYPE)) {
				return ((IRoseItemPtr)item)->GetContext();
			} else if (
				item->IsClass ("ClassDiagram")
				|| item->IsClass ("ScenarioDiagram")
			) {
				IRoseDiagramPtr diag = item;
				std::string prop_id = item->IsClass ("ClassDiagram") == VARIANT_TRUE
					? RoseHelper::CLASS_DIAG_LINK_PROPERTY
					: "UseCase";

				std::string linked_uid (
					static_cast<const char*> (
						diag->GetPropertyValue (
							TOOL_NAME
							, prop_id.c_str ()
						)
					)
				);
				IRoseItemPtr context;
				if (linked_uid.length () > 0) {
					context = ModelSearcherFactory::get ().search (linked_uid);
				}

				if (!context) {
					context = diag->GetParentContext ();
				}
				return context;
			} else if (item->IsClass ("StateDiagram")) {
				//GDS_ASSERT_MSG(0, ("Can't use get_context () for StateDiagram"));
				IRoseElementPtr parent = ((IRoseStateDiagramPtr)item)->Parent;
				return parent;
			} else if (item->IsClass ("Diagram")) {
				return ((IRoseDiagramPtr)item)->GetParentContext ();
			}
		} catch (std::exception& ex) {
			LOG_E (("%s: exception %s", GDS_CURRENT_FUNCTION, ex.what ()));
		} catch (...) {
		}
	}
	//std::string type = item->IdentifyClass ();
	//GDS_ASSERT_MSG(false, ("get_context (), unknown item type: %s", type.c_str ()));
	return 0;
/*
	IRoseRolePtr role = (IRoseRolePtr) item;
	if (role) {
		if (role != role->Association->Role2) {
			return role->Association->Role2->Class;
		} else {
			return role->Association->Role1->Class;
		}
	} else {
		return item->GetContext();
	}*/
}

bool is_it_available_by_constr (
	IRoseItemPtr item, IRoseItemPtr item_context, const AbstractDumperBase::StereotypeID& st_tp
) {
	//TRACE ("Check by constr for: %s\n", st_tp.first.data());
	if (item_context->IsClass (MODEL_TYPE)) {
		return true;
	} else {		
		AbstractDumperBase::Template& pt = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(item_context));
		if (!pt.child_st_constraints.size()) {
			return true;
		} else {
			GCL::StrVector chk_parts = GCL::split_string_by_sub_string (st_tp/*.get ()*/.data(), "::");
			if (chk_parts.size() >= 4) {
				// chk_parts == MySt::Class::oneway::Operation
				// chk_parts == MySt::Class::oneway::Operation::Parametr				
				// chk_parts == MySt::Class::Operation::Parametr
				return true;
				return item != 0; // small hack - to disable sub stereotypes
			} else if (chk_parts.size() == 3) {
				// chk_parts == MySt::Class::Operation
				return true;
			}

			for (
				GCL::StrSet::iterator it = pt.child_st_constraints.begin()
				; it != pt.child_st_constraints.end()
				; it++
			) {
				GCL::StrVector parts = GCL::split_string_by_sub_string (it->data(), "::");
				if (chk_parts.size() == 2) {
					if (parts[0] == "*") {
						if (item != 0) {
							if (item->IsClass(parts[1].data())) {
								return pt.child_st_constarint_type == AbstractDumperBase::CSCT_INCLUDED;
							}
						} else if (parts[1] == chk_parts[1]) {
							return pt.child_st_constarint_type == AbstractDumperBase::CSCT_INCLUDED;
						}
					} 
				}
                    
				if (*it == st_tp) {
					return pt.child_st_constarint_type == AbstractDumperBase::CSCT_INCLUDED;
				}				
			}
		
			return pt.child_st_constarint_type != AbstractDumperBase::CSCT_INCLUDED;			
		}
	}	
}
AvailableParentByConstrMap& get_available_parent_by_constr_map () {
	return g_available_parent_by_constr_map;
}

RoseHelper::TemplatesSet get_available_parent_by_constr (
	const AbstractDumperBase::Templates::key_type& key_child
	, const AbstractDumperBase::Templates::value_type& child
) {	
	class local {
	public:
		static RoseHelper::TemplatesSet get_available_parent_by_constr_i (
			const AbstractDumperBase::Templates::value_type& child
		) {
			//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);

			GCL::StrVector c_parts = GCL::split_string_by_sub_string (child.first/*.get ()*/.data(), "::");
			std::string parent_st;
			if (c_parts.size() > 2) {
				parent_st = c_parts[0];
			}

			//TRACE ("find parent st for %s:\n", child.first.data());
			TemplatesSet res;
			for (
				AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
				; it != AbstractDumperBase::templates_end ()
				; it ++
			) {		
				const AbstractDumperBase::Template& parent = it->second;
				if (
					parent.classtype_name == ATTRIBUTE_TYPE 
					|| parent.classtype_name == PARAMETER_TYPE 
					|| parent.classtype_name == OPERATION_TYPE
					|| parent.classtype_name == CLASS_DEPENDENCY_TYPE
					|| parent.stereotype_name == "<default>"
				) {
					continue;
				}

				//TRACE ("\tCHECK FOR%s:\n", it->first.data());

				if (parent_st == parent.stereotype_name) {
					res.insert (&(*it));
					//TRACE ("\t%s:\n", it->first.data());
				} else if (parent_st == "") {
					if (!parent.child_st_constraints.size()) {
						res.insert (&(*it));
						//TRACE ("\t%s:\n", it->first.data());
					} else {
						bool exit = false;
						for (
							GCL::StrSet::const_iterator it2 = parent.child_st_constraints.begin ()
							; !exit && it2 != parent.child_st_constraints.end ()
							; it2++
						) {
							//TRACE ("\t\tCHECK CONST%s:\n", it2->data());
							GCL::StrVector parts = GCL::split_string_by_sub_string (it2->data(), "::");
							
							if (parts.size() == 2) {
								if (parts[1] == child.second.classtype_name) {
									if (parts[0] == "*" || parts[0] == child.second.stereotype_name) {
										if (parent.child_st_constarint_type == AbstractDumperBase::CSCT_INCLUDED) {
											res.insert (&(*it));
											//TRACE ("\t%s:\n", it->first.data());
										}
										exit = true;
									}
								}
							} else {
								assert (0);
							}
						}
						if (exit) {
							continue;
						}

						if (parent.child_st_constarint_type != AbstractDumperBase::CSCT_INCLUDED) {
							res.insert (&(*it));
							//TRACE ("\t%s:\n", it->first.data());
						}
					}
				}
			}
			return res;
		}
	};	
	RoseHelper::AvailableParentByConstrMap::iterator f = RoseHelper::g_available_parent_by_constr_map.find (key_child);
	if (f == RoseHelper::g_available_parent_by_constr_map.end ()) {
		f = RoseHelper::g_available_parent_by_constr_map.insert (
			RoseHelper::AvailableParentByConstrMap::value_type (
				key_child
				, local::get_available_parent_by_constr_i (child)
			)
		).first;
	}
	return f->second;
}

GCL::StrVector get_available_target_stereotypes (IRoseElementPtr item) {
	GCL::StrVector ret;
	
	AbstractDumperBase::Template& t = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(item));
	if (t.available_target_stereotypes.size()) {
		ret = t.available_target_stereotypes;
	}
	return ret;
}

//возвращает время создания элемента (если элемент новый, то фиксирует время создания, записывая его в настройки)
unsigned long long get_creation_timestamp (IRoseElementPtr item) {
	static ACE_UINT64 counter = 0;

	ACE_UINT64 timestamp = 0;

	bool initialized = false;
	
	std::string persistent_creation_order = static_cast<const char*> (item->GetPropertyValue (TOOL_NAME, Base::ELEMENT_CREATION_ORDER.c_str ()));
	if (!persistent_creation_order.empty ()) {
		try {
			timestamp = boost::lexical_cast<ACE_UINT64> (persistent_creation_order);
			initialized = true;
		} catch (boost::bad_lexical_cast&) {
			//skip
		}
	}

	if (!initialized || GenerationParams::get_overwrite_creation_order_property ()) {
		//получем текущее время и записываем его в микросекундах
		const ACE_Time_Value time = ACE_OS::gettimeofday();
		time.to_usec (timestamp);

		timestamp += counter++; //используем счетчик, чтобы получить строго возрастающую последовательность
								//иначе точности gettimeofday может не хватить и два подряд вызова вернут
								//одинаковый результат, т.к таймстемп хранится в микросекундах, то даже 1 млн вызовов
								//этого метода приведет к диффе во времени в 1 секунду, чем можно принебречь

		RoseHelper::write_property_with_lock (
			item
			, Base::ELEMENT_CREATION_ORDER
			, boost::lexical_cast<std::string> (timestamp)
			, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
			, true
			, Base::ELEMENT_CREATION_ORDER
		);
	}

	return timestamp;
}

std::string get_auto_counter(IRoseElementPtr item) {
	std::string ret (static_cast<const char*> (item->GetPropertyValue(TOOL_NAME, PROP_AUTO_COUNTER)));
	if (ret.empty ()) {
		ret = "0";
		RoseHelper::override_property(item, TOOL_NAME, PROP_AUTO_COUNTER, ret.data());
		s_incremented_counters.insert (get_rose_element_uid(item));
	} else {
		if (s_incremented_counters.find(get_rose_element_uid(item)) == s_incremented_counters.end()) {			
			long counter = atoi (ret.data());
			long prev_counter = counter;
			if (!GenSupport::EnvironmentFactory::get ().get_disable_auto_count ()) {
				counter++;
			}
			char buf [32];
			ret = itoa (counter, buf, 10);
			_bstr_t porp_id (PROP_AUTO_COUNTER);
			bool save_counter = RoseHelper::write_property_with_lock (
				item
				, static_cast<const char*> (porp_id)
				, ret
				, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
				, true
				, "AutoCounter"
			);
			if (save_counter) {
				s_incremented_counters.insert (get_rose_element_uid(item));
			} else {
				ret = itoa (prev_counter, buf, 10);
			}
		}
	}

	return ret;
}

bool set_link_type (IRoseElementPtr item, const std::string& lt) {
	bool ret = false;	
	if (item->IsClass ("Role")) {
		IRoseRolePtr rl = (IRoseRolePtr)item;
		if (lt == "agr") {
			rl->Association->Role2->Aggregate = true;
			rl->Association->Role1->Containment->PutValue(1);
		} else if (lt == "ref") {
			rl->Association->Role2->Aggregate = true;
			rl->Association->Role1->Containment->PutValue(2);
		} else if (lt == "lnk") {
			rl->Association->Role2->Aggregate = false;
			rl->Association->Role1->Containment->PutValue(0);
		}
	} else if (item->IsClass (ATTRIBUTE_TYPE)) {
		IRoseAttributePtr atr = (IRoseAttributePtr)item;
		RoseHelper::override_property (atr, TOOL_NAME, "ValueInitialized", "true");
		short prev_val = atr->Containment->GetValue();
		if (lt == "agr") {		
			atr->Containment->PutValue(1);
		} else if (lt == "ref") {
			atr->Containment->PutValue(2);
		} else if (lt == "lnk") {
			atr->Containment->PutValue(0);
		}
		ret = (prev_val != atr->Containment->GetValue());
	} else {
	}
	
	//нужно обновить значение дампера, криво, но что делать...
	RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (item);
	if (rad) {
		rad->update_cached_attrs ();
	}

	return ret;
}

const std::string get_link_type (IRoseElementPtr item) {
	if (item->IsClass ("Role")) {
		IRoseRolePtr rol = (IRoseRolePtr)item;

		if (rol->Association->Role2->GetAggregate()) {
			if (rol->Association->Role1->GetContainment()->GetValue() == 1 /*by value*/) {
				return "agr";
			} else {
				return "ref";
			}
		} else {
			return "lnk";
		}
	} else if (item->IsClass (ATTRIBUTE_TYPE)) {
		IRoseAttributePtr atr = (IRoseAttributePtr)item;
		if (atr->GetPropertyValue(TOOL_NAME, "ValueInitialized") == _bstr_t("true")) {
			switch (atr->Containment->GetValue()) {
			case 0:
				return "lnk";
			case 1:
				return "agr";
			case 2:
				return "ref";
			default:
				assert (0);
				return "agr";
			}
		} else {
			return "agr";
		}
	} else {
		return "agr";
	}
}

std::string get_target_stereotype(IRoseElementPtr item) {
	return (char*)item->GetPropertyValue(TOOL_NAME, PROP_TARGET_STEREOTYPE);
}

std::string get_target_stereotype(const RoseAbstractDumper* item) {
	return item->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (PROP_TARGET_STEREOTYPE))
	);
}

bool set_target_stereotype (IRoseElementPtr item, const std::string& st) {		
	return RoseHelper::override_property(item, TOOL_NAME, PROP_TARGET_STEREOTYPE, st.data());
}

bool set_target_stereotype (const RoseAbstractDumper* item, const std::string& st, bool persist) {
	if (persist) {
		return set_target_stereotype (item->rose_element (), st);
	}

	return item->set_temporary_property (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (PROP_TARGET_STEREOTYPE))
		, st
	);
}


static const char ENTER[3] = {13, 10, 0};

class InsertInNote {
public:
	IRoseElementPtr m_item;
	
	InsertInNote (IRoseElementPtr _item) : m_item(_item) {
	}

	void each_func (const GCL::StaticNode* item, std::string& res) {
		if (!item->has_children()) {
			
			std::string prop_name = "NATIVE_PATH";
			std::string gen_id = dynamic_cast<const AbstractDumperBase::GenTreeItem*>(item)->name();
			prop_name += gen_id;
			std::string n_path = m_item->GetPropertyValue (TOOL_NAME, prop_name.data());
			if (n_path != "") {
				if (res != "") {
					res += ENTER;
				}
				res += "Native path for \"";
				res += gen_id;
				res += "\": ";
				res += n_path;
			}
		}
	}
};


std::string get_overwriten_prop (IRoseElementPtr item) {
	std::string ret;
	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);
	
	AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);
	
	if (tpl.user_properties_group.is_nil () == false) {
		AbstractDumperBase::UserPropertyMap props;
		tpl.user_properties_group->for_each (
			AbstractDumperBase::CollectUserProperty ()
			, props
		);
		for (
			AbstractDumperBase::UserPropertyMap::iterator it = props.begin();
			it != props.end();
			it ++
		) {
			std::string val = (const char*) item->GetPropertyValue (Base::USER_PROPERTY_TOOL, it->first.data());
			if (val != "" && val != it->second.def_value) {
				//TRACE ("\t for %s : \"%s\" != \"%s\"\n", it->first.data(), val.data(), it->second.data());
				if (ret != "") {
					ret += ENTER;
				}
				ret += "{";
				ret += it->first;
				ret += ":=";
				ret += val;
				ret += "}";
			}
		}
	}
	
	bool with_p;
	if (RoseHelper::get_is_native_with_parent (item, with_p)) {
		if (with_p == false) {
			if (ret != "") {
				ret += ENTER;
			}
			ret += "NATIVE";
		}

		if (!RoseAbstractDumper::s_gen_tree.is_nil ()) {
			Core::Var<AbstractDumperBase::GenTreeItem> gen_tree_copy = AbstractDumperBase::GenTreeItem::clone_tree (
				RoseAbstractDumper::s_gen_tree.in()
				, RoseAbstractDumper::s_gen_tree.in()
				, ParentSelectFilter (item)
			);

			gen_tree_copy->for_each (InsertInNote(item), ret);
		}

	}

	if (GCL::NumericTraits::bits_count (tpl.abstraction_type) != 1) {	
		AbstractDumperBase::AbstractionType abstr = RoseHelper::get_abstraction_type (item);

		if (
			abstr != AbstractDumperBase::ATF_REGULAR
			&& (
				item->IsClass(OPERATION_TYPE) 
				|| item->IsClass(ATTRIBUTE_TYPE) 
				|| abstr != AbstractDumperBase::ATF_ABSTRACT
			)
		) {
			if (!ret.empty ()) {
				ret += ENTER;
			}
			ret += "Abstraction type: ";
			ret += abstr;
		}
	}

	std::string st = RoseHelper::get_target_stereotype(item);
	if (st != "") {
		if (ret != "") {
			ret += ENTER;
		}
		ret += "Target stereotype: ";
		ret += st;
	}

	if (item->IsClass(ATTRIBUTE_TYPE)) {
		std::string lt (RoseHelper::get_link_type(item));
		if (lt != "" & lt != "agr") {
			if (ret != "") {
				ret += ENTER;
			}
			ret += "Link type: ";
			ret += lt;
		}
	}

	/*if (tpl.has_get_except) {
		GCL::StrVector get_e = GCL::split_string_by((char*) item->GetPropertyValue(TOOL_NAME, PROP_ATTR_GET_RAISES), ',');
		std::string except;
		for (RoseItemMap::iterator it = g_all_ex.begin(); it != g_all_ex.end(); it++) {
			if (std::find(get_e.begin(), get_e.end(), (*it).second) != get_e.end()) {
				if (except != "") {
					except += ", ";
				}
				except += it->first;
			}
		}

		if (except != "") {
			if (ret != "") {
				ret += ENTER;
			}
			ret += "GET Exception: ";
			ret += except;
		}
	}
	if (tpl.has_set_except) {
		GCL::StrVector set_e = GCL::split_string_by((char*) item->GetPropertyValue(TOOL_NAME, PROP_ATTR_SET_RAISES), ',');
		std::string except;
		for (RoseItemMap::iterator it = g_all_ex.begin(); it != g_all_ex.end(); it++) {
			if (std::find(set_e.begin(), set_e.end(), (*it).second) != set_e.end()) {
				if (except != "") {
					except += ", ";
				}
				except += it->first;
			}
		}

		if (except != "") {
			if (ret != "") {
				ret += ENTER;
			}
			ret += "SET Exception: ";
			ret += except;
		}
	}*/

	if (item->IsClass(CLASS_TYPE)) {
		IRoseClassPtr cls = item;
		IRoseAttributeCollectionPtr attrs = cls->Attributes;
		short attrs_count = attrs->Count;
		for (short i = 1; i <= attrs_count; i++) {		
			IRoseAttributePtr attr = attrs->GetAt(i);
			std::string atr_note = RoseHelper::get_overwriten_prop(attr);
			if (atr_note != "") {
				if (ret != "") {
					ret += ENTER;
					ret += ENTER;
				}
				ret += "FOR ATTR. \"";
				ret += (const char*)attr->Name;
				ret += "\"";
				ret += ENTER;
				ret += atr_note;
			}
		}

		IRoseOperationCollectionPtr ops = cls->Operations;
		short ops_count = ops->Count;
		for (short i = 1; i <= ops_count; i++) {
			IRoseOperationPtr op = ops->GetAt(i);
			std::string op_note = RoseHelper::get_overwriten_prop(op);
			if (op_note != "") {
				if (ret != "") {
					ret += ENTER;
					ret += ENTER;
				}
				ret += "FOR OPER. \"";
				ret += (const char*)op->Name;
				ret += "\"";
				ret += ENTER;
				ret += op_note;
			}
		}

		{ //  print implemented/overwriten prop
			/*RoseItemMap::iterator it;
			RoseItemMap all_derived_impl = RoseHelper::find_all_derived_impl (item);
			
			std::string impl_sel_type = RoseHelper::get_implement_select_type (item);			
			if (impl_sel_type == "exclude" || impl_sel_type == "include") {
				RoseItemMap all_derived_abstract = RoseHelper::find_all_derived_abstract (item);
				
				Core::Aptr<ImplementedItemSet> implemented_items = InheritedItemHelperFactory::get ().get_stored_implemented (item);

				GCL::StrVector implemented;

				std::transform (
					implemented_items->begin ()
					, implemented_items->end ()
					, std::back_inserter (implemented)
					, boost::bind (
						&ImplementedItem::get_uid
						, boost::bind (
							static_cast<const ImplementedItem* (ImplementedItem_var::*) () const> (&ImplementedItem_var::ptr)
							, _1
						)
					)
				);

				// = GCL::split_string_by((char*) item->GetPropertyValue(TOOL_NAME, PROP_DERIVED_IMPLEMENT), ',');

				bool first_der_abst = true;
				for (it = all_derived_abstract.begin(); it != all_derived_abstract.end(); it++) {
					if (all_derived_impl.find(it->first) == all_derived_impl.end()) {
						if (std::find(implemented.begin(), implemented.end(), (*it).second) != implemented.end()) {
							if (first_der_abst) {
								first_der_abst = false;
								if (ret != "") {
									ret += ENTER;
									ret += ENTER;
								}
								if (impl_sel_type == "exclude") {
									ret += "IMPLEMENT ALL ABSTRACTS, EXCLUDE:";
								} else {
									ret += "IMPLEMENT ONLY THIS ABSTRACTS:";
								}								
							}
							ret += ENTER;
							ret += it->first;
						}					
					}
				}
			}
			
			Core::Aptr<OverloadedItemSet> overloaded_items = InheritedItemHelperFactory::get ().get_stored_overloaded (item);

			GCL::StrVector overloaded;

			std::transform (
				overloaded_items->begin ()
				, overloaded_items->end ()
				, std::back_inserter (overloaded)
				, boost::bind (
					&OverloadedItem::get_uid
					, boost::bind (
						static_cast<const OverloadedItem* (OverloadedItem_var::*) () const> (&OverloadedItem_var::ptr)
						, _1
					)
				)
			);
			
			bool first_der_impl = true;			
			for (it = all_derived_impl.begin(); it != all_derived_impl.end(); it++) {
				if ( std::find(overloaded.begin(), overloaded.end(), (*it).second) != overloaded.end() ) {
					if (first_der_impl) {
						first_der_impl = false;
						if (ret != "") {
							ret += ENTER;
							ret += ENTER;
						}
						ret += "OVERWRITEN IMPLEMENTATIONS:";						
					}
					ret += ENTER;
					ret += it->first;
				} 
			}*/
		}
	}

	return ret;
}

IRoseDiagramCollectionPtr get_all_diagrams (IRoseElementPtr item) {
	IRoseDiagramCollectionPtr res (__uuidof(RoseDiagramCollection));
	GDS_ASSERT_MSG(res, ("Can't create user-defined collection (RoseDiagramCollection)"));
	if (
		item->IsClass ("State")
		|| item->IsClass ("Transition")
	) {
		IRoseItemPtr vertex = item;
		IRoseStateMachinePtr machine = vertex->GetContext ();
		IRoseStateDiagramCollectionPtr st_diags = machine->Diagrams;
		
		short st_diags_count = st_diags->Count;
		for (short j = 1; j <= st_diags_count; ++j) {
			IRoseDiagramPtr st_diag = st_diags->GetAt (j);
			IRoseItemViewPtr iview = st_diag->GetViewFrom(vertex);
			if (iview != NULL) {
				res->Add (st_diag);
			}
		}
	} else {
		IRoseCategoryPtr item_cat = RoseHelper::get_parent_category (item);
		IRoseItemPtr item_to_select = RoseHelper::get_nearest_container (item);
		if (item_to_select) {
			IRoseCategoryCollectionPtr all_cats = item->Model->GetAllCategories ();
			short all_cats_count = all_cats->Count;
			for (short i = 1; i <= all_cats_count; ++i) {
				IRoseCategoryPtr cat = all_cats->GetAt (i);
				if (cat) {
					IRoseClassDiagramCollectionPtr cls_diags = cat->GetClassDiagrams ();
					if (cls_diags) {
						short cls_diags_count = cls_diags->Count;
						for (short j = 1; j <= cls_diags_count; ++j) {
							IRoseDiagramPtr diag = cls_diags->GetAt (j);
							IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
							if (
								iview != NULL
							) {	
								if (
									item->IsClass (OPERATION_TYPE) 
									|| item->IsClass (ATTRIBUTE_TYPE)
								) {									
									//проверям разрешён ли показ атрибутов или операция для конкретного вью
									IRoseClassViewPtr class_view = iview;
									if (
										class_view
										&& ((
												item->IsClass (OPERATION_TYPE)
												&& !class_view->SuppressOperations
											) || (
												item->IsClass (ATTRIBUTE_TYPE)
												&& !class_view->SuppressAttributes
											)
										)
									) {
										res->Add (diag);
									}
								} else if (item->IsClass ("Role")) {
									//атрибутная связь может быть только на "родной" диаграмме
									if (
										item_cat
										&& get_rose_element_uid(item_cat) == get_rose_element_uid(cat)
									) {
										res->Add (diag);
									}
								} else {
									res->Add (diag);
								}
							}
						}
					}
					IRoseScenarioDiagramCollectionPtr scen_diags = cat->GetScenarioDiagrams ();
					if (scen_diags) {
						short scen_diags_count = scen_diags->Count;
						for (short j = 1; j <= scen_diags_count; ++j) {
							IRoseDiagramPtr diag = scen_diags->GetAt (j);
							IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
							if (iview != NULL) {
								res->Add (diag);
							}
						}
					}
				}

			}
		}		
	}
	return res;
}

IRoseDiagramPtr get_self_diagram (IRoseElementPtr item) {
	if (
		item->IsClass ("State")
		|| item->IsClass ("Transition")
	) {
		IRoseItemPtr vertex = item;
		IRoseStateMachinePtr machine = vertex->GetContext ();
		IRoseStateDiagramCollectionPtr st_diags = machine->Diagrams;
		
		short st_diags_count = st_diags->Count;
		for (short j = 1; j <= st_diags_count; ++j) {
			IRoseStateDiagramPtr st_diag = st_diags->GetAt (j);
			IRoseItemViewPtr iview = st_diag->GetViewFrom(vertex);
			if (iview != NULL) {
				return st_diag;
			}
		}
	} else {
		IRoseCategoryPtr cat = RoseHelper::get_parent_category (
			item->IsClass ("CategoryDependency") ? RoseHelper::get_context (item) : item
		);
		if (cat != 0) {
			IRoseItemPtr item_to_select = RoseHelper::get_nearest_container (item);
			
			while (item_to_select && IsVirtualFactory::get ().execute (item_to_select)) {
				item_to_select = RoseHelper::get_context (item_to_select);
			}

			LOG_D ((
				"Selected item - %s, item category - %s, item container %s\n"
				, (const char*)item->Name
				, (const char*)cat->Name
				, (const char*)item_to_select->Name
			));
			
			try {
				IRoseClassDiagramCollectionPtr diags = cat->GetClassDiagrams();

				if (diags) {
					short diags_count = diags->Count;
					for (short i = 1; i <= diags_count; i++) {
						IRoseClassDiagramPtr diag = diags->GetAt(i);			

						IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
						if (iview != NULL) {
							return diag;
						}
					}
				}
			} catch (_com_error& ex) {
				LOG_E (("COM Exception when looking for item diagram, ex: %s", ex.ErrorMessage ()));
			}
		}
	}
 	return 0;
}

void colorize_all () {
	/*
	IRoseCategoryCollectionPtr all_cats = s_rose_app->CurrentModel->GetAllCategories ();
	_bstr_t main_guid = get_rose_element_uid(RoseHelper::get_main_model_element ());

	bool first_colorize_need_logs = true;

	for (int i = 1; i < all_cats->Count + 1; i++) {
		IRoseCategoryPtr cat = all_cats->GetAt(i);
		if (cat->Stereotype != _bstr_t ("UMLModule")) {
			IRoseClassDiagramCollectionPtr diags  = cat->GetClassDiagrams ();
			for (int i = 1; i < diags->Count + 1; i++) {
				IRoseClassDiagramPtr diag = diags->GetAt(i);

				if (main_guid != diag->GetPropertyValue(TOOL_NAME, "ColorizeFor")) {
					if (first_colorize_need_logs) {
						first_colorize_need_logs = false;
						GenSupport::LogManagerFactory::get ().log_error ("Pre-colorization start...");
					}
					RoseHelper::colorize (diag);
				}
			}
		}
	}

	if (!first_colorize_need_logs) {
		GenSupport::LogManagerFactory::get ().log_error ("Pre-colorization end.");
	}
	*/
}

void colorize(const IRoseDiagramPtr& d) {
#ifndef GDS_NLOG_DEBUG
	::Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif
	if (d == 0) {
		return;
	}
	DiagramColorizer colorizer (d);
	colorizer.colorize ();
	d->Invalidate ();
}

void make_visible (CTreeCtrl& tree, HTREEITEM ht_node) {
	while (ht_node = tree.GetNextItem (ht_node, TVGN_PARENT)) {
		tree.Expand(ht_node, TVE_EXPAND);
	}
}

void fill_node (Selections& selections, CTreeCtrl& tree, HTREEITEM ht_node, RoseAbstractDumper::GenTreeItem* gt_node) {
	if (ht_node == 0) {
		ht_node = tree.InsertItem (gt_node->name().data(), TVI_ROOT);
		tree.SetItemData (ht_node, (DWORD)gt_node);
		if (selections.find (gt_node->name()) != selections.end() || selections.size() == 0) {
			tree.SetCheck(ht_node);
		}
		
		RoseHelper::fill_node (selections, tree, ht_node, gt_node);
	} else {
		Core::Var<RoseAbstractDumper::GenTreeItem> child = dynamic_cast<RoseAbstractDumper::GenTreeItem*>(gt_node->first_child());
		while (!child.is_nil()) {
			HTREEITEM ht_child;
			
			if (child->description () != "") {			
				ht_child = tree.InsertItem (child->description().data(), ht_node);
			} else {
				ht_child = tree.InsertItem (child->name().data(), ht_node);
			}

			if (selections.find (child->name()) != selections.end()) {
				tree.SetCheck(ht_child);
				make_visible (tree, ht_child);
			}

			tree.SetItemData (ht_child, (DWORD)child.ptr());

			if (child->has_children()) {
				fill_node (selections, tree, ht_child, child.in());
			}
			child = dynamic_cast<RoseAbstractDumper::GenTreeItem*>(child->next());
		}
	}
}

void collect_all_checked (const CTreeCtrl& tree, RoseHelper::TreeItems& items, RoseHelper::TreeItems& leaf_items, HTREEITEM current, bool parent_checked) {
	if (!current) {
		current = tree.GetRootItem ();
	}
	if (tree.GetCheck(current)) {
		items.push_back (current);
	}
	
	HTREEITEM next = tree.GetNextItem (current, TVGN_CHILD);
	if (next) {		
		collect_all_checked (tree, items, leaf_items, next, parent_checked || tree.GetCheck(current));
	} else {
		if (parent_checked || tree.GetCheck(current)) {
			leaf_items.push_back (current);
		}
	}

	next = tree.GetNextItem (current, TVGN_NEXT);
	if (next) {
		collect_all_checked (tree, items, leaf_items, next, parent_checked);
	}
}

bool is_it_main_model_element(IRoseElementPtr item) {
	//std::string stereotype = RoseHelper::get_gen_stereotype(item);
	std::string main_guid (static_cast<const char*> (item->Model->GetPropertyValue (TOOL_NAME, "MODEL_MAIN_ELEMENT")));
	return main_guid == get_rose_element_uid(item);
	//return AbstractDumperBase::get_template (stereotype).main_st;
}

void set_new_main_model_element(IRoseItemPtr item) {
	IRoseModelPtr model = item->Model;
	if (std::string (model->GetPropertyValue (TOOL_NAME, "MODEL_MAIN_ELEMENT")) != get_rose_element_uid(item)) {
		RoseHelper::override_property (model, TOOL_NAME, "MODEL_MAIN_ELEMENT", get_rose_element_uid(item).c_str ());
		RoseHelper::colorize_all ();
	}
}

IRoseItemPtr get_main_model_element() {
	IRoseItemPtr main_item = 0;
	if (s_rose_app && s_rose_app->CurrentModel) {
		std::string main_guid (static_cast<const char*> (s_rose_app->CurrentModel->GetPropertyValue (TOOL_NAME, "MODEL_MAIN_ELEMENT")));

		main_item = ModelSearcherFactory::get ().search (main_guid);
	}

	return main_item != 0 ? main_item : s_rose_app->CurrentModel;
}

bool show_item (IRoseElementPtr item) {
	GDS_ASSERT(item);
	bool res = false;
	IRoseItemPtr item_to_select = RoseHelper::get_nearest_container (item);
	IRoseDiagramPtr diag = RoseHelper::get_self_diagram (item);

	if (diag != 0) {
		IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
		diag->Activate();
		iview->SetSelected(true);
		diag->CenterDiagramToView(iview);
		res = true;
	}

	return res;
}

void browse_item (IRoseItemPtr item) {
	if (item) {
		if (!RoseHelper::show_item (item)) {
			MessageBox(AfxGetMainWnd ()->GetSafeHwnd (), "No diagrams availble", 0, MB_ICONERROR | MB_OK);
		}
	}
}

//пытаемся удалить элемент с залочкой, если залочить не удалось - возвращаем false
bool delete_item_with_lock (IRoseItemPtr item) {
	bool res = false;
	MDPSupport::CatLockerFacade_var clf = 
		MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)item);
	if (clf->try_change ()) {
		res = true;
		delete_item (item);
		clf->do_change ();
	}
	return res;
}

struct IsSupplierEqualTo: public std::unary_function<IRoseRelationPtr, bool> {
	template <class T>
	IsSupplierEqualTo (const T& to)
		: m_to_guid (get_rose_element_uid(to))
	{}

	bool operator () (const IRoseRelationPtr& arg) const {
		IRoseItemPtr rel_suppl = arg->GetSupplier ();
		return rel_suppl && get_rose_element_uid(rel_suppl) == m_to_guid;
	}

private:
	std::string m_to_guid;
};

template <class InCollection, class OutCollection, class Predicate>
void copy_if (const InCollection& in_collection, OutCollection& out_collection, Predicate predicate) {
	short in_collection_count = in_collection->Count;
	for (short i = 1; i <= in_collection_count; ++i) {
		IRoseRelationPtr rel = in_collection->GetAt (i);
		if (predicate (rel)) {
			IRoseItemPtr item = rel;
			out_collection->Add (item);
		}
	}
}

IRoseItemCollectionPtr get_clients (const IRoseCategoryPtr& cat) {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	IRoseItemCollectionPtr res_deps (__uuidof(RoseItemCollection));
	IRoseCategoryPtr root = cat->Model->RootCategory;

	IRoseCategoryCollectionPtr all_cats = root->GetAllCategories ();
	short all_cats_count = all_cats->Count;

	IsSupplierEqualTo predicate (cat);
	for (short i = 1; i <= all_cats_count; ++i) {
		IRoseCategoryPtr c = all_cats->GetAt (i);

		IRoseCategoryDependencyCollectionPtr deps = c->GetCategoryDependencies ();
		short deps_count = deps->Count;
		for (short j = 1; j <= deps_count; ++j) {
			IRoseItemPtr dep = deps->GetAt (j);
			if (predicate (dep)) {
				res_deps->Add (dep);
			}
		}
	}
	return res_deps;
}

IRoseItemCollectionPtr get_clients (const IRoseClassPtr& cls) {
	
	IRoseItemCollectionPtr deps (__uuidof(RoseItemCollection));

	IsSupplierEqualTo predicate (cls);

	IRoseClassCollectionPtr clients = cls->GetClients (rsAnyKind, rsTypeAny);
	short clients_count = clients->Count;

	for (short i = 1; i <= clients_count; ++i) {
		IRoseClassPtr client = clients->GetAt (i);
		
		IRoseClassDependencyCollectionPtr client_deps = client->GetClassDependencies ();
		copy_if (client_deps, deps, predicate);

		IRoseInheritRelationCollectionPtr client_inherites = client->GetInheritRelations ();
		copy_if (client_inherites, deps, predicate);
		
		IRoseRealizeRelationCollectionPtr client_realizations = client->GetRealizeRelations ();
		copy_if (client_realizations, deps, predicate);

		IRoseAssociationCollectionPtr assocs = client->GetAssociations ();
		short assocs_count = assocs->Count;

		for (short k = 1; k <= assocs_count; ++k) {
			IRoseAssociationPtr assoc = assocs->GetAt (k);
			IRoseRolePtr role = get_role (assoc);
			if (role && predicate (role)) {
				deps->Add ((IRoseItemPtr)assoc);
			}
		}
	}

	return deps;
}

IRoseItemCollectionPtr get_clients (const IRoseElementPtr& elem) {
	if (elem->IsClass (CLASS_TYPE)) {
		return get_clients ((IRoseClassPtr)elem);
	} else if (elem->IsClass (CATEGORY_TYPE)) {
		return get_clients ((IRoseCategoryPtr)elem);
	}
	IRoseItemCollectionPtr empty (__uuidof(RoseItemCollection));
	return empty;
}

void delete_item (IRoseItemPtr new_item) {
	
	IRoseItemPtr parent_item = RoseHelper::get_context (new_item);
	RoseHelper::move_generated_source_to_parent (new_item, parent_item);
	
	if (parent_item == 0) {
		return;
	}
	
	if (new_item->IsClass("Role")) {
		((IRoseRolePtr)new_item)->GetClass()->DeleteAssociation(((IRoseRolePtr)new_item)->Association);
	} else if (parent_item->IsClass(CLASS_TYPE)) {		
		if (new_item->IsClass(CLASS_TYPE)) {
			((IRoseClassPtr)parent_item)->DeleteNestedClass ((IRoseClassPtr)new_item);
		} else if (new_item->IsClass(ATTRIBUTE_TYPE)) {
			((IRoseClassPtr)parent_item)->DeleteAttribute ((IRoseAttributePtr)new_item);
		} else if (new_item->IsClass(OPERATION_TYPE)) {
			((IRoseClassPtr)parent_item)->DeleteOperation ((IRoseOperationPtr)new_item);
		} else if (new_item->IsClass(CLASS_DEPENDENCY_TYPE)) {
			((IRoseClassPtr)parent_item)->DeleteClassDependency((IRoseClassDependencyPtr)new_item);
		} else if (new_item->IsClass("InstantiateRelation")){
			((IRoseClassPtr)parent_item)->DeleteInstantiateRel((IRoseInstantiateRelationPtr)new_item);
		} else if (new_item->IsClass("InheritRelation")){
			((IRoseClassPtr)parent_item)->DeleteInheritRel((IRoseInheritRelationPtr)new_item);
		} else if (new_item->IsClass("RealizeRelation")){
			((IRoseClassPtr)parent_item)->DeleteRealizeRel((IRoseRealizeRelationPtr)new_item);
		} else if (new_item->IsClass("Association")){
			((IRoseClassPtr)parent_item)->DeleteAssociation((IRoseAssociationPtr)new_item);
		} else if (new_item->IsClass("DependencyRelation")) {
			std::string message ("Can't delete DependencyRelation from ");
			message += RoseHelper::get_full_name (parent_item);
			GenSupport::LogManagerFactory::get ().log_error (message.c_str ());		
		} else {
			std::string class_type = new_item->IdentifyClass ();
			GDS_ASSERT_MSG (0, ("Unknown item type: %s", class_type.c_str ()));
		}
	} else if (parent_item->IsClass(CATEGORY_TYPE)) {
		if (new_item->IsClass(CLASS_TYPE)) {
			((IRoseCategoryPtr)parent_item)->DeleteClass ((IRoseClassPtr)new_item);
		} else if (new_item->IsClass(CATEGORY_TYPE)) {
			((IRoseCategoryPtr)parent_item)->DeleteCategory ((IRoseCategoryPtr)new_item);
		} else if (new_item->IsClass("CategoryDependency")) {
			((IRoseCategoryPtr)parent_item)->DeleteCategoryDependency ((IRoseCategoryDependencyPtr)new_item);
		} else if (new_item->IsClass("DependencyRelation")) {
			std::string message ("Can't delete DependencyRelation from ");
			message += RoseHelper::get_full_name (parent_item);
			GenSupport::LogManagerFactory::get ().log_error (message.c_str ());		
		} else {
			std::string class_type = new_item->IdentifyClass ();
			GDS_ASSERT_MSG (0, ("Unknown item type: %s", class_type.c_str ()));
		}
	} else if (parent_item->IsClass(OPERATION_TYPE)) {
		if (new_item->IsClass(PARAMETER_TYPE)) {
			((IRoseOperationPtr)parent_item)->DeleteParameter((IRoseParameterPtr)new_item);
		}
	} else if (parent_item->IsClass("Role")) {
		if (new_item->IsClass(ATTRIBUTE_TYPE)) {
			((IRoseRolePtr)parent_item)->DeleteKey((IRoseAttributePtr)new_item);
		}
	}
}

/*
all:
	ADVector m_activity_seq;
	ADList m_diagrams;

	//mutable std::string m_abstract_type;
	//mutable std::string m_visability_type;
	//mutable char m_is_native;
	
?  
	static Counters s_counters_value;
	mutable Counters m_counters;

sequence 
	std::string m_name;
	AbstractDumperBase* m_reciver;
	AbstractDumperBase* m_sender;
	AbstractDumperBase* m_operation;
	std::string m_message;

*/

void add_to_stamp (std::string& stamp, IRoseElementPtr item) {
	stamp += get_rose_element_uid(item);
	/*if (item->IsClass (ROSE_ITEM_TYPE)) {
		stamp += ((IRoseItemPtr)item)->Stereotype;
	}*/
	short i;

	if (item->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr cat = (IRoseCategoryPtr)item;
		IRoseCategoryCollectionPtr cats = cat->GetCategories ();

		short cats_count = cats->Count;
		for (i = 1; i <= cats_count; i++) {
			add_to_stamp (stamp, cats->GetAt(i));
		}

		IRoseClassCollectionPtr clss = cat->GetClasses ();
		short clss_count = clss->Count;
		for (i = 1; i <= clss_count; i++) {
			add_to_stamp (stamp, clss->GetAt(i));
		}

		//////
		IRoseCategoryDependencyCollectionPtr dps = cat->GetCategoryDependencies ();
		short dps_count = dps->Count;
		for (i = 1; i <= dps_count; i++) {
			IRoseItemPtr s = dps->GetAt(i)->GetSupplier();
			if (s != 0) {
				stamp += get_rose_element_uid(s);
			}
		}
		IRoseClassDiagramCollectionPtr class_diags = cat->ClassDiagrams;
		short class_diags_count = class_diags->Count;
		for (i = 1; i <= class_diags_count; ++i) {
			IRoseClassDiagramPtr class_diag = class_diags->GetAt (i);
			stamp += class_diag->GetName ();
			stamp += get_rose_element_uid(class_diag);			
		}

		IRoseScenarioDiagramCollectionPtr scenario_diags = cat->ScenarioDiagrams;
		short scenario_diags_count = scenario_diags->Count;
		for (i = 1; i <= scenario_diags_count; ++i) {
			IRoseScenarioDiagramPtr s = scenario_diags->GetAt (i);
			IRoseItemCollectionPtr items = s->Items;
			
			short count = items->Count;
			for (short j = 1; j <= count; ++j) {
				stamp += get_rose_element_uid(items->GetAt (j));
			}
			
			IRoseMessageCollectionPtr messages = s->GetMessages ();
			count = messages->Count;
			for (short j = 1; j <= count; ++j) {
				IRoseMessagePtr mess = messages->GetAt (j);
				IRoseObjectInstancePtr sender = mess->GetSenderObject ();
				if (sender) {
					stamp += get_rose_element_uid(sender);					
				}				
				stamp += "->";
				IRoseObjectInstancePtr reciver = mess->GetReceiverObject ();
				if (reciver) {
					stamp += get_rose_element_uid(reciver);					
				}
			}
			stamp += s->GetName ();
			stamp += get_rose_element_uid(s);
		}

		IRoseStateMachineOwnerPtr state_machine_owner = cat->GetStateMachineOwner ();
		if (state_machine_owner) {
			add_to_stamp (stamp, state_machine_owner);
		}
		stamp += item->GetName ();
		stamp += get_rose_element_uid(item);
	} else if (item->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = item;
		IRoseClassCollectionPtr clss = cls->GetNestedClasses ();
		short clss_count = clss->Count;
		for (i = 1; i <= clss_count; i++) {
			add_to_stamp (stamp, clss->GetAt(i));
		}

		IRoseAttributeCollectionPtr atrs = cls->GetAttributes ();
		short atrs_count = atrs->Count;
		for (i = 1; i <= atrs_count; i++) {
			add_to_stamp (stamp, atrs->GetAt(i));
		}

		IRoseOperationCollectionPtr ops = cls->GetOperations ();
		short ops_count = ops->Count;
		for (i = 1; i <= ops_count; i++) {
			add_to_stamp (stamp, ops->GetAt(i));
		}

		IRoseParameterCollectionPtr pars = cls->GetParameters ();		
		short pars_count = pars->Count;
		for (i = 1; i <= pars_count; i++) {
			add_to_stamp (stamp, pars->GetAt(i));
		}

		IRoseRoleCollectionPtr rls = cls->GetRoles ();
		short rls_count = rls->Count;
		for (i = 1; i <= rls_count; i++) {
			add_to_stamp (stamp, rls->GetAt(i));
		}

		IRoseClassDependencyCollectionPtr dps = cls->GetClassDependencies ();
		short dps_count = dps->Count;
		for (i = 1; i <= dps_count; i++) {
			add_to_stamp (stamp, dps->GetAt(i));
		}
		////
		IRoseRealizeRelationCollectionPtr rs = cls->GetRealizeRelations();
		short rs_count = rs->Count;
		for (i = 1; i <= rs_count; i++) {
			IRoseItemPtr s = rs->GetAt(i)->GetSupplier();
			if (s != 0) {
				stamp += "Realize: " + get_rose_element_uid(s);
			}
		}
		IRoseInheritRelationCollectionPtr is = cls->GetInheritRelations ();
		short is_count = is->Count;
		for (i = 1; i <= is_count; i++) {
			IRoseItemPtr s = is->GetAt(i)->GetSupplier();
			if (s != 0) {
				stamp += "Inherit: " +get_rose_element_uid(s);
			}
		}

		IRoseStateMachineOwnerPtr state_machine_owner = cls->GetStateMachineOwner ();
		if (state_machine_owner) {
			add_to_stamp (stamp, state_machine_owner);
		}

		stamp += item->GetName ();
		stamp += get_rose_element_uid(item);
		stamp += RoseHelper::get_abstraction_type_str (item);
		stamp += RoseHelper::get_visibility_type(item);
	} else if (item->IsClass (ATTRIBUTE_TYPE)) {
		IRoseAttributePtr attr = item;
		IRoseItemPtr s = attr->GetTypeClass ();
		if (s != 0) {
			stamp += get_rose_element_uid(s);
		} else {
			stamp += attr->GetType ();
		}
		stamp += item->GetName ();
		stamp += get_rose_element_uid(item);
		stamp += RoseHelper::get_abstraction_type_str (item);
		stamp += RoseHelper::get_visibility_type(item);
	} else if (item->IsClass ("Role"))  {
		IRoseRolePtr role = item;
		IRoseItemPtr s = role->GetClass();
		if (s != 0) {
			stamp += get_rose_element_uid(s);
		}

		IRoseAttributeCollectionPtr atrs = role->GetKeys ();
		short attrs_count = atrs->Count;
		for (i = 1; i <= attrs_count; i++) {
			add_to_stamp (stamp, atrs->GetAt(i));
		}
		stamp += item->GetName ();
		stamp += get_rose_element_uid(item);
		stamp += RoseHelper::get_abstraction_type_str (item);
		stamp += RoseHelper::get_visibility_type(item);
	} else if (item->IsClass (OPERATION_TYPE)) {
		IRoseOperationPtr operation = item;
		IRoseClassPtr s = operation->GetResultClass ();
		if (s != 0) {
			stamp += get_rose_element_uid(s);
		} else {
			stamp += operation->GetReturnType ();
		}
		IRoseParameterCollectionPtr pars = operation->GetParameters ();
		short pars_count = pars->Count;
		for (i = 1; i <= pars_count; i++) {
			add_to_stamp (stamp, pars->GetAt(i));
		}

		IRoseStateMachineOwnerPtr state_machine_owner = operation->GetStateMachineOwner ();
		if (state_machine_owner) {
			add_to_stamp (stamp, state_machine_owner);
		}
		stamp += item->GetName ();
		stamp += get_rose_element_uid(item);
		stamp += RoseHelper::get_abstraction_type_str (item);
		stamp += RoseHelper::get_visibility_type(item);
	} else if (item->IsClass (PARAMETER_TYPE)) {
		IRoseParameterPtr parameter = item;
		IRoseClassPtr s = parameter->GetTypeClass();
		if (s != 0) {
			stamp += get_rose_element_uid(s);
		} else {
			stamp += parameter->GetType ();
		}
		stamp += item->GetName ();
		stamp += get_rose_element_uid(item);
	} else if (item->IsClass (CLASS_DEPENDENCY_TYPE)) {
		IRoseClassPtr s = ((IRoseClassDependencyPtr)item)->GetSupplier();
		if (s != 0) {
			stamp += get_rose_element_uid(s);
		}
		stamp += item->GetName ();
		stamp += get_rose_element_uid(item);
	} else if (item->IsClass ("StateMachineOwner")) {
		IRoseStateMachineOwnerPtr state_machine_owner = item;
		IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
		short st_machines_count = st_machines->Count;
		for (short i = 1; i <= st_machines_count; ++i) {
			IRoseStateMachinePtr st_machine = st_machines->GetAt (i);
			IRoseStateDiagramCollectionPtr state_diags = st_machine->GetAllDiagrams ();
			short state_diags_count = state_diags->Count;
			for (short j = 1; j <= state_diags_count; ++j) {
				IRoseStateDiagramPtr state_diag = state_diags->GetAt (j);
				stamp += state_diag->GetName ();
				stamp += get_rose_element_uid(state_diag);
			}
			
			IRoseStateCollectionPtr states = st_machine->GetAllStates ();
			short states_count = states->Count;
			for (short j = 1; j <= states_count; ++j) {
				IRoseStatePtr state = states->GetAt (j);
				stamp += state->GetName ();
				stamp += get_rose_element_uid(state);
			}

			IRoseTransitionCollectionPtr transitions = st_machine->GetAllTransitions ();
			short transitions_count = transitions->Count;
			for (short j = 1; j <= transitions_count; ++j) {
				IRoseTransitionPtr transition = transitions->GetAt (j);
				stamp += transition->GetName ();
				stamp += get_rose_element_uid(transition);
			}
		}

	} else {
		assert (0);
	}
	stamp += (const char*)item->GetPropertyValue(TOOL_NAME, PROP_ATTR_SET_RAISES);
	stamp += (const char*)item->GetPropertyValue(TOOL_NAME, PROP_ATTR_GET_RAISES);	
	stamp += ".";
}

bool check_model_for_changes () {
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	bool res = false;	
	
	//IRoseCategoryPtr root_cat = RoseHelper::s_rose_app->CurrentModel->RootCategory;
	//add_to_stamp (stamp, root_cat);
	
	if (
		ModelStamp::instance ()->is_stamp_changed ()
		|| RoseTreeState::instance ()->is_changed ()
	) {
		LOG_D (("Model changed"));
		RoseAbstractDumper::reset_model_tree_root ();
		//saved_stamp = stamp;
		res = true;
	}
	return res;
}

int get_image_id (const AbstractDumperBase* adb) {
	if (adb->get_model_class_str() == "Class") {
		return 1;
	} else if (adb->get_model_class_str() == "Category") {
		return 0;
	} else if (adb->get_model_class_str() == "Operation") {
		return 5;
	} else if (adb->get_model_class_str() == "Attribute") {
		return 4;
	} else if (adb->get_model_class_str() == "Dependency") {
		return 6;
	} else if (adb->get_model_class_str() == "Parameter") {
		return 10;
	} else {
		return -1;
	}
}

bool has_content (IRoseItemPtr item) {	
	if (item->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = item;
		if (cls->GetNestedClasses()->Count) {
			return true;
		}
		IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
		short rl_attrs_count = rl_attrs->Count;
				
		for (int i = 1; i <= rl_attrs_count; i++) {
			if (RoseHelper::is_attribute_role (rl_attrs->GetAt(i))) {
				return true;
			}
		}		
		if (cls->GetAttributes()->Count) {
			return true;
		}
		if (cls->GetClassDependencies()->Count) {
			return true;
		}
		if (cls->GetOperations()->Count) {
			return true;
		}
		if (cls->GetParameters()->Count) {
			return true;
		}
	}
	if (item->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr cat = item;
		if (cat->GetClasses()->Count) {
			return true;
		}
		if (cat->GetCategories()->Count) {
			return true;
		}
	}
	if (item->IsClass (OPERATION_TYPE)) {
		IRoseOperationPtr op = item;
		if (op->GetParameters()->Count) {
			return true;
		}
	}
	if (item->IsClass ("Role")) {
		IRoseRolePtr rol = item;
		if (rol->GetKeys()->Count) {
			return true;
		}
	}

	return false;
}


//override for IRoseParametrPtr
void write_type (IRoseParameterPtr obj, const char* value) {
	obj->Type = value;
}

void write_init_value (IRoseParameterPtr obj, const char* value) {
	obj->InitValue = value;
}

void do_on_lock_fail (const std::string& mess) {
	if (GenSupport::EnvironmentFactory::get ().get_lock_failed_options ().need_ask) {
		std::string question (mess);
		question += "\r\n\r\n";
		question += "Продолжить без сохранения информации в модели?";
		int answer = ::AfxMessageBox (question.c_str (), MB_ICONQUESTION | MB_YESNO);

		GenSupport::EnvironmentFactory::get ().set_lock_failed_need_ask (false);
		GenSupport::EnvironmentFactory::get ().set_lock_failed_need_fatal_error (answer == IDYES ? false : true);

	}
	if (
		GenSupport::EnvironmentFactory::get ().get_lock_failed_options ().need_fatal_error
		&& !GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()
	) {
		//не смогли залочить, но записать свойство нужно - бросаем исключение
		//и взводим флаг прерывания генерации
		GenSupport::EnvironmentFactory::get ().set_cancel_generation (true);
		throw Base::FatalError (mess);
	} else {
		GenSupport::LogManagerFactory::get ().log_warning (mess);
	}
}

bool RoseHelper::is_attribute_role (IRoseRolePtr role) {
	return role->Navigable
			&& role->Model; //гнусный хак - таким образом проверям, что это не фиктивная связь
							   //Роза при копировании на диаграмме элементов, имеющих связи к
							   //самому себе создаёт фиктивную, временную связь, которая
							   //не сохраняется!!!
}

void RoseHelper::update_nested_generated_source (
	IRoseElementPtr parent
	, const GeneratedSourcePropertiesMap& nested_generated_sources
) {
	RoseHelper::GeneratedSourcePropertiesMap::const_iterator it = nested_generated_sources.begin ();
	RoseHelper::GeneratedSourcePropertiesMap::const_iterator it_end = nested_generated_sources.end ();
	for (; it != it_end; ++it) {
		parent->OverrideProperty (TOOL_NAME, it->first.c_str (), it->second.c_str ());
	}
}

void RoseHelper::update_nested_generated_source_with_lock (
	IRoseElementPtr parent
	, const GeneratedSourcePropertiesMap& nested_generated_sources
) {
	RoseHelper::GeneratedSourcePropertiesMap::const_iterator it = nested_generated_sources.begin ();
	RoseHelper::GeneratedSourcePropertiesMap::const_iterator it_end = nested_generated_sources.end ();
	for (; it != it_end; ++it) {
		RoseHelper::write_property_with_lock (
			parent
			, it->first
			, it->second
			, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
			, true
			, std::string ("Nested generated source: ") + it->first
		);
	}
}


void RoseHelper::get_updated_nested_generated_source (
	IRoseElementPtr parent
	, const RoseHelper::GeneratedSourceSetMap& files_properties
	, const RoseHelper::GeneratedSourceSetMap& pages_properties
	, RoseHelper::GeneratedSourcePropertiesMap& nested_generated_sources
) {
	RoseHelper::GeneratedSourceSetMap::const_iterator it = files_properties.begin ();
	RoseHelper::GeneratedSourceSetMap::const_iterator it_end = files_properties.end ();

	for (; it != it_end; ++it) {
		//получаем у родителя свойство		 
		std::string parent_value = (const char*)parent->GetPropertyValue (TOOL_NAME, it->first.c_str ());
		
		boost::char_separator<char> sep (",;", "", boost::drop_empty_tokens);
		typedef boost::token_iterator_generator<boost::char_separator<char>>::type TokenIter;		
		
		TokenIter tok_begin = boost::make_token_iterator<std::string> (
			parent_value.begin(), parent_value.end(), sep
		);

		TokenIter tok_end = boost::make_token_iterator<std::string> (
			parent_value.end(), parent_value.end(), sep
		);

		//добавляем к уже записанной информации о сгенерённых артефактах
		//
		GCL::StrSet parent_nested_arts (tok_begin, tok_end);
		parent_nested_arts.insert (it->second.begin (), it->second.end ());
		
		std::string parent_nested_arts_str = GCL::join (
			parent_nested_arts
			, ";"
		);
		if (parent_value != parent_nested_arts_str) {
			nested_generated_sources[it->first] = parent_nested_arts_str;
		}
	}
	it = pages_properties.begin ();
	it_end = pages_properties.end ();

	for (; it != it_end; ++it) {
		//получаем у родителя свойство		 
		std::string parent_value = (const char*)parent->GetPropertyValue (TOOL_NAME, it->first.c_str ());
		
		boost::char_separator<char> sep (";", "", boost::drop_empty_tokens);
		typedef boost::token_iterator_generator<boost::char_separator<char>>::type TokenIter;		
		
		TokenIter tok_begin = boost::make_token_iterator<std::string> (
			parent_value.begin(), parent_value.end(), sep
		);

		TokenIter tok_end = boost::make_token_iterator<std::string> (
			parent_value.end(), parent_value.end(), sep
		);

		//добавляем к уже записанной информации о сгенерённых артефактах
		//
		GCL::StrSet parent_nested_arts (tok_begin, tok_end);
		parent_nested_arts.insert (it->second.begin (), it->second.end ());
		
		std::string parent_nested_arts_str = GCL::join (
			parent_nested_arts
			, ";"
		);
		if (parent_value != parent_nested_arts_str) {
			nested_generated_sources[it->first] = parent_nested_arts_str;
		}
	}
}

void RoseHelper::collect_generated_source_for_parent (
	const std::string& elem_guid
	, const std::string& prop_name
	, const std::string& prop_value
	, RoseHelper::GeneratedSourceSetMap& files_properties
	, RoseHelper::GeneratedSourceSetMap& pages_properties
) {
	std::string property_name (prop_name);

	if (property_name.find ("SELF GENERATED FILE") != std::string::npos) {
		GCL::str_replace (property_name, "SELF GENERATED FILE ", "NESTED GENERATED FILES ");
		boost::char_separator<char> sep (",;", "", boost::drop_empty_tokens);
		typedef boost::token_iterator_generator<boost::char_separator<char> >::type TokenIter;
		
		TokenIter tok_begin = boost::make_token_iterator<std::string> (
			prop_value.begin(), prop_value.end(), sep
		);

		TokenIter tok_end = boost::make_token_iterator<std::string> (
			prop_value.end(), prop_value.end(), sep
		);
		
		for (; tok_begin != tok_end; ++tok_begin) {
			std::string parent_prop_value = *tok_begin + "::" + elem_guid;
			files_properties[property_name].insert (parent_prop_value);
		}
	} else if (prop_name.find ("WikiPageID") == 0) {				
		property_name = "NESTED GENERATED " + property_name;
		boost::char_separator<char> sep (";", "", boost::drop_empty_tokens);
		typedef boost::token_iterator_generator<boost::char_separator<char> >::type TokenIter;
		
		TokenIter tok_begin = boost::make_token_iterator<std::string> (
			prop_value.begin(), prop_value.end(), sep
		);

		TokenIter tok_end = boost::make_token_iterator<std::string> (
			prop_value.end(), prop_value.end(), sep
		);
		
		for (; tok_begin != tok_end; ++tok_begin) {
			std::string parent_prop_value = *tok_begin + "::" + elem_guid;
			pages_properties[property_name].insert (parent_prop_value);
		}
	}
}

//возвращает true, если prop_name - это имя юзер-секции
bool is_user_code_property (const std::string& prop_name) {
	static std::string start_uc_id (":*");
	std::string::size_type pos_start_uc_id = prop_name.rfind (start_uc_id);
	if (pos_start_uc_id != std::string::npos) {
		std::string::size_type pos_end_uc_id = prop_name.find ('*', pos_start_uc_id + start_uc_id.size ());
		if (pos_end_uc_id != std::string::npos) {
			return true;
		}
	}

	return false;
}
//#UC END# *4571F040008C*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation


BadName::BadName (const std::string& name)
	: m_name (name)
//#UC START# *4572051902FD_BASE_INIT*
//#UC END# *4572051902FD_BASE_INIT*
{
	//#UC START# *4572051902FD_BODY*
	//#UC END# *4572051902FD_BODY*
}

BadName::~BadName () throw () {
}

const char* BadName::uid () const /*throw ()*/ {
	return "4A700E36-3B13-4045-AA38-75DC1BD8558A";
}

const char* BadName::what () const throw () {
	//#UC START# *4572051902FD_WHAT_IMPL*
	return m_name.c_str ();
	//#UC END# *4572051902FD_WHAT_IMPL*
}



// определяет можно ли папку вылить в отдельный кат
bool can_control (IRoseCategoryPtr cat) {
	//#UC START# *46B939A200FA*
	IRoseCategoryPtr parent = cat->ParentCategory;
	bool res = true;
	if (parent) {
		parent = parent->ParentCategory;
		res = (parent != 0);
	} else {
		res = false;
	}
	return res;
	//#UC END# *46B939A200FA*
}

// возвращает true если переданный элемент можно редактировать
bool can_modify_elem (IRoseElementPtr elem) {
	//#UC START# *462891EB014D*
	if (!IsVirtualFactory::get ().execute (elem) && !elem->IsClass (MODEL_TYPE)) {
		IRoseControllableUnitPtr cat = get_nearest_controllable_unit (elem);
		if (0 != cat && false == cat->IsModifiable ()) {
			return false;
		}
	}
	return true;
	//#UC END# *462891EB014D*
}

// проверяет имя на уникальность и не конфликтность в заданном контексте
void check_class_name (IRoseClassPtr cls, const char* name_buf, bool& bad) {
	//#UC START# *462DDB5200AB*
	if (cls != 0) {
		IRoseClassCollectionPtr nested_class = cls->GetNestedClasses();
		short i;
		short nested_class_count = nested_class->Count;
		for (i = 1; i <= nested_class_count && !bad; i++) {
			if (nested_class->GetAt(i)->GetName() == _bstr_t(name_buf)) {
				bad = true;
			}
		}

		IRoseAttributeCollectionPtr nested_attr = cls->GetAttributes();
		short nested_attr_count = nested_attr->Count;
		for (i = 1; i <= nested_attr_count && !bad; i++) {
			if (nested_attr->GetAt(i)->GetName() == _bstr_t(name_buf)) {
				bad = true;
			}
		}

		IRoseOperationCollectionPtr nested_op = cls->GetOperations();
		short nested_op_count = nested_op->Count;
		for (i = 1; i <= nested_op_count && !bad; i++) {
			if (nested_op->GetAt(i)->GetName() == _bstr_t(name_buf)) {
				bad = true;
			}
		}

		IRoseRealizeRelationCollectionPtr rels = cls->GetRealizeRelations();
		short rels_count = rels->Count;
		for (i = 1; i <= rels_count && !bad; i++) {
			IRoseRealizeRelationPtr rel = rels->GetAt(i);	
			IRoseClassPtr sup_cls = rel->GetSupplierClass();
			check_class_name (sup_cls, name_buf, bad);
		}

		IRoseInheritRelationCollectionPtr gens = cls->GetInheritRelations();
		short gens_count = gens->Count;
		for (i = 1; i <= gens_count && !bad; i++) {
			IRoseInheritRelationPtr rel = gens->GetAt(i);	
			IRoseClassPtr sup_cls = rel->GetSupplierClass();
			check_class_name (sup_cls, name_buf, bad);
		}
	}
	//#UC END# *462DDB5200AB*
}

// проверяет синтаксиси введенного имени в диалоге свойств элемента
void check_name (IRoseItemPtr item, const std::string& pure_name) /*throw (BadName)*/ {
	//#UC START# *457204D401D4*
	if (item == 0) {
		return;
	}
	if (item->IsClass(CLASS_TYPE) || item->IsClass(CATEGORY_TYPE) || item->IsClass(OPERATION_TYPE)) {
		IRoseItemPtr item_par = item->GetContext();

		class _local {
		public:
			static void check_name (
				IRoseItemPtr item, const std::string& pure_name, bool need_inherit_check
			) /*throw BadName*/ {
				if (item == 0) {
					return;
				}

				if (item->Name == _bstr_t(pure_name.data())) {
					throw BadName ("Conflict with parent's or (parent base's) content name");
				}
				
				if (item->IsClass(CLASS_TYPE)) {
					IRoseClassPtr cls_item = item;
					IRoseClassCollectionPtr nested_class = cls_item->GetNestedClasses();
					short i;
					short nested_class_count = nested_class->Count;
					for (i = 1; i <= nested_class_count; i++) {
						if (nested_class->GetAt(i)->GetName() == _bstr_t(pure_name.data())) {
							throw BadName ("Conflict with parent's or (parent base's) nested class' name");
						}
					}

					IRoseOperationCollectionPtr nested_op = cls_item->GetOperations();
					short nested_op_count = nested_op->Count;
					for (i = 1; i <= nested_op_count; i++) {
						if (nested_op->GetAt(i)->GetName() == _bstr_t(pure_name.data())) {
							throw BadName ("Conflict with parent's or (parent base's) nested operation's name");
						}
					}
					
					if (need_inherit_check) {
						IRoseRealizeRelationCollectionPtr rels = cls_item->GetRealizeRelations();
						short rels_count = rels->Count;
						for (i = 1; i <= rels_count; i++) {
							IRoseRealizeRelationPtr rel = rels->GetAt(i);
							if (rel != 0) {
								IRoseClassPtr sup_cls = rel->GetSupplierClass();
								_local::check_name(sup_cls, pure_name, need_inherit_check);
							}
						}

						IRoseInheritRelationCollectionPtr gens = cls_item->GetInheritRelations();
						short gens_count = gens->Count;
						for (i = 1; i <= gens_count; i++) {
							IRoseInheritRelationPtr rel = gens->GetAt(i);	
							if (rel != 0) {
								IRoseClassPtr sup_cls = rel->GetSupplierClass();
								_local::check_name(sup_cls, pure_name, need_inherit_check);
							}
						}
					}
				}
				if (item->IsClass (CATEGORY_TYPE)) {
					IRoseCategoryPtr cat = item;
					IRoseClassCollectionPtr nested_class = cat->GetClasses();
					int i;
					short nested_class_count = nested_class->Count;
					for (i = 1; i <= nested_class_count; i++) {
						if (nested_class->GetAt(i)->GetName() == _bstr_t(pure_name.data())) {
							throw BadName ("Conflict with parent's or (parent base's) nested class' name");
						}
					}

					IRoseCategoryCollectionPtr nested_cat = cat->GetCategories();
					short nested_cat_count = nested_cat->Count;
					for (i = 1; i <= nested_cat_count; i++) {
						if (nested_cat->GetAt(i)->GetName() == _bstr_t(pure_name.data())) {
							throw BadName ("Conflict with parent's or (parent base's) nested category's name");
						}
					}
				}
			}
		};

		_local::check_name(item_par, pure_name, item->IsClass(OPERATION_TYPE));
	}
	//#UC END# *457204D401D4*
}

// очищает переданную строку от запрещенных файловой системой символов
// и вовращает эту стрку в качестве результата
const std::string clean_wrong_sympbols (const char* str) {
	//#UC START# *46B939AB032C*
	static std::string wrong_symbols = "\\/:*?\"<>|";
	std::string ret = str;
	for (
		std::string::const_iterator it = wrong_symbols.begin ()
		; it != wrong_symbols.end ()
		; ++it
	) {
		std::string erased_str;
		erased_str += *it;
		boost::erase_all(ret, erased_str);
	}
	return ret;
	//#UC END# *46B939AB032C*
}

// метод раскрашивает элемент (elem) на диаграмме (diag)
// 
// Общий алгоритм:
// 1. Если элемент примитив: серый фон, без рамки, без атрибутов без операций, шрифт красный болд
// 2. Если элемет из чужой папки: цвет рамки и шрифта из шаблона forieghn color, заливка белая (или
// прозрачная что лучше всего), без атрибутов, без операций
// 3. Иначе, раскрашиваем по шаблону: цвет фона, цвет рамки, видимость операций, видимость атрибутов
// 4. далее, если элемент не из чужой папки, то смотрим есть ли юзерские свойства отличные от
// дефолтных, если есть то выводим их в "ноте".
// Ноту сначала пытаемся найти, по ее ид, сохраненному в свойствах элемента, если таковой нет -
// создаем. Если раньше была, а теперь не нужна - удаляем.
void colorize (IRoseDiagramPtr diag, IRoseElementPtr elem) {
	//#UC START# *46C3E3B1035B*
	GDS_ASSERT(diag);
	DiagramColorizer colorizer (diag);
	colorizer.colorize (elem);
	diag->Invalidate ();
	//#UC END# *46C3E3B1035B*
}

// формирует путь на файловой системе куда будет сохранён кат.
const std::string create_dir_path (IRoseCategoryPtr cat) {
	//#UC START# *46B939BA036B*
	IRoseModelPtr model = cat->Model;
	std::string project_path ("W:\\shared\\models");
	const std::string path_component_to_control = MDAModelParams::get_path_component_to_control ();
	if (model) {
		std::string mdl_file = model->GetFileName ();
		std::string::size_type pos = mdl_file.find (path_component_to_control);
		if (pos != std::string::npos) {
			project_path = mdl_file.substr (0, pos + path_component_to_control.size ());
		}
	}

	std::string ret;
	
	GCL::StrVector path;
	path.push_back (clean_wrong_sympbols ((const char*)cat->Name));
	if (can_control (cat)) {				
		IRoseCategoryPtr project = cat->ParentCategory;
		while (project) {
			if (can_control (project) == false) {
				project_path += "\\";
				project_path += extract_cat_name (project);
				break;
			}
			std::string name = extract_cat_name (project);
			path.insert (path.begin (), name);
			project = project->ParentCategory;
		}
	}
	ret = GCL::join (path, "\\");
	return project_path + "\\" + ret;
	//#UC END# *46B939BA036B*
}

// по кату позволяет получить его полное имя-строку, нужное для паказа в диалогах список залоченных
// и в списке кандидатов на разлочку.
const std::string create_full_name (IRoseCategoryPtr cat) {
	//#UC START# *48DC62150060*
	std::string ret = static_cast<const char*>(cat->GetQualifiedName ());
	std::string::size_type j = ret.find_last_of (':');
	std::string pack_name;
	if (j != std::string::npos) {
		pack_name = ret.substr (j+1, ret.length ()-j-1);
	} else {
		pack_name = ret;
	}
	std::string sfn = static_cast<const char*>(cat->GetFileName ());
	std::string::size_type i = sfn.find_last_of ('\\');
	if (i != std::string::npos) {
		sfn = sfn.substr (i+1, sfn.length ()-i-1);
	}
	if (sfn.find (pack_name) != 0) {
		ret += " (";
		ret += sfn;
		ret += ")";
	}
	return ret;
	//#UC END# *48DC62150060*
}

// формирует из имени элемента имя лэйбла вью на диаграмме.
// используется для выделения на диаграмме элемента с переопределёнными UP
const std::string create_label_name (const std::string& item_name) {
	//#UC START# *470635F6005D*
	std::string text = RoseHelper::view_prefix;
	text += item_name;
	text += RoseHelper::view_postfix;
	return text;
	//#UC END# *470635F6005D*
}

// метод создает уникальное имя
const std::string create_unic_name (IRoseItemPtr context, const char* prefix) {
	//#UC START# *462D9D6501E4*
	std::string name_buf;
	if (context->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr cat = context;
		unsigned number = 0;
		bool bad;
		do {
			bad = false;
			if (number) {
				name_buf = prefix;
				name_buf += boost::lexical_cast<std::string> (number++);				
			} else {
				name_buf = prefix;
				number++;
			}
			
			if (cat->GetName() == _bstr_t(name_buf.c_str ())) {
				bad = true;
			}

			IRoseCategoryCollectionPtr nested_cats = cat->GetCategories();
			short i;
			short nested_cats_count = nested_cats->Count;
			for (i = 1; i <= nested_cats_count && !bad; i++) {
				if (nested_cats->GetAt(i)->GetName() == _bstr_t(name_buf.c_str ())) {
					bad = true;
				}
			}
			IRoseClassCollectionPtr nested_class = cat->GetClasses();
			short nested_class_count = nested_class->Count;
			for (i = 1; i <= nested_class_count && !bad; i++) {
				if (nested_class->GetAt(i)->GetName() == _bstr_t(name_buf.c_str ())) {
					bad = true;
				}
			}
			
			IRoseClassDiagramCollectionPtr diags = cat->GetClassDiagrams ();
			short diags_count = diags->Count;
			for (i = 1; i <= diags_count && !bad; i++) {
				if (diags->GetAt(i)->GetName() == _bstr_t(name_buf.c_str ())) {
					bad = true;
				}
			}
		} while (bad);
	}

	if (context->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = context;
		unsigned number = 0;
		bool bad;
		do {
			bad = false;
			if (number) {
				name_buf = prefix;
				name_buf += boost::lexical_cast<std::string> (number++);				
			} else {
				name_buf = prefix;
				number++;
			}
			
			check_class_name (cls, name_buf.c_str (), bad);
			
		} while (bad);
	}

	return name_buf;
	//#UC END# *462D9D6501E4*
}

// возвращает имя ката если папка уже вылита в отдельный кат, в противном случае возвращает имя
// папки
const std::string extract_cat_name (IRoseCategoryPtr cat) {
	//#UC START# *46B939B40222*
	if (cat->IsControlled ()) {
		std::string::size_type pos = -1;
		std::string cat_file = cat->GetFileName ();
		std::string drive;
		std::string dir;
		std::string fname;
		std::string ext;
		
		GCL::FileOp::splitpath (cat_file, drive, dir, fname, ext);
		return fname;
	}
	return clean_wrong_sympbols (cat->GetName ());
	//#UC END# *46B939B40222*
}

// извлекает из лэйбла вью имя элемента
const std::string extract_name_from_label (const std::string& label) {
	//#UC START# *470636530138*
	std::string regex_str (RoseHelper::view_prefix);
	regex_str += "(.*)";
	regex_str += RoseHelper::view_postfix;
	boost::regex exp (regex_str.c_str ());
	boost::smatch what;
	std::string res (label);
	if (boost::regex_match (label, what, exp)) {
		res.assign (what[1].first, what[1].second);
	}
	return res;
	//#UC END# *470636530138*
}

// возвращает стереотип элемента, соответствующий строке в шаблоне (template_str)
const std::string extract_stereotype (const std::string& template_str) {
	//#UC START# *462DB3AD0157*
	std::string ret;
	GCL::StrVector parts = GCL::split_string_by_sub_string (template_str.data(), "::");
	if (parts.size() == 2) { // class or categories (MySt::Class)
		std::string s = parts[0];			

		if (parts[1] == "Class") {
			ret = "Class";
		} else {
			ret = "Category";
		}
	} else if (parts.size() == 4) { // like Interface::Class::factory::Operation 
									//   or Interface::Class::Operation::Parameter :((
									//   or Interface::Class::Parameter::Parameter :((
		if (parts[2] == "Operation") {					
		}

		if (parts[3] == "Operation") {
			ret = "Operation";
		} else if (parts[3] == "Attribute") {
			ret = "Attribute";
		} else {
			ret = "ClassDependency";
		}			
	} else if (parts.size() == 3) { // unstereotyped ops and attrs 
									//  like Interface::Class::Operation, Interface::Class::Operation
									//  like Interface::Class::Parameter, Interface::Class::ClassDependency
		if (parts[2] == "Operation") {
			ret = "Operation";
		} else if (parts[2] == "Attribute") {
			ret = "Attribute";
		} else if (parts[2] == "StateMachine") {
			ret = "StateMachine";
		} else {
			ret = "ClassDependency";
		}		
	}

	return ret;
	//#UC END# *462DB3AD0157*
}

// возвращает список всех детей элемента
RoseElementSet* get_all_childs (IRoseElementPtr elem) {
	//#UC START# *47D8D75200A5*
	class local {
	public:
		static void collect_childs (const IRoseElementPtr& elem, RoseElementSet& childs) {
			if (elem->IsClass (CATEGORY_TYPE)) {
				IRoseCategoryPtr cat = elem;
				
				IRoseCategoryCollectionPtr cats = cat->GetCategories ();
				short cats_count = cats->Count;
				for (short i = 1; i <= cats_count; ++i) {
					IRoseCategoryPtr ch_cat = cats->GetAt (i);
					childs.insert (RoseElementWrapper (ch_cat));
					collect_childs (ch_cat, childs);
				}

				IRoseClassCollectionPtr classes = cat->GetClasses ();
				short classes_count = classes->Count;
				for (short i = 1; i <= classes_count; ++i) {
					IRoseElementPtr cls = classes->GetAt (i);
					childs.insert (RoseElementWrapper (cls));
					collect_childs (cls, childs);
				}

				//собираем все State-диаграммы
				IRoseStateMachineOwnerPtr state_machine_owner = cat->GetStateMachineOwner ();
				if (state_machine_owner) {
					IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
					short st_machines_count = st_machines->Count;
					for (short i = 1; i <= st_machines_count; ++i) {
						collect_childs (st_machines->GetAt (i), childs);
					}
				}

			} else if (elem->IsClass (CLASS_TYPE)) {
				IRoseClassPtr cls = elem;

				IRoseClassCollectionPtr classes = cls->GetNestedClasses();
				short classes_count = classes->Count;
				for (short i = 1; i <= classes_count; i++) {
					IRoseElementPtr nested_cls = classes->GetAt (i);
					childs.insert (RoseElementWrapper (nested_cls));
					collect_childs (nested_cls, childs);
				}

				IRoseAttributeCollectionPtr attrs = cls->Attributes;
				int attrs_count = attrs->Count;
				for (short i = 1; i <= attrs_count; i++) {		
					IRoseAttributePtr attr = attrs->GetAt(i);
					childs.insert (RoseElementWrapper (attr));
				}

				IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
				int rl_attrs_count = rl_attrs->Count;
				for (short i = 1; i <= rl_attrs_count; i++) {
					IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
					if (RoseHelper::is_attribute_role (rl_attr)) {
						childs.insert (RoseElementWrapper (rl_attr));
					}
				}

				IRoseOperationCollectionPtr ops = cls->Operations;
				int ops_count = ops->Count;
				for (short i = 1; i <= ops_count; i++) {
					IRoseOperationPtr op = ops->GetAt(i);
					childs.insert (RoseElementWrapper (op));
					collect_childs (op, childs);
				}

				IRoseParameterCollectionPtr pars = cls->Parameters;
				int pars_count = pars->Count;
				for (short i = 1; i <= pars_count; i++) {
					IRoseParameterPtr par = pars->GetAt(i);
					childs.insert (RoseElementWrapper (par));
				}
				
				IRoseClassDependencyCollectionPtr deps = cls->GetClassDependencies();	
				int deps_count = deps->Count;
				for (int i = 1; i <= deps_count; i++) {
					IRoseClassDependencyPtr dep = deps->GetAt(i);
					childs.insert (RoseElementWrapper (dep));
				}
				//собираем все State-диаграммы
				IRoseStateMachineOwnerPtr state_machine_owner = cls->GetStateMachineOwner ();
				if (state_machine_owner) {
					IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
					short st_machines_count = st_machines->Count;
					for (short i = 1; i <= st_machines_count; ++i) {
						childs.insert (RoseElementWrapper (st_machines->GetAt (i)));
						collect_childs (st_machines->GetAt (i), childs);
					}
				}
			} else if (elem->IsClass (OPERATION_TYPE)) {
				IRoseOperationPtr op = elem;
				
				IRoseParameterCollectionPtr params = op->Parameters;
				short params_count = params->Count;
				for (short l=1; l <= params_count; l++) {		
					IRoseParameterPtr par = params->GetAt(l);
					childs.insert (RoseElementWrapper (par));
				}
				//собираем все State-диаграммы
				IRoseStateMachineOwnerPtr state_machine_owner = op->GetStateMachineOwner ();
				if (state_machine_owner) {
					IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
					short st_machines_count = st_machines->Count;
					for (short i = 1; i <= st_machines_count; ++i) {
						childs.insert (RoseElementWrapper (st_machines->GetAt (i)));
						collect_childs (st_machines->GetAt (i), childs);
					}
				}
			} else if (elem->IsClass ("StateMachine")) {
				IRoseStateMachinePtr st_machine = elem;
				IRoseStateDiagramCollectionPtr state_diags = st_machine->GetDiagrams ();
				short state_diags_count = state_diags->Count;
				for (short j = 1; j <= state_diags_count; ++j) {
					IRoseStateDiagramPtr state_diag = state_diags->GetAt (j);
					//проверяем есть ли на диаграмме элементы или нет
					//если диаграмма пустая - не добавляем её в дерево,
					//т.к это бессмысленнно
					if (state_diag->ItemViews->Count > 0) {
						childs.insert (RoseElementWrapper (state_diag));
					}
				}
				std::string this_guid = get_rose_element_uid(st_machine);
				
				IRoseStateCollectionPtr states = st_machine->States;
				short states_count = states->Count;
				
				for (short j = 1; j <= states_count; ++j) {
					IRoseStatePtr state = states->GetAt (j);
					std::string context_guid = get_rose_element_uid(state->GetContext ());
					if (context_guid == this_guid) {
						childs.insert (RoseElementWrapper (state));
						collect_childs (state, childs);
					}					
				}
			} else if (elem->IsClass ("State")) {
				IRoseStatePtr state = elem;
				IRoseTransitionCollectionPtr transitions = state->GetTransitions ();
				short transitions_count = transitions->Count;
				for (short i = 1; i <= transitions_count; ++i) {
					IRoseTransitionPtr transition = transitions->GetAt (i);
					childs.insert (RoseElementWrapper (transition));
					collect_childs (transition, childs);
				}
				
				IRoseStateMachineCollectionPtr st_machines = state->GetStateMachines ();
				short st_machines_count = st_machines->Count;
				for (short i = 1; i <= st_machines_count; ++i) {
					childs.insert (RoseElementWrapper (st_machines->GetAt (i)));
					collect_childs (st_machines->GetAt (i), childs);
				}	
				
				IRoseEventCollectionPtr events = state->GetUserDefinedEvents ();

				IRoseActionCollectionPtr actions = state->GetActions ();
				short events_count = events->Count;
				short action_count = actions->Count;
				for (short i = 1; i <= action_count; ++i) {
					IRoseActionPtr action = actions->GetAt (i);
					if (action->Name != _bstr_t ("")) {
						//если имя не пустое - добавялем в дереве, иначе нет смысла
						childs.insert (RoseElementWrapper (action));
						collect_childs (action, childs);						
						for (short j = 1; j <= events_count; ++j) {
							IRoseEventPtr user_event = events->GetAt (j);
							if (user_event && user_event->Name != _bstr_t ("")) {
								IRoseActionPtr event_action = user_event->GetAction ();
								if (
									event_action
									&& get_rose_element_uid(event_action) == get_rose_element_uid(action)
								) {
									childs.insert (RoseElementWrapper (user_event));
									break;
								}
							}				
						}
					}
				}	
			} else if (elem->IsClass ("Transition")) {
				IRoseTransitionPtr transition = elem;
				IRoseActionPtr send_action = transition->GetSendAction ();
				if (send_action && send_action->Name != _bstr_t ("")) {
					childs.insert (RoseElementWrapper (send_action));
					collect_childs (send_action, childs);
				}
				IRoseActionPtr trigger_action = transition->GetTriggerAction ();
				if (trigger_action && trigger_action->Name != _bstr_t ("")) {
					childs.insert (RoseElementWrapper (trigger_action));
					collect_childs (trigger_action, childs);
				}

				IRoseEventPtr trigger_event = transition->GetTriggerEvent ();
				if (trigger_event && (trigger_event->Name != _bstr_t ("") || trigger_event->GuardCondition != _bstr_t (""))) {
					childs.insert (RoseElementWrapper (trigger_event));
				}
			} else if (elem->IsClass ("Action")) {
			}

			IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (elem);
			short diags_count = diags->Count;
			for (short i = 1; i <= diags_count; ++i) {
				childs.insert (RoseElementWrapper (diags->GetAt (i)));
			}
		}
	};
	Core::Aptr<RoseElementSet> res = new RoseElementSet ();
	local::collect_childs (elem, *res);
	return res.forget ();
	//#UC END# *47D8D75200A5*
}

// возвращает список всех производных (наследующихся, реализующих)  от данного классов (рекурсивно)
IRoseClassCollectionPtr get_all_derived (IRoseClassPtr cls) {
	//#UC START# *47C510C002DA*
	class local {
	public:
		static bool is_derived (IRoseClassPtr what, IRoseClassPtr from) {
			bool res = false;
			IRoseClassPtr cls = what;
			IRoseRealizeRelationCollectionPtr rs = what->GetRealizeRelations ();
			std::string from_guid (get_rose_element_uid(from));
			short i;
			short count = rs->Count;
			for (i = 1; i <= count; i++) {
				IRoseRealizeRelationPtr rel = rs->GetAt(i);
				if (rel) {
					IRoseClassPtr super_cls =  rel->GetSupplierClass();
					res |= get_rose_element_uid(super_cls) == from_guid;
				}
			}
			
			IRoseInheritRelationCollectionPtr is = what->GetInheritRelations ();
			count = is->Count;
			for (i = 1; i <= count; i++) {
				IRoseInheritRelationPtr rel = is->GetAt(i);
				if (rel) {
					IRoseClassPtr super_cls =  rel->GetSupplierClass();
					res |= get_rose_element_uid(super_cls) == from_guid;
				}
			}

			return res;
		}
		
		static void collect_subclasses (IRoseClassCollectionPtr classes, IRoseClassCollectionPtr& out) {			
			short count = classes->Count;
						
			for (short i = 1; i <= count; ++i) {
				IRoseClassPtr subcls = classes->GetAt (i);						
				if (!out->Exists (subcls)) {
					out->Add (subcls);
					collect_subclasses (subcls, out);
				}
			}
		}

		static void collect_subclasses (IRoseClassPtr cls, IRoseClassCollectionPtr& out) {
			GDS_ASSERT(cls);
			
			IRoseClassCollectionPtr inherits = cls->GetClients (rsAnyKind, rsTypeInherits);
			collect_subclasses (inherits, out);

			IRoseClassCollectionPtr realize = cls->GetClients (rsAnyKind, rsTypeRealizes);
			collect_subclasses (realize, out);
		}
	};
	GDS_ASSERT(cls);
	IRoseClassCollectionPtr res (__uuidof(RoseClassCollection));
	GDS_ASSERT_MSG(res, ("Can't create user-defined collection (RoseClassCollection)"));
	
	local::collect_subclasses (cls, res);
	return res;
	//#UC END# *47C510C002DA*
}

// возвращает список непосредственных детей элемента
RoseElementSet* get_childs (IRoseElementPtr elem) {
	//#UC START# *47E7AE460386*
	Core::Aptr<RoseElementSet> ret = new RoseElementSet ();
	if (elem->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr cat = elem;
		
		IRoseCategoryCollectionPtr cats = cat->GetCategories ();
		short cats_count = cats->Count;
		for (short i = 1; i <= cats_count; ++i) {
			IRoseCategoryPtr ch_cat = cats->GetAt (i);
			ret->insert (RoseElementWrapper (ch_cat));
		}

		IRoseClassCollectionPtr classes = cat->GetClasses ();
		short classes_count = classes->Count;
		for (short i = 1; i <= classes_count; ++i) {
			IRoseElementPtr cls = classes->GetAt (i);
			ret->insert (RoseElementWrapper (cls));
		}

		//собираем все State-диаграммы
		IRoseStateMachineOwnerPtr state_machine_owner = cat->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				Core::Aptr<RoseElementSet> st_machines_set = get_childs (st_machines->GetAt (i));
				ret->insert (st_machines_set->begin (), st_machines_set->end ());
			}
		}

	} else if (elem->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = elem;

		IRoseClassCollectionPtr classes = cls->GetNestedClasses();
		short classes_count = classes->Count;
		for (short i = 1; i <= classes_count; i++) {
			IRoseElementPtr nested_cls = classes->GetAt (i);
			ret->insert (RoseElementWrapper (nested_cls));			
		}

		IRoseAttributeCollectionPtr attrs = cls->Attributes;
		int attrs_count = attrs->Count;
		for (short i = 1; i <= attrs_count; i++) {		
			IRoseAttributePtr attr = attrs->GetAt(i);
			ret->insert (RoseElementWrapper (attr));
		}

		IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
		int rl_attrs_count = rl_attrs->Count;
		for (short i = 1; i <= rl_attrs_count; i++) {
			IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
			if (RoseHelper::is_attribute_role (rl_attr)) {
				ret->insert (RoseElementWrapper (rl_attr));
			}
		}

		IRoseOperationCollectionPtr ops = cls->Operations;
		int ops_count = ops->Count;
		for (short i = 1; i <= ops_count; i++) {
			IRoseOperationPtr op = ops->GetAt(i);
			ret->insert (RoseElementWrapper (op));
		}

		IRoseParameterCollectionPtr pars = cls->Parameters;
		int pars_count = pars->Count;
		for (short i = 1; i <= pars_count; i++) {
			IRoseParameterPtr par = pars->GetAt(i);
			ret->insert (RoseElementWrapper (par));
		}
	
		IRoseClassDependencyCollectionPtr deps = cls->GetClassDependencies();	
		int deps_count = deps->Count;
		for (int i = 1; i <= deps_count; i++) {
			IRoseClassDependencyPtr dep = deps->GetAt(i);
			ret->insert (RoseElementWrapper (dep));
		}

		//собираем все State-диаграммы
		IRoseStateMachineOwnerPtr state_machine_owner = cls->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				Core::Aptr<RoseElementSet> st_machines_set = get_childs (st_machines->GetAt (i));
				ret->insert (st_machines_set->begin (), st_machines_set->end ());
			}
		}
	} else if (elem->IsClass (OPERATION_TYPE)) {
		IRoseOperationPtr op = elem;
		
		IRoseParameterCollectionPtr params = op->Parameters;
		short params_count = params->Count;
		for (short l=1; l <= params_count; l++) {		
			IRoseParameterPtr par = params->GetAt(l);
			ret->insert (RoseElementWrapper (par));
		}
		//собираем все State-диаграммы
		IRoseStateMachineOwnerPtr state_machine_owner = op->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				ret->insert (RoseElementWrapper (st_machines->GetAt (i)));
			}
		}
	} else if (elem->IsClass ("StateMachine")) {
		IRoseStateMachinePtr st_machine = elem;
		IRoseStateDiagramCollectionPtr state_diags = st_machine->GetDiagrams ();
		short state_diags_count = state_diags->Count;
		for (short j = 1; j <= state_diags_count; ++j) {
			IRoseStateDiagramPtr state_diag = state_diags->GetAt (j);
			//проверяем есть ли на диаграмме элементы или нет
			//если диаграмма пустая - не добавляем её в дерево,
			//т.к это бессмысленнно
			if (state_diag->ItemViews->Count > 0) {
				ret->insert (RoseElementWrapper (state_diag));
			}
		}
		std::string this_guid = get_rose_element_uid(st_machine);
		
		IRoseStateCollectionPtr states = st_machine->States;
		short states_count = states->Count;
		
		for (short j = 1; j <= states_count; ++j) {
			IRoseStatePtr state = states->GetAt (j);
			std::string context_guid = get_rose_element_uid(state->GetContext ());
			if (context_guid == this_guid) {
				ret->insert (RoseElementWrapper (state));
			}					
		}
	} else if (elem->IsClass ("State")) {
		IRoseStatePtr state = elem;
		IRoseTransitionCollectionPtr transitions = state->GetTransitions ();
		short transitions_count = transitions->Count;
		for (short i = 1; i <= transitions_count; ++i) {
			IRoseTransitionPtr transition = transitions->GetAt (i);
			ret->insert (RoseElementWrapper (transition));
		}
		
		IRoseStateMachineCollectionPtr st_machines = state->GetStateMachines ();
		short st_machines_count = st_machines->Count;
		for (short i = 1; i <= st_machines_count; ++i) {
			ret->insert (RoseElementWrapper (st_machines->GetAt (i)));
		}	
		
		IRoseEventCollectionPtr events = state->GetUserDefinedEvents ();

		IRoseActionCollectionPtr actions = state->GetActions ();
		short events_count = events->Count;
		short action_count = actions->Count;
		for (short i = 1; i <= action_count; ++i) {
			IRoseActionPtr action = actions->GetAt (i);
			if (action->Name != _bstr_t ("")) {
				//если имя не пустое - добавялем в дереве, иначе нет смысла
				ret->insert (RoseElementWrapper (action));
				for (short j = 1; j <= events_count; ++j) {
					IRoseEventPtr user_event = events->GetAt (j);
					if (user_event && user_event->Name != _bstr_t ("")) {
						IRoseActionPtr event_action = user_event->GetAction ();
						if (
							event_action
							&& get_rose_element_uid(event_action) == get_rose_element_uid(action)
						) {
							ret->insert (RoseElementWrapper (user_event));
							break;
						}
					}				
				}
			}
		}	
	} else if (elem->IsClass ("Transition")) {
		IRoseTransitionPtr transition = elem;
		IRoseActionPtr send_action = transition->GetSendAction ();
		if (send_action && send_action->Name != _bstr_t ("")) {
			ret->insert (RoseElementWrapper (send_action));
		}
		IRoseActionPtr trigger_action = transition->GetTriggerAction ();
		if (trigger_action && trigger_action->Name != _bstr_t ("")) {
			ret->insert (RoseElementWrapper (trigger_action));
		}

		IRoseEventPtr trigger_event = transition->GetTriggerEvent ();
		if (trigger_event && (trigger_event->Name != _bstr_t ("") || trigger_event->GuardCondition != _bstr_t (""))) {
			ret->insert (RoseElementWrapper (trigger_event));
		}
	} else if (elem->IsClass ("Action")) {
	}

	IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (elem);
	short diags_count = diags->Count;
	for (short i = 1; i <= diags_count; ++i) {
		ret->insert (RoseElementWrapper (diags->GetAt (i)));
	}

	return ret.forget ();
	//#UC END# *47E7AE460386*
}

// возвращает коллекцию диаграмм классов, связанных с классом (item), если с item не связанна ни
// одна диаграмма коллекция пустая
// 
// Поиск связанной диаграммы осуществялется в папке, в которой находится item
IRoseClassDiagramCollectionPtr get_class_diagrams (IRoseClassPtr item) {
	//#UC START# *46C53A0D02BF*
	IRoseClassDiagramCollectionPtr res (__uuidof(RoseClassDiagramCollection));
	GDS_ASSERT_MSG(res, ("Can't create user-defined collection (RoseClassDiagramCollection)"));

	std::string uid = get_rose_element_uid(item);
	IRoseCategoryPtr cat = RoseHelper::get_nearest_category (item);
	if (cat) {
		IRoseClassDiagramCollectionPtr class_diagrams = cat->ClassDiagrams;
		short count = class_diagrams->Count;
		for (short i = 1; i <= count; ++i) {
			IRoseClassDiagramPtr diag = class_diagrams->GetAt (i);
			std::string linked_uid = diag->GetPropertyValue (
				TOOL_NAME, RoseHelper::CLASS_DIAG_LINK_PROPERTY
			);
			if (linked_uid == uid) {
				res->Add (diag);
			}
		}
	}
	return res;
	//#UC END# *46C53A0D02BF*
}

// возвращает идентификатор окна диаграммы
HWND get_diag_window (IRoseDiagramPtr diag) {
	//#UC START# *46C29C680213*
	IRoseCategoryPtr context = diag->GetParentContext ();
	std::string window_diagram_name = context->GetName () + " / " + diag->GetName ();
	if (RoseHelper::can_modify_elem (context) == false) {
		window_diagram_name += " {read-only}";
	}
	HWND diag_wnd = WinGUI::find_window (AfxGetMainWnd ()->GetSafeHwnd (), window_diagram_name, "");
	return diag_wnd;
	//#UC END# *46C29C680213*
}

// возвращает список всех диаграмм (диаграммы классов, сиквенс-диаграммы, диаграммы состояний)
// элемента
IRoseDiagramCollectionPtr get_diagrams (IRoseElementPtr elem) {
	//#UC START# *470DC8F9036B*
	IRoseDiagramCollectionPtr res (__uuidof(RoseDiagramCollection));
	GDS_ASSERT_MSG(res, ("Can't create user-defined collection (RoseDiagramCollection)"));
	if (elem->IsClass (CLASS_TYPE)) {
		IRoseClassPtr cls = elem;
		IRoseClassDiagramCollectionPtr class_diags = get_class_diagrams (cls);
		if (class_diags) {
			short class_diags_count = class_diags->Count;
			for (short j = 1; j <= class_diags_count; ++j) {
				IRoseDiagramPtr diag = class_diags->GetAt (j);
				res->Add (diag);
			}
		}
		IRoseCategoryPtr cat = RoseHelper::get_parent_category (cls);
		IRoseScenarioDiagramCollectionPtr sc_diags = cat->ScenarioDiagrams;
		if (sc_diags != 0) {
			std::string self_guid (get_rose_element_uid(cls));
			short collection_count = sc_diags->Count;
			for (short i = 1; i <= collection_count; i++) {
				IRoseDiagramPtr diag = sc_diags->GetAt(i);
				//проверяем есть ли на диаграмме элементы или нет
				//если диаграмма пустая - не добавляем её в дерево,
				//т.к это бессмысленнно				
				std::string use_case_uid = diag->GetPropertyValue (TOOL_NAME, "UseCase");				
				
				//проверяем, если даграмма связана с этим юзкейсом -
				//добавляем её
				if (use_case_uid == self_guid) {
					res->Add (diag);					
				}				
			}
		}
		//собираем все State-диаграммы
		IRoseStateMachineOwnerPtr state_machine_owner = cls->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				IRoseStateMachinePtr st_machine = st_machines->GetAt (i);
				IRoseStateDiagramCollectionPtr state_diags = st_machine->GetDiagrams ();
				short state_diags_count = state_diags->Count;
				for (short j = 1; j <= state_diags_count; ++j) {
					IRoseDiagramPtr state_diag = state_diags->GetAt (j);
					res->Add (state_diag);
				}				
			}
		}
	} else if (elem->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr cat = elem;
		IRoseClassDiagramCollectionPtr class_diags = cat->ClassDiagrams;
		
		IRoseModelPtr model = cat->Model;
		short class_diags_count = class_diags->Count;
		for (short j = 1; j <= class_diags_count; ++j) {
			IRoseDiagramPtr diag = class_diags->GetAt (j);
			std::string linked_uid = diag->GetPropertyValue (
				TOOL_NAME, RoseHelper::CLASS_DIAG_LINK_PROPERTY
			);			
			if (linked_uid.empty () == false && model) {
				IRoseClassPtr linked_cls = model->FindClassWithID (linked_uid.c_str ());
				if (!linked_cls) {
					res->Add (diag);
				}
			} else {
				res->Add (diag);
			}
		}
		////
		IRoseScenarioDiagramCollectionPtr sc_diags = cat->ScenarioDiagrams;
		if (sc_diags != 0) {			
			short collection_count = sc_diags->Count;
			for (short i = 1; i <= collection_count; i++) {
				IRoseDiagramPtr diag = sc_diags->GetAt(i);
				//проверяем есть ли на диаграмме элементы или нет
				//если диаграмма пустая - не добавляем её в дерево,
				//т.к это бессмысленнно				
				std::string use_case_uid = diag->GetPropertyValue (TOOL_NAME, "UseCase");				
				
				//проверяем, если даграмма не связана ни с каким юзкейсом -
				//добавляем её
				if (use_case_uid.empty ()) {
					res->Add (diag);					
				}				
			}
		}
		//собираем все State-диаграммы
		IRoseStateMachineOwnerPtr state_machine_owner = cat->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				IRoseStateMachinePtr st_machine = st_machines->GetAt (i);
				IRoseStateDiagramCollectionPtr state_diags = st_machine->GetDiagrams ();
				short state_diags_count = state_diags->Count;
				for (short j = 1; j <= state_diags_count; ++j) {
					IRoseDiagramPtr state_diag = state_diags->GetAt (j);
					res->Add (state_diag);
				}
			}
		}
	}
	return res;
	//#UC END# *470DC8F9036B*
}

// возвращает элемент диаграммы по заданным координатам
IRoseElementPtr get_element (IRoseDiagramPtr diag, long x, long y) {
	//#UC START# *45F50B8D01F4*
	IRoseElementPtr elem;
	POINT in_point = {x, y};
	if (point_to_diagram (in_point, diag)) {		
		IRoseItemViewCollectionPtr views = diag->GetItemViews ();
		short count = views->Count;
		for (short i = 1; i <= count; ++i) {
			IRoseItemViewPtr view = views->GetAt (i);			
			if (view->PointInView ((short)in_point.x, (short)in_point.y)) {
				elem = view->GetItem ();
				break;
			}
		}
	}
	return elem;
	//#UC END# *45F50B8D01F4*
}

// возвращает множество стереотипов (Class, Operation, Attribute и т.д), которые разрешено
// создавать внутри элемента (elem).
GCL::StrSet* get_enabled_stereotypes (IRoseElementPtr elem) {
	//#UC START# *4784652800C1*
	Core::Aptr<GCL::StrSet> res = new GCL::StrSet ();
	IRoseElementPtr item = elem;			
	if (elem->IsClass ("Diagram")) {
		item = RoseHelper::get_context (elem);
	}
	for (
		AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
		; it != AbstractDumperBase::templates_end ()
		; it ++
	) {				
		if (
			RoseHelper::is_it_available_by_constr (0, item, it->first)
			&& RoseHelper::is_it_available_by_type (0, item, it->first)
		) {
			std::string stereotype_str = it->first;
			res->insert (RoseHelper::extract_stereotype (stereotype_str));
		}
	}
	return res.forget ();
	//#UC END# *4784652800C1*
}

// возвращает индекс изображения в ImageList'е, соответствующего элементу (elem), если такого
// изображения нет - возвращает -1
int get_image_index (IRoseElementPtr elem) {
	//#UC START# *46963D5D02CE*
	int img_id = -1;
	AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(elem));

	if (tpl.image_file_name != "") {
		std::string image_path = MDAModelParams::get_image_dir();
		image_path += "\\";
		image_path += tpl.image_file_name;
		img_id = RoseHelper::get_rose_image_list ()->get_image_index (image_path);
	} 
	if (img_id == -1) {					
		if (elem->IsClass (CLASS_TYPE)) {
			IRoseClassPtr cls = elem;
			if (cls->Stereotype == _bstr_t ("UseCase")) {
				img_id = 7;
			} else if (cls->Stereotype == _bstr_t ("Actor")) {
				img_id = 8;
			} else {
				img_id = 1;
			}
		} else if (elem->IsClass (CATEGORY_TYPE)) {
			img_id = 0;
		} else if (elem->IsClass (OPERATION_TYPE)) {
			img_id = 3;
		} else if (elem->IsClass (ATTRIBUTE_TYPE)) {
			IRoseAttributePtr attr = elem;	
			IRoseItemPtr parent = attr->GetContext ();
			if (parent->IsClass ("Role")) {
				img_id = 1;
			} else {
				img_id = 2;
			}
		} else if (elem->IsClass ("Role")) {
			IRoseRolePtr role = elem;
			if (role->Name != _bstr_t ("")) {
				img_id = 2;
			} else {
				img_id = 2;
			}
		} else if (
			elem->IsClass (CLASS_DEPENDENCY_TYPE)
			|| elem->IsClass ("CategoryDependecy")
			|| elem->IsClass ("InheriteRelation")
			|| elem->IsClass ("RealizeRelation")
			|| elem->IsClass ("Association")
		) {
			img_id = 4;
		} else if (elem->IsClass ("ClassDiagram")) {
			img_id = 5;
		} else if (elem->IsClass ("ScenarioDiagram")) {
			img_id = 6;
		} else if (elem->IsClass (PARAMETER_TYPE)) {
			IRoseParameterPtr par = elem;
			IRoseItemPtr parent = par->GetContext ();
			if (parent->IsClass (CLASS_TYPE)) {
				img_id = 1;
			}
		} else if (elem->IsClass ("CategoryDependency")) {
			img_id = 4;
		} else if (elem->IsClass ("StateDiagram")) {
			img_id = 16;
		} else if (elem->IsClass ("State")) {
			IRoseStatePtr state = elem;
			short state_kind = state->StateKind->GetValue ();
			switch (state_kind) {
				case 0: 
					img_id = 19;
					break;
				case 1:
					img_id = 18;
					break;
				case 2:
					img_id = 17;
					break;
			}		
		} else if (elem->IsClass ("Transition")) {
			img_id = 20;
		} else if (elem->IsClass ("StateMachine")) {
			img_id = 21;
		} else {
			img_id = -1;
		}
	}
	return img_id;
	//#UC END# *46963D5D02CE*
}

// возвращает ближайший пакет
IRoseCategoryPtr get_nearest_category (IRoseElementPtr elem) {
	//#UC START# *4632F092034B*
	if (elem->IsClass (CATEGORY_TYPE)) {
		return elem;
	} else if (elem->IsClass ("Diagram")) {
		return ((IRoseDiagramPtr)elem)->GetParentContext ();
	} else if (elem->IsClass ("ItemView")) {
		return ((IRoseDiagramPtr)elem)->GetParentContext ();
	} else {
		IRoseItemPtr item = elem;
		if (item) {
			return RoseHelper::get_parent_category (item);
		}
	}
	return 0;
	//#UC END# *4632F092034B*
}

// возвращает ближайших элемент модели который может быть помещен на контроль
IRoseControllableUnitPtr get_nearest_controllable_unit (IRoseElementPtr elem) {
	//#UC START# *46288CBC03BE*
	class Local {
	public:
		static public IRoseControllableUnitPtr get_nearest_controllable_unit_i (IRoseItemPtr item) {
			GDS_ASSERT_MSG(item != 0, ("Unknown object type"));
			if (item->IsClass("ControllableUnit")) {
				IRoseControllableUnitPtr cat = (IRoseControllableUnitPtr)item;
				if (cat->IsControlled ()) {
					return cat;
				}
			}
			
			IRoseElementPtr parent_item = NULL;
			if (item->IsClass("Role")) {
				IRoseRolePtr rr = IRoseRolePtr(item);
				IRoseAssociationPtr ra = rr->Association;
				parent_item = ra->ParentCategory;
			} else if (item->IsClass("Association")) {
				parent_item = ((IRoseAssociationPtr)item)->ParentCategory;
			} else {
				parent_item = RoseHelper::get_context(item);
			}

			if (parent_item == NULL) {
				return NULL;
			}
			return get_nearest_controllable_unit_i (parent_item);
		}
	};
	if (elem) {
		IRoseItemPtr item;	
		if (elem->IsClass ("Diagram")) {
			item = ((IRoseDiagramPtr)elem)->GetParentContext ();
		} else if (elem->IsClass ("ItemView")/* || elem->IsClass ("NoteView")*/) {
			item = ((IRoseItemViewPtr)elem)->ParentDiagram->GetParentContext ();		
		} else if (elem->IsClass ("StateMachine")) {
			IRoseStateMachinePtr state_machine = elem;
			item = state_machine->StateMachineOwner->GetParentItem ();
		} else if (elem->IsClass ("Transition")) {
			item = ((IRoseTransitionPtr)elem)->GetContext ();
		} else if (elem->IsClass ("State")) {
			IRoseStatePtr state = elem;				
			IRoseStateMachinePtr machine = state->GetParentStateMachine ();
			IRoseStateMachineOwnerPtr machine_owner = machine->GetStateMachineOwner ();
			item = machine_owner->GetParentItem ();	
		} else if (elem->IsClass ("Event")) {
			IRoseActionPtr action = ((IRoseEventPtr)elem)->GetAction ();
			if (action == NULL) {
				return NULL;
			}
			return get_nearest_controllable_unit (action);
		} else if (elem->IsClass ("Action")) {
			IRoseActionPtr action = elem;
			IRoseStateMachineOwnerPtr machine_owner = action->GetStateMachineOwner ();
			if (machine_owner) {
				item = machine_owner->GetParentItem ();	
			} else {
				item = action->GetContext ();
			}
		} else {
			item = (IRoseItemPtr)elem;		
			if (item == 0) {
				std::string class_type = elem->IdentifyClass ();
				LOG_E (("Wrong element type: %s", class_type.c_str ()));
			}
		}

		return Local::get_nearest_controllable_unit_i (item);
	}
	return NULL;
	//#UC END# *46288CBC03BE*
}

// возвращает прямоугольник, соответствующий view элемента
void get_rect (IRoseItemViewPtr view, CRect& rect) {
	//#UC START# *474564200371*
	GDS_ASSERT(view);
	short x = view->XPosition;
	short y = view->YPosition;
	short width = view->GetWidth ();
	short height = view->GetHeight ();

	rect.SetRect (
		x - (short)width/2
		, y + (short)height/2
		, x + (short)width/2
		, y - (short)height/2
	);
	//#UC END# *474564200371*
}

// возвращает роль, соответствующую "концу" стрелки ассоциации
IRoseRolePtr get_role (IRoseAssociationPtr assoc) {
	//#UC START# *46383E01002E*	
	GDS_ASSERT (assoc);	
	IRoseRolePtr role = assoc->Role1;
	if (role && !role->Navigable) {
		role = assoc->Role2;
	}

	return role;
	//#UC END# *46383E01002E*
}

// возвращает ImageList, хранящий изображения, соответсвующие элементам модели.
// 
// Удалять возвращаемый результат не надо!
WinGUI::CImageListEx* get_rose_image_list () {
	//#UC START# *469620F90196*
	if (RoseImageListSingleton::instance ()->m_hImageList == NULL) {		
		RoseImageListSingleton::instance ()->create (16, 18, ILC_COLOR24 | ILC_MASK, 0, 1);				
	}
	if (RoseImageListSingleton::instance ()->GetImageCount () <= 0) {		
		CBitmap cBitmap;
		BITMAP bmBitmap;
		if (
			cBitmap.Attach(
				LoadImage(
					AfxGetResourceHandle()
					, MAKEINTRESOURCE(IDB_BITMAP_FOR_EXPLORER)
					, IMAGE_BITMAP
					, 0
					, 0
					, LR_DEFAULTSIZE|LR_CREATEDIBSECTION
				)
			)
			&& cBitmap.GetBitmap(&bmBitmap)
		) {			
			int number_btn = bmBitmap.bmWidth/16;			
			RoseImageListSingleton::instance ()->add_image ((HBITMAP)cBitmap, number_btn);			
			cBitmap.Detach();
		}		
		
	}
	return RoseImageListSingleton::instance ();
	//#UC END# *469620F90196*
}

// возвращает путь к файлу
const std::string get_template_file () {
	//#UC START# *46E8FE5303A9*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46E8FE5303A9*
}

// возвращает коллекцию вью соответствующих элементу (item) на диаграмме (diag)
IRoseItemViewCollectionPtr get_views (IRoseItemPtr item, IRoseDiagramPtr diag) {
	//#UC START# *474568A2003A*
	IRoseItemViewCollectionPtr res (__uuidof(RoseItemViewCollection));
	GDS_ASSERT_MSG(res, ("Can't create user-defined collection (RoseItemViewCollection)"));
	
	IRoseItemViewCollectionPtr diag_views = diag->ItemViews;
	short diag_views_count = diag_views->Count;
	for (short i = 1; i <= diag_views_count; ++i) {
		IRoseItemViewPtr view = diag_views->GetAt (i);
		if (view) {
			IRoseItemPtr view_item = view->Item;
			if (view_item && get_rose_element_uid(view_item) == get_rose_element_uid(item)) {
				res->Add (view);
			}
		}
	}
	return res;
	//#UC END# *474568A2003A*
}

// метод определяет является ли окно h_wnd окном диаграммы
bool is_diagram_window (HWND h_wnd, IRoseDiagramPtr diag) {
	//#UC START# *45CCC8AE03B9*
	class CFindWnd {
	private:
	   //////////////////
	   // This private function is used with EnumChildWindows to find the 
	   // child with a given class name. Returns FALSE if found (to stop 
	   // enumerating).
	   //
	   static BOOL CALLBACK FindChildClassHwnd(HWND hwndParent, LPARAM lParam) {
		   CFindWnd *pfw = (CFindWnd*)lParam;
		   HWND hwnd = FindWindowEx(hwndParent, NULL, pfw->m_classname, NULL);
		   if (hwnd) {
			   CWnd* wnd = CWnd::FromHandle (hwnd);
			   CString wnd_caption;
			   wnd->GetWindowText (wnd_caption);
			   if (wnd_caption.Find (pfw->m_caption) != -1) {
				   pfw->m_hWnd = hwnd;  // found: save it
				   return FALSE;        // stop enumerating
			   }
		   }
		   // recurse
		   EnumChildWindows(hwndParent, FindChildClassHwnd, lParam); 
		   return TRUE;            // keep looking
	   }
	public:
		LPCSTR m_classname;        // class name to look for
		LPCSTR m_caption;        // caption to look for
		HWND m_hWnd;               // HWND if found
		// ctor does the work—just instantiate and go
		CFindWnd(HWND hwndParent, LPCSTR classname, LPCSTR caption)
			: m_hWnd(NULL), m_classname(classname), m_caption (caption) 
		{
			FindChildClassHwnd(hwndParent, (LPARAM)this);
		}
	};
	
	CWnd* wnd = CWnd::FromHandle (h_wnd);
	CWnd* root = NULL;
	if (wnd) {
		root = wnd->GetTopLevelParent ();	
	}
	if (diag) {
		IRoseItemPtr context = diag->GetParentContext ();
		std::string window_diagram_name;
		if (diag->IsClass ("ClassDiagram") || diag->IsClass ("ScenarioDiagram")) {
			window_diagram_name	= context->GetName () + " / " + diag->GetName ();
		} else if (diag->IsClass ("StateDiagram")) {
			IRoseStateDiagramPtr st_diag = diag;
			IRoseStateMachinePtr machine = st_diag->Parent;
			IRoseElementPtr item = RoseHelper::get_context (machine);
			window_diagram_name	= item->GetName () + " / " + diag->GetName ();
		}

		if (context && RoseHelper::can_modify_elem (context) == false) {
			window_diagram_name += " {read-only}";
		}
		CString wnd_caption;
		wnd->GetWindowText (wnd_caption);
		
		if (wnd_caption.Find (window_diagram_name.c_str ()) != -1) {
			return true;
		} else {
			CWnd* parent = wnd->GetParent ();
			if (parent) {
				parent->GetWindowText (wnd_caption);
				if (wnd_caption.Find (window_diagram_name.c_str ()) != -1) {
					return true;
				}
			}
		}
		CFindWnd fw (root->GetSafeHwnd (), NULL, window_diagram_name.c_str ());
		if (fw.m_hWnd == ::GetParent (h_wnd) || fw.m_hWnd == h_wnd) {
			return true;
		} else {
			return false;
		}
	}
	return false;
	//#UC END# *45CCC8AE03B9*
}

// Является ли элемент незавршённым. Возвращает true, если для элемента или хотя бы для одного его
// родителя выставлен признак незавршённости, иначе - false
bool is_incomplete (IRoseElementPtr elem) {
	//#UC START# *473B10330271*
	bool res = false;
	for (
		IRoseElementPtr context = elem
		; context != 0
		; context = RoseHelper::get_context (context)
	) {
		std::string prop_value = context->GetPropertyValue(TOOL_NAME, PROP_INCOMPLETE);
		if (prop_value == "true") {
			res = true;
			break;
		}		
	}
	return res;
	//#UC END# *473B10330271*
}

// метод возвращает true, если элемент или хотя бы один из его родителей является Main - элементом,
// иначе возвращает false
bool is_main_with_parents (IRoseElementPtr elem) {
	//#UC START# *4739278F009C*
	bool res = RoseHelper::is_it_main_model_element (elem);
	if (!res) {
		IRoseElementPtr context = RoseHelper::get_context (elem);
		for (; res != true && context != 0; context = RoseHelper::get_context (context)) {
			res |= RoseHelper::is_it_main_model_element (context);
		}
	}
	return res;
	//#UC END# *4739278F009C*
}

// формирует идентификатор для кэлбэка сбрасывающего измененные при суммонинге списки override или
// implement операций.
const std::string make_restore_overriden_or_impl_callback_uid (IRoseElementPtr elem, const std::string& prop_name) {
	//#UC START# *4AF29DDA00EC*
	return get_rose_element_uid(elem) + prop_name;
	//#UC END# *4AF29DDA00EC*
}

// метод переносит информацию о сгенерённых артефактах (записанных в свойствах элемента) в его
// родителя
void move_generated_source_to_parent (IRoseElementPtr elem, IRoseElementPtr parent) {
	//#UC START# *47D8D6F40092*
	class local {
	public:
		static void collect_properties (
			const IRoseElementPtr& elem
			, IRoseElementPtr parent
			, std::map<std::string, GCL::StrSet>& files_properties
			, std::map<std::string, GCL::StrSet>& pages_properties
		) {
			GDS_ASSERT(elem);
			GDS_ASSERT(parent);

			IRosePropertyCollectionPtr props = elem->GetToolProperties (TOOL_NAME);
			short props_count = props->Count;
			
			std::string elem_guid = get_rose_element_uid(elem);
			for (short i = 1; i <= props_count; ++i) {
				IRosePropertyPtr prop = props->GetAt (i);
				std::string prop_name = prop->GetName ();
				std::string prop_value = prop->GetValue ();
				collect_generated_source_for_parent (elem_guid, prop_name, prop_value, files_properties, pages_properties);
							
			}
		}
	};

	if (parent) {
		std::map<std::string, GCL::StrSet> files_properties;
		std::map<std::string, GCL::StrSet> pages_properties;
		local::collect_properties (elem, parent, files_properties, pages_properties);
		
		//нужно перенести информацию о сгенерённых элементах из всех детей
		Core::Aptr<RoseElementSet> all_child_elems = RoseHelper::get_all_childs (elem);
		if (all_child_elems.is_nil () == false && all_child_elems->empty () == false) {
			RoseElementSet::const_iterator it = all_child_elems->begin ();
			RoseElementSet::const_iterator it_end = all_child_elems->end ();
			for (; it != it_end; ++it) {
				local::collect_properties (it->element, parent, files_properties, pages_properties);
			}
		}
		
		GeneratedSourcePropertiesMap nested_gen_sources;
		get_updated_nested_generated_source (parent, files_properties, pages_properties, nested_gen_sources);
		update_nested_generated_source (parent, nested_gen_sources);
	}	
	//#UC END# *47D8D6F40092*
}

// пытаемся открыть файл шаблона на файловой системе возвращает путь к файлу.
// 
// \one_trye - флаг определяет делать ли только одну попытку открыть файл
const std::string open_template_file (bool one_try) {
	//#UC START# *46F0A8EE00FA*	

	char szFilters[] = "MDA Template Files (*.tpl)|*.tpl|All Files (*.*)|*.*||";	
	bool finished = false;
	std::string template_dir = MDAModelParams::get_templates_dir();
	std::string file_name;
	std::string res;
	do {
		CFileDialog f_dlg (true, "tpl", "*.tpl", OFN_FILEMUSTEXIST| OFN_HIDEREADONLY, szFilters);
		if (f_dlg.DoModal() == IDOK) {
			file_name = (const char*) f_dlg.GetPathName ();			
			std::string::size_type pos = file_name.find (template_dir);
			if (pos != std::string::npos) {
				file_name = file_name.substr (pos + template_dir.length ());
			} else {
				pos = file_name.find_first_of ("\\");
				if (pos != std::string::npos) {
					file_name = file_name.substr (pos + 1);
				}
			}
			std::ifstream templ_file (RoseHelper::make_template_file (file_name).c_str (), std::ios::in);
			if (templ_file.is_open ()) {
				finished = true;
				res = file_name;
			}
		} else {
			finished = true;
		}
	} while (finished == false && one_try == false);
	return res;
	//#UC END# *46F0A8EE00FA*
}

// приводит точки из координат экрана в координаты диаграммы
bool point_to_diagram (POINT& point, IRoseDiagramPtr diag) {
	//#UC START# *45F514A400DA*	
	HWND diag_wnd = WindowFromPoint (point);
	if (diag_wnd != NULL && is_diagram_window (diag_wnd, diag)) {
		
		//HDC dc = GetDC (diag_wnd);
		//LOG_D (("Device TECHNOLOGY: %d", GetDeviceCaps (dc, TECHNOLOGY)));
		//LOG_D (("Device LOGPIXELSX: %d", GetDeviceCaps (dc, LOGPIXELSX)));
		//LOG_D (("Device LOGPIXELSY: %d", GetDeviceCaps (dc, LOGPIXELSY)));
		//LOG_D (("Device SCALINGFACTORX: %d", GetDeviceCaps (dc, SCALINGFACTORX)));
		//LOG_D (("Device SCALINGFACTORY: %d", GetDeviceCaps (dc, SCALINGFACTORY)));
		//ReleaseDC (diag_wnd, dc);
		SCROLLINFO horiz_scroll = {};
		SCROLLINFO vert_scroll = {};

		CWnd* parent = CWnd::FromHandle (::GetParent (diag_wnd));		
		if (parent != NULL) {
			CWnd* first_scroll = CWnd::FindWindowEx (
				parent->GetSafeHwnd ()
				, NULL
				, "ScrollBar"
				, NULL
			);
			CWnd* second_scroll = NULL;
			if (first_scroll) {
				second_scroll = CWnd::FindWindowEx (
					parent->GetSafeHwnd ()
					, first_scroll->GetSafeHwnd ()
					, "ScrollBar"
					, NULL
				);
			}
			if (first_scroll) {
				RECT cl_rect = {};
				::GetWindowRect (first_scroll->GetSafeHwnd (), &cl_rect);
				CScrollBar temp;
				temp.Attach (first_scroll->GetSafeHwnd ());
				if ((cl_rect.bottom - cl_rect.top) <= 20) { // this is horiz scroll!!!					
					temp.GetScrollInfo (&horiz_scroll);
				} else { //this is vert scroll
					temp.GetScrollInfo (&vert_scroll);
				}
				temp.Detach ();
			}
			if (second_scroll) {
				RECT cl_rect = {};
				::GetWindowRect (second_scroll->GetSafeHwnd (), &cl_rect);
				CScrollBar temp;
				temp.Attach (second_scroll->GetSafeHwnd ());
				if ((cl_rect.bottom - cl_rect.top) <= 20) { // this is horiz scroll!!!
					temp.GetScrollInfo (&horiz_scroll);
				} else { //this is vert scroll
					temp.GetScrollInfo (&vert_scroll);
				}
				temp.Detach ();
			}
		}		
		::ScreenToClient (diag_wnd, &point);
		//const double k_x = (1233-150)/(828-476);
		//const double k_y = (1962-132)/(696-110);
		//point.x = (long)((point.x + horiz_scroll.nPos)*k_x*100/diag->ZoomFactor);
		//point.y = (long)((point.y + vert_scroll.nPos)*k_y*100/diag->ZoomFactor);
		const double k_x_[] = {(double)(2050-175)/(double)(657-56), (double)(2071-197)/(double)(663-63)};
		const double k_y_[] = {(double)(2065-268)/(double)(660-85), (double)(275-2046)/(double)(86-654)};
		const double k_x = (double)(k_x_[0] + k_x_[1])/(sizeof(k_x_)/sizeof(k_x_[0]));
		const double k_y = (double)(k_y_[0] + k_y_[1])/(sizeof(k_y_)/sizeof(k_y_[0]));
		const double a_[] = {(double)(175-56*k_x_[0]), (double)(2071-663*k_x_[1])};
		const double b_[] = {(double)(268-85*k_y_[0]), (double)(2046-654*k_y_[1])};
		const double a = (double)(a_[0] + a_[1])/(sizeof(a_)/sizeof(a_[0]));
		const double b = (double)(b_[0] + b_[1])/(sizeof(b_)/sizeof(b_[0]));

		point.x = (long)(((point.x + horiz_scroll.nPos)*k_x + a)*100/diag->ZoomFactor);
		point.y = (long)(((point.y + vert_scroll.nPos)*k_y + b)*100/diag->ZoomFactor);
		return true;
	}
	return false;
	//#UC END# *45F514A400DA*
}

// метод корретирует положение элемента на диаграмме в соответствии
// с координатами курсора (x, y)
void position_in_diagram (IRoseDiagramPtr diag, IRoseItemPtr item, long x, long y) {
	//#UC START# *45CCC76E0157*
	POINT point = {x, y};
	if (point_to_diagram (point, diag)) {
		IRoseItemViewPtr item_view = diag->GetViewFrom (item);
		if (item_view) {
			item_view->XPosition = (short)point.x;
			item_view->YPosition = (short)point.y;
		}
	}
	/*HWND diag_wnd = WindowFromPoint (point);
	if (diag_wnd != NULL && is_diagram_window (diag_wnd, diag)) {
		
		IRoseItemViewPtr item_view = diag->GetViewFrom (item);

		SCROLLINFO horiz_scroll = {};
		SCROLLINFO vert_scroll = {};

		CWnd* parent = CWnd::FromHandle (::GetParent (diag_wnd));		
		if (parent != NULL) {
			CWnd* first_scroll = CWnd::FindWindowEx (
				parent->GetSafeHwnd ()
				, NULL
				, "ScrollBar"
				, NULL
			);
			CWnd* second_scroll = NULL;
			if (first_scroll) {
				second_scroll = CWnd::FindWindowEx (
					parent->GetSafeHwnd ()
					, first_scroll->GetSafeHwnd ()
					, "ScrollBar"
					, NULL
				);
			}
			if (first_scroll) {
				RECT cl_rect = {};
				::GetWindowRect (first_scroll->GetSafeHwnd (), &cl_rect);
				CScrollBar temp;
				temp.Attach (first_scroll->GetSafeHwnd ());
				if ((cl_rect.bottom - cl_rect.top) <= 20) { // this is horiz scroll!!!					
					temp.GetScrollInfo (&horiz_scroll);
				} else { //this is vert scroll
					temp.GetScrollInfo (&vert_scroll);
				}
				temp.Detach ();
			}
			if (second_scroll) {
				RECT cl_rect = {};
				::GetWindowRect (second_scroll->GetSafeHwnd (), &cl_rect);
				CScrollBar temp;
				temp.Attach (second_scroll->GetSafeHwnd ());
				if ((cl_rect.bottom - cl_rect.top) <= 20) { // this is horiz scroll!!!
					temp.GetScrollInfo (&horiz_scroll);
				} else { //this is vert scroll
					temp.GetScrollInfo (&vert_scroll);
				}
				temp.Detach ();
			}
		}
		::ScreenToClient (diag_wnd, &point);
		item_view->XPosition = (short)(abs (156 + (short)(point.x + horiz_scroll.nPos)*2.9)*100/diag->ZoomFactor);
		item_view->YPosition = (short)(abs (96 + (short)(point.y + vert_scroll.nPos)*2.9)*100/diag->ZoomFactor);
		RoseHelper::colorize (diag);
	}*/
	//#UC END# *45CCC76E0157*
}

// метод корретирует положение вью элемента на диаграмме в соответствии
// с координатами курсора (x, y)
void position_in_diagram (IRoseDiagramPtr diag, IRoseItemViewPtr view, long x, long y) {
	//#UC START# *47BD03890087*
	GDS_ASSERT(view);
	POINT point = {x, y};
	if (point_to_diagram (point, diag)) {
		view->XPosition = (short)point.x;
		view->YPosition = (short)point.y;
	}
	//#UC END# *47BD03890087*
}

// метод перемещает в модели Розы item в нового родителя (new_parent)
// is_new - флаг сигнализирует о том, был ли в результате перемещения создан новый объект (например
// нельзя перемещать операции, атрибуты)
// 
// возвращает true, в случае если перемещение было успешным, иначе false
bool relocate (IRoseElementPtr elem, IRoseElementPtr new_parent, bool& is_new) {
	//#UC START# *468211FA0242*
	class local {
	public:
		static IRoseClassDiagramCollectionPtr get_all_class_diagrams (IRoseElementPtr elem) {			
			if (elem->IsClass (CATEGORY_TYPE)) {
				return ((IRoseCategoryPtr)elem)->ClassDiagrams;
			} else if (elem->IsClass (CLASS_TYPE)) {
				IRoseClassDiagramCollectionPtr res = RoseHelper::get_class_diagrams (elem);
				IRoseClassPtr cls = elem;				
				IRoseClassCollectionPtr nested_classes= cls->GetAllNestedClasses ();

				short cls_count = nested_classes->Count;
				for (short i = 1; i <= cls_count; ++i) {
					IRoseClassDiagramCollectionPtr nested_diags = RoseHelper::get_class_diagrams (nested_classes->GetAt (i));
					short nested_diags_count = nested_diags->Count;
					for (short j = 1; j <= nested_diags_count; ++j) {
						res->Add (nested_diags->GetAt (j));
					}
				}
				return res;
			}
			return 0;
		}

		static void override_derived_impl (IRoseElementPtr source, IRoseElementPtr dest, IRoseClassPtr new_parent) {
			GDS_ASSERT(source);
			GDS_ASSERT(dest);
			GDS_ASSERT(new_parent);
			if (
				(
					source->IsClass (ATTRIBUTE_TYPE) 
					|| source->IsClass (OPERATION_TYPE)
				) && (
					source->IdentifyClass () == dest->IdentifyClass () 
				)
			) {
				//для всех производных классов (производных от родителя перемещаемой опрерации/атрибута)
				//заменяем в свойствах ГУИД перемещаемой операций/атрибута на гуид новой операции/атрибута (dest)
				//дополнительно меняем гуиды родителя операции/атрибута
				IRoseClassPtr cls_parent = RoseHelper::get_context (source);
				if (cls_parent) {
					_bstr_t tool_name = TOOL_NAME;

					//std::string src_guid = get_rose_element_uid(source);
					//std::string dest_guid = get_rose_element_uid(dest);

					std::string src_parent_guid = get_rose_element_uid(cls_parent);
					std::string dest_parent_guid  = get_rose_element_uid(new_parent);

					IRoseClassCollectionPtr clss = RoseHelper::get_all_derived (cls_parent);
					short count = clss->Count;
					for (short j = 1; j <= count; ++j) {
						IRoseClassPtr subcls = clss->GetAt(j);
									
						IRosePropertyCollectionPtr subcls_props = subcls->GetAllProperties ();
						short props_count = subcls_props->Count;
						for (short i = 1; i <= props_count; ++i) {
							IRosePropertyPtr prop = subcls_props->GetAt (i);
							if (prop->GetToolName () == tool_name) {
								std::string prop_name = prop->GetName ();
								std::string prop_value = prop->GetValue ();
								//GCL::str_replace (prop_name, src_guid.c_str (), dest_guid.c_str ());				
								//GCL::str_replace (prop_value, src_guid.c_str (), dest_guid.c_str ());
								
								if (src_parent_guid.empty () == false) {
									GCL::str_replace (prop_name, src_parent_guid.c_str (), dest_parent_guid.c_str ());
									GCL::str_replace (prop_value, src_parent_guid.c_str (), dest_parent_guid.c_str ());
								}
								RoseHelper::override_property(subcls, tool_name, prop_name.data(), prop_value.data ());
							}
						}
					}
				}
			}
		}
	};

	bool res = false;
	is_new = false;
	IRoseClassDiagramPtr class_diag = elem;
	IRoseScenarioDiagramPtr scenario_diag = elem;
	IRoseItemPtr item = elem;
	IRoseElementPtr new_element = elem;
	if (class_diag) {		
		if (new_parent->IsClass(CATEGORY_TYPE)) {
			((IRoseCategoryPtr)new_parent)->RelocateClassDiagram (class_diag);
			//разрываем связь (если она была) с элементом - действительным родителем диаграммы
			class_diag->OverrideProperty (TOOL_NAME, CLASS_DIAG_LINK_PROPERTY, "");
			res = true;
		}
	} else if (scenario_diag) {		
		if (new_parent->IsClass(CATEGORY_TYPE)) {
			((IRoseCategoryPtr)new_parent)->RelocateScenarioDiagram (scenario_diag);
			scenario_diag->OverrideProperty (TOOL_NAME, "UseCase", "");
			LOG_D ((
				"Scenarion diagram \"%s\" was relocated to \"%s\""
				, (const char*)scenario_diag->Name
				, (const char*)new_parent->Name
			));
			res = true;
		} else if (new_parent->IsClass(CLASS_TYPE)) {
			IRoseClassPtr cls = new_parent;			
			if (
				cls->Stereotype == _bstr_t ("UseCase")				
			) {
				std::string sc_use_case_uid = scenario_diag->GetPropertyValue (TOOL_NAME, "UseCase");
				std::string cls_uid =get_rose_element_uid(cls);
				if (sc_use_case_uid != cls_uid) {
					res = true;
					IRoseCategoryPtr parent_cat = RoseHelper::get_parent_category (cls);
					IRoseCategoryPtr diag_cat = scenario_diag->GetParentContext ();
					if (
						parent_cat != 0
						&& diag_cat != 0
						&& get_rose_element_uid(parent_cat) != get_rose_element_uid(diag_cat)
					) {
						parent_cat->RelocateScenarioDiagram (scenario_diag);						
					}
					LOG_D ((
						"Scenarion diagram \"%s\" was relocated to \"%s\""
						, (const char*)scenario_diag->Name
						, (const char*)new_parent->Name
					));
					scenario_diag->OverrideProperty (TOOL_NAME, "UseCase", cls_uid.c_str ());
				}
			}
		}
	} else if (item) {	
		IRoseItemPtr parent = item->GetContext ();
		if (elem->IsClass("Role")) {
			//((IRoseRolePtr)elem)->GetClass()->DeleteAssociation(((IRoseRolePtr)new_item)->Association);
		} else if (new_parent->IsClass(CLASS_TYPE)) {
			if (elem->IsClass(CLASS_TYPE)) {
				IRoseClassPtr new_parent_class = new_parent;
				IRoseClassCollectionPtr new_parent_classes = new_parent_class->GetNestedClasses ();
				short index = new_parent_classes->FindFirst (elem->Name);
				if (index == 0) {
					IRoseClassPtr cls = elem;
					IRoseCategoryPtr parent_cat = RoseHelper::get_parent_category (cls);
				    IRoseCategoryPtr new_parent_cat = RoseHelper::get_parent_category (new_parent_class);
					if (cls->Stereotype == _bstr_t ("UseCase")) {
						std::vector<RoseElementWrapper> sc_diags_to_relocated;

						std::string cls_uid =get_rose_element_uid(cls);					
						IRoseScenarioDiagramCollectionPtr scen_diags = parent_cat->ScenarioDiagrams;
						short scen_diags_count = scen_diags->Count;
						for (short i = 1; i <= scen_diags_count; ++i) {
							IRoseScenarioDiagramPtr sc_diag = scen_diags->GetAt (i);
							std::string scen_diag_use_case_guid = sc_diag->GetPropertyValue (TOOL_NAME, "UseCase"); 
							if (scen_diag_use_case_guid == cls_uid) {
								sc_diags_to_relocated.push_back (RoseElementWrapper (sc_diag));								
							}
						}
						std::vector<RoseElementWrapper>::iterator it = sc_diags_to_relocated.begin ();
						std::vector<RoseElementWrapper>::iterator it_end = sc_diags_to_relocated.end ();

						for (; it != it_end; ++it) {
							IRoseScenarioDiagramPtr sc_diag = it->element;
							new_parent_cat->RelocateScenarioDiagram (sc_diag);
						}
					}
					
					std::vector<RoseElementWrapper> cls_diags_to_relocated;

					IRoseClassDiagramCollectionPtr class_diags = local::get_all_class_diagrams (cls);
					short class_diags_count = class_diags->Count;
					
					for (short i = 1; i <= class_diags_count; ++i) {
						cls_diags_to_relocated.push_back (RoseElementWrapper (class_diags->GetAt (i)));
					}

					std::vector<RoseElementWrapper>::iterator it = cls_diags_to_relocated.begin ();
					std::vector<RoseElementWrapper>::iterator it_end = cls_diags_to_relocated.end ();

					for (; it != it_end; ++it) {
						IRoseClassDiagramPtr cls_diag = it->element;
						new_parent_cat->RelocateClassDiagram (cls_diag);
					}
					new_parent_class->RelocateClass (cls);
					
					IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
					int rl_attrs_count = rl_attrs->Count;
					for (short i = 1; i <= rl_attrs_count; i++) {
						IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
						if (RoseHelper::is_attribute_role (rl_attr)) {
							new_parent_cat->RelocateAssociation (rl_attr->Association);
						}
					}
					res = true;
				} else {
					std::string mess = "Can't relocate class: ";
					mess += RoseHelper::get_full_name (elem);
					mess += ", because new parent already have class with same name";
					GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
				}
			} else if (elem->IsClass(ATTRIBUTE_TYPE)) {
				IRoseAttributePtr attr = elem;
				IRoseClassPtr new_parent_cls = new_parent;

				new_element = new_parent_cls->AddAttribute (
					attr->GetName (), attr->GetType (), attr->GetInitValue ()
				);
				
				RoseHelper::override_property (
					new_element
					, TOOL_NAME
					, Base::STORED_UID_KEY.c_str ()
					, get_rose_element_uid(elem).c_str ()
				);

				RoseCopyHelper::copy (attr, (IRoseAttributePtr)new_element, true);
				
				elem = new_element;

				((IRoseClassPtr)parent)->DeleteAttribute (attr);
				res = true;
				is_new = true;
			} else if (elem->IsClass(OPERATION_TYPE)) {
				IRoseOperationPtr op = elem;
				IRoseClassPtr new_parent_cls = new_parent;
				
				IRoseOperationPtr new_op = new_parent_cls->AddOperation (
					op->GetName (), op->GetReturnType ()
				);
				
				new_element = new_op;
				
				RoseHelper::override_property (
					new_element
					, TOOL_NAME
					, Base::STORED_UID_KEY.c_str ()
					, get_rose_element_uid(elem).c_str ()
				);

				RoseCopyHelper::copy (op, new_op, true);
				
				//нужно параметрам новой операции прописать идентификаторы параметров старой операции
				IRoseParameterCollectionPtr op_params = op->GetParameters ();
				IRoseParameterCollectionPtr new_op_params = new_op->GetParameters ();
				
				GDS_ASSERT(new_op_params->Count == op_params->Count);
				
				short params_count = op_params->Count;
				
				for (short i = 1; i <= params_count; ++i) {
					IRoseParameterPtr param = op_params->GetAt (i);
					IRoseParameterPtr new_param = new_op_params->GetAt (i);
					
					RoseHelper::override_property (
						new_param
						, TOOL_NAME
						, Base::STORED_UID_KEY.c_str ()
						, get_rose_element_uid(param).c_str ()
					);
				}
				
				elem = new_element;
				((IRoseClassPtr)parent)->DeleteOperation (op);
				is_new = true;
				res = true;
			} else if (elem->IsClass(CLASS_DEPENDENCY_TYPE)) {
				//((IRoseClassPtr)parent_item)->DeleteClassDependency((IRoseClassDependencyPtr)new_item);
			} else {
				GDS_ASSERT (0);
			}
		} else if (new_parent->IsClass(CATEGORY_TYPE)) {
			IRoseCategoryPtr new_parent_cat = new_parent;
			if (elem->IsClass(CLASS_TYPE)) {
				IRoseClassCollectionPtr new_parent_classes = new_parent_cat->Classes;
				short index = new_parent_classes->FindFirst (elem->Name);
				if (index == 0) {
					IRoseClassPtr cls = elem;
					IRoseCategoryPtr parent_cat = RoseHelper::get_parent_category (cls);
									
					if (cls->Stereotype == _bstr_t ("UseCase")) {					
						std::string cls_uid =get_rose_element_uid(cls);	
						std::vector<RoseElementWrapper> sc_diags_to_relocated;

						IRoseScenarioDiagramCollectionPtr scen_diags = parent_cat->ScenarioDiagrams;
						short scen_diags_count = scen_diags->Count;
						for (short i = 1; i <= scen_diags_count; ++i) {
							IRoseScenarioDiagramPtr sc_diag = scen_diags->GetAt (i);
							std::string scen_diag_use_case_guid = sc_diag->GetPropertyValue (TOOL_NAME, "UseCase"); 
							if (scen_diag_use_case_guid == cls_uid) {
								sc_diags_to_relocated.push_back (RoseElementWrapper (sc_diag));
							}
						}

						std::vector<RoseElementWrapper>::iterator it = sc_diags_to_relocated.begin ();
						std::vector<RoseElementWrapper>::iterator it_end = sc_diags_to_relocated.end ();

						for (; it != it_end; ++it) {
							IRoseScenarioDiagramPtr sc_diag = it->element;
							new_parent_cat->RelocateScenarioDiagram (sc_diag);
						}
					}
					std::vector<RoseElementWrapper> cls_diags_to_relocated;

					IRoseClassDiagramCollectionPtr class_diags = local::get_all_class_diagrams (cls);
					short class_diags_count = class_diags->Count;

					for (short i = 1; i <= class_diags_count; ++i) {
						cls_diags_to_relocated.push_back (RoseElementWrapper (class_diags->GetAt (i)));
					}

					std::vector<RoseElementWrapper>::iterator it = cls_diags_to_relocated.begin ();
					std::vector<RoseElementWrapper>::iterator it_end = cls_diags_to_relocated.end ();

					for (; it != it_end; ++it) {
						IRoseClassDiagramPtr cls_diag = it->element;
						new_parent_cat->RelocateClassDiagram (cls_diag);
					}										

					new_parent_cat->RelocateClass (cls);
					IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
					int rl_attrs_count = rl_attrs->Count;
					for (short i = 1; i <= rl_attrs_count; i++) {
						IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
						if (RoseHelper::is_attribute_role (rl_attr)) {
							new_parent_cat->RelocateAssociation (rl_attr->Association);
						}
					}

					res = true;
				} else {
					std::string mess = "Can't relocate class: ";
					mess += RoseHelper::get_full_name (elem);
					mess += ", because new parent already have class with same name";
					GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
				}

			} else if (elem->IsClass(CATEGORY_TYPE)) {
				IRoseCategoryCollectionPtr new_parent_cats = new_parent_cat->GetCategories ();
				short index = new_parent_cats->FindFirst (elem->Name);
				if (index == 0) {
					new_parent_cat->RelocateCategory ((IRoseCategoryPtr)elem);
					res = true;
				} else {
					std::string mess = "Can't relocate category: ";
					mess += RoseHelper::get_full_name (elem);
					mess += ", because new parent already have category with same name";
					GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
					res = false;
				}
			} else {
				GDS_ASSERT (0);
			}
		} else if (new_parent->IsClass(OPERATION_TYPE)) {
			if (elem->IsClass(PARAMETER_TYPE)) {
				/*IRoseParameterPtr param = elem;				
				new_element = ((IRoseOperationPtr)new_parent)->AddParameter (
					param->GetName (), param->GetType (), param->GetInitValue (), 0
				);
				((IRoseOperationPtr)parent)->DeleteParameter(param);*/
			}
		}
	}
	return res;
	//#UC END# *468211FA0242*
}

// записывает свойство в элемент, в зависимости от стратегии залочки принимается решение о
// возможности залочки, в случае невозможности залочки бросает исключение, при успешной записи
// свойства возвращает true.
// user_friendly_name - имя \записываемого свойства, для отображения пользователю в диалоге, либо в
// логе
bool write_property_with_lock (
	IRoseElementPtr elem
	, const std::string& prop_id
	, const std::string& prop_value
	, GenSupport::LockStrategy lock_strategy
	, bool is_write_necessary
	, const std::string& user_friendly_name
) /*throw (
	Base::FatalError
)*/ {
	//#UC START# *47D7C4C900D3*
	_bstr_t tool_name (TOOL_NAME);
	return write_property_with_lock (
		elem
		, std::string (tool_name)
		, prop_id
		, prop_value
		, lock_strategy
		, is_write_necessary
		, user_friendly_name
	);
	//#UC END# *47D7C4C900D3*
}

// записывает свойство в элемент, в зависимости от стратегии залочки принимается решение о
// возможности залочки, в случае невозможности залочки бросает исключение, при успешной записи
// свойства возвращает true.
// user_friendly_name - имя \записываемого свойства, для отображения пользователю в диалоге, либо в
// логе
bool write_property_with_lock (
	IRoseElementPtr elem
	, const std::string& tool_name
	, const std::string& prop_id
	, const std::string& prop_value
	, GenSupport::LockStrategy lock_strategy
	, bool is_write_necessary
	, const std::string& user_friendly_name
) {
	//#UC START# *4A41F423013D*
	class local {
	public:
		static bool write_with_lock (
			IRoseElementPtr elem
			, const std::string& tool_name
			, const std::string& prop_id
			, const std::string& prop_value
			, bool is_write_necessary
			, const std::string& user_friendly_name
		) {
			bool res = false;
			MDPSupport::CatLockerFacade_var clf = MDPSupport::CatLockerFacadeFactory::make (elem);
			if (clf->try_change ()) {
				res = elem->OverrideProperty(tool_name.c_str (), prop_id.c_str (), prop_value.c_str ());
				clf->do_change ();
			} else {
				std::string mess ("Не удалось записать свойство \"");
				mess += user_friendly_name;
				mess += "\" для элемента ";
				mess += get_full_name (elem);
				mess += " (возможно пакет захвачен другим пользователем)";

				if (is_write_necessary) {
					do_on_lock_fail (mess);
				} else {
					GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());
				}
			}
			return res;
		}

		static bool write_with_no_lock (
			IRoseElementPtr elem
			, const std::string& tool_name
			, const std::string& prop_id
			, const std::string& prop_value
			, bool is_write_necessary
			, const std::string& user_friendly_name
		) {
			bool res = false;
			if (false == can_modify_elem (elem)) {
				std::string mess ("Не удалось записать свойство \"");
				mess += user_friendly_name;
				mess += "\" для элемента ";
				mess += get_full_name (elem);
				mess += " (т.к пакет находится в режиме ReadOnly (залочьте пакет и повторите попытку))";
				
				if (is_write_necessary) {
					do_on_lock_fail (mess);
				} else {
					GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());
				}				
			} else {
				res = elem->OverrideProperty(tool_name.c_str (), prop_id.c_str (), prop_value.c_str ());
			}
			return res;
		}
	};
	bool res = false;
	std::string prev_value = static_cast<const char*> (elem->GetPropertyValue(tool_name.c_str (), prop_id.c_str ()));
	if (prev_value != prop_value) {
		if (false == can_modify_elem (elem)) {
			//дополнительная логика нужна только, если зачение свойства поменялось
			switch (lock_strategy) {
				case GenSupport::LS_NO_LOCK: {
					try {
						res = local::write_with_no_lock (
							elem
							, tool_name
							, prop_id
							, prop_value
							, is_write_necessary
							, user_friendly_name
						);
					} catch (...) {
						LOG_E (("Execption, when try write_with_no_lock on element: %s", get_full_name (elem).c_str ()));
					}
					break;
				}
				case GenSupport::LS_ASK: {				
					std::string mess ("Для записи свойства \"");
					mess += user_friendly_name;
					mess += "\" необходимо захватить элемент:\r\n";
					mess += get_full_name (elem);
					
					int answer = ::AfxMessageBox (mess.c_str (), MB_ICONQUESTION | MB_YESNOCANCEL);
					
					switch (answer) {
						case IDYES:
							res = local::write_with_lock (elem, tool_name, prop_id, prop_value, is_write_necessary, user_friendly_name);
							break;
						case IDNO:
							res = local::write_with_no_lock (elem, tool_name, prop_id, prop_value, is_write_necessary, user_friendly_name);
							break;
						case IDCANCEL:
							GenSupport::EnvironmentFactory::get ().set_cancel_generation (true);
							throw Base::FatalError ("Генерация была прервана пользователем");
							break;
					}
					break;
				}
				
				 case GenSupport::LS_LOCK_ALL: {
					 res = local::write_with_lock (elem, tool_name, prop_id, prop_value, is_write_necessary, user_friendly_name);
					break;
				}
			}
		} else {
			//элемент уже доступен для редактирования
			res = elem->OverrideProperty(tool_name.c_str (), prop_id.c_str (), prop_value.c_str ());
		}
	} else {
		res = true;
	}
	return res;
	//#UC END# *4A41F423013D*
}

} // namespace RoseHelper

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

