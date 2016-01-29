////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractDumper
//
// базовый дампер для всех элементов модели Розы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseOverridenElementDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseSequenceDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContents.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContentsFactories.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"
#include "MDProcess/MDAModel/AbstractDumpers/EmptyDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"
#include "boost/lambda/bind.hpp"
#include "boost/lambda/casts.hpp"
#include "boost/lambda/lambda.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571D1A5009C_CUSTOM_INCLUDES*
#include <algorithm>
#include <set>
#include <typeinfo>
#include <direct.h>
#include <objbase.h>
#include <shlobj.h>

#include "shared/GCL/os/FileOp.h"
#include "shared/GCL/alg/container_op.h"
#include "shared/GCL/str/str_conv.h"
#include "shared/GCL/str/str_op.h"
#include "shared/GCL/alg/sorting.h"

#include <boost/lexical_cast.hpp>
#include <boost/regex.hpp>
#include <boost/algorithm/string/regex.hpp>
#include <boost/algorithm/string/split.hpp>
#include<boost/token_iterator.hpp>
//#UC END# *4571D1A5009C_CUSTOM_INCLUDES*


//#UC START# *4571D1A5009C*
//#define FORCE_STOP_WARCH 1

RoseAbstractDumper::DumpersFactory* RoseAbstractDumper::s_dump_factory = NULL;
RoseAbstractDumper::IChoiceDlg* RoseAbstractDumper::s_choice_dlg = NULL;
RoseAbstractDumper::RADList RoseAbstractDumper::s_global_cats;
unsigned RoseAbstractDumper::s_current_elem_order = 0;
RoseAbstractDumper::IMissedGenFileDlg* RoseAbstractDumper::s_missed_gen_file_dlg;
bool RoseAbstractDumper::s_force_applied_gens_to_all = false;
unsigned RoseAbstractDumper::s_lock_reset = 0;
bool RoseAbstractDumper::s_attempt_reset_while_locked = false;

RoseAbstractDumper* RoseAbstractDumper::s_model_tree_root;
RoseAbstractDumper* RoseAbstractDumper::s_void_rad;

RoseAbstractDumper::SelectionsMap RoseAbstractDumper::s_selections_map;
// контейнер для хранения созданных экземпляров RoseAbstractDumper
typedef std::vector < Core::Var<RoseAbstractDumper> > RoseAbstractDumperList;
// "свалка" созданных экземпляров RoseAbstractDumper подлежащих удалению
typedef ACE_Singleton <RoseAbstractDumperList, ACE_SYNCH_RECURSIVE_MUTEX> RoseAbstractDumperListSingleton;

const RoseAbstractDumper& RoseAbstractDumper::get_model_tree_root (bool auto_spell) {
	if (RoseAbstractDumper::is_has_error ()) {
		RoseAbstractDumper::reset_model_tree_root ();
	}

	if (!s_model_tree_root) {
		::Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
		
		GenSupport::EnvironmentFactory::get ().set_lock_strategy (static_cast<GenSupport::LockStrategy> (GenerationParams::get_lock_strategy ()));
		GenSupport::EnvironmentFactory::get ().set_lock_failed_need_ask (true);
		GenSupport::EnvironmentFactory::get ().set_lock_failed_need_fatal_error (true);

		RoseAbstractDumper::s_current_elem_order = 0;
		RoseAbstractDumper::reset_all ();
		AbstractDumperBase::reset_accepted_gens ();
		RoseAbstractDumper::has_error (false);	
		IRoseCategoryPtr rootCat = RoseHelper::rose_app()->CurrentModel->GetRootCategory();
		try {
			AbstractDumper::log_mem_info ("Before build tree");

			Core::Aptr<DumpersFactory> df = new RoseAbstractDumpFactory;
			RoseAbstractDumper::set_dumper_factory (df.in());
			s_model_tree_root = df->create_by_root (rootCat);
			s_model_tree_root->fill_sequence_data ();

			if (auto_spell) {
				AbstractDumper::run_spell ();
			}

			RoseTreeState::instance ()->set_changed (false);
		} catch (Base::FatalError& ex) {
			GenSupport::LogManagerFactory::get ().log_error("Loading model tree finished by Fatal error:");
			GenSupport::LogManagerFactory::get ().log_error(ex.what ());
			
			GenSupport::ErrorManagerFactory::get ().fatal_error (0, "Fatal errors while loading model tree - see log for detail", GDS_CURRENT_FUNCTION);
		} catch (std::exception& ex) {
			GenSupport::LogManagerFactory::get ().log_error("Loading model tree finished exception:");
			GenSupport::LogManagerFactory::get ().log_error(ex.what ());
			throw;
		} catch (...) {
			std::string mess ("Unknown exception while loading model tree");
			GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
			GenSupport::LogManagerFactory::get ().log_error (mess);
		}
	}
	if (RoseAbstractDumper::is_has_error ()) {
		RoseAbstractDumperListSingleton::instance ()->clear ();
	}
	return *s_model_tree_root;
}

void RoseAbstractDumper::lock_reset () {
	s_lock_reset++;
}

void RoseAbstractDumper::unlock_reset () {
	if (s_lock_reset) {
		if (!--s_lock_reset) {
			if (s_attempt_reset_while_locked) {
				s_attempt_reset_while_locked = false;
				RoseAbstractDumper::reset_model_tree_root ();
			}
		}		
	}
}

void RoseAbstractDumper::reset_model_tree_root () {
	if (s_lock_reset == 0) {
		AbstractDumperBase::has_error(false);
		
		s_model_tree_root = 0;
	} else {
		s_attempt_reset_while_locked = true;
	}
}

void RoseAbstractDumper::set_choice_dlg (IChoiceDlg* dlg) {
	s_choice_dlg = dlg;
}

void RoseAbstractDumper::set_missed_gen_file_dlg (IMissedGenFileDlg* dlg) {
	s_missed_gen_file_dlg = dlg;
}

RoseAbstractDumper::RADList& RoseAbstractDumper::global_cats() {
	return s_global_cats;
}

RoseAbstractDumper::DumpersFactory* RoseAbstractDumper::dump_factory() {
	return s_dump_factory;
}

void RoseAbstractDumper::set_dumper_factory (DumpersFactory* factory) {
	s_dump_factory = factory;
}

RoseAbstractDumper* RoseAbstractDumper::find_in_tree (IRoseElementPtr item) {
	RoseAbstractDumper* ret = NULL;
	if (s_tree) {
		if (item != NULL) {
			class TempOD : public RoseAbstractElementDumper {
			public:
				TempOD ( IRoseItemPtr item ) : RoseAbstractElementDumper (NULL, item, AbstractDumperBase::StereotypeID ("default")) {
					this->own_output(false);
				}
				void link_suppliers () {
				}	
				const std::string get_model_class_str() const {
					return "Temp";
				}
			};

			TempOD temp (item);
			const ObjectTreeResolver** otr = s_tree->find(&temp);
			if ( otr ) {
				return const_cast<RoseAbstractDumper*>(dynamic_cast <const RoseAbstractDumper*> (*otr));
			} else {
				return NULL;
			}
		} else {
			return s_void_rad;
		}
	} 
	return ret;
}

void RoseAbstractDumper::reset_all () {	
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
	AbstractDumper::reset ();

	TemplatePainter::clear ();

	AbstractDumper::s_is_fixed_type_map.clear ();
	AbstractDumper::s_functions_cache.clear ();
	AbstractDumper::s_clean_on_start_list_functions_cache.clear ();
	AbstractDumperBase::s_list_functions_cache.clear ();
	AbstractDumperBase::s_resolve_functions_cache.clear ();
	AbstractDumperBase::s_get_full_name_cache.clear ();

	ResolveTypeCacheSingleton::instance ()->ptr.clear ();

	RelationsForRestoreSingleton::instance ()->ptr.clear ();
	VirtualRelationsSingleton::instance ()->ptr.clear ();
	VirtualDumpersSingleton::instance ()->ptr.clear ();
	RoseAbstractDumperListSingleton::instance ()->clear ();
	
	ObjectTreeResolver::clean_up ();

	if (s_tree) {
		AbstractDumper::clear_all_var_dumpers (AbstractDumperBase::LVT_ALL);

		GenSupport::ErrorManagerFactory::get ().clear_only_dumper_errors ();
		ObjectTree* tree = s_tree;
		try {			
			s_tree = 0;
			for ( ObjectTree::iterator it = tree->begin(); it != tree->end(); it++ ) {
				try {
					ObjectTreeResolver* p = const_cast<ObjectTreeResolver*>(*(*it));
					if (p) {
						delete p;
					}
				} catch (...) {
					assert (0);
				}
			}
			delete tree;
		} catch (...) {
		}
		tree = 0;
	}

	RoseHelper::clear_incremented_counters ();
	s_model_main_element = 0;
	s_void_rad = 0;
	s_selections_map.clear ();

	RoseAbstractDumper::s_current_elem_order = 0;
	AbstractDumperBase::s_need_run_spell = true;
}

///////////////////////////////////////////////////////////////////////
// RoseAbstractDumper
///////////////////////////////////////////////////////////////////////
// конструктор - в нем выполняется добавление элемента в дерево parent
// - родительский элемент item - розовский элемент, связанный с элементом
// дерева st - стереотип на модели
RoseAbstractDumper::RoseAbstractDumper (const RoseAbstractDumper* parent, IRoseElementPtr item, const AbstractDumperBase::StereotypeID& st)
	: m_rose_element (item)
	, m_model_stereotype (st)
	, m_elem_order(s_current_elem_order++)
	, m_is_native (2)
	, m_native_with_parent (false)
{
	try {
		if (m_model_stereotype/*.get ()*/.empty ()) {
			m_model_stereotype = RoseHelper::get_gen_stereotype(m_rose_element);
		}
		try {
			AbstractDumper::init (parent);
		} catch (ObjectTreeResolver::ObjectTree::AlreadyInTree&) {
			RoseAbstractDumperListSingleton::instance ()->push_back (const_cast<RoseAbstractDumper*> (this));			
			throw;
		} catch (...) {
			if (ObjectTreeResolver::s_tree && !ObjectTreeResolver::s_tree->find (this)) {
				RoseAbstractDumperListSingleton::instance ()->push_back (const_cast<RoseAbstractDumper*> (this));
			}
			return;
		}

		if (s_model_main_element == 0) {
			if (RoseHelper::is_it_main_model_element(m_rose_element)) {
				s_model_main_element = this;
			}
		}
		if (s_void_rad == 0) {
			if (
				item->Name == _bstr_t("void")
				&& item->IsClass (ROSE_ITEM_TYPE)
				&& ((IRoseItemPtr)item)->Stereotype == _bstr_t("UMLPrimitive")
			) {
				s_void_rad = this;
			}
		}

		//init caches
		RoseAbstractDumper::update_cached_attrs ();

		//инициализируем порядковый номер элемента с момента создания
		m_creation_order = RoseHelper::get_creation_timestamp (item);

	} catch (ObjectTreeResolver::ObjectTree::AlreadyInTree& ) {
		std::string str ("Duplicated model id (");
		if (item) {
			str += get_rose_element_uid(item);
		}
		str += ") for element ";
		str += RoseHelper::get_full_name (item);
		str += " - check model integrity";
		
		const ObjectTreeResolver** otr = ObjectTreeResolver::s_tree->find (this);
		if (otr) {
			const RoseAbstractDumper* dupl = dynamic_cast<const RoseAbstractDumper*> (*otr);
			str += " (duplicated item: ";
			str += dupl->get_full_name ();
			str += ")";
		}

		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.c_str ());
	} catch (std::exception& ex) {
		//m_rose_element = 0;
		std::string str = "STD exception in RoseAbstractDumper ctor (";
		if (item) {
			str += RoseHelper::get_full_name (item);
		}
		str += "): ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.c_str ());
	} catch (_com_error& ex) {
		std::string str = "COM exception in RoseAbstractDumper ctor (";
		if (item) {
			str += RoseHelper::get_full_name (item);
		}
		str += "): ";
		str += ex.ErrorMessage ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.c_str ());
	} catch (...) {
		//m_rose_element = 0;
		AbstractDumperBase::has_error(true);
		std::string str = "Exception in RoseAbstractDumper ctor (";
		if (item) {
			str += RoseHelper::get_full_name (item);
		}
		str += ")";
		GenSupport::LogManagerFactory::get ().log_error (str.c_str ());
	}
}

void RoseAbstractDumper::fill_sequence_data () {
	IRoseModelPtr model = RoseHelper::rose_app()->CurrentModel;
	IRoseCategoryPtr root = model->GetRootCategory();
	IRoseCategoryCollectionPtr cats = root->GetAllCategories();
	
	GCL::StrSet unknown_classes;
	short cats_count = cats->Count;

	ModelSearcher* searcher = &ModelSearcherFactory::get ();
	for (short i=1; i <= cats_count; i++) {
		IRoseCategoryPtr cat = cats->GetAt(i);
		IRoseScenarioDiagramCollectionPtr col = cat->GetScenarioDiagrams();
		IRoseClassCollectionPtr classes = cat->GetClasses();		
		short col_count = col->Count;
		for (short ii=1; ii <= col_count; ii++) {
			IRoseClassPtr usecase = 0;
			IRoseScenarioDiagramPtr sd = col->GetAt(ii);
			TRACE ("%s\n", (const char*) sd->Name);

			std::string use_case_uid = sd->GetPropertyValue (TOOL_NAME, "UseCase");
			if (use_case_uid.empty ()) {
				short classes_count = classes->Count;
				for (int iii = 1; iii <= classes_count; iii++) {
					IRoseClassPtr cls = classes->GetAt (iii);
					if (cls->Name == sd->Name) {
						usecase = cls;
						break;
					}
				}
			} else {
				usecase = searcher->search (use_case_uid);
			}

			IRoseCategoryPtr usecase_cat_tmp = RoseHelper::get_parent_category (usecase);
			if (usecase == 0 || usecase_cat_tmp != cat) {
				std::string mess ("Error - unlinked sequence diagram (");
				mess += RoseHelper::get_full_name (sd);
				mess += ")";
				if (usecase != 0) {
					mess += ". It was linked with: ";
					mess += RoseHelper::get_full_name (usecase);
				}
				GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
				continue;
			}

			RoseAbstractDumper* usecase_ad = RoseAbstractDumper::find_in_tree (usecase);
			GDS_ASSERT (usecase_ad);
			
			IRoseInstanceViewCollectionPtr items = sd->GetInstanceViews();
			short items_count = items->Count;
			for (short ll=1; ll <= items_count; ll++) {				
				IRoseObjectInstancePtr oi = items->GetAt(ll)->GetInstance ();
				if (oi) {
					IRoseClassPtr cls = oi->GetClass();
					if (cls != 0) {
						if (cls->Stereotype != _bstr_t("UseCase") && cls->Stereotype != _bstr_t("Actor")) {
							RoseAbstractDumper* cls_ad = RoseAbstractDumper::find_in_tree (cls);
							
							if (!usecase_ad->check_access (cls_ad)) {
								//нужно автоматически добавить зависимость между пакетами класса и юз-кейса:
								usecase_ad->set_dependencies (
									cls_ad
									, boost::lambda::bind (
										&ObjectTreeResolver::add_supplier_spec
										, boost::lambda::ll_const_cast<ObjectTreeResolver*> (boost::lambda::_1)
										, boost::lambda::_2
										, ST_NOT_NAVIGABLE
										, ST_LINK_DEP
										, false
										, true
									)
								);
							}							
							
							//добавляем связь зависимости от перецедента к типу
							//прецедент становится зависимыми от типа (!)
							usecase_ad->add_supplier_spec (cls_ad, ST_NAVIGABLE, /*ST_SEQ_LINK_DEP*/ ST_LINK_DEP, false, true);
						} else {
							// нужно проверять определена ли прямая зависимость на диаграмме прецедентов
						}
					} else {
						std::string mess = "Unknown element with name: ";						
						mess += (const char*)oi->GetName ();
						mess += " and class: ";
						mess += (const char*)oi->GetClassName ();
						mess += " on sequence diagram: ";
						mess += RoseHelper::get_full_name (sd);
						unknown_classes.insert (mess);
					}
				}
			}

			/*
			//fill tree
			MessTree tree ("0");
			
			for (int ll=1; ll<mesages->Count+1; ll++) {				
				IRoseMessagePtr message = mesages->GetAt(ll);
				SeqId mess_id = std::string("0.") + (char*)message->GetSequenceInformation();
				
				GCL::StrVector ids = GCL::split_string_by(mess_id.c_str(), '.');
				ids.pop_back();
				SeqId parent_id = GCL::join (ids, ".");
				
				try {
					tree.add_child(parent_id, MessTreeNode(mess_id, message));			
				} catch (...) {
					std::string mess = "Inavalid sequence diagram (";
					mess += (char*)sd->GetQualifiedName();
					mess += ")";
					write_error_log (mess);
					return;
				}
			}

			MessTree::iterator it = tree.begin();
			it++;
			for (; it != tree.end(); it++) {
				const RoseAbstractDumper* op = RoseAbstractDumper::find_in_tree ((*it)->mess->GetOperation());

				if (op) {
					ADVector aads;
					MessTree::Items ch = tree.childs(**it);
					
					std::sort(ch.begin(), ch.end(), MessTreeNode::Sort());
					for (MessTree::Items::iterator it2 = ch.begin(); it2 != ch.end(); it2++) {
						AbstractDumper_box aad = new RoseSequenceDumper((*it2)->mess);
						aads.push_back(aad);
					}
					const_cast<RoseAbstractDumper*>(op)->add_sequence (aads);
				}
			}*/
		}
	}
	for (
		GCL::StrSet::const_iterator it = unknown_classes.begin ()
		; it != unknown_classes.end ()
		; ++it
	) {
		this->write_error_log (*it, false);
	}
	/*if (unknown_classes.empty () == false) {
		this->write_error_log ("Error while fill sequence data", false);
	}*/
}

IRoseElementPtr RoseAbstractDumper::rose_element () const {
	return m_rose_element;
}

bool RoseAbstractDumper::operator == (const AbstractDumperBase& c) const {
	return this->get_model_unique_id_str () == c.get_model_unique_id_str ();	
}

int RoseAbstractDumper::compare (const ObjectTreeResolver* od) const {
	const AbstractDumperBase* ad = dynamic_cast<const AbstractDumperBase*> (od);
	if (ad) {
		return ACE_OS::strcmp (
			this->get_model_unique_id_str ().c_str ()
			, ad->get_model_unique_id_str ().c_str ()
		);
		//return this->get_model_unique_id_str () < ad->get_model_unique_id_str ();
	}

	return 0;
}

ObjectTreeResolver::VisibilityType RoseAbstractDumper::get_visibility_type () const {
	std::string visability_type = RoseHelper::get_visibility_type(this);
	
	if (visability_type == "PublicAccess") {
		return VT_PUBLIC;
	} else if (visability_type == "ProtectedAccess") {
		return VT_PROTECTED;
	} else if (visability_type == "PrivateAccess") {
		return VT_PRIVATE;
	} else if (visability_type == "ImplementationAccess") {
		return VT_IMPL;
	} else {
		assert (0);
		return VT_PUBLIC;
	}
}

typedef std::set<const RoseAbstractDumper*> RADSet;
class collect_all_nested_class {
public:
	collect_all_nested_class (const RoseAbstractDumper* rad, RADSet& res) {
#ifndef GDS_NLOG_DEBUG
		Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
		
		std::string class_str = rad->get_model_class_str ();
		if (
			class_str == CLASS_TYPE
			|| class_str == CATEGORY_TYPE
		) {
			collect_all_nested (rad, res);
		}
		/*IRoseElementPtr elem = rad->rose_element ();										
		RADSet all_nested;
		if (elem->IsClass (CLASS_TYPE)) {						
			IRoseClassPtr rcls = (IRoseClassPtr)elem;
			collect_all_nested (rcls, all_nested);
							
		} else if (elem->IsClass (CATEGORY_TYPE)) {
			IRoseCategoryPtr rc = (IRoseCategoryPtr)elem;
			collect_all_nested (rc, all_nested);
		}
		res.insert (all_nested.begin (), all_nested.end ());*/
	}

private:
	/*
	void collect_all_nested (const IRoseClassPtr& cls, RADSet& res) {
		IRoseClassCollectionPtr cc = cls->GetNestedClasses();
		collect_impl (cc, res);	
	}
	void collect_all_nested (const IRoseCategoryPtr& rc, RADSet& res) {
		IRoseClassCollectionPtr cc = rc->Classes;
		collect_impl (cc, res);
	}

	void collect_impl (const IRoseClassCollectionPtr& cc, RADSet& res) {
		short cc_count = cc->Count;
		for (int i = 1; i <= cc_count; i++) {
			IRoseClassPtr cls = cc->GetAt (i);
			if (cls->GetNestedClasses()->Count > 0) {
				const RoseAbstractDumper* rad_res = RoseAbstractDumper::find_in_tree(cls);
				if (res.insert (rad_res).second) {
					collect_all_nested (cls, res);
				}
			}
		}
		
	}
	*/

	void collect_all_nested (const RoseAbstractDumper* cls, RADSet& res) {
		ObjectTreeResolver::ObjectTree::Items childs = ObjectTreeResolver::s_tree->childs (cls);
		collect_impl (childs, res);		
	}	

	void collect_impl (ObjectTreeResolver::ObjectTree::Items& cc, RADSet& res) {
		for (ObjectTreeResolver::ObjectTree::Items::iterator it = cc.begin(); it != cc.end(); it++) {
			const RoseAbstractDumper* cls = dynamic_cast<const RoseAbstractDumper*>(*(*it));
			if (cls->get_model_class_str () == CLASS_TYPE) {
				ObjectTreeResolver::ObjectTree::Items cls_childs = ObjectTreeResolver::s_tree->childs (cls);
				if (res.find (cls) == res.end ()) {
					bool has_nested_class = false;
					for (
						ObjectTreeResolver::ObjectTree::Items::iterator it2 = cls_childs.begin()
						; it2 != cls_childs.end()
						; it2++
					) {
						const RoseAbstractDumper* child_cls = dynamic_cast<const RoseAbstractDumper*>(*(*it2));
						if (child_cls->get_model_class_str () == CLASS_TYPE) {
							has_nested_class = true;
							break;
						}
					}

					if (has_nested_class) {
						res.insert (cls);
						collect_impl (cls_childs, res);						
					}
				}
			}			
		}
	}
};

//использование std::list оказалось чуть-чуть эффективние в плане производительности...
typedef std::list<std::string> StrList;

class scope_helper {
public:
	static StrList* intersect_scope (const std::string& base, const std::string& target, bool add_last) {
#ifndef GDS_NLOG_DEBUG
		Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif

		StrList target_vec;
		GCL::split_string_by_sub_string (target_vec, target.c_str (), "::");
		//target_vec.reverse ();
		
		StrList base_vec;
		GCL::split_string_by_sub_string (base_vec, base.c_str (), "::");
		//base_vec.reverse ();
		
		StrList::const_reverse_iterator target_it = target_vec.rbegin ();
		StrList::const_reverse_iterator target_it_end = target_vec.rend ();
		Core::Aptr<StrList> intersected (new StrList ());
		for (
			StrList::reverse_iterator it = base_vec.rbegin ()
			; it != base_vec.rend ()
			; ++it
		) {
			if (
				target_it != target_it_end						
			) {
				if (*target_it == *it) {
					intersected->insert (intersected->begin (), *it);						
					++target_it;
				} else {
					if (add_last) {
						intersected->insert (intersected->begin (), *it);
					}
					break;
				}
			} else {
				
				break;
			}
		}
		return intersected.forget ();
	}

	static bool compare_scope (const std::string& type, const std::string& full_scope) {
#if !defined(GDS_NLOG_DEBUG) || defined(FORCE_STOP_WARCH)
		Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif		
		
		/*size_t type_len = type.size ();
		size_t full_scope_len = full_scope.size ();
		std::string::size_type pos = full_scope.rfind (type);

		bool res = false;
		if (
			pos != std::string::npos 
			&& (pos + type_len) == full_scope_len //full_scope должен заканчиваться на type
		) {
			//проверяем, что предыдущие два символа - это "::"
			res = (pos > 1) ? (full_scope[pos - 1] == ':' && full_scope[pos - 2] == ':') : true;
		}
		
		return res;*/

		if (!GCL::end_with (full_scope.c_str (), type.c_str ())) {
			return false;
		}

		Core::Aptr<StrList> intersected = scope_helper::intersect_scope (type, full_scope, false);

		size_t type_components_size = type.empty () ? 0 : 1;
		std::string::size_type pos = 0;
	
		while ((pos = type.find ("::", pos)) != std::string::npos) {
			pos += 2;
			type_components_size++;
		}		

		return (intersected->size () == type_components_size);
	}
};

const RoseAbstractDumper* RoseAbstractDumper::resolve (std::string& type) const {
#if !defined(GDS_NLOG_DEBUG) || defined(FORCE_STOP_WARCH)
	Core::GDS::StopWatchEx sw ("RoseAbstractDumper::resolve (std::string&)");
#endif

	const RoseAbstractDumper* ret = NULL;
    if (type.empty ()) {
		if (!this->is_allow_empty_target()) {
			this->write_error_log ("Не определенный тип, использован void по умолчанию", false);
		}
		type = "void";
		return s_void_rad;
    }   

   {
		AbstractDumperBase::ResolveTypeCacheType::iterator it = ResolveTypeCacheSingleton::instance ()->ptr.find (type);
		if (it != ResolveTypeCacheSingleton::instance ()->ptr.end ()) {
			ret =  dynamic_cast<const RoseAbstractDumper*> (it->second);
		} else {
			const RoseAbstractDumper* owner_cat = dynamic_cast<const RoseAbstractDumper*>(
				this->get_parent_category()
			);

			std::string key = owner_cat->get_model_unique_id_str () + type;

			it = ResolveTypeCacheSingleton::instance ()->ptr.find (key);
			if (it != ResolveTypeCacheSingleton::instance ()->ptr.end ()) {
				ret =  dynamic_cast<const RoseAbstractDumper*> (it->second);
			} else {
				std::string original_type = type;
				// try to resolve		
				RADSet cats_in_scope;
				
				// collect pakage of visibilty		
				
				const RoseAbstractDumper* self_class = dynamic_cast<const RoseAbstractDumper*>(
					this->get_parent_container()
				);
				if (self_class) {
					cats_in_scope.insert (self_class);			

					// owner's parent cats
					while (self_class = dynamic_cast<const RoseAbstractDumper*>(self_class->parent())) {
						cats_in_scope.insert (self_class);
					}
				}		
				
				// global cats
				cats_in_scope.insert(RoseAbstractDumper::s_global_cats.begin(), RoseAbstractDumper::s_global_cats.end());

				if (owner_cat) {
					// owner cat dependences
					OTRSet deps = owner_cat->get_supplier_by_stereotype (ST_LINK_DEP);			
					for (OTRSet::const_iterator it = deps.begin(); it != deps.end(); it++) {
						const RoseAbstractDumper* dep_cat = dynamic_cast<const RoseAbstractDumper*>(*it);
						if (dep_cat) {
							cats_in_scope.insert (dep_cat);
						}
					}
				}

				// expand to all nested class
				{	
					RADSet all_nested;

					for (RADSet::const_iterator it = cats_in_scope.begin(); it != cats_in_scope.end(); it++) {
						collect_all_nested_class (*it, all_nested);
					}

					cats_in_scope.insert(all_nested.begin(), all_nested.end());
				}
				
				typedef std::map<std::string, const RoseAbstractDumper*> TypeMap;
				TypeMap types;
				
				{
		#if !defined(GDS_NLOG_DEBUG) || defined(FORCE_STOP_WARCH)
					Core::GDS::StopWatchEx sw ("Fill TypeMap");
		#endif
					for (RADSet::const_iterator it = cats_in_scope.begin(); it != cats_in_scope.end(); it++) {
						//this->write_info_log (std::string ("Алгоритм поиска типа: ") + (*it)->get_full_name ());
						ObjectTree::Items items = s_tree->childs (*it);
						for (ObjectTree::Items::iterator it2 = items.begin(); it2 != items.end(); it2++ ) {
							const RoseAbstractDumper* cls = dynamic_cast<const RoseAbstractDumper*>(*(*it2));
							std::string cls_model_class = cls->get_model_class_str ();
							if (
								cls_model_class == CLASS_TYPE			//нас интересуют только классы
								|| cls_model_class == PARAMETER_TYPE	//и параметры (для шаблонных классов)
							) {
								std::string full_name = cls->get_full_name();					
								if (scope_helper::compare_scope (type, full_name)) {
									TypeMap::value_type vt (full_name, cls);
									types.insert(vt);					
								}
							}
						}
					}
				}
						
				if (types.size() > 1) {
					GCL::StrSet choise_strings;
					for (TypeMap::const_iterator it = types.begin(); it != types.end(); it++) {
						choise_strings.insert(it->first);
					}

					std::string choice = s_choice_dlg->make_choice (choise_strings, this->get_full_name());
					
					if (choice.empty ()) {
						this->write_error_log (
							std::string("Не могу точно определить связанный тип ") 
							+ type
							, false
						);
						ret = NULL;
					} else {
						ret = types[choice];				
						this->write_info_log (
							std::string("Тип ")
							+ type
							+ " был связан с элементом: "
							+ choice
							+ "(" 
							+ get_rose_element_uid(ret->m_rose_element) 
							+ ")" 
						);
						
						GCL::StrVector result; 
						for (
							GCL::StrSet::const_iterator it = choise_strings.begin()
							; it != choise_strings.end()
							; it++
						) {
							if (*it != choice) {
								Core::Aptr<StrList> temp = scope_helper::intersect_scope (choice, *it, true);
								if (temp->size () > result.size ()) {
									result.assign (temp->begin (), temp->end ());
								}
							}
						}
						type = GCL::join (result, "::");
						//RoseHelper::override_property(m_rose_item, TOOL_NAME, prop_linkeditem, ret->m_rose_item->GetUniqueID());
					}
				} else if (types.size() == 1 ) {
					ret = (*types.begin()).second;
				} else {
					bool need_error = !RoseHelper::is_incomplete (
						this->m_rose_element
					);

					if (need_error) {
						//ругаемся только если элемент не является незавершённым
						this->write_error_log (
							std::string("Не могу найти связанный тип \"") 
							+ type
							+ std::string ("\" в области видимости")
							, false
						);
					}
					ret = NULL;
				}

				if (ret) {
					if (ret->is_global_visible ()) {
						ResolveTypeCacheSingleton::instance ()->ptr[original_type] = ret;
					} else {
						ResolveTypeCacheSingleton::instance ()->ptr[key] = ret;
					}
				}
			}
		}
	}

	return ret;
}

RoseAbstractDumper::MessTreeNode::MessTreeNode(const SeqId a_id) : id(a_id), mess(NULL) {
}

RoseAbstractDumper::MessTreeNode::MessTreeNode (const char* a_id) : id(a_id), mess(NULL) {
}

RoseAbstractDumper::MessTreeNode::MessTreeNode (const SeqId a_id, IRoseMessagePtr a_mess) : id(a_id), mess(a_mess) {
}

bool RoseAbstractDumper::MessTreeNode::operator < (const MessTreeNode& c) const {
	return id < c.id;
}

const ObjectTreeResolver* RoseAbstractDumper::get_parent_category () const {	
	const RoseAbstractDumper* ret = this;
	bool is_cat = false;
	do {
		ret = dynamic_cast<const RoseAbstractDumper*>(ret->parent());
		if (ret) {
			is_cat = ret->rose_element ()->IsClass(CATEGORY_TYPE) != 0;
		}
	} while (!is_cat && ret);
	return ret;
}

const ObjectTreeResolver* RoseAbstractDumper::get_parent_container () const {
	const RoseAbstractDumper* ret = this;
	bool is_cont = false;
	do {
		ret = dynamic_cast<const RoseAbstractDumper*>(ret->parent());
		if (ret) {
			is_cont = ret->rose_element()->IsClass(CATEGORY_TYPE) != 0 || ret->rose_element()->IsClass(CLASS_TYPE) != 0;
		}
	} while (!is_cont && ret);
	return ret;
}

const ObjectTreeResolver* RoseAbstractDumper::get_nearest_container () const {
	if (m_rose_element->IsClass(CLASS_TYPE) || m_rose_element->IsClass(CATEGORY_TYPE)) {
		return this;
	}

	const RoseAbstractDumper* parent = dynamic_cast<const RoseAbstractDumper*>(this->parent());
	if (parent == NULL) {
		return NULL;
	}

	return parent->get_nearest_container();
}

bool RoseAbstractDumper::is_native (bool& wilth_parent) const {
	if (m_is_native == 2) {
		if (RoseHelper::get_is_native_with_parent (m_rose_element, m_native_with_parent)) {
			m_is_native = 1;
		} else {
			m_is_native = 0;			
		}
	}
	wilth_parent = m_native_with_parent;
	return m_is_native;
}

struct FlaterEachFunc {
	struct CollectEachFunc {
		void each_func (const GCL::StaticNode* item, RoseHelper::Selections& res) const {
			if (!item->has_children()) {
				res.insert(dynamic_cast<const AbstractDumperBase::GenTreeItem*>(item)->name());
			}
		}
	};

	FlaterEachFunc (AbstractDumperBase::Selections& sels) : selsected_nodes (sels) {
	}
	
	void each_func (const GCL::StaticNode* item, RoseHelper::Selections& flat_child_gens) const {
		if (
			std::find (
				selsected_nodes.begin()
				, selsected_nodes.end()
				, dynamic_cast<const AbstractDumperBase::GenTreeItem*>(item)->name()
			) != selsected_nodes.end()
		) {
			item->for_each (CollectEachFunc(), flat_child_gens);
		}		
	}

	AbstractDumperBase::Selections& selsected_nodes;
};

void RoseAbstractDumper::force_applied_gens_to_all (bool set) {
	s_force_applied_gens_to_all = set;
}

void get_derived_methods (const RoseAbstractDumper* item, RoseAbstractDumper::UnorderedRADSet& derived_impl) {
	RoseAbstractDumper::UnorderedRADSet all_abstr;		
	RoseHelper::find_all_derived_abstract (item, all_abstr);
	
	RoseAbstractDumper::UnorderedRADSet from_prop;
	RoseHelper::get_derived_methods_from_prop (item, _bstr_t (PROP_DERIVED_IMPLEMENT), from_prop);
	for (
		RoseAbstractDumper::UnorderedRADSet::const_iterator it = from_prop.begin ()
		; it != from_prop.end ()
		; ++it
	) {
		if (all_abstr.find (*it) != all_abstr.end ()) {
			derived_impl.insert (*it);
		}
	}			
}

template<typename ItemCollection, typename StateCollection>
AbstractDumperBase::ADList* wrap_all (ItemCollection& items, const StateCollection& states, const RoseAbstractDumper* for_owner) {
	typedef typename ItemCollection::iterator ItemCollectionIterator;
	typedef typename StateCollection::const_iterator StateCollectionIterator;
	typedef typename StateCollection::value_type StateCollectionValueType;
	typedef Core::TypeTraits<StateCollectionValueType::value_type>::Factory StateCollectionValueTypeFactory;

	Core::Aptr<AbstractDumperBase::ADList> result (new AbstractDumperBase::ADList ());
	for (
		ItemCollectionIterator it = items.begin ()
		; it != items.end ()
		; ++it
	) {
		StateCollectionValueType state = StateCollectionValueTypeFactory::make ((*it)->get_model_unique_id_str (), false);
		StateCollectionIterator state_it = states.find (state);
		if (state_it != states.end ()) {
			state = StateCollectionValueType::value_type::_duplicate (const_cast<StateCollectionValueType::value_type*> ((*state_it).ptr ()));
		}
		
		RoseAbstractDumper& wrapper = RoseAbstractDumper::make_overriden_wrapper (*it, state.in (), for_owner);
		result->push_back (&wrapper);
	}

	return result.forget ();
}

void difference (RoseAbstractDumper::UnorderedRADSet& from, const RoseAbstractDumper::UnorderedRADSet& what) {
	for (
		RoseAbstractDumper::UnorderedRADSet::const_iterator it = what.begin ()
		; it != what.end ()
		; ++it
	) {
		from.erase (*it);
	}
}
//#UC END# *4571D1A5009C*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
RoseAbstractDumper::IRoseItemWrapper::IRoseItemWrapper (IRoseItemPtr m_rose_item_)
//#UC START# *4575AB0200E6_INIT_CTOR_BASE_INIT*
	: m_rose_item(m_rose_item_)
//#UC END# *4575AB0200E6_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4575AB0200E6_INIT_CTOR*
	//#UC END# *4575AB0200E6_INIT_CTOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// находит элемент в дереве по его UID
RoseAbstractDumper* RoseAbstractDumper::find_in_tree (const std::string& uid) {
	//#UC START# *4A489940019C*
	RoseAbstractDumper* ret = NULL;
	if (s_tree) {
		if (!uid.empty ()) {
			
			EmptyDumper temp (uid);
			const ObjectTreeResolver** otr = s_tree->find(&temp);
			if ( otr ) {
				return const_cast<RoseAbstractDumper*>(dynamic_cast <const RoseAbstractDumper*> (*otr));
			} else {
				return 0;
			}
		} else {
			return s_void_rad;
		}
	} 
	return ret;
	//#UC END# *4A489940019C*
}

// возвращает true, если модель генерации построена
bool RoseAbstractDumper::is_model_tree_initialized () {
	//#UC START# *4B34A8F50370*
	return s_model_tree_root != 0;
	//#UC END# *4B34A8F50370*
}

// создает экземпляр дампера-обертки, связывая его с владельцем (with_owner)
RoseAbstractDumper& RoseAbstractDumper::make_overriden_wrapper (const RoseAbstractDumper* from, const InheritedItem* state, const RoseAbstractDumper* with_owner) {
	//#UC START# *4C1F0B1D0240*
	RoseOverridenElementDumper* res = 0;
	const RoseOverridenElementDumper* existing_wrapper = from->get_wrapper (with_owner);
	if (existing_wrapper) {
		res = const_cast<RoseOverridenElementDumper*> (existing_wrapper);
		res->update (from, state);
	} else {
		RoseOverridenElementDumper_var wrapper = new RoseOverridenElementDumper (from, state, with_owner);
		
		const_cast<RoseAbstractDumper*>(from)->add_wrapper (wrapper.in (), with_owner); //тут wrapper захватывается!

		res = wrapper.ptr ();
	}

	return *res;
	//#UC END# *4C1F0B1D0240*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractDumper::~RoseAbstractDumper () {
	//#UC START# *4571D1A5009C_DESTR_BODY*
	//т.к вызывать виртуальные методы из дестукртора черевато проблемами - 
	//нельзя тут вызывать s_tree->find (this), т.к это приводит к вызову this->get_model_unique_id_str
	//а он может быть перекрыт на наследниках

	/*
	if (s_tree && m_rose_element) {		
		ObjectTree::Item_ptr find = s_tree->find (this);
		if (find != 0 && *find == this) {
			LOG_E(("Удаляем элемент \"\", но он ещё в дереве!!!", this->get_full_name ().c_str ()));
		}
	}*/
	
	m_wrappers.clear ();
	//#UC END# *4571D1A5009C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Добавляет обертку, связывая ее с владельцем, таким образом обеспечивается гарантия, что для
// одного элемента, который переопределяет (или реализует) другой элемент существует только одна
// обертка (т.е они не пложятся бесконтрольно)
void RoseAbstractDumper::add_wrapper (RoseOverridenElementDumper* wrapper, const RoseAbstractDumper* for_owner) {
	//#UC START# *4C4519C403E0*
	RoseOverridenElementDumper_var new_wrapper = RoseOverridenElementDumper::_duplicate (wrapper);
	m_wrappers[for_owner] = new_wrapper;
	//#UC END# *4C4519C403E0*
}

// копирует временные свойства с заданного элемента
void RoseAbstractDumper::copy_temporary_properties_from (const RoseAbstractDumper* rad) {
	//#UC START# *4B99D0BC015E*
	m_temporary_properties = rad->m_temporary_properties;
	//#UC END# *4B99D0BC015E*
}

// возвращает знечение свойства - сначала ищет во временном хранилище, а затем в модели
const std::string RoseAbstractDumper::get_property_value (
	const std::string& tool_name
	, const std::string& prop_name
) const {
	//#UC START# *4AFD03F200BC*
	Base::ToolPropertyMap::iterator tool_it = m_temporary_properties.find (tool_name);
	if (tool_it != m_temporary_properties.end ()) {
		Base::PropertyMap::iterator it = tool_it->second.find (prop_name);
		if (it != tool_it->second.end ()) {
			return it->second;
		}
	}

	std::string value = m_rose_element->GetPropertyValue(tool_name.c_str (), prop_name.c_str ());
	//replace back newline character
	GCL::replace_char (value, ROSE_NEWLINE_REPLACEMENT, '\n');
	return value;
	//#UC END# *4AFD03F200BC*
}

// возвращает обертку, связанную с владельцем, если обертки не найдено - возвращает 0
const RoseOverridenElementDumper* RoseAbstractDumper::get_wrapper (const RoseAbstractDumper* for_owner) const {
	//#UC START# *4C451A7903C1*
	WrappersMap::const_iterator it = m_wrappers.find (for_owner);
	if (it != m_wrappers.end ()) {
		return it->second.ptr ();
	}

	return 0;
	//#UC END# *4C451A7903C1*
}

// сбрасывает закэшированный model stereotype
void RoseAbstractDumper::reset_model_stereotype () {
	//#UC START# *4AC35B0500E2*
	AbstractDumperBase::s_stereotypes.erase (get_rose_element_uid(m_rose_element));
	if (ObjectTreeResolver::s_tree) {
		ObjectTree::Items ch = s_tree->childs (this);
		for (ObjectTree::Items::iterator it = ch.begin(); it != ch.end(); it++) {
			RoseAbstractDumper* child = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*>(*(*it)));
			child->reset_model_stereotype ();
		}
	}

	m_model_stereotype = RoseHelper::get_gen_stereotype(m_rose_element);
	//#UC END# *4AC35B0500E2*
}

// записать свойство во временное хранилище
bool RoseAbstractDumper::set_temporary_property (
	const std::string& tool_name
	, const std::string& prop_name
	, const std::string& value
) const {
	//#UC START# *4AFD0404034D*
	//RoseHelper::override_property (m_rose_element, tool_name.c_str (), prop_name.c_str (), value.c_str ());
	std::string& current_value = m_temporary_properties[tool_name][prop_name];
	if (current_value != value) {
		current_value = value;		
		return true;
	}

	return false;
	//#UC END# *4AFD0404034D*
}

// метод вызывается, когда нужно обновить, закэшированные на дампере значения атрибутов
void RoseAbstractDumper::update_cached_attrs () const {
	//#UC START# *4B98C3A50072*
	std::string doc;
	if (m_rose_element->IsClass (ROSE_ITEM_TYPE)) {
		doc = (const char*)((IRoseItemPtr)m_rose_element)->Documentation;
	} else if (m_rose_element->IsClass ("Diagram")) {
		doc = (const char*)((IRoseDiagramPtr)m_rose_element)->Documentation;
	}
	
	GCL::str_replace (doc, "\r\n", "\n");
	boost::trim_if (doc, boost::is_any_of("\n "));
	//GCL::trim_char (doc, "\n");
	//GCL::trim_char (doc, " ");

	this->set_documentation (doc);
	//#UC END# *4B98C3A50072*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& RoseAbstractDumper::get_documentation () const {
	//#UC START# *4B98C03601BE_GET_ACCESSOR*
	return m_documentation;
	//#UC END# *4B98C03601BE_GET_ACCESSOR*
}

void RoseAbstractDumper::set_documentation (const std::string& documentation) const {
	//#UC START# *4B98C03601BE_SET_ACCESSOR*
	m_documentation = documentation;
	//#UC END# *4B98C03601BE_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// добавляет юзер секцию
void RoseAbstractDumper::add_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
	, const AbstractDumperBase::UserCode& uc
) const {
	//#UC START# *4666BE6D01C5_4571D1A5009C*
	GCL::StrVector strs = GCL::split_string_by_fragment (uc_id.data(), '*', '*');
	if (strs.empty () == false) {
		std::string guid = strs[0];
		guid.erase (12);
		
		RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (guid);
		IRoseElementPtr item;
		if (rad && (item = rad->rose_element ())) {
			std::string prop_id = gen_id + ":" + uc_id;

			std::string s;
			s += ROSE_NEWLINE_REPLACEMENT;

			std::string uc_to_save;
			std::string uc_to_save_2;

			GCL::replace_char(uc, uc_to_save, 10, s);
			GCL::replace_char(uc_to_save, uc_to_save_2, 13, "");

			RoseHelper::write_property_with_lock (
				item
				, prop_id
				, uc_to_save_2
				, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
				, false
				, "User section"
			);			
		} else {
			//missed item for UC
		}
	} else {
		std::string mess ("Bad UC identificator: ");
		mess += uc_id;

		throw Base::FatalError (mess);
	}
	//#UC END# *4666BE6D01C5_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
// items - коллекция элементов даграммы, для формирования навигационной мапы
// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
CxMemFile* RoseAbstractDumper::dump_diagram (
	AbstractDumperBase::DiagramItemCollection& items
	, std::string& diagram_hash
) const {
	//#UC START# *4642AC6B0138_4571D1A5009C*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4642AC6B0138_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает список разрешенных генераторов
AbstractDumperBase::Selections* RoseAbstractDumper::get_applied_gens () const {
	//#UC START# *46678131036B_4571D1A5009C*
	SelectionsMap::iterator current_selections = s_selections_map.find (this);
	if (current_selections == s_selections_map.end ()) {
		Core::Aptr<AbstractDumperBase::Selections> ret = new AbstractDumperBase::Selections;
		if (s_force_applied_gens_to_all) {
			ret->insert ("All");
		} else {
			std::string merged_sels = this->get_property_value (
				std::string (_bstr_t (TOOL_NAME))
				, std::string (_bstr_t (PROP_APPLGEN))
			);

			ret = GCL::split_string_by_sub_string_uniq (merged_sels.data(), "|");

			if (ret->find("none") != ret->end()) {
				ret->clear();
				ret->insert ("none");
			} else {
				if (ret->size() == 0 || (ret->find("All") != ret->end())) {
					const AbstractDumperBase* parent = this->parent();
					if (parent) {
						ret = parent->get_applied_gens();
					} else {
						if (ret->size() == 0) {
							ret->insert ("All");
						}
					}
				} else {
					AbstractDumperBase::Selections flat_ret;
					{
						FlaterEachFunc fef (*ret.ptr ());
						AbstractDumperBase::s_gen_tree->for_each (fef, flat_ret);
					}
					ret = flat_ret;

					const AbstractDumperBase* parent = this->parent();
					if (parent) {
						Core::Aptr<AbstractDumperBase::Selections> filt = parent->get_applied_gens();
						
						if (filt->size() == 0 || (filt->find("All") != filt->end())) {
						} else if (filt->find("none") != filt->end()) {
							ret->clear();
							ret->insert ("none");
						} else {
							for (
								AbstractDumperBase::Selections::iterator it = ret->begin ()
								; it != ret->end ()
								;
							) {
								if (filt->find(*it) == filt->end()) {
									ret->erase(it++);
								} else {
									++it;
								}
							}
							if (!ret->size()) {
								ret->insert ("none");
							}
						}
					}
				}
			}
		}
		current_selections = s_selections_map.insert (
			SelectionsMap::value_type (this, *ret.ptr ())
		).first;
	}
	return new AbstractDumperBase::Selections (current_selections->second);
	//#UC END# *46678131036B_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// авто инкрементирующийся счетчик на элементе.
const std::string RoseAbstractDumper::get_auto_counter_str () const {
	//#UC START# *4666BCB7033C_4571D1A5009C*
	return RoseHelper::get_auto_counter(m_rose_element);
	//#UC END# *4666BCB7033C_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает информацию об тех файлах которые были сгенерированны
// ранее, а теперь "исчезли" из списка генерации. Т.е. о тех файлы,
// который фактически удалились из репазитария
AbstractDumperBase::GenSourceInfoSet* RoseAbstractDumper::get_deleted_child_generated_source () const {
	//#UC START# *459D2DD40228_4571D1A5009C*
	AbstractDumperBase::GenSourceInfoSet* ret = 0;
	
	if (m_rose_element != 0) {
		ret = new AbstractDumperBase::GenSourceInfoSet;
		
		AbstractDumperBase::GenSourceType srs_type = this->get_source_type ();		
		if (srs_type == AbstractDumperBase::GST_FILE) {

			std::string prop_id = "NESTED GENERATED FILES (" + AbstractDumperBase::s_current_map + ")";
			std::string value = this->get_property_value (
				std::string (_bstr_t (TOOL_NAME))
				, prop_id
			);
			
			boost::char_separator<char> sep (",;", "", boost::drop_empty_tokens);
			typedef boost::token_iterator_generator<boost::char_separator<char>>::type TokenIter;

			TokenIter tok_begin = boost::make_token_iterator<std::string> (
				value.begin(), value.end(), sep
			);

			TokenIter tok_end = boost::make_token_iterator<std::string> (
				value.end(), value.end(), sep
			);

			ModelSearcher* searcher = &ModelSearcherFactory::get ();
			for (TokenIter it = tok_begin; it != tok_end; ++it) {
				GCL::StrVector parts = GCL::split_string_by_sub_string (it->data (), "::");
				if (parts.size() == 2) {
					IRoseItemPtr item = searcher->search (parts[1]);
					if (
						item == 0 
						|| get_rose_element_uid(RoseHelper::get_context (item)) != get_rose_element_uid(m_rose_element)
					) {
						AbstractDumperBase::GenSourceInfo srs;
						srs.source.file_name(parts[0]);
						srs.gen_id = s_current_map;
						ret->insert(srs);
					}
				} else {
					GDS_ASSERT (0);
				}
			}
		} else if (srs_type == AbstractDumperBase::GST_WIKI) {
			std::string prop_id = "NESTED GENERATED WikiPageID (" + AbstractDumperBase::s_current_map + ")";
			std::string value = this->get_property_value (
				std::string (_bstr_t (TOOL_NAME))
				, prop_id
			);
			
			if (!value.empty ()) {
				boost::char_separator<char> sep (";", "", boost::drop_empty_tokens);
				typedef boost::token_iterator_generator<boost::char_separator<char>>::type TokenIter;

				TokenIter tok_begin = boost::make_token_iterator<std::string> (
					value.begin(), value.end(), sep
				);

				TokenIter tok_end = boost::make_token_iterator<std::string> (
					value.end(), value.end(), sep
				);

				ModelSearcher* searcher = &ModelSearcherFactory::get ();
				for (TokenIter it = tok_begin; it != tok_end; ++it) {
					GCL::StrVector parts = GCL::split_string_by_sub_string (it->data (), "::");
					if (parts.size() == 2) {
						IRoseItemPtr item = searcher->search (parts[1]);
						if (
							item == 0 //элемент удалили
							|| RoseHelper::get_is_native_with_parent (item) //элемент стал Native
							/* || (item->GetContext()->GetUniqueID() != m_rose_item->GetUniqueID())*/
						) {
							AbstractDumperBase::GenSourceInfo srs;							
							srs.gen_id = s_current_map;
							std::string page_id;
							std::string page_path;
							AbstractDumperBase::extract_from_page_property (
								parts[0]
								, page_id
								, page_path
							);
							
							GenSupport::PageProxy& existent_page = GenSupport::PageProxyFactory::get (page_id.c_str ());
							
							if (existent_page.is_new_page () == false) {
								srs.source.wiki_page (&existent_page);						
								ret->insert(srs);
							} else {
								srs.gen_id = AbstractDumperBase::s_current_map;
								srs.source.wiki_page (&existent_page);
								TransactionContainer::instance ()->add_source (srs);
							}
						}
					} else {
						GDS_ASSERT (0);
					}
				}
			}
		}
	}
	return ret;
	//#UC END# *459D2DD40228_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// массив реализующих методов и\или атрибутов (реализуемых данным элементом относительно
// абстрактных членов своих базовых классов)
AbstractDumperBase::ADList* RoseAbstractDumper::get_derived_impl () const {
	//#UC START# *4666379A0222_4571D1A5009C*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("RoseAbstractDumper::get_derived_impl ()");
#endif
	
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const RoseAbstractDumper* this_) {
			
			RoseAbstractDumper::UnorderedRADSet real_items;
			std::string impl_sel_type = RoseHelper::get_implement_select_type (this_);

			if (impl_sel_type == "include") {
				get_derived_methods (this_, real_items);
			} else if (impl_sel_type == "exclude") {	
				RoseHelper::find_all_derived_abstract (this_, real_items);

				RoseAbstractDumper::UnorderedRADSet all_impl;
				RoseHelper::find_all_derived_impl (this_, all_impl);
				
				RoseAbstractDumper::UnorderedRADSet excluded;
				RoseHelper::get_derived_methods_from_prop (this_, _bstr_t(PROP_DERIVED_IMPLEMENT), excluded);

				difference (real_items, all_impl);
				difference (real_items, excluded);
			} else {
				RoseHelper::find_all_derived_abstract (this_, real_items);

				RoseAbstractDumper::UnorderedRADSet all_impl;
				RoseHelper::find_all_derived_impl (this_, all_impl);
				
				difference (real_items, all_impl);
			}

			//находим созраненные состояния для реализуемых элементов
			Core::Aptr<ImplementedItemSet> implemented = InheritedItemHelperFactory::get ().get_stored_implemented (this_);

			//создаем обертки над элементами
			ADList_aptr ret = wrap_all (real_items, *implemented.ptr (), this_);

			ret->sort (AbstractDumperBase::SortByUID ());
			
			return ret.forget ();
		}
	};

	ADList_aptr ret;

	if (AbstractDumper::is_functions_cache_enabled ()) {
		CleanOnStartFunctionsCache::key_type key (this, FT_GET_DERIVED_IMPL);
		CleanOnStartFunctionsCache::iterator func_it = s_clean_on_start_list_functions_cache.find (key);

		if (func_it != s_clean_on_start_list_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_clean_on_start_list_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	return ret.forget ();
	//#UC END# *4666379A0222_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// массив перегруженных методов и\или атрибутов (перегруженных данным элементом относительно своих
// базовых классов)
AbstractDumperBase::ADList* RoseAbstractDumper::get_derived_over () const {
	//#UC START# *466637C50399_4571D1A5009C*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("RoseAbstractDumper::get_derived_over ()");
#endif
	class local {
	public:
		static void get_overloaded_methods (const RoseAbstractDumper* item, RoseAbstractDumper::UnorderedRADSet& overloaded, const OverloadedItemSet& overloaded_items) {
			RoseAbstractDumper::UnorderedRADSet all_derived_impl;
			RoseHelper::find_all_derived_impl (item, all_derived_impl);

			for (OverloadedItemSet::const_iterator it = overloaded_items.begin (); it != overloaded_items.end (); ++it) {				
				RoseAbstractDumper* overloaded_item = RoseAbstractDumper::find_in_tree ((*it)->get_uid ());
				if (overloaded_item) {
					if (overloaded_item->get_model_class_str () == CLASS_TYPE && (*it)->get_need_collect_children ()) {
						//если в настройках был записан гуид класса -
						//собираем все его операции и атрибуты, которые присутсвует в списке all_derived_impl
						Core::Aptr<AbstractDumperBase::ADList> contents = overloaded_item->get_contents ();
						if (!contents.is_nil ()) {
							for (
								AbstractDumperBase::ADList::const_iterator c_it = contents->begin ()
								; c_it != contents->end ()
								; ++c_it
							) {
								const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (*c_it);
								if (all_derived_impl.find (rad) != all_derived_impl.end ()) {
									overloaded.insert (rad);
								}
							}
						}
					} else {
						if (all_derived_impl.find (overloaded_item) != all_derived_impl.end ()) {
							overloaded.insert (overloaded_item);
						}
					}
				}
			}
		}
		
		static AbstractDumperBase::ADList* impl (const RoseAbstractDumper* this_) {
			//находим созраненные состояния для реализуемых элементов
			Core::Aptr<OverloadedItemSet> overloaded_states = InheritedItemHelperFactory::get ().get_stored_overloaded (this_);

			RoseAbstractDumper::UnorderedRADSet overloaded;			
			get_overloaded_methods (this_, overloaded, *overloaded_states.ptr ());
			
			//создаем обертки над элементами
			ADList_aptr ret = wrap_all (overloaded, *overloaded_states.ptr (), this_);

			ret->sort (AbstractDumperBase::SortByUID ());

			return ret.forget (); 
		}
	};

	ADList_aptr ret;

	if (AbstractDumper::is_functions_cache_enabled ()) {
		CleanOnStartFunctionsCache::key_type key (this, FT_GET_DERIVED_OVER);
		CleanOnStartFunctionsCache::iterator func_it = s_clean_on_start_list_functions_cache.find (key);

		if (func_it != s_clean_on_start_list_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_clean_on_start_list_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	return ret.forget ();
	//#UC END# *466637C50399_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// получение докуентации к элементу
const std::string RoseAbstractDumper::get_documentation_str () const {
	//#UC START# *4666BA670109_4571D1A5009C*
	return get_documentation ();
	//#UC END# *4666BA670109_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает COM GUID
const std::string RoseAbstractDumper::get_guid_str () const {
	//#UC START# *4666AA6D02EE_4571D1A5009C*
	std::string ret;

	ret = this->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, std::string (_bstr_t (PROP_OS_GUID))
	);
	
	if (ret.empty ()) {
		GUID guid;
		CoCreateGuid (&guid);
		LPOLESTR str;
		StringFromCLSID (guid, &str);
		char _str[256];
		WideCharToMultiByte( CP_ACP, 0, str, -1, _str, 256, NULL, NULL );		
		CoTaskMemFree(str);
		
		ret = _str+1;
		ret.resize (ret.size()-1);
		
		RoseHelper::write_property_with_lock (
			m_rose_element
			, PROP_OS_GUID
			, ret
			, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
			, true
			, PROP_OS_GUID
		);		
	}
	return ret;
	//#UC END# *4666AA6D02EE_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// значение по умолчанию (для атрибутов и аргументов операции)
const std::string RoseAbstractDumper::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_4571D1A5009C*
	return "";
	//#UC END# *4666BA9F03D8_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
const AbstractDumperBase::StereotypeID& RoseAbstractDumper::get_model_stereotype_str () const {
	//#UC START# *4666AB4D0109_4571D1A5009C*
	return m_model_stereotype;
	//#UC END# *4666AB4D0109_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает GUID элемента
const std::string& RoseAbstractDumper::get_model_unique_id_str () const {
	//#UC START# *465E51860213_4571D1A5009C*
	if (m_model_unique_id.empty ()) {
		m_model_unique_id = get_rose_element_uid(m_rose_element);
	}
	return m_model_unique_id;
	//#UC END# *465E51860213_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает имя
const std::string RoseAbstractDumper::get_name_str () const {
	//#UC START# *466554D9006D_4571D1A5009C*	
	static const boost::regex ex ("\\BЯ");
	static const std::string replace ("я");
	std::string name = (const char*)m_rose_element->Name;
	boost::replace_all_regex (name, ex, replace);
	return name;
	//#UC END# *466554D9006D_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает native-путь к элементу, прописанный в настройках
const std::string RoseAbstractDumper::get_native_path_str () const {
	//#UC START# *4666BD0F01C5_4571D1A5009C*
	std::string prop_name = "NATIVE_PATH";
	prop_name += s_current_map;

	return this->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, prop_name
	);
	//#UC END# *4666BD0F01C5_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает список абстрактных операций/атрибутов базовых или реализуемых классов, который НЕ
// реализует данный элемент
AbstractDumperBase::ADList* RoseAbstractDumper::get_not_implemented_derived_abstract () const {
	//#UC START# *4B5EE7570302_4571D1A5009C*	
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const RoseAbstractDumper* this_) {			
			ADList_aptr ret = new ADList ();

			std::string impl_sel_type = RoseHelper::get_implement_select_type (this_);

			if (
				impl_sel_type == "include" 
				|| !RoseHelper::has_it_derived_impl (this_->m_rose_element)
			) {
				RoseAbstractDumper::UnorderedRADSet implemented;
				RoseHelper::get_derived_methods_from_prop (this_, _bstr_t(PROP_DERIVED_IMPLEMENT), implemented);

				RoseAbstractDumper::UnorderedRADSet all_abstr;
				RoseHelper::find_all_derived_abstract (this_, all_abstr);

				RoseAbstractDumper::UnorderedRADSet all_impl;
				RoseHelper::find_all_derived_impl (this_, all_impl);

				all_impl.insert (implemented.begin (), implemented.end ());
				
				difference (all_abstr, all_impl);				
				ret->assign (all_abstr.begin (), all_abstr.end ());
			} else if (impl_sel_type == "exclude") {
				RoseAbstractDumper::UnorderedRADSet abstract_methods;
				RoseHelper::get_derived_methods_from_prop (this_, _bstr_t(PROP_DERIVED_IMPLEMENT), abstract_methods);

				RoseAbstractDumper::UnorderedRADSet all_impl;
				RoseHelper::find_all_derived_impl (this_, all_impl);

				difference (abstract_methods, all_impl);
				ret->assign (abstract_methods.begin (), abstract_methods.end ());
			}
			
			RoseAbstractDumper::UnorderedRADSet self_abstract;
			RoseHelper::get_self_abstract (this_, self_abstract);
			
			std::copy (self_abstract.begin (), self_abstract.end (), std::back_inserter (*ret));			
			ret->sort (AbstractDumperBase::SortByUID ());

			return ret.forget ();
		}
	};

	ADList_aptr ret;

	if (AbstractDumper::is_functions_cache_enabled ()) {
		CleanOnStartFunctionsCache::key_type key (this, FT_GET_NOT_DERIVED_ABSTRACT);
		CleanOnStartFunctionsCache::iterator func_it = s_clean_on_start_list_functions_cache.find (key);

		if (func_it != s_clean_on_start_list_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_clean_on_start_list_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	return ret.forget ();
	//#UC END# *4B5EE7570302_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает ID страницы в конфлюенсе
const std::string RoseAbstractDumper::get_page_id () const {
	//#UC START# *4639BED10119_4571D1A5009C*
	std::string ret;
	std::string prop_id = "WikiPageID (" + AbstractDumperBase::s_current_map + ")";
	ret = this->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, prop_id
	);

	std::string::size_type pos = ret.find_last_of ("|");
	if (pos != std::string::npos) {
		ret = ret.substr (pos + 1);
	}
	return ret;
	//#UC END# *4639BED10119_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает путь страницы, прописанный в свйоствах элемента
const std::string RoseAbstractDumper::get_page_path () const {
	//#UC START# *4640808A0119_4571D1A5009C*
	std::string ret;
	std::string prop_id = "WikiPageID (" + AbstractDumperBase::s_current_map + ")";
	ret = this->get_property_value (
		std::string (_bstr_t (TOOL_NAME))
		, prop_id
	);
	
	std::string::size_type pos = ret.find_last_of ("|");
	if (pos != std::string::npos) {
		ret = ret.substr (0, pos);
	}
	return ret;
	//#UC END# *4640808A0119_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// значение рутовой дирректории для генерации
const std::string RoseAbstractDumper::get_root_dir (bool direct_get) const {
	//#UC START# *4666BC450203_4571D1A5009C*
	class local {
	public:
		static std::string impl (const RoseAbstractDumper* this_, bool direct_get) {
			if (direct_get) {
				 std::string ret = RoseHelper::get_root_dir (this_->m_rose_element);
				 if (ret != "") {
					 return ret;
				 } else {
					 return this_->get_root_dir (false);
				 }
			}

			if (this_->get_template_body().use_current_root && this_ != AbstractDumperBase::s_model_main_element) {
				return AbstractDumperBase::s_model_main_element->get_root_dir(false);
			} else {
				if (this_->get_template().main_st) {
					std::string ret = RoseHelper::get_root_dir (this_->m_rose_element);
					if (ret.empty ()) {
						std::string str ("Main element \"" + this_->get_full_name() + "\": must specify generation root dir (check MDA property)");
						throw Base::FatalError (str);
					}
					return ret;
				} else {
					const AbstractDumperBase* parent = this_->parent();
					GDS_ASSERT_MSG(parent, ("Parent can't be null"));
					if (parent) {
						return parent->get_root_dir(false);
					} else {
						return "";
					}
				}
			}
		}
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("RoseAbstractDumper::get_root_dir (bool)");
#endif
	std::string res;
	ResolveFunctionsCache::key_type key (
		this
		, BOOST_CURRENT_FUNCTION + (direct_get == true ? std::string ("|true") :std::string ("|false"))
	);
	ResolveFunctionsCache::iterator it = s_resolve_functions_cache.find (key);

	if (it != s_resolve_functions_cache.end ()) {
		res = it->second;
	} else {
		res = local::impl (this, direct_get);
		s_resolve_functions_cache[key] = res;
	}

	return res;
	//#UC END# *4666BC450203_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// возвращает информацию о ранее сгенерированном файле
AbstractDumperBase::GenSourceInfo* RoseAbstractDumper::get_self_generated_source () const {
	//#UC START# *459D2DA9011E_4571D1A5009C*
	AbstractDumperBase::GenSourceInfo* ret = 0;	
	if (m_rose_element != 0) {	
		
		AbstractDumperBase::GenSourceType srs_type = this->get_source_type ();		
		if (srs_type == AbstractDumperBase::GST_FILE) {
			std::string prop_id = "SELF GENERATED FILE (" + AbstractDumperBase::s_current_map + ")";
			std::string prop_value = this->get_property_value (
				std::string (_bstr_t (TOOL_NAME))
				, prop_id
			);

			ret = new AbstractDumperBase::GenSourceInfo;
			ret->gen_id = AbstractDumperBase::s_current_map;
			ret->source.file_name (prop_value);
		} else if (srs_type == AbstractDumperBase::GST_WIKI) {			
			std::string page_id = this->get_page_id ();
			std::string page_path = this->get_page_path ();
			if (!page_id.empty ()) {
				GenSupport::PageProxy& existent_page = GenSupport::PageProxyFactory::get (page_id.c_str ());				
				
				if (existent_page.is_new_page () == false) {
					ret = new AbstractDumperBase::GenSourceInfo;
					ret->gen_id = AbstractDumperBase::s_current_map;
					ret->source.wiki_page (&existent_page);
				} else {
					AbstractDumperBase::GenSourceInfo srs;
					srs.gen_id = AbstractDumperBase::s_current_map;
					srs.source.wiki_page (&existent_page);
					TransactionContainer::instance ()->add_source (srs);
				}
			}
		}
		
	}
	return ret;
	//#UC END# *459D2DA9011E_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// стереотип «цели» (const, var, ...)
const std::string RoseAbstractDumper::get_target_stereotype_str () const {
	//#UC START# *4666BCE003D8_4571D1A5009C*
	return RoseHelper::get_target_stereotype(this);
	//#UC END# *4666BCE003D8_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// получить юзер секцию
const AbstractDumperBase::UserCode RoseAbstractDumper::get_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
) const {
	//#UC START# *4666BEAB0138_4571D1A5009C*
	UserCode  ret;
	if (!GenSupport::EnvironmentFactory::get ().get_suppress_user_code ()) {
		GCL::StrVector strs = GCL::split_string_by_fragment (uc_id.data(), '*', '*');
		std::string guid = strs[0];
		guid.erase (12);
		
		RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (guid);
		if (rad) {
			std::string prop_id = gen_id + ":" + uc_id;
			std::string uc = rad->get_property_value (
				std::string (_bstr_t (TOOL_NAME))
				, prop_id
			);

			GCL::replace_char(uc, ret, ROSE_NEWLINE_REPLACEMENT, "\n");			
		} else {
			//missed item for UC
		}			
	}
	return ret;
	//#UC END# *4666BEAB0138_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// выводит значение пользовательского свойства «prop_name»
const std::string RoseAbstractDumper::get_user_property_str (const std::string& prop_name) const {
	//#UC START# *4666BC09003E_4571D1A5009C*
	std::string ret = this->get_property_value (
		std::string (_bstr_t (Base::USER_PROPERTY_TOOL))
		, prop_name
	);
	
	if (ret.empty ()) {
		const AbstractDumperBase::StereotypeID& model_stereotype (this->get_model_stereotype_str ());

		const AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (model_stereotype);
		if (tpl.user_properties_group.is_nil () == false) {
			AbstractDumperBase::UserPropertyMap props;
			tpl.user_properties_group->for_each (
				AbstractDumperBase::CollectUserProperty ()
				, props
			);
			AbstractDumperBase::UserPropertyMap::iterator it = props.find (prop_name);
			if (it != props.end ()) {
				ret = it->second.def_value;
			}
		}			
	}
	return ret;
	//#UC END# *4666BC09003E_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// строка определяющая видимость элемента.
// Может принимать значения: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
const std::string RoseAbstractDumper::get_visability_str () const {
	//#UC START# *4666BAC60177_4571D1A5009C*
	return RoseHelper::get_visibility_type(this);
	//#UC END# *4666BAC60177_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// удаляет из модели информацию об ранее сгенерированном источнике артефакта, возвращает true в
// случае успеха.
bool RoseAbstractDumper::remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5AE03B9_4571D1A5009C*
	bool res = false;
	if (src.source.d_() == GST_WIKI) {
		//if wiki - remove PageId
		if (src.source.wiki_page () != 0) {
			std::string prop_id = "WikiPageID (" + src.gen_id + ")";

			/*CORBA::String_var self = src.source.wiki_page ()->get_guid ();
			CORBA::String_var path = src.source.wiki_page ()->get_path ();
			std::string page_path = path.in ();
			std::string self_id = self.in ();*/

			std::string page_path (src.source.wiki_page ()->get_guid ());
			std::string self_id (src.source.wiki_page ()->get_path ());
			
			std::string self_prop_value = this->get_property_value (
				std::string (_bstr_t (TOOL_NAME))
				, prop_id
			);

			std::string self_prop_page_id;
			std::string self_prop_page_path;
			AbstractDumperBase::extract_from_page_property (
				self_prop_value
				, self_prop_page_id
				, self_prop_page_path
			);

			if (self_prop_page_id == self_id && self_prop_page_path == page_path) {			
				RoseHelper::write_property_with_lock (
					m_rose_element
					, prop_id
					, ""
					, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
					, true
					, std::string ("Removed generated source: ") + prop_id
				);
			}
			prop_id = "NESTED GENERATED WikiPageID (" + src.gen_id + ")";
			
			std::string nested_files = this->get_property_value (
				std::string (_bstr_t (TOOL_NAME))
				, prop_id
			);
			
			boost::char_separator<char> sep (";", "", boost::drop_empty_tokens);
			typedef boost::token_iterator_generator<boost::char_separator<char>>::type TokenIter;

			TokenIter tok = boost::make_token_iterator<std::string> (
				nested_files.begin(), nested_files.end(), sep
			);

			TokenIter tok_end = boost::make_token_iterator<std::string> (
				nested_files.end(), nested_files.end(), sep
			);

			GCL::StrSet updated_pages;

			for (; tok != tok_end; ++tok) {
				GCL::StrVector parts = GCL::split_string_by_sub_string (tok->data(), "::");
				if (parts.empty () == false) {
					std::string page_id_from_prop = parts[0];
					std::string page_path_from_prop = parts[0];
					AbstractDumperBase::extract_from_page_property (
						parts[0]
						, page_id_from_prop
						, page_path_from_prop
					);
					if (
						page_path_from_prop != page_path 
						&& self_id != page_id_from_prop
					) {
						updated_pages.insert (*tok);
					}
				}
			}
			res = RoseHelper::write_property_with_lock (
				m_rose_element
				, prop_id
				, GCL::join (updated_pages, ";")
				, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
				, true
				, std::string ("Removed generated source: ") + prop_id
			);

		}		
	} else if (src.source.d_() == GST_FILE) {
		std::string prop_id = "SELF GENERATED FILE (" + src.gen_id + ")";
		if (
			src.source.file_name() == this->get_property_value (std::string (_bstr_t (TOOL_NAME)), prop_id)
		) {
			RoseHelper::write_property_with_lock (
				m_rose_element
				, prop_id
				, ""
				, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
				, true
				, std::string ("Removed generated source: ") + prop_id
			);
		}
		prop_id = "NESTED GENERATED FILES (" + src.gen_id + ")";
		std::string nested_files = this->get_property_value (std::string (_bstr_t (TOOL_NAME)), prop_id);

		boost::char_separator<char> sep (",;", "", boost::drop_empty_tokens);
		typedef boost::token_iterator_generator<boost::char_separator<char>>::type TokenIter;

		TokenIter tok = boost::make_token_iterator<std::string> (
			nested_files.begin(), nested_files.end(), sep
		);

		TokenIter tok_end = boost::make_token_iterator<std::string> (
			nested_files.end(), nested_files.end(), sep
		);

		GCL::StrSet updated_files;

		for (; tok != tok_end; ++tok) {
			GCL::StrVector parts = GCL::split_string_by_sub_string (tok->data(), "::");

			if (parts.empty () == false && parts[0] != src.source.file_name()) {
				updated_files.insert (*tok);
			}
		}
		res = RoseHelper::write_property_with_lock (
			m_rose_element
			, prop_id
			, GCL::join (updated_files, ";")
			, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
			, true
			, std::string ("Removed generated source: ") + prop_id
		);		
	}

	return res;
	//#UC END# *45C9F5AE03B9_4571D1A5009C*
}

// implemented method from AbstractDumperBase
// записывает на модели информацию о сгенерированном файле, возвращает true в случае успеха.
bool RoseAbstractDumper::set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5490109_4571D1A5009C*
	bool res = false;
	std::string prop_id;
	std::string prop_value;

	if (src.source.d_() == AbstractDumper::GST_WIKI) {				
		/*CORBA::String_var page_path = src.source.wiki_page ()->get_path ();
		CORBA::String_var page_id = src.source.wiki_page ()->get_guid ();*/

		prop_id = "WikiPageID (" + src.gen_id + ")";
		prop_value = AbstractDumperBase::create_page_property (
			src.source.wiki_page ()->get_guid ().c_str (), src.source.wiki_page ()->get_path ().c_str ()
		);

	} else if (src.source.d_() == AbstractDumper::GST_FILE) {
		prop_id = "SELF GENERATED FILE (" + src.gen_id + ")";
		prop_value = src.source.file_name ();		
	}

	res = RoseHelper::write_property_with_lock (
		m_rose_element
		, prop_id
		, prop_value
		, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
		, true
		, std::string ("Generated source: ") + prop_id
	);
	
	//прописываем тип сгенерённого артефакта
	prop_id = std::string ("SourceType (" + src.gen_id + ")");
	prop_value = (AbstractDumperBase::SourceTypeConvertorSingleton::instance ()->get (src.source.d_()));

	res |= RoseHelper::write_property_with_lock (
		m_rose_element
		, prop_id
		, prop_value
		, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
		, true
		, std::string ("Generated source: ") + prop_id
	);

	return res;
	//#UC END# *45C9F5490109_4571D1A5009C*
}

// implemented method from Base::NamedElement
// возвращает полное имя элемента
const std::string RoseAbstractDumper::get_full_name () const {
	//#UC START# *4AF93E9E0166_4571D1A5009C*
#if !defined(GDS_NLOG_DEBUG) || defined(FORCE_STOP_WARCH)
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	class local {
	public:
		static std::string impl (const AbstractDumperBase* this_) {
			std::string ret;
			
			const AbstractDumper* parent = dynamic_cast<const AbstractDumper*> (this_->parent ());
			if (parent) {
				ret = parent->get_full_name ();
				ret += "::";
				ret += this_->get_name_str();
			} else {
				ret = this_->get_name_str();
			}
			
			return ret;
		}
	};

	std::string res;
	StringResultCache::key_type key (this);
	StringResultCache::iterator it = s_get_full_name_cache.find (key);

	if (it != s_get_full_name_cache.end ()) {
		res = it->second;
	} else {
		res = local::impl (this);
		s_get_full_name_cache[key] = res;
	}

	return res;
	//#UC END# *4AF93E9E0166_4571D1A5009C*
}

// implemented method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseAbstractDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4571D1A5009C*
	class local {
	public:
		static void link_set_exception (RoseAbstractDumper* rad) {
			link_exceptions (rad, PROP_ATTR_SET_RAISES, ST_SET_EXCEPTION);
		}
		static void link_get_exception (RoseAbstractDumper* rad) {
			link_exceptions (rad, PROP_ATTR_GET_RAISES, ST_GET_EXCEPTION);
		}
	private:
		static void link_exceptions (
			RoseAbstractDumper* rad
			, const _bstr_t& ex_prop_key
			, const std::string& link_stereotype
		) {
			IRoseElementPtr elem = rad->rose_element ();
			IRoseModelPtr model = elem->Model;
			GCL::StrVector exceptions = GCL::split_string_by(
				rad->get_property_value (
					std::string (_bstr_t (TOOL_NAME))
					, std::string (_bstr_t (ex_prop_key))
				).c_str ()
				, ','
			);

			for (GCL::StrVector::const_iterator it = exceptions.begin(); it != exceptions.end(); it++) {
				std::string uid = (*it);
				IRoseItemPtr item = model->FindClassWithID (uid.data());
				if (item != 0) {
					rad->add_supplier (RoseAbstractDumper::find_in_tree (item), ST_NAVIGABLE, link_stereotype);		
				}
			}
		}
	};
	this->clear_suppliers ();
	const AbstractDumperBase::Template& tpl = this->get_template ();	

	if (tpl.has_set_except) {
		local::link_set_exception (this);		
	}

	if (tpl.has_get_except) {
		local::link_get_exception (this);		
	}
	//#UC END# *465E57F1029F_4571D1A5009C*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumper
// инициирует удаление элемента из кэшей
void RoseAbstractDumper::delete_from_cache () const {
	//#UC START# *4C219598003F_4571D1A5009C*
	RADSet wrappers;
	for (
		WrappersMap::const_iterator it = m_wrappers.begin (), it_end = m_wrappers.end ()
		; it != it_end
		; ++it
		) {
			const RoseAbstractDumper* wrapper = it->second.ptr ();
			if (wrapper) {
				wrappers.insert (wrapper);
			}
	}

	std::for_each (wrappers.begin (), wrappers.end (), std::mem_fun (&RoseAbstractDumper::delete_from_cache));

	AbstractDumper::delete_from_cache ();
	//#UC END# *4C219598003F_4571D1A5009C*
}

// overloaded method from AbstractDumper
// метод вызываемые на каждом элементе перед запуском спела)
void RoseAbstractDumper::spell_generation_prepare () {
	//#UC START# *4AFD27ED017D_4571D1A5009C*
	AbstractDumper::spell_generation_prepare ();
	m_temporary_properties.clear ();
	
	std::set<RoseAbstractDumper*> wrappers;
	for (
		WrappersMap::iterator it = m_wrappers.begin (), it_end = m_wrappers.end ()
		; it != it_end
		; ++it
		) {
			RoseAbstractDumper* wrapper = it->second.ptr ();
			if (wrapper) {
				wrappers.insert (wrapper);
			}
	}

	std::for_each (wrappers.begin (), wrappers.end (), std::mem_fun (&RoseAbstractDumper::spell_generation_prepare));
	//#UC END# *4AFD27ED017D_4571D1A5009C*
}

// overloaded method from AbstractDumperBase
// очищаем список связанных элементов
void RoseAbstractDumper::clear_var_dumpers (AbstractDumperBase::LocalVarType type) const {
	//#UC START# *4B21183703AA_4571D1A5009C*
	for (
		WrappersMap::const_iterator it = m_wrappers.begin (), it_end = m_wrappers.end ()
		; it != it_end
		; ++it
		) {
			const RoseAbstractDumper* wrapper = it->second.ptr ();
			if (wrapper) {
				wrapper->clear_var_dumpers (type);
			}
	}

	AbstractDumperBase::clear_var_dumpers (type);
	//#UC END# *4B21183703AA_4571D1A5009C*
}

// overloaded method from AbstractDumperBase
// порядковый номер элемента (устанавливается ОДИН раз при построении дерева генерации и хранится в
// модели)
unsigned long long RoseAbstractDumper::elem_creation_order () const {
	//#UC START# *4CA290A1031C_4571D1A5009C*
	return m_creation_order;
	//#UC END# *4CA290A1031C_4571D1A5009C*
}

// overloaded method from AbstractDumperBase
// порядковый номер элемента (устанавливается при построении дерева генерации)
unsigned int RoseAbstractDumper::elem_order () const {
	//#UC START# *4C174C9C0184_4571D1A5009C*
	return m_elem_order;
	//#UC END# *4C174C9C0184_4571D1A5009C*
}

// overloaded method from AbstractDumperBase
// regular/abstract/final - тип абстрактности элемента.
const std::string RoseAbstractDumper::get_abstract_str () const {
	//#UC START# *4666BBA801A5_4571D1A5009C*
	return RoseHelper::get_abstraction_type_str (this);
	//#UC END# *4666BBA801A5_4571D1A5009C*
}

// overloaded method from AbstractDumperBase
// возвращает тип сгенерированного артефакта
AbstractDumperBase::GenSourceType RoseAbstractDumper::get_source_type () const {
	//#UC START# *46678170007D_4571D1A5009C*
	std::string prop_id ("SourceType (");
	prop_id += AbstractDumperBase::s_current_map + ")";
	
	std::string source_type = this->get_property_value (std::string (_bstr_t (TOOL_NAME)), prop_id);
	
	AbstractDumperBase::GenSourceType type = AbstractDumperBase::GST_FILE;
	
	if (source_type.empty () && AbstractDumperBase::s_current_map == "wiki") {
		type = AbstractDumperBase::GST_WIKI;
	} else {
		try {
			type = AbstractDumperBase::SourceTypeConvertorSingleton::instance ()->get (source_type);
		} catch (Core::ElementNotFound&) {
			//временная заточка нужна для того, чтобы прописать 
			//свойство в модель для старых элементов)
			if (AbstractDumperBase::s_current_map == "wiki") {
				type = AbstractDumperBase::GST_WIKI;
			}
		}
	}

	return type;
	//#UC END# *46678170007D_4571D1A5009C*
}

// overloaded method from AbstractDumperBase
// возвращает стереотип элемента
const std::string RoseAbstractDumper::get_stereotype_str () const {
	//#UC START# *465FE0B403D8_4571D1A5009C*
	return m_rose_element->IsClass (ROSE_ITEM_TYPE) 
		? (const char*)((IRoseItemPtr)m_rose_element)->Stereotype 
		: "";
	//#UC END# *465FE0B403D8_4571D1A5009C*
}

// overloaded method from ObjectTreeResolver
// уровень видимости детей, если -1 - значит уровень не задан
int RoseAbstractDumper::get_childs_visibility_level () const {
	//#UC START# *4AAF10C300D1_4571D1A5009C*
	return ModelPropertiesHelperFactory::get ().get_visibility_level (m_rose_element);
	//#UC END# *4AAF10C300D1_4571D1A5009C*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

