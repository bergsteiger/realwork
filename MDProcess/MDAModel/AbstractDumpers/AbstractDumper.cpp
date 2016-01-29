////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumper
//
// Класс реализующий основную логику Дампера, не зависящую от реализации конткретной модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"
#include "MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"

//#UC START# *4571A2CB02DE_CUSTOM_INCLUDES*
#include <algorithm>
#include <fstream>
#include <string>
#include <strstream>
#include <limits>
#include <map>

#include "shared/GCL/alg/CycleChecker.h"
#include "shared/GCL/data/OnDemandFile.h"
#include "shared/GCL/os/dir_op.h"
#include "shared/GCL/alg/sorting.h"
#include "shared/GCL/str/str_op.h"
#include "shared/GCL/os/FileOp.h"
#include "SyntaxDef.h"
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/timer.hpp>
#include "shared/GCI/ResourceInfo/ResourceInfo.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
//#UC END# *4571A2CB02DE_CUSTOM_INCLUDES*


//#UC START# *4571A2CB02DE*
typedef GCL::CycleChecker<const AbstractDumper*> GetFixedSizeCC;
GetFixedSizeCC g_get_fixed_size_cc;
//AbstractDumper::PostGenData AbstractDumper::s_stat;
AbstractDumper::IsFixedTypeMap AbstractDumper::s_is_fixed_type_map;
AbstractDumper::FunctionsCache AbstractDumper::s_functions_cache;
AbstractDumper::CleanOnStartFunctionsCache AbstractDumper::s_clean_on_start_list_functions_cache;

int odp_compare_adapter (const void *a1, const void *a2) {
	AbstractDumperBase** adb_x = (AbstractDumperBase**)a1;
	AbstractDumperBase** adb_y = (AbstractDumperBase**)a2;

	ObjectTreeResolver* x = dynamic_cast<ObjectTreeResolver*> (*adb_x);
	ObjectTreeResolver* y = dynamic_cast<ObjectTreeResolver*> (*adb_y);
	
	return ObjectTreeResolver::odp_compare (x, y);
}

int adb_cvar_compare_adapter (const void *a1, const void *a2) {
	AbstractDumperBase_cvar* adb_cvar_x = (AbstractDumperBase_cvar*)a1;
	AbstractDumperBase_cvar* adb_cvar_y = (AbstractDumperBase_cvar*)a2;

	GDS_ASSERT((adb_cvar_x && adb_cvar_y));

	const AbstractDumperBase* adb_x = adb_cvar_x->ptr ();
	const AbstractDumperBase* adb_y = adb_cvar_y->ptr ();

	return odp_compare_adapter (&adb_x, &adb_y);
}

int adb_compare_by_order (const AbstractDumperBase* adb_x, const AbstractDumperBase* adb_y) {
	GDS_ASSERT((adb_x && adb_y));

	return adb_x->elem_order () > adb_y->elem_order ()
		? 1
		: adb_x->elem_order () < adb_y->elem_order ()
			? - 1
			: 0;
}

int adb_cvar_compare_by_order (const void *a1, const void *a2) {
	AbstractDumperBase_cvar* adb_cvar_x = (AbstractDumperBase_cvar*)a1;
	AbstractDumperBase_cvar* adb_cvar_y = (AbstractDumperBase_cvar*)a2;

	GDS_ASSERT((adb_cvar_x && adb_cvar_y));

	return adb_compare_by_order (adb_cvar_x->ptr (), adb_cvar_y->ptr ());
}

int compare_by_order (const void *a1, const void *a2) {
	AbstractDumperBase** adb_x = (AbstractDumperBase**)a1;
	AbstractDumperBase** adb_y = (AbstractDumperBase**)a2;
	
	GDS_ASSERT((adb_x && adb_y));

	return adb_compare_by_order (*adb_x, *adb_y);
}

//сортировка по порядку создания элемента
int adb_compare_by_creation_order (const AbstractDumperBase* adb_x, const AbstractDumperBase* adb_y) {
	GDS_ASSERT((adb_x && adb_y));

	return adb_x->elem_creation_order () > adb_y->elem_creation_order ()
		? 1
		: adb_x->elem_creation_order () < adb_y->elem_creation_order ()
		? - 1
		: 0;
}

int compare_by_creation_order (const void *a1, const void *a2) {
	AbstractDumperBase** adb_x = (AbstractDumperBase**)a1;
	AbstractDumperBase** adb_y = (AbstractDumperBase**)a2;

	GDS_ASSERT((adb_x && adb_y));

	return adb_compare_by_creation_order (*adb_x, *adb_y);
}

int adb_cvar_compare_by_creation_order (const void *a1, const void *a2) {
	AbstractDumperBase_cvar* adb_cvar_x = (AbstractDumperBase_cvar*)a1;
	AbstractDumperBase_cvar* adb_cvar_y = (AbstractDumperBase_cvar*)a2;

	GDS_ASSERT((adb_cvar_x && adb_cvar_y));

	return adb_compare_by_creation_order (adb_cvar_x->ptr (), adb_cvar_y->ptr ());
}

//функтор - возвращает true, если элемент можно генерировать (выставлен соответствующий генератор)
class not_accepted_gen: public std::unary_function<const AbstractDumperBase*, bool> {
public:
	bool operator () (const AbstractDumperBase* arg) {
		return !arg->accepted_generator();
	}
};

class not_accepted_gen_with_target: public std::unary_function<const AbstractDumperBase*, bool> {
public:
	bool operator () (const AbstractDumperBase* arg) {
		const AbstractDumperBase* targ = arg->get_target ();
		if (arg->accepted_generator() && (!targ || targ->accepted_generator())) {
			return false;
		} else {
			return true;
		}
	}
};

struct CacheCleaner {
	template <class CacheType>
	static void apply (const AbstractDumperBase* adb, CacheType& cache) {
		typedef typename CacheType::iterator CacheIterator;
		CacheIterator it = cache.begin ();
		CacheIterator it_end = cache.end ();

		for (; it != it_end;) {
			if (it->first.first == adb) {
				cache.erase (it++);
			} else {
				//также нужно удалить кэш везде, где использовался элемент:
				AbstractDumperBase::ADList::const_iterator adb_it = std::find (
					it->second.begin ()
					, it->second.end ()
					, adb
				);
				if (adb_it != it->second.end ()) {
					cache.erase (it++);
				} else {
					++it;
				}
			}
		}
	}
};

AbstractDumperBase::ADList* AbstractDumper::get_req_generalizator_impl () const {
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_consumer_by_stereotype (ST_LINK_INH);
			AbstractDumperBase::ADList_aptr ret (new ADList ());

			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {	
				const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*it);
				/*if (p->accepted_generator())*/ {
					ret->push_back (p);
					
					ADList_aptr nr;
					if (AbstractDumper::is_functions_cache_enabled ()) {
						FunctionsCache::key_type key (p, FT_GET_REQ_GENERALIZATOR);
						FunctionsCache::iterator func_it = s_functions_cache.find (key);

						if (func_it != s_functions_cache.end ()) {
							nr = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
						} else {
							nr = local::impl (p);
							(s_functions_cache[key]).assign (nr->begin (), nr->end ());
						}
						ret->insert(ret->end(), nr->begin(), nr->end());
					} else {
						nr = local::impl (p);
					}
				}
			}

			return ret._retn ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	AbstractDumperBase::ADList_aptr ret;
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_REQ_GENERALIZATOR/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}

	return ret._retn ();
}
///////////////////////////////////////////////////////////////////////
// contructor/destructor
///////////////////////////////////////////////////////////////////////

void AbstractDumper::init (const AbstractDumper * parent ) {
	class local {
	public:
		static const AbstractDumperBase::TemplateBody& get_tpl_body (
			AbstractDumperBase::Templates::iterator tpl_it
			, AbstractDumperBase::Templates::iterator def_tpl_it
			, const AbstractDumperBase::GenID& gen_id
		) {
			if (tpl_it != def_tpl_it) {
				AbstractDumperBase::GT_map::iterator gen = tpl_it->second.generators.find (gen_id);
				if (gen != tpl_it->second.generators.end()) {
					return gen->second;
				}
			}

			return def_tpl_it->second.generators[gen_id];
		}
	};

	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);	

	ObjectTreeResolver::init(parent);	
	
	// инициализирует внутренний кэш элемента: флаг -
	// генерится ли с элемента файл (выставляется при наличии соответствующей команды в шаблоне),
	// величину отступа для команды "#"
	{
		AbstractDumperBase::Templates::iterator it_tpl = s_templates.find (get_model_stereotype_str ());
		AbstractDumperBase::Templates::iterator def_it_tpl = s_templates.find (AbstractDumperBase::DEFAULT_STEREOTYPE_ID);	
		if (it_tpl == AbstractDumperBase::s_templates.end ()) {
			it_tpl = def_it_tpl;
		}
		
		GenInfos::iterator it = s_gen_infos.begin();
		GenInfos::iterator it_end = s_gen_infos.end();
		for (; it != it_end; it++) {
			OutputDesc& output_desc = m_outputs[it->first];
			if (parent) {
				OutputDesc& parent_output_desc = parent->m_outputs[it->first];
				output_desc.intend = parent_output_desc.is_plain
					? parent_output_desc.intend
					: parent_output_desc.intend + 1;
			}
			const AbstractDumperBase::TemplateBody& tpl_body = local::get_tpl_body (it_tpl, def_it_tpl, it->first);
			output_desc.own_output = tpl_body.file_create;
			output_desc.is_plain = tpl_body.plain;
		}
	}

	if (parent) {
		this->check_perent_st_constraint ();
	}
}

///////////////////////////////////////////////////////////////////////
// method implementation
///////////////////////////////////////////////////////////////////////

void AbstractDumper::check_perent_st_constraint () const {

	if (!this->check_stereotype_use ()) {
		std::string str ("Illegal use of stereotype <<");
		str += this->get_model_stereotype_str();;
		str += ">>";		
		this->write_error_log (str.data(), false);
	}	
}

bool AbstractDumper::is_child_of (const AbstractDumperBase* parent) const {
	if (s_tree) {
		const AbstractDumper* ad_parent = dynamic_cast<const AbstractDumper*> (parent);
		return s_tree->is_child_of_parent(this, ad_parent);
	}
	return false;
}

//AbstractDumperBase::GenFileMap g_saved_generated_files;

const RegistredSupplierSt g_registred_supplier;

void AbstractDumper::collect_include (OTRSet& col) const {
	{
		OTRSet sups = this->get_supplier_by_stereotypes(g_registred_supplier);
		for (OTRSet::iterator it = sups.begin(); it != sups.end(); it++) {
			const AbstractDumper* rad = dynamic_cast<const AbstractDumper*>(*it);
			while (rad) {
				if (!rad->create_file_name_str ().empty ()) {
					col.insert (rad);
					break;
				}
				rad = dynamic_cast<const AbstractDumper*>(rad->parent());
			}
		}
	}

	ObjectTree::Items ch = s_tree->childs (this);
	for ( ObjectTree::Items::iterator it = ch.begin(); it != ch.end(); it++ ) {
		const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*(*it));
		p->collect_include ( col );
	}
}

void AbstractDumper::collect_all_include (OTRSet& col) const {
	OTRSet prev = col;
	this->collect_include (col);
	
	for (OTRSet::iterator it = col.begin(); it != col.end(); it++) {
		if (prev.find(*it) == prev.end()) {
			dynamic_cast<const AbstractDumper*>(*it)->collect_all_include(col);
		}
	}
}



bool AbstractDumper::is_it_registred_supplied_by (const ObjectTreeResolver* supplier) const {
	OTRSet supps = this->get_all_suppliers();

	for (OTRSet::const_iterator it = supps.begin(); it != supps.end(); it++) {
		if (*it == supplier) {
			if (AbstractDumper::is_it_registred(this->get_model_stereotype_str())) {
				return true;
			}
		}
	}

	ObjectTree::Items ch = s_tree->childs (this);
	for ( ObjectTree::Items::iterator it = ch.begin(); it != ch.end(); it++ ) {
		const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*(*it));
		if (p->is_it_registred_supplied_by (supplier)) {
			return true;
		}
	}

	return false;
}

void AbstractDumper::add_diagram(AbstractDumperBase* ad) {
	m_diagrams.push_back(ad);
}

void AbstractDumper::collect_reqursive_generalization (OTRSet& res) const {
	OTRSet supp = get_supplier_by_stereotype (ST_LINK_INH);
			
	for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {	
		const AbstractDumper* ad = dynamic_cast<const AbstractDumper*>(*it);
		if (ad/* && ad->accepted_generator()*/) {			
			res.insert(*it);
			ad->collect_reqursive_generalization (res);
		}
	}	
}

void AbstractDumper::collect_reqursive_dependences (OTRSet& res) const {
	OTRSet supp = this->get_supplier_by_stereotype (ST_LINK_DEP);
			
	for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
		const AbstractDumper* ad = dynamic_cast<const AbstractDumper*>(*it);
		if (ad/* && ad->accepted_generator()*/) {			
			if (res.insert(*it).second) {
				//TRACE ("collect_reqursive_dependences insert %s\n", dynamic_cast<const AbstractDumper*>(*it)->get_full_name().data());
				ad->collect_reqursive_dependences (res);
			}
		}
	}	
}

void AbstractDumper::collect_requrcive_all_consumers (OTRSet& col) const {
	for (Consumer_set::const_iterator it = m_consumers.begin(); it != m_consumers.end(); it++) {
		const AbstractDumper* ad = dynamic_cast<const AbstractDumper*>(it->consumer);
		std::string mcs = ad->get_model_class_str ();
		if (
			mcs == "Operation" 
			|| mcs == "Attribute"
			|| mcs == "Parameter"
			|| mcs == "Dependency"
		) {
			ad = dynamic_cast<const AbstractDumper*>(ad->parent ());
		}
		/*if (ad->accepted_generator())*/ {
			if (col.insert (ad).second) {
				ad->collect_requrcive_all_consumers (col);
			}
		}
	}
}


std::ostream* AbstractDumper::output () const {
	return m_outputs[s_current_map].file;
}

std::string AbstractDumper::file_name () const {
	std::string ret;
	OutputMap::const_iterator it = m_outputs.find(s_current_map);
	if (it != m_outputs.end()) {
		ret = (*it).second.file_name;
	}
	
	return ret;
}

const std::string AbstractDumper::temp_file_name () const {
	std::string ret;
	OutputMap::const_iterator it = m_outputs.find(s_current_map);
	if (it != m_outputs.end()) {
		ret = (*it).second.temp_file_name;
	}
	
	return ret;
}

void AbstractDumper::own_output (bool oo) {
	m_outputs[s_current_map].own_output = oo;
}

unsigned AbstractDumper::intend () const {
	unsigned  ret = false;
	OutputMap::const_iterator it = m_outputs.find(s_current_map);
	if (it != m_outputs.end()) ret = (*it).second.intend;
	
	return ret;
}

void AbstractDumper::inc_intend () {
	m_outputs[s_current_map].intend++;
}

void AbstractDumper::dec_intend () {
	m_outputs[s_current_map].intend--;
}

bool AbstractDumper::is_type_fixed_size () const {		
	IsFixedTypeMap::iterator is_fixed_it = s_is_fixed_type_map.find (this);
	if (is_fixed_it == s_is_fixed_type_map.end ()) {
		// check self
		TemplatePainter::TPArgs args;
		args.push_back(this);
		std::ostrstream resolve;
		TemplatePainter tp (args, resolve, this, NULL);
		GCL::StrVector params;
		params.push_back("%S");
		AbstractDumperBase::TransformatorID fixed_type_id ("_fixed_type");
		std::string trans = tp.transform (fixed_type_id, params);
		if (trans == "true") {
			is_fixed_it = s_is_fixed_type_map.insert (
				IsFixedTypeMap::value_type (this, true)
			).first;
			return true;
		} else if (trans == "false") {
			is_fixed_it = s_is_fixed_type_map.insert (
				IsFixedTypeMap::value_type (this, false)
			).first;
			return false;
		} 

		GetFixedSizeCC::Iteration iteration (g_get_fixed_size_cc, this);
		if (iteration.is_cycled()) {
			is_fixed_it = s_is_fixed_type_map.insert (
				IsFixedTypeMap::value_type (this, false)
			).first;
			return false;
		}
		
		bool constructed_type = false;

		// check childs
		{
			ObjectTree::Items items = s_tree->childs ((AbstractDumper*)this);
			if (items.size() != 0) {
				for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
					const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*(*it));
					if (!p->is_type_fixed_size()) {
						is_fixed_it = s_is_fixed_type_map.insert (
							IsFixedTypeMap::value_type (this, false)
						).first;
						return false;				
					}
				}
				constructed_type = true;
			} 
		}

		// check target
		{
			const AbstractDumper* target = dynamic_cast<const AbstractDumper*>(this->get_target());
			if (target) {
				if (!target->is_type_fixed_size()) {
					is_fixed_it = s_is_fixed_type_map.insert (
						IsFixedTypeMap::value_type (this, false)
					).first;
					return false;				
				}
				constructed_type = true;
			}
		}
		
		// check realizations
		{
			AbstractDumper::ADList_aptr ad_list = this->get_realizations();
			if (ad_list->size() != 0) {
				for (ADList::iterator it = ad_list->begin(); it != ad_list->end(); it++) {
					const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*it);
					if (!p->is_type_fixed_size()) {
						is_fixed_it = s_is_fixed_type_map.insert (
							IsFixedTypeMap::value_type (this, false)
						).first;
						return false;
					}
				}
				constructed_type = true;
			}
		}

		// check generalizations
		{
			AbstractDumper::ADList_aptr ad_list = this->get_generalizations();	
			if (ad_list->size() != 0) {
				for (ADList::iterator it = ad_list->begin(); it != ad_list->end(); it++) {
					const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*it);
					if (!p->is_type_fixed_size()) {
						is_fixed_it = s_is_fixed_type_map.insert (
							IsFixedTypeMap::value_type (this, false)
						).first;
						return false;
					}
				}
				constructed_type = true;
			}
		}
		is_fixed_it = s_is_fixed_type_map.insert (
			IsFixedTypeMap::value_type (this, constructed_type)
		).first;
		return constructed_type;
	}
	return is_fixed_it->second;
}

typedef std::pair<const AbstractDumper*, AbstractDumperBase::GenID> OutputFilesValue;
typedef std::set<OutputFilesValue> OutputFilesValues;
typedef std::map <std::string, OutputFilesValues> OutputFilesMap;

static OutputFilesMap s_all_output_files;

std::ostream* AbstractDumper::get_output () const {
	if (own_output()) {
		if (!m_outputs[s_current_map].file) {
						
			std::string conf_flag =  this->get_root_dir (false);		
			conf_flag += STR_CONF_FLAG;

			std::string file_name = create_file_name ();
			
			std::string::size_type pos = -1;
			pos = file_name.find (conf_flag);
			if (pos != std::string::npos) {
				//генерим в конфлюенс				
				std::string file_path = file_name.substr (pos + conf_flag.length () + 1);				
				
				GCL::StrVector splited_path = GCL::split_string_by (file_path.c_str (), '/');
				GCL::StrVector::size_type path_size = splited_path.size ();
				
				std::string name = splited_path[path_size - 2];
				std::string::size_type pos = name.find_last_of (":");			
				
				if (pos != std::string::npos) {
					name = name.substr (0, pos);
				}

				if (splited_path[path_size - 1] == name) {
					splited_path[path_size - 2] = name;
					splited_path.pop_back ();												
				} else {
					std::string mess ("Wrong page path: ");
					mess += file_path;
					mess += "\r\n, page name (\"output\") must be equal last page name in \"output category template\":";
					mess += "\r\n\"";
					mess += splited_path[path_size - 1];
					mess += "\" must be equal \"";
					mess += name;
					mess += "\"";

					GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
					GenSupport::LogManagerFactory::get ().log_error (mess);
				}
				ACE_TCHAR filename_[MAXPATHLEN + 1];
				// Create a temporary file.				 				
				std::string templ = this->get_model_unique_id_str ();
				std::string fpath;
				if (ACE::get_temp_dir (filename_, MAXPATHLEN) != -1) {					
					fpath = filename_ + templ + s_current_map + ".txt";					
				}
				std::ofstream* new_stream = new std::ofstream(
					fpath.data()
					, std::ios_base::out
				);				
				m_outputs[s_current_map].file = new_stream;
				m_outputs[s_current_map].temp_file_name = fpath;
				file_path = STR_CONF_FLAG;
				file_path += "//";
				file_path += GCL::join (splited_path, "/");				
				m_outputs[s_current_map].file_name = file_path;
				
			} else {				
				m_outputs[s_current_map].file_name = file_name;
				if (m_outputs[s_current_map].file_name.empty ()) {
					goto NO_OUTPUT;
				}

				FILE* file = fopen (m_outputs[s_current_map].file_name.c_str(), "rt");
				if (file) {
					// ранее созданный файл
					try {
						this->load_user_code (file, m_outputs[s_current_map].file_name);
					} catch (Base::MultipleUCSections& ex) {
						fclose (file);
						std::string message (ex.what ());
						message += " in file (" + m_outputs[s_current_map].file_name + ")";

						GenSupport::ErrorManagerFactory::get ().fatal_error (this, message, GDS_CURRENT_FUNCTION);
						GenSupport::LogManagerFactory::get ().log_error (message);
					} catch (...) {
						fclose(file);
						throw;
					}

					fclose (file);
				} 
			
				// Создаем полный путь
				GCL::create_tree_dirs (m_outputs[s_current_map].file_name.c_str(), true);					
				
				std::string tmp_gen_file = create_gen_file_name (m_outputs[s_current_map].file_name);
				std::ofstream* new_file = new std::ofstream(
					tmp_gen_file.data()
					, std::ios_base::out
				);
				
				if (!new_file->is_open ()) {
					std::string mess ("Can't open output file ");
					mess += tmp_gen_file;
					
					GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
					GenSupport::LogManagerFactory::get ().log_error (mess);
				}
				m_outputs[s_current_map].file = new_file;
			}

			if (m_outputs[s_current_map].file) {
				OutputFilesValue value (this, s_current_map);
				s_all_output_files[m_outputs[s_current_map].file_name].insert (value);
			}
		}
		return m_outputs[s_current_map].file;
	}

NO_OUTPUT:
	if (this != AbstractDumperBase::s_gen_root_element && parent()) {
		return parent()->get_output();
	} else {
		m_outputs[s_current_map].file = new std::strstream; //garbage stream
		m_outputs[s_current_map].own_output = true;
		return m_outputs[s_current_map].file;
	}	
}

void AbstractDumper::add_sequence (ADVector asds) {
	if (asds.size()) {
		if (m_activity_seq.size() > 0) {
			std::string mess ("Different sequence for one model opeartion \"");
			mess += this->get_name_str();
			mess += "\"";
			
			this->write_error_log (mess, false);
		} else {
			m_activity_seq = asds;
		}
	}
}

AbstractDumperBase::ADList* AbstractDumper::get_sorted_childs () const {
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());

			ObjectTree::Items items = s_tree->childs (this_);
			if (!items.empty ()) {
				GCL::uqsort (&(*items.begin()), items.size(), sizeof(ObjectTree::Item_ptr), odp_compare_ex);			
				
				for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
					const ObjectTreeResolver* otr = *(*it);
					const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(otr);
					ret->push_back (p);				
				}
			}

			return ret.forget ();
		}
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif

	ADList_aptr childs;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		CleanOnStartFunctionsCache::key_type key (this, FT_GET_SORTED_CHILDS);
		CleanOnStartFunctionsCache::iterator func_it = s_clean_on_start_list_functions_cache.find (key);

		if (func_it != s_clean_on_start_list_functions_cache.end ()) {
			childs = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			childs = local::impl (this);
			(s_clean_on_start_list_functions_cache[key]).assign (childs->begin (), childs->end ());
		}
	} else {
		childs = local::impl (this);
	}

	return childs.forget ();
}

void AbstractDumper::clean_forward ( OTRSet& scope) {	
	{
		m_not_in_scope_forwarded_suppliers = m_forwarded_suppliers;
		if (m_forwarded_suppliers.empty () == false) {
			// erase
			OTRSet::iterator it;
			OTRSet::iterator it_end = scope.end();
			for ( it = scope.begin(); it != it_end; it++) {
				m_forwarded_suppliers.erase (*it);
			}
		}

		// insert
				
		scope.insert (m_forwarded_suppliers.begin(),m_forwarded_suppliers.end());
		scope.insert (this);
	}
	
	// clean on child
	ADList_aptr childs = this->get_sorted_childs ();
	if (childs.is_nil () == false && childs->empty () == false) {
		ADList::iterator it = childs->begin ();
		ADList::iterator it_end = childs->end ();
		for (; it != it_end; ++it) {
			AbstractDumper* p = dynamic_cast<AbstractDumper*> (const_cast<AbstractDumperBase*>(*it));
			p->clean_forward(scope);
		}
	}
}

void AbstractDumper::log_mem_info (const std::string& prefix) {
	try {
		GCI::ResourceInfo::ProcessMemoryData info = GCI::ResourceInfo::ProcessMemoryInfoFactory::get ().get_memory_info ();

		const int bytes_in_mb = 1024*1024;
		LOG_D ((
			"%s: Current usage: %QMb, Max usage: %QMb, VM usage: %QMb"
			, prefix.c_str ()
			, info.current_usage/bytes_in_mb
			, info.max_usage/bytes_in_mb
			, info.vm_usage/bytes_in_mb
		));
	} catch (...) {
	}
}

//#UC END# *4571A2CB02DE*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool AbstractDumper::GenArtData::operator < (const GenArtData& y) const {
	//#UC START# *45964D37029F_LESS*
	return dumper < y.dumper ? true : (dumper > y.dumper ? false : source_info < y.source_info);
	//#UC END# *45964D37029F_LESS*
}

AbstractDumper::GenArtData::GenArtData (
	const AbstractDumperBase* dumper_
	, SourceStatus status_
	, const AbstractDumperBase::GenSourceInfo& source_info_
)
//#UC START# *45964D37029F_INIT_CTOR_BASE_INIT*
	: dumper (dumper_), status (status_), source_info (source_info_)
//#UC END# *45964D37029F_INIT_CTOR_BASE_INIT*
{
	//#UC START# *45964D37029F_INIT_CTOR*
	//#UC END# *45964D37029F_INIT_CTOR*
}
AbstractDumper::GenArtData::GenArtData (const GenArtData& copy) 
//#UC START# *45964D37029F_COPY_CTOR_BASE_INIT*
	: dumper (copy.dumper), status (copy.status), source_info (copy.source_info)
//#UC END# *45964D37029F_COPY_CTOR_BASE_INIT*
{
	//#UC START# *45964D37029F_COPY_CTOR*
	//#UC END# *45964D37029F_COPY_CTOR*
}

AbstractDumper::GenArtData& AbstractDumper::GenArtData::operator = (const GenArtData& copy) {
	//#UC START# *45964D37029F_ASSIGN_OP*
	dumper = copy.dumper;
	status = copy.status;
	source_info = copy.source_info;
	//#UC END# *45964D37029F_ASSIGN_OP*
	return *this;
}


bool AbstractDumper::RelationInfo::operator < (const RelationInfo& y) const {
	//#UC START# *4B1CD8B60085_LESS*
	return this->source < y.source 
		? true 
		: this->target < y.target
			? true
			: this->type < y.type
				? true
				: this->stereotype < y.stereotype;
	//#UC END# *4B1CD8B60085_LESS*
}



//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// флаг сигнализирующий о том отправлен список лэйблов на сервер или нет
bool AbstractDumper::s_sent_labels_list;

// началась ли генерация в К
bool AbstractDumper::s_wiki_generation_started = false;

// флаг - включен или нет кэш для функций
bool AbstractDumper::s_functions_cache_enabled = true;

// функции модификации юзер-свойств, вызываются в самом конце сумонинга.
AbstractDumper::UCModificationFunctionList AbstractDumper::s_uc_modification_functions;

// Доступ к информации о сгенерированных артефактах
AbstractDumper::GenArtefacts& AbstractDumper::get_artefacts () {
	//#UC START# *459650C2007C*
	return GenArtsSingleton::instance()->ptr;
	//#UC END# *459650C2007C*
}

// Сброс данных о сгенерированных артефактах
void AbstractDumper::reset_artefacts () {
	//#UC START# *45C9CDBF004E*
	GenArtsSingleton::instance()->ptr.reset();
	//#UC END# *45C9CDBF004E*
}

// Завершает генерацию (всех элементов дерева),  применяя все ее результаты на файловую систему
// и, сохраняя информацию о сгенерированных артефактах на модели
void AbstractDumper::dump_commit (const AbstractLogger* logger) {
	//#UC START# *45C9CDD703A9*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx  sw (GDS_CURRENT_FUNCTION);
#endif
	// new
	Core::Aptr<AbstractDumper::ArtefactSet> new_arts = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_NEW);
	for (AbstractDumper::ArtefactSet::iterator it = new_arts->begin(); it != new_arts->end(); it++) {	
		if (AbstractDumper::commit (**it) == false) {
			std::string mess ("Some warning while commit new artefact: ");
			if ((*it)->source_info.source.d_() == AbstractDumper::GST_FILE) {
				mess += (*it)->source_info.source.file_name();
			} else if ((*it)->source_info.source.d_() == AbstractDumper::GST_WIKI) {
				if ((*it)->source_info.source.wiki_page () != 0) {
					//CORBA::String_var path = (*it)->source_info.source.wiki_page ()->get_path ();
					//mess += path.in ();
					mess += (*it)->source_info.source.wiki_page ()->get_path ();
				}
			}
			mess += ", see log for more info";				
			logger->write_warning_log (mess.c_str ());
		}		
	}

	// chg
	Core::Aptr<AbstractDumper::ArtefactSet> chg_arts = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_CHG);
	for (AbstractDumper::ArtefactSet::const_iterator it = chg_arts->begin(); it != chg_arts->end(); it++) {				
		if (AbstractDumper::commit (**it) == false) {
			std::string mess ("Some warning while commit change: ");
			if ((*it)->source_info.source.d_() == AbstractDumper::GST_FILE) {
				mess += (*it)->source_info.source.file_name();
			} else if ((*it)->source_info.source.d_() == AbstractDumper::GST_WIKI) {
				if ((*it)->source_info.source.wiki_page () != 0) {
					//CORBA::String_var path = (*it)->source_info.source.wiki_page ()->get_path ();
					//mess += path.in ();
					mess += (*it)->source_info.source.wiki_page ()->get_path ();
				}
			}
			mess += ", see log for more info";				
			logger->write_warning_log (mess.c_str ());
		}		
	}

	// del
	Core::Aptr<AbstractDumper::ArtefactSet> del_arts = AbstractDumper::get_artefacts ().get_by_status (AbstractDumper::SS_DEL);
	for (AbstractDumper::ArtefactSet::const_iterator it = del_arts->begin(); it != del_arts->end(); it++) {		
		if (AbstractDumper::commit (**it) == false) {
			std::string mess ("Some warning while delete artefact: ");
			if ((*it)->source_info.source.d_() == AbstractDumper::GST_FILE) {
				mess += (*it)->source_info.source.file_name();
			} else if ((*it)->source_info.source.d_() == AbstractDumper::GST_WIKI) {
				if ((*it)->source_info.source.wiki_page () != 0) {
					//CORBA::String_var path = (*it)->source_info.source.wiki_page ()->get_path ();
					//mess += path.in ();
					mess += (*it)->source_info.source.wiki_page ()->get_path ();
				}
			}
			mess += ", see log for more info";				
			logger->write_warning_log (mess.c_str ());
		}		
	}

	//Удаляем информацию о псевдо-удаленных элементах, т.к возможна ситуация, когда
	//элемент перенесли в другой пакет, в старом пакете записалась информация, о том, 
	//что с него генерился этот элемент по пути А, но в новом пакете этот же элемент
	//генерится по тому же пути А, в результате если при перегенерации не удалить из
	//старого элемента эту информацию, то при генерации только старого пакета элемент
	//окажется в списке удаленных, а при генерации всей модели все будет хорошо
	//
	//по мотивам: http://mdp.garant.ru/pages/viewpage.action?pageId=235866508
	Core::Aptr<AbstractDumper::ArtefactSet> fake_del_arts = AbstractDumper::get_artefacts ().get_fake_deleted ();
	for (AbstractDumper::ArtefactSet::const_iterator it = fake_del_arts->begin(); it != fake_del_arts->end(); it++) {		
		(*it)->dumper->remove_generated_source ((*it)->source_info);					
	}

	if (!GenSupport::EnvironmentFactory::get ().get_disable_post_processing ()) {					
		for (AbstractDumper::ArtefactSet::const_iterator it = new_arts->begin(); it != new_arts->end(); it++) {
			std::string tmp_map = s_current_map;
			s_current_map = (*it)->source_info.gen_id;
			(*it)->dumper->run_post_command();
			s_current_map = tmp_map;
		}

		for (AbstractDumper::ArtefactSet::const_iterator it = chg_arts->begin(); it != chg_arts->end(); it++) {
			std::string tmp_map = s_current_map;
			s_current_map = (*it)->source_info.gen_id;
			(*it)->dumper->run_post_command();
			s_current_map = tmp_map;
		}
	}
	//#UC END# *45C9CDD703A9*
}

// релизует dump_commit для конкретного элемента
bool AbstractDumper::commit (const GenArtData& art) {
	//#UC START# *4632D38401C5*
	bool res = false;
	if (art.status == AbstractDumper::SS_NEW) {
		if (art.source_info.source.d_() == AbstractDumper::GST_FILE) {			
			std::string file_name = art.source_info.source.file_name();
			try {
				res = art.dumper->set_self_generated_source (art.source_info);
				if (res) {
					GCL::FileOp::move_file (
						create_gen_file_name(file_name).data()
						, file_name.data()
						, true
					);
				}
			} catch (GCL::FileOp::FOException& ex) {				
				LOG_W (("Can't rename new file \"%s\" (%s)", create_gen_file_name(file_name).data(), ex.what()));
			} catch (Base::FatalError&) {
				std::string tmp_fname = create_gen_file_name(file_name);
				ACE_OS::unlink(tmp_fname.data ());
				throw;
			}
		} else if (art.source_info.source.d_() == AbstractDumper::GST_WIKI) {
			res = art.dumper->set_self_generated_source (art.source_info);				
		} else {
			GDS_ASSERT (0);
		}
	} else if (art.status == AbstractDumper::SS_CHG) {
		if (art.source_info.source.d_() == AbstractDumper::GST_FILE) {
			std::string file_name = art.source_info.source.file_name();
			try {
				res = art.dumper->set_self_generated_source (art.source_info);
				
				if (res) {
					GCL::FileOp::move_file (file_name.data(), (file_name + ".bak").data(), true);
					GCL::FileOp::move_file (
						create_gen_file_name(file_name).data()
						, file_name.data()
						, true
					);
				}
			} catch (GCL::FileOp::FOException& ex) {				
				LOG_W (("Can't rename changed file \"%s\" (%s)", create_gen_file_name(file_name).data(), ex.what()));
			} catch (Base::FatalError&) {
				std::string tmp_fname = create_gen_file_name(file_name);
				ACE_OS::unlink(tmp_fname.data ());
				throw;
			}
		} else if (art.source_info.source.d_() == AbstractDumper::GST_WIKI) {
			res = art.dumper->set_self_generated_source (art.source_info);				
		} else {
			GDS_ASSERT (0);
		}
	} else if (art.status == AbstractDumper::SS_DEL) {
		if (art.source_info.source.d_() == AbstractDumper::GST_FILE) {
			std::string file_name = art.source_info.source.file_name();
			try {
				res = art.dumper->remove_generated_source (art.source_info);
				if (res) {
					GCL::FileOp::move_file (
						file_name.data()
						, (file_name + ".bak").data()
						, true
					);
				}
			} catch (GCL::FileOp::InvalidPath& ex) {
				LOG_W (("Can't rename deleted file \"%s\" (%s)", file_name.data(), ex.what()));
				art.dumper->remove_generated_source (art.source_info);
			} catch (GCL::FileOp::FOException& ex) {
				LOG_W (("Can't rename deleted file \"%s\" (%s)", file_name.data(), ex.what()));
			}
		} else if (art.source_info.source.d_() == AbstractDumper::GST_WIKI) {
			if (art.source_info.source.wiki_page () != 0) {				
				try {
					res = art.dumper->remove_generated_source (art.source_info);
					if (res) {
						art.source_info.source.wiki_page ()->mark_for_remove ();
					}
					TransactionContainer::instance ()->add_source (art.source_info);					
				} catch (ServerGate::GenerationContents::TransactionConflict&) {
					if (art.dumper) {
						std::string mess = "TransactionConflict, while execute mark_for_remove";
						art.dumper->write_warning_log (mess);
					}
				}				
			}
		} else {
			GDS_ASSERT (0);
		}
	}

	if (res) {
		ArtsForCommitSingleton::instance ()->ptr.insert (GenArtData (art.dumper, art.status, art.source_info));
		AbstractDumper::get_artefacts ().change_status (art, AbstractDumper::SS_EQ);
	}
	return res;
	//#UC END# *4632D38401C5*
}

// создает имя для файла временной генерации
const std::string AbstractDumper::create_gen_file_name (const std::string& fn) {
	//#UC START# *45C9CE01037A*
	
	std::string path;
	std::string drive;
	std::string dir;
	std::string fname;
	std::string ext;

	GCL::FileOp::splitpath (fn, drive, dir, fname, ext);

	std::string full_dir;
	ACE_TCHAR tmpdir[MAXPATHLEN + 1];
	if (ACE::get_temp_dir (tmpdir, MAXPATHLEN - 11) != -1) {
		full_dir = tmpdir + std::string("MDAGeneratorTempDir") + dir;

		if (ACE_OS::mkdir (full_dir.c_str ()) == -1 && errno == ENOENT) {
			if (!GCL::create_tree_dirs (full_dir.c_str (), false)) {
				full_dir = drive + dir;
			}
		}
	} else {
		full_dir = drive + dir;
	}	

	std::string ret (full_dir + fname + STR_TEMP_GEN_EX + ext);	

	return ret;
	//#UC END# *45C9CE01037A*
}

// сохраняет все сделанные за сеанс изменения в общем репозитрарии. Для фаловой генерации в CVS,
// для генерации страниц в MDKnow на сервере. Кроме сохранения артефактов, сохраняет в CVS
// изменения модели (после чего разлочивает модель). По событию "постоянного коммита", другие
// активные клиенты MDGen должны обновить свое состояние модели (и артефактов).
void AbstractDumper::persistent_commit (bool is_minor) {
	//#UC START# *463862E700C4*	
	class local {
	public:
		static AbstractDumper::ArtefactSetUnic* get_arts_for_commit (SourceStatus status) {
			Core::Aptr<AbstractDumper::ArtefactSetUnic> result = new AbstractDumper::ArtefactSetUnic ();
			for (
				AbstractDumper::ArtefactSetUnic::iterator it = ArtsForCommitSingleton::instance ()->ptr.begin()
				; it != ArtsForCommitSingleton::instance ()->ptr.end()
				; ++it
			) {
				if (
					it->source_info.source.d_() == AbstractDumper::GST_WIKI
					&& it->status == status
					&& it->source_info.source.wiki_page () != 0
				) {
					result->insert (*it);
				}
			}

			return result.forget ();
		}

		static void commit_all_impl (SourceStatus status, bool is_minor) {
			ServerGate::GenerationContents::PageList pages;
			
			Core::Aptr<AbstractDumper::ArtefactSetUnic> arts_for_commit = local::get_arts_for_commit (status);

			for (
				AbstractDumper::ArtefactSetUnic::iterator it = arts_for_commit->begin()
				; it != arts_for_commit->end()
				; ++it
			) {				
				pages.length (pages.length () + 1);
				pages[pages.length () - 1] = ServerGate::GenerationContents::Page::_duplicate (
					(it)->source_info.source.wiki_page ()->get_delegate ()
				);
				(it)->source_info.source.wiki_page ()->reset ();
			}

			if (pages.length () > 0) {
				LOG_I (("GenerationManager->commit_all (%d)", pages.length ()));
				ServerGate::GenerationContents::GenerationManagerFactory::get ().commit_all (pages, is_minor);
			}

			for (
				AbstractDumper::ArtefactSetUnic::iterator it = arts_for_commit->begin()
				; it != arts_for_commit->end()
				; ++it
			) {				
				//сбрасываем флаг изменённости у связанных дамперов
				GenSourceInfoToDumpersMap::iterator f_it = SourceToDumpersSingleton::instance ()->ptr.find ((it)->source_info);
				if (f_it != SourceToDumpersSingleton::instance ()->ptr.end ()) {
					ADList::iterator list_it_end = std::unique (f_it->second.begin (), f_it->second.end ());
					ADList::iterator list_it = f_it->second.begin ();							
					for (; list_it != list_it_end; ++list_it) {
						(*list_it)->reset_changed ();
					}
					SourceToDumpersSingleton::instance ()->ptr.erase ((it)->source_info);
				}
				TransactionContainer::instance ()->remove_source ((it)->source_info);

				ArtsForCommitSingleton::instance ()->ptr.erase (*it);
			}
		}		
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx  sw (GDS_CURRENT_FUNCTION);
#endif
	// комитим артефакты	
	try {
		local::commit_all_impl (SS_DEL, is_minor);
		local::commit_all_impl (SS_CHG, is_minor);
		local::commit_all_impl (SS_NEW, is_minor);
	} catch (CORBA::Exception& ex) {
		std::string mess = "Exception in persistent_commit: ";
		mess += ex._info ().c_str ();
		
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	} catch (...) {
		std::string mess ("Unknown exception in persistent_commit");
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	}
	//#UC END# *463862E700C4*
}

// очищает список артефактов, подлежащих коммиту, предварительно вызывая на них
// rollback_all_changes на случай если остались не закрытые транзакции
void AbstractDumper::reset_arts_for_commit () {
	//#UC START# *4676543501D4*
	TransactionContainer::instance ()->close_all ();
	ArtsForCommitSingleton::instance ()->ptr.clear ();
	AbstractDumper::on_end_wiki_generation ();
	//#UC END# *4676543501D4*
}

// подготавливает элемент к генерации (иницилизирует внутренний кэш элемента и всех его детей
// рекурсивно)
void AbstractDumper::prepare () {
	//#UC START# *46B69EAF006D*
	s_clean_on_start_list_functions_cache.clear ();
	AbstractDumperBase::TemplateContext::instance ()->clear ();
	
	ObjectTreeResolver::on_generation_start ();

	if (AbstractDumperBase::s_need_run_spell) {
		AbstractDumperBase::clear_user_code ();
		run_spell ();
	} else {
		AbstractDumper::clear_all_var_dumpers (AbstractDumperBase::LVT_OTHER);
		AbstractDumperBase::dump_prepare ();
		AbstractDumperBase::clear_user_code_from_file ();
		s_is_it_first_cache.clear ();		
	}
	
	//TemplatePainter::dumpers_heap ().clear ();

	AbstractDumperBase::set_in_spell (false);	

	AbstractDumper::s_uc_modification_functions.clear ();
	s_clean_on_start_list_functions_cache.clear ();
	AbstractDumperBase::TemplateContext::instance ()->clear ();

	ObjectTreeResolver::on_generation_start ();
	//#UC END# *46B69EAF006D*
}

// метод отправляет на сервер список меток, присутствующих в шаблоне
void AbstractDumper::send_labels_list () {
	//#UC START# *46FA543702BF*
	if (s_sent_labels_list == false) {
		AbstractDumperBase::Templates::const_iterator it_templ_begin = AbstractDumper::templates_begin ();
		AbstractDumperBase::Templates::const_iterator it_templ_end = AbstractDumper::templates_end ();
		AbstractDumperBase::Templates::const_iterator it_templ = it_templ_begin;

		GCL::StrSet all_labels;
		for (; it_templ != it_templ_end; ++it_templ) {
			all_labels.insert (
				it_templ->second.labels.begin ()
				, it_templ->second.labels.end ()				
			);
		}
		ServerGate::GenerationContents::Labels server_labels;
		size_t labels_size = all_labels.size ();
		server_labels.length (labels_size);

		GCL::StrSet::iterator it_begin = all_labels.begin ();
		GCL::StrSet::iterator it_end = all_labels.end ();
		GCL::StrSet::iterator it = it_begin;
		for (size_t i = 0; it != it_end; ++it, ++i) {
			server_labels[i] = it->c_str ();
		}
		
		ServerGate::GenerationContents::GenerationManager& config 
			= ServerGate::GenerationContents::GenerationManagerFactory::get ();
		
		config.set_generated_labels (server_labels);
		s_sent_labels_list = true;
	}
	//#UC END# *46FA543702BF*
}

// сбрасывает кэши
void AbstractDumper::reset () {
	//#UC START# *46FA54810186*
	AbstractDumper::reset_artefacts ();
	AbstractDumper::reset_arts_for_commit ();
	SourceToDumpersSingleton::instance ()->ptr.clear ();
	AbstractDumper::s_uc_modification_functions.clear ();
	s_sent_labels_list = false;
	//#UC END# *46FA54810186*
}

// метод вызываетя при начале генерации в К (до первого обращения к странице К)
void AbstractDumper::on_start_wiki_generation () {
	//#UC START# *4912DFA60211*
	if (s_wiki_generation_started == false) {
		try {
			ServerGate::GenerationContents::GenerationManagerFactory::get ().begin_generation ();
			s_wiki_generation_started = true;
		} CATCH_AND_LOG ("while GenerationManager::begin_generation");
		AbstractDumper::send_labels_list ();		
	}
	//#UC END# *4912DFA60211*
}

// вызывается при окончании генерации в К (после всех вызовов commit и rollback)
void AbstractDumper::on_end_wiki_generation () {
	//#UC START# *4912DFF0007C*
	if (s_wiki_generation_started == true) {
		s_wiki_generation_started = false;
		try {
			ServerGate::GenerationContents::GenerationManagerFactory::get ().end_generation ();
		} CATCH_AND_LOG ("while GenerationManager::end_generation");
	}
	//#UC END# *4912DFF0007C*
}

// вызывается при подготовке к генерации перед проверкой констрэйнтов
void AbstractDumper::prepare_internal () {
	//#UC START# *4A4DFC37005F*
	LOG_I (GDS_CURRENT_FUNCTION);
	delete_virtuals_from_tree ();

	LOG_I(("Prepare elements in tree for spell-generation"));
	if (s_tree) {
		ObjectTree::iterator it = s_tree->begin ();
		ObjectTree::iterator it_end = s_tree->end ();
		
		for (; it != it_end; it++) {
			AbstractDumper* dumper = const_cast<AbstractDumper*> (dynamic_cast<const AbstractDumper*> (**it));
			
			if (dumper) {
				dumper->spell_generation_prepare ();
			}
		}
	}
	//#UC END# *4A4DFC37005F*
}

// активировать кэш для фукнций
void AbstractDumper::enable_functions_cache () {
	//#UC START# *4A926D720085*
	AbstractDumper::s_functions_cache_enabled = true;
	//#UC END# *4A926D720085*
}

// отключить кэш для функций
void AbstractDumper::disable_functions_cache () {
	//#UC START# *4A926D9602B0*
	AbstractDumper::s_functions_cache_enabled = false;
	AbstractDumper::s_functions_cache.clear ();
	AbstractDumper::s_clean_on_start_list_functions_cache.clear ();
	//#UC END# *4A926D9602B0*
}

// включен ли кэш для функций
bool AbstractDumper::is_functions_cache_enabled () {
	//#UC START# *4A926DB30010*
	return AbstractDumper::s_functions_cache_enabled;
	//#UC END# *4A926DB30010*
}

// запускает генерацию виртуальных элементов
void AbstractDumper::run_spell () {
	//#UC START# *4AA6299E00EE*
	s_uc_modification_functions.clear ();
	s_clean_on_start_list_functions_cache.clear ();

	AbstractDumper::clear_all_var_dumpers (AbstractDumperBase::LVT_ALL);

	GenSupport::EnvironmentFactory::get ().set_enable_spell_explicit_call_logging (GenerationParams::get_enable_spell_explicit_call_logging ());
	GenSupport::EnvironmentFactory::get ().set_scold_if_call_tpl_function_on_null (GenerationParams::get_scold_if_call_tpl_function_on_null ());
	//запускаем построение вирутальных элементов
	//предварительно удаляем старые виртуальные элементы
	//и очищаем список юзер-секций
	AbstractDumperBase::dump_prepare ();
	//TemplatePainter::dumpers_heap ().clear ();

	s_is_it_first_cache.clear ();	
	AbstractDumperBase::TemplateContext::instance ()->clear ();
	
	AbstractDumperBase::clear_user_code ();
	prepare_internal ();

	//отключаем кэш для построения виртуальных элементов
	AbstractDumper::disable_functions_cache ();
	{
		const ObjectTreeResolver* otr = *(*(ObjectTreeResolver::s_tree->begin ()));
		const AbstractDumper* parent = dynamic_cast<const AbstractDumper*> (otr);
		const AbstractDumper* root = parent;
		
		while (parent = dynamic_cast<const AbstractDumper*> (parent->parent())) {
			root = parent;
			
		}
		
		std::string tmp_map = s_current_map;
		s_current_map = AbstractDumperBase::SPELL_GENERATOR_ID;

		bool run_spell = false;
		ObjectTree::Items projects = ObjectTreeResolver::s_tree->childs (root);
		ObjectTree::Items::const_iterator it = projects.begin ();
		ObjectTree::Items::const_iterator end = projects.end ();
		for (; it != end && !run_spell; ++it) {
			const AbstractDumper* project = dynamic_cast<const AbstractDumper*> (*(*it));
			const AbstractDumperBase::Template& tpl = project->get_template ();
		
			AbstractDumperBase::GT_map::const_iterator it = tpl.generators.find (AbstractDumperBase::SPELL_GENERATOR_ID);
			
			if (
				it != tpl.generators.end ()
				&& !it->second.code_template.empty ()
				&& project->accepted_generator ()
			) {
				run_spell = true;
			}
		}

		if (run_spell) {

			run_sort (root);			
			
			root->write_info_log ("Start building virtual tree...");
			
			AbstractDumperBase::set_in_spell (true);
			root->dump();					

			root->write_info_log ("Start post spell...");
			run_post_spell ();
			root->write_info_log ("End post spell...");

			root->write_info_log ("End building virtual tree...");
		} else {
			root->write_info_log ("We don't need to build virtual tree, because spell template is empty");
		}

		s_current_map = tmp_map;
	}
	
	AbstractDumper::enable_functions_cache ();
	AbstractDumperBase::s_need_run_spell = false;
	//#UC END# *4AA6299E00EE*
}

// запускает алгоритм поготовки данных для сортировки элементов
void AbstractDumper::run_sort (const AbstractDumper* from_node) {
	//#UC START# *4AB09F780253*
	boost::timer tm;

	log_mem_info ("Before sorting");
	from_node->write_info_log ("Start sorting...");
	
	ObjectTreeResolver::fill_graph (from_node);
	log_mem_info ("After fill graph");
	
	ObjectTreeResolver::sort_tree (from_node);
	{
	#ifndef GDS_NLOG_DEBUG
		Core::GDS::StopWatchEx sw ("clean_forward");
	#endif
		OTRSet scope;		
		const_cast<AbstractDumper*>(from_node)->clean_forward (scope);
	}
	log_mem_info ("After sort");
	
	ObjectTreeResolver::clear_graph ();

	log_mem_info ("clear graph");

	std::string mess = "Sorting complete, elapsed time: ";
	mess += boost::lexical_cast<std::string> (tm.elapsed ());
	mess += "s.";
	from_node->write_info_log (mess);
	//#UC END# *4AB09F780253*
}

// проверяет, что никакие два различных элемента не порождают однаковый артефакт генерации (т.е
// один и тот же файл, страницу в К)
void AbstractDumper::check_unique_outputs (const AbstractLogger* logger) {
	//#UC START# *4AC0920E01C5*
	bool was_error = false;
	//проверяем не генерятся ли несколько элементом в один и тот же файл
	for (OutputFilesMap::const_iterator it = s_all_output_files.begin (); it != s_all_output_files.end (); ++it) {
		bool has_non_user_file = false;
		for (		
			OutputFilesValues::const_iterator value_it = it->second.begin ()
			; value_it != it->second.end () && !has_non_user_file
			; ++value_it
		) {
			std::string temp_map (AbstractDumper::s_current_map);
			AbstractDumper::s_current_map = value_it->second;
			has_non_user_file |= !value_it->first->is_user_file ();
			AbstractDumper::s_current_map.swap (temp_map);
		}

		if (has_non_user_file && it->second.size () > 1) {
			//выводим список элементов, которые генерятся в один файл
			was_error = true;
			std::string message ("Файл \"");
			message += it->first;
			message += "\" генерится несколькими элементами: ";

			OutputFilesValues::const_iterator value_it = it->second.begin ();
			message += value_it->first->get_full_name ();
			message += "(генератор: ";
			message += value_it->second;
			message += ", user_file: ";
			message += value_it->first->is_user_file () ? "true" : "false";
			message += ")";
			++value_it;
			for (				
				; value_it != it->second.end ()
				; ++value_it
			) {
				message += ", ";
				message += value_it->first->get_full_name ();
				message += "(генератор: ";
				message += value_it->second;
				message += ", user_file: ";
				message += value_it->first->is_user_file () ? "true" : "false";
				message += ")";
			}

			logger->write_error_log (message, false);
		}
	}

	if (was_error) {
		std::string mess ("Ошибка: несколько элементов генерятся в один файл");
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	}
	//#UC END# *4AC0920E01C5*
}

// удаляет витруальные элементы из дерева
void AbstractDumper::delete_virtuals_from_tree () {
	//#UC START# *4ACC6C930113*
	LOG_I (GDS_CURRENT_FUNCTION);
	if (s_tree) {
		//удаляем связи
		{
			const RelationsSet& deps =  get_virtual_relations ();
			RelationsSet::const_iterator it = deps.begin ();
			RelationsSet::const_iterator it_end = deps.end ();
			for (; it != it_end; ++it) {
				it->source->delete_from_cache ();
				it->target->delete_from_cache ();

				it->source->remove_supplier (it->target, it->type, it->stereotype);
			}
		}

		//восстанавливаем связи
		{
			const RelationsSet& deps =  get_relations_for_restore ();
			RelationsSet::const_iterator it = deps.begin ();
			RelationsSet::const_iterator it_end = deps.end ();
			for (; it != it_end; ++it) {
				it->source->add_supplier_spec (it->target, it->type, it->stereotype, false, false);
			}
		}

		UnorderedOTRSet::const_iterator it = get_virtual_dumpers ().begin ();
		UnorderedOTRSet::const_iterator end = get_virtual_dumpers ().end ();
		
		UnorderedOTRSet for_deleting;
		for (; it != end; ++it) {
			//сначала удаляем всех детей
			ObjectTreeResolver* rad = const_cast<ObjectTreeResolver*> (*it);

			//проверяем не удалили пометили ли ещё элемент как удаляемый
			if (for_deleting.find (rad) == for_deleting.end ()) {
				ObjectTree::Items ch = s_tree->all_childs (rad);
				for (ObjectTree::Items::iterator it = ch.begin(); it != ch.end(); it++) {
					ObjectTreeResolver* p = const_cast<ObjectTreeResolver*>(*(*it));
					if (p) {
						//разрываем связь
						p->remove_from_consumers ();
						s_tree->remove (p);						
						for_deleting.insert (p);
					}
				}
				rad->remove_from_consumers ();
				s_tree->remove (rad);
				for_deleting.insert (rad);
			}
		}

		for (UnorderedOTRSet::iterator it = for_deleting.begin (); it != for_deleting.end (); ++it) {
			const ObjectTreeResolver* p = *it;
			const AbstractDumper* ad = dynamic_cast<const AbstractDumper*> (p);
			if (ad) {
				ad->delete_from_cache ();
			}
			if (p) {				
				delete p;
			}
		}
	}	

	RelationsForRestoreSingleton::instance ()->ptr.clear ();
	VirtualRelationsSingleton::instance ()->ptr.clear ();
	VirtualDumpersSingleton::instance ()->ptr.clear ();
	//#UC END# *4ACC6C930113*
}

// добавить виртуальную связь между двумя элементами
void AbstractDumper::add_virtual_relation (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype) {
	//#UC START# *4ACC6CAB007C*
	RelationInfo rel;
	rel.source = const_cast<AbstractDumper*> (source);
	rel.target = const_cast<AbstractDumper*> (target);
	rel.type = type;
	rel.stereotype = stereotype;
	
	VirtualRelationsSingleton::instance ()->ptr.insert (rel);
	//#UC END# *4ACC6CAB007C*
}

// добавляет виртуальный дампер в спец. список
void AbstractDumper::add_virtual_dumper (const ObjectTreeResolver* rad, const AbstractDumperBase* context) {
	//#UC START# *4ACC6CBE0394*
	GDS_ASSERT(context);
	const AbstractDumper* ad = dynamic_cast<const AbstractDumper*> (context);

	GDS_ASSERT(ad);

	ad->add_dumper_for_delay_dump (dynamic_cast<const AbstractDumperBase*> (rad));
	VirtualDumpersSingleton::instance ()->ptr.insert (rad);
	//#UC END# *4ACC6CBE0394*
}

// удаляет вирутальный элемент
void AbstractDumper::delete_virtual_dumper (const ObjectTreeResolver* otr) {
	//#UC START# *4AEEC073035E*
	if (s_tree) {
		VirtualDumpersSingleton::instance ()->ptr.erase (otr);

		//сначала удаляем всех детей
		ObjectTreeResolver* rad = const_cast<ObjectTreeResolver*> (otr);

		UnorderedOTRSet for_deleting;
		//проверяем не удалили пометили ли ещё элемент как удаляемый
		ObjectTree::Items ch = s_tree->all_childs (rad);
		for (ObjectTree::Items::iterator it = ch.begin(); it != ch.end(); it++) {
			ObjectTreeResolver* p = const_cast<ObjectTreeResolver*>(*(*it));
			if (p) {
				//разрываем связь
				p->remove_from_consumers ();
				s_tree->remove (p);
				for_deleting.insert (p);
			}
		}

		rad->remove_from_consumers ();
		s_tree->remove (rad);
		for_deleting.insert (rad);

		for (UnorderedOTRSet::iterator it = for_deleting.begin (); it != for_deleting.end (); ++it) {
			const ObjectTreeResolver* p = *it;
			const AbstractDumper* ad = dynamic_cast<const AbstractDumper*> (p);
			if (ad) {
				AbstractDumperBase::remove_dumper_for_delay_dump (ad);
				ad->delete_from_cache ();
			}
			if (p) {				
				delete p;
			}
		}	
	}
	//#UC END# *4AEEC073035E*
}

// удалять виртуальную связь
void AbstractDumper::remove_virtual_relation (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype) {
	//#UC START# *4AEECA9A0355*
	RelationInfo rel;
	rel.source = const_cast<AbstractDumper*> (source);
	rel.target = const_cast<AbstractDumper*> (target);
	rel.type = type;
	rel.stereotype = stereotype;
	
	VirtualRelationsSingleton::instance ()->ptr.erase (rel);
	
	source->delete_from_cache ();
	target->delete_from_cache ();
	

	rel.source->remove_supplier (rel.target, type, stereotype);
	//#UC END# *4AEECA9A0355*
}

// очищает список дамперов связанных с каждым элементов дерева, должен вызываться при старте
// генерации
void AbstractDumper::clear_all_var_dumpers (AbstractDumperBase::LocalVarType by_type) {
	//#UC START# *4B21169B0310*
	LOG_I((GDS_CURRENT_FUNCTION));
	if (s_tree) {
		ObjectTree::iterator it = s_tree->begin ();
		ObjectTree::iterator it_end = s_tree->end ();
		
		for (; it != it_end; it++) {
			const AbstractDumperBase* dumper = dynamic_cast<const AbstractDumperBase*> (**it);
			
			if (dumper) {
				dumper->clear_var_dumpers (by_type);
			}
		}
	}
	//#UC END# *4B21169B0310*
}

// запускает операции, которые нужн выполнить сразу после ссумонинга (вызывается внутри run_spell)
void AbstractDumper::run_post_spell () {
	//#UC START# *4B27877903D5*
	/*AbstractDumperBase::AbstractDumperBaseToSet::iterator m_it = ForDelayDumpDumpersSingleton::instance ()->ptr.begin ();
	AbstractDumperBase::AbstractDumperBaseToSet::iterator m_it_end = ForDelayDumpDumpersSingleton::instance ()->ptr.end ();

	for (; m_it != m_it_end; ++m_it) {
		for (
			AbstractDumperBaseSet::iterator it = m_it->second.begin ()
			; it != m_it->second.end ()
			; ++it
		) {
			(*it)->write_warning_log ("hasn't been spelled!!!");
		}
	}*/

	do {
		UCModificationFunctionList copy (s_uc_modification_functions);
		s_uc_modification_functions.clear ();

		for (
			UCModificationFunctionList::iterator it = copy.begin ()
			; it != copy.end ()
			; ++it
		) {
			(**it)();
		}
	} while (!s_uc_modification_functions.empty ());
	
	//#UC END# *4B27877903D5*
}

// добавить функцию
void AbstractDumper::add_uc_modification_function (const UCModificationfunction_var& func) {
	//#UC START# *4B278EF40199*
	s_uc_modification_functions.push_back (func);
	//#UC END# *4B278EF40199*
}

// должен вызываться перед запуском генерации!
void AbstractDumper::before_dump () {
	//#UC START# *4B66ADE900C2*
	s_clean_on_start_list_functions_cache.clear ();
	s_is_it_first_cache.clear ();
	AbstractDumper::enable_functions_cache ();
	s_all_output_files.clear ();

	AbstractDumperBase::TemplateContext::instance ()->clear ();

	{
		const ObjectTreeResolver* otr = *(*(ObjectTreeResolver::s_tree->begin ()));
		const AbstractDumper* parent = dynamic_cast<const AbstractDumper*> (otr);
		const AbstractDumper* root = parent;
		
		while (parent = dynamic_cast<const AbstractDumper*> (parent->parent())) {
			root = parent;
			
		}
		
		run_sort (root);
	}
	//#UC END# *4B66ADE900C2*
}

// добавить связь для восстановления перед следующим запуска спела
void AbstractDumper::add_relation_for_restore (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype) {
	//#UC START# *4B990EEF02A1*
	RelationInfo rel;
	rel.source = const_cast<AbstractDumper*> (source);
	rel.target = const_cast<AbstractDumper*> (target);
	rel.type = type;
	rel.stereotype = stereotype;
	
	RelationsForRestoreSingleton::instance ()->ptr.insert (rel);
	//#UC END# *4B990EEF02A1*
}

// возвращает имформацию о связи для восстановления (результат БЕЗ увеличения счетчика ссылок)
AbstractDumper::RelationInfo* AbstractDumper::get_relation_for_restore (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype) {
	//#UC START# *4B990FD302D6*
	RelationInfo rel;
	rel.source = const_cast<AbstractDumper*> (source);
	rel.target = const_cast<AbstractDumper*> (target);
	rel.type = type;
	rel.stereotype = stereotype;

	RelationsSet::iterator it = RelationsForRestoreSingleton::instance ()->ptr.find (rel);
	if (it != RelationsForRestoreSingleton::instance ()->ptr.end ()) {
		return const_cast<RelationInfo*> (&(*it));
	}

	return 0;
	//#UC END# *4B990FD302D6*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractDumper::~AbstractDumper () {
	//#UC START# *4571A2CB02DE_DESTR_BODY*	
	for (ADList::iterator it2 = m_diagrams.begin(); it2 != m_diagrams.end(); it2++) {
		delete const_cast<AbstractDumperBase*>(*it2);
	}
	//#UC END# *4571A2CB02DE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает true, если использование стереотипа разрешено правилами родителя, иначе false
bool AbstractDumper::check_stereotype_use () const {
	//#UC START# *4AC358F50359*
	const AbstractDumperBase* parent = this->parent();
    
	if (parent) {
		const AbstractDumperBase::StereotypeID& st = this->get_model_stereotype_str ();
		GCL::StrVector st_part = GCL::split_string_by_sub_string (st.data(), "::");
		if (st_part.size() > 2) {
			GCL::StrVector par_st_part = GCL::split_string_by_sub_string (parent->get_model_stereotype_str ().data(), "::");

			if ((st_part[0] == par_st_part[0] || st_part[0] == "default") && st_part[1] == par_st_part[1]) {
				return true;
			}
		} else {
			const AbstractDumperBase::Template& pt = parent->get_template ();
			GCL::StrSet st_constraints (pt.child_st_constraints.begin () , pt.child_st_constraints.end ());
			st_constraints.insert (pt.child_internal_st_constraints.begin (), pt.child_internal_st_constraints.end ());
			if (st_constraints.size()) {
				GCL::StrSet::const_iterator it;
				for (it = st_constraints.begin (); it != st_constraints.end (); ++it) {
					if (pt.child_st_constarint_type == AbstractDumperBase::CSCT_INCLUDED) {
						if (*it == st) {
							return true;
						} else {
							GCL::StrVector const_part = GCL::split_string_by_sub_string (it->data(), "::");
							if (const_part[0] == "*" && st_part[1] == const_part[1]) {
								return true;
							}
						}
					} else {
						if (*it == st) {
							break;
						} else {
							GCL::StrVector const_part = GCL::split_string_by_sub_string (it->data(), "::");
							if (const_part[0] == "*" && st_part[1] == const_part[1]) {
								break;
							}
						}
					}
				}

				if (
					pt.child_st_constarint_type == AbstractDumperBase::CSCT_EXCLUDED
					&& it == st_constraints.end()
				) {
					return true;
				}		
			} else {
				return true;
			}
		}
		return false;
	}

	return true;
	//#UC END# *4AC358F50359*
}

// Закрывает выходной поток и "обрезает" выходной файл до нужного размера (т.к в конце потока может
// находится мусор)
void AbstractDumper::close_output (std::ofstream& file) const {
	//#UC START# *49EE99220008*
	// определяем реальный размер записанных данных
	// он нам понадобится для того, чтобы "обрезать файл"
	// т.к в конце него может быть мусор
	unsigned int size = (unsigned int)file.tellp();							
	file.close();
	
	std::string gen_file = create_gen_file_name (this->file_name());
	// обрезаем исходный файл
	if (size >= 0) {
		ACE_HANDLE fd = ACE_OS::open (gen_file.c_str (), O_RDWR);
		if (fd != ACE_INVALID_HANDLE) {
			ACE_OS::ftruncate (fd, size);
			ACE_OS::close (fd);
		}
	}
	//#UC END# *49EE99220008*
}

// инициирует удаление элемента из кэшей
void AbstractDumper::delete_from_cache () const {
	//#UC START# *4C219598003F*
	CacheCleaner::apply (this, AbstractDumper::s_functions_cache);
	//#UC END# *4C219598003F*
}

// Начинает генерацию, от данного узла
void AbstractDumper::dump_start () const {
	//#UC START# *45C9CDE70157*
	AbstractDumperBase::s_gen_root_element = this;
	for (GCL::StrSet::iterator it = s_active_map.begin(); it != s_active_map.end(); it++) {
		if (*it != AbstractDumperBase::SPELL_GENERATOR_ID) {
			std::string mess ("Write for: ");
			mess += *it;
			mess += "...";			
			this->write_info_log (mess.c_str ());

			s_current_map = *it;		
			this->dump();
		}
	}
	s_current_map.clear ();
	AbstractDumperBase::s_gen_root_element = 0;
	//#UC END# *45C9CDE70157*
}

// Пост-обработка сгенерированного файла:
// заменяет символ переноса строки (если это необходимо) на тот, что прописан в шаблоне стереотипа.
// file_path - путь к файлу, в котором нужно провести изменения, также конвертит файл в нужную
// кодировку
void AbstractDumper::file_post_process (const std::string& file_path) const {
	//#UC START# *49EE997301EE*	
	std::ifstream temp_file (file_path.c_str (), std::ios::in);
	
	if (!temp_file) {
		std::string mess ("Не удалось прочитать файл \"");
		mess += file_path;
		mess += "\", сгенерённый генератором \"";
		mess += AbstractDumperBase::s_current_map;
		mess += "\", errno = ";
		mess += boost::lexical_cast<std::string> (errno);
		mess += " (";
		mess += strerror (errno);
		mess += ")";
		
		this->write_error_log (mess, true); // process error 
	}
	
	///заменяем переносы строк
	std::string gen_file_content;
	
	// load the file into memory so we can scan it:						
	std::copy(
		std::istreambuf_iterator<char>(temp_file)
		, std::istreambuf_iterator<char>()
		, std::back_inserter(gen_file_content)
	);
	temp_file.close ();

	if (!gen_file_content.empty ()) {
		const AbstractDumperBase::TemplateBody& tp = this->get_template_body ();
		GCL::str_replace (gen_file_content, "\n", tp.newline_replacer.c_str ());

		GCL::code_t output_coding = this->get_output_coding ();
		if (AbstractDumperBase::s_default_encoding != output_coding) {
			std::string temp (gen_file_content);
			gen_file_content.clear ();
			if (output_coding == GCL::cd_utf) {
				//нужно записать BOM в начало файла,
				//чтобы другие редакторы могли его распознать как UTF
				gen_file_content = reinterpret_cast<const char*> ("\xEF\xBB\xBF");
			}
			gen_file_content += GCL::convert (
				temp.c_str ()
				, AbstractDumperBase::s_default_encoding
				, output_coding
			);
		}

		std::ofstream out_temp_file (
			file_path.c_str ()
			, std::ios::out | std::ios::trunc | std::ios::binary
		);
		
		if (!out_temp_file) {
			std::string mess ("Не удалось записать файл \"");
			mess += file_path;
			mess += "\", сгенерённый генератором \"";
			mess += AbstractDumperBase::s_current_map;
			mess += "\", errno = ";
			mess += boost::lexical_cast<std::string> (errno);
			mess += " (";
			mess += strerror (errno);
			mess += ")";
			
			GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
			GenSupport::LogManagerFactory::get ().log_error (mess);
		} else {
			out_temp_file << gen_file_content;
		}
	}
	//#UC END# *49EE997301EE*
}

// заполняет кэш флагов генерит ли элемент собственный файл
void AbstractDumper::prepare_output_cache () const {
	//#UC START# *4ACC6BDB02A1*
	class local {
	public:
		static void init_cache (const AbstractDumper* ad) {
			AbstractDumperBase::GenInfos::iterator it = AbstractDumperBase::s_gen_infos.begin ();
			AbstractDumperBase::GenInfos::iterator end = AbstractDumperBase::s_gen_infos.end ();
			for (; it != end; ++it) {
				s_current_map = it->first;				
				ad->m_outputs[s_current_map].own_output = ad->get_template_body ().file_create;
			}
		}
	};
	
	std::string tmp_map = s_current_map;

	local::init_cache (this);	
	
	ObjectTree::Items items = s_tree->childs (this);
	ObjectTree::Items::iterator it = items.begin();
	ObjectTree::Items::iterator end = items.end();
	
	for (; it != end; ++it) {
		AbstractDumper* p = const_cast<AbstractDumper*> (dynamic_cast<const AbstractDumper*>(*(*it)));
		if (p) {
			local::init_cache (p);
		}
	}
	s_current_map = tmp_map;
	//#UC END# *4ACC6BDB02A1*
}

// фиксирует и сбрасывает на диск все сгенерированные артефакты, анализируя характер изменений и
// заполняя информацию о сгенерированных артефактах
void AbstractDumper::push_changes () const {
	//#UC START# *459D4B190370*
	std::string temp_map = s_current_map;

	for ( GCL::StrSet::iterator it = s_active_map.begin(); it != s_active_map.end(); it++ ) {
		bool with_parent;
		if (this->is_native (with_parent) == false) {//собираем статистику ТОЛЬКО для НЕ native элементов
			s_current_map = *it;

			GenSourceInfo srs;
			srs.gen_id = s_current_map;
			SourceStatus status;

			if (this->own_output()) {
				
				switch (this->get_source_type ()) {
					case GST_FILE: 
					{
						std::ofstream* file = dynamic_cast<std::ofstream*>(output());
						if (file) {
							this->close_output (*file);						

							if (GenSupport::EnvironmentFactory::get ().get_cancel_generation ()) {
								continue;
							}
							
							srs.source.file_name(this->file_name());							
							std::string gen_file = create_gen_file_name (this->file_name()); //путь к временному сгенерённому файлу

							this->file_post_process (gen_file);
							
							// check for changes
							bool is_diff = true;

							long old_file_size = ACE_OS::filesize (this->file_name().data());
							bool old_file_exists = old_file_size != -1;
							
							bool is_user_file = this->is_user_file ();
							if (old_file_exists) {
								if (!is_user_file) {
									is_diff = GCL::FileOp::compare (
										gen_file.data ()
										, this->file_name().data()
										, true
									) != 0;
								} else {
									is_diff = false;
								}
							}

							if (is_diff) {
								if (old_file_exists) {
									status = SS_CHG;
								} else if (ACE_OS::filesize (gen_file.c_str ()) > 0) {
									status = SS_NEW;
								}
							} else {
								status = SS_EQ;
								std::string gen_file_name = create_gen_file_name(srs.source.file_name());

								if (ACE_OS::access(gen_file_name.c_str (), F_OK) != -1) {
									try {
										GCL::FileOp::remove_file(gen_file_name.data());
									} catch (GCL::FileOp::FOException& ex) {
										//ЗАТОЧКА!!!
										//ругаемся только если НЕ юзер-файл
										//т.к несколько элементов могут генерится в один юзер-файл
										if (!is_user_file) {

											std::string mess (
												std::string ("Не удалось удалить временный файл: ")										
												+ gen_file_name
												+ " (" + std::string (ex.what ()) + ")"
											);

											GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
											GenSupport::LogManagerFactory::get ().log_error (mess);
										}
									}
								} else if (!is_user_file) {
									std::string mess (
										std::string ("Отсутствует временный файл (возможно он был удален ранее): ")										
										+ gen_file_name
									);

									GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);
								}
							}

							AbstractDumper::get_artefacts().add (GenArtData(this, status, srs));
						} 
					}
					break;

					case GST_WIKI:
					{
						std::ofstream* stream = dynamic_cast<std::ofstream*>(output());
						if (stream) {
							unsigned int size = (unsigned int)stream->tellp();							
							stream->close();
							
							if (GenSupport::EnvironmentFactory::get ().get_cancel_generation ()) {
								continue;
							}							
							std::string fpath = this->temp_file_name ();							
							FILE* fh = ACE_OS::fopen (fpath.c_str (), "r+");
							// Open a file 
							if (fh != 0) {
								_chsize_s (_fileno (fh), size);
								ACE_OS::fclose (fh);
							}

							std::ifstream temp_file (fpath.c_str (), std::ios::in);
							
							if (!temp_file) {
								std::string mess ("Не удалось открыть файл \"");
								mess += fpath;
								mess += "\", сгенерённый генератором \"";
								mess += AbstractDumperBase::s_current_map;
								mess += "\", errno = ";
								mess += boost::lexical_cast<std::string> (errno);
								mess += " (";
								mess += strerror (errno);
								mess += ")";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);
							}
							
							try {								
								AbstractDumper::on_start_wiki_generation ();
								std::string self_generated_text;
								std::string temp_file_content;
								// load the file into memory so we can scan it:						
								std::copy(std::istreambuf_iterator<char>(temp_file), std::istreambuf_iterator<char>(), std::back_inserter(self_generated_text));						
								//self_generated_text = self_generated_text.substr (0, size);								
								temp_file.close ();
								ACE_OS::unlink (fpath.c_str ());
								//std::string self_generated_text = stream->str ();
								
								//получаем путь для страницы
								std::string page_path = this->file_name ();
								std::string conf_prefix = STR_CONF_FLAG;
								conf_prefix += "//";
								std::string::size_type pos = page_path.find (conf_prefix);

								if (pos != std::string::npos) {
									page_path = page_path.substr (pos + conf_prefix.length ());
								}
															
								std::string page_id = this->get_model_unique_id_str ();
								
								//получаем страницу по ID и пути
								//если страница с таким ID не найдена - должны
								//вернуть страницу по пути, если и такой нет - 
								//создать новую
								GenSupport::PageProxy& page = GenSupport::PageProxyFactory::get (page_id.c_str ());
								
								//добавляем страницу в список сгенеренных артефактов
								srs.source.wiki_page (&page);
								
								TransactionContainer::instance ()->add_source (srs);
								
								page.set_generated_text (self_generated_text.c_str ());
								page.set_path (page_path.c_str ());
								
								ServerGate::GenerationContents::PropertyMapEntryList metadata_map;
								metadata_map.length (
									std::distance (this->metadatas_begin (), this->metadatas_end ())
								);
								size_t metadata_map_index = 0;
								for (
									AbstractDumperBase::MetaDataMap::const_iterator it = this->metadatas_begin ()
									; it != this->metadatas_end ()
									; ++it, ++metadata_map_index
								) {
									metadata_map[metadata_map_index].key = it->first.c_str ();
									metadata_map[metadata_map_index].string_list.length (it->second.size ());
									
									for (size_t i = 0; i < it->second.size (); ++i) {
										metadata_map[metadata_map_index].string_list[i] = it->second[i].c_str ();
									}
								}								
								
								page.add_property_map (metadata_map);								
	
								Core::Aptr<GCL::StrSet> labels = this->get_labels ();								
								if (!labels.is_nil ()) {
									GCL::StrSet correct_labels;
									for (
										GCL::StrSet::iterator it = labels->begin ()
										; it != labels->end ()
										; ++it
									) {
										correct_labels.insert (GCL::trim_ws (it->c_str ()));										
									}									
									std::string labels_str = GCL::join (correct_labels, ",");
									page.set_labels (labels_str.c_str ());
								} else {
									page.set_labels ("");
								}
								
								if (page.is_new_page () == true) {
									status = SS_NEW;
								} else {
									status = page.is_modified () ? SS_CHG : SS_EQ;
								}				
								
								AbstractDumper::get_artefacts().add (GenArtData(this, status, srs));
							} catch (ServerGate::GenerationContents::TransactionConflict&) {
								std::string mess = "TransactionConflict, when dump " + this->get_full_name ();
								this->write_warning_log (mess);
							} catch (ServerGate::GenerationContents::ReadOnlyContent&) {
								std::string mess = "ReadOnlyContent, when dump " + this->get_full_name ();
								this->write_warning_log (mess);
							} catch (ServerGate::GenerationContents::PathNotValid&) {
								std::string mess = "PathNotValid, when dump " + this->get_full_name ();
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

							} catch (CORBA::Exception& ex) {
								std::string mess = "Exception: ";
								mess += ex._info ().c_str ();
								mess += ", when dump " + this->get_full_name ();
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);
							}
						}
					}
					break;

					default: GDS_ASSERT (0);
						break;

				}				
			}
			
			Core::GDS::StopWatchEx sw ("push_changes:: check deleted childs");
			// check self for deleted files
			Core::Aptr<GenSourceInfo> old_srs = this->get_self_generated_source ();
			if (old_srs.ptr()) {
				if (old_srs->source.d_ () == GST_FILE) {
					if (old_srs->source.file_name() != "") {
						if (srs.source.d_ () != GST_FILE || srs.source.file_name() != old_srs->source.file_name()) {
							AbstractDumper::get_artefacts().add (GenArtData(this, SS_DEL, *old_srs));
						}
					}
				} else if (old_srs->source.d_ () == GST_WIKI) {
					if (old_srs->source.wiki_page() != 0) {
						bool need_remove = false;
						if (srs.source.d_ () != GST_WIKI) {
							need_remove = true;
						} else {						
							if (srs.source.wiki_page() == 0) {
								need_remove = true;
							} else {
								/*CORBA::String_var srs_path = srs.source.wiki_page()->get_path ();
								CORBA::String_var old_srs_path = old_srs->source.wiki_page()->get_path ();*/

								/*CORBA::String_var srs_self = srs.source.wiki_page()->get_guid ();
								CORBA::String_var old_srs_self = old_srs->source.wiki_page()->get_guid ();

								need_remove = (
									ACE_OS::strcmp (srs_self.in (), old_srs_self.in ()) != 0
								);*/

								need_remove = srs.source.wiki_page()->get_guid () != old_srs->source.wiki_page()->get_guid ();
							}														
						}
						if (need_remove) {
							//old_srs->source.wiki_page()->mark_for_remove ();
							AbstractDumper::get_artefacts().add (GenArtData(this, SS_DEL, *old_srs));
						}
					}
				} else {
					GDS_ASSERT (0);
				}
			}

			// check deleted childs for deleted files
			Core::Aptr<GenSourceInfoSet> deleted_srs = this->get_deleted_child_generated_source ();
			if (deleted_srs.ptr()) {
				for (GenSourceInfoSet::iterator it = deleted_srs->begin(); it != deleted_srs->end(); it++) {
					if (it->source.d_ () == GST_FILE) {
						if (srs.source.d_ () != GST_FILE || srs.source.file_name() != it->source.file_name()) {
							AbstractDumper::get_artefacts().add (GenArtData(this, SS_DEL, *it));
						}
					} else if (it->source.d_ () == GST_WIKI) {
						if (it->source.wiki_page() != 0) {
							bool need_remove = false;
							if (srs.source.d_ () != GST_WIKI) {	
								need_remove = true;
							} else {
								if (srs.source.wiki_page() == 0) {
									need_remove = true;
								} else {
									/*CORBA::String_var srs_guid = srs.source.wiki_page()->get_guid ();
									CORBA::String_var it_guid = it->source.wiki_page()->get_guid ();
									need_remove = (
										strcmp (srs_guid.in (), it_guid.in ()) != 0
									);*/

									need_remove = srs.source.wiki_page()->get_guid () != it->source.wiki_page()->get_guid ();
								}																	
							}
							if (need_remove) {
								//it->source.wiki_page()->mark_for_remove ();
								AbstractDumper::get_artefacts().add (GenArtData(this, SS_DEL, *it));
							}
						}
					} else {
						GDS_ASSERT (0);
					}
				}
			}
		}
	}

	s_current_map = temp_map;

////////////////

	std::string tmp_map = s_current_map;

	{
		Core::GDS::StopWatchEx sw ("push_changes:: free output");
		for (OutputMap::iterator it = m_outputs.begin(); it != m_outputs.end(); it++) {
			s_current_map = it->first;
			
			OutputDesc& od = it->second;
			if (od.own_output) {
				delete od.file;
				od.file = 0;
			}
			
			od.own_output = get_template_body ().file_create;
		}
	}

	s_current_map = tmp_map;
	
	ObjectTree::Items items = s_tree->childs (this);
	for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
		const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(**it);
		if (p) {
			p->push_changes ();
		}
	}
	//#UC END# *459D4B190370*
}

// метод вызываемые на каждом элементе перед запуском спела)
void AbstractDumper::spell_generation_prepare () {
	//#UC START# *4AFD27ED017D*
	//#UC END# *4AFD27ED017D*
}
//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors

const AbstractDumper::RelationsSet& AbstractDumper::get_relations_for_restore () {
	//#UC START# *4B990EAD0343_GET_ACCESSOR*
	return RelationsForRestoreSingleton::instance ()->ptr;
	//#UC END# *4B990EAD0343_GET_ACCESSOR*
}

const ObjectTreeResolver::UnorderedOTRSet& AbstractDumper::get_virtual_dumpers () {
	//#UC START# *4ACC6CB4015E_GET_ACCESSOR*
	return VirtualDumpersSingleton::instance ()->ptr;
	//#UC END# *4ACC6CB4015E_GET_ACCESSOR*
}
void AbstractDumper::set_virtual_dumpers (const ObjectTreeResolver::UnorderedOTRSet& virtual_dumpers) {
	//#UC START# *4ACC6CB4015E_SET_ACCESSOR*
	VirtualDumpersSingleton::instance ()->ptr = virtual_dumpers;
	//#UC END# *4ACC6CB4015E_SET_ACCESSOR*
}

const AbstractDumper::RelationsSet& AbstractDumper::get_virtual_relations () {
	//#UC START# *4ACC6CBA0387_GET_ACCESSOR*
	return VirtualRelationsSingleton::instance ()->ptr;
	//#UC END# *4ACC6CBA0387_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// зарегистрирован или нет
bool AbstractDumper::am_i_registred () const {
	//#UC START# *4665554F00BB_4571A2CB02DE*
	return is_it_registred (get_model_stereotype_str());
	//#UC END# *4665554F00BB_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// regular/abstract/final - тип абстрактности элемента.
const std::string AbstractDumper::get_abstract_str () const {
	//#UC START# *4666BBA801A5_4571A2CB02DE*
	return "false";
	//#UC END# *4666BBA801A5_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// ВСЕ элементы которые используют текущий
AbstractDumperBase::ADList* AbstractDumper::get_all_consumers () const {
	//#UC START# *46663374004E_4571A2CB02DE*	
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());
			
			for (
				Consumer_set::const_iterator it = this_->m_consumers.begin()
				; it != this_->m_consumers.end()
				; ++it
			) {
				const AbstractDumperBase* consumer = dynamic_cast<const AbstractDumperBase*>(it->consumer);
				//if (consumer->accepted_generator()) {
					ret->push_back(consumer);
				//}
			}
			return ret.forget ();
		}
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;

	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_ALL_CONSUMERS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);
				
		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46663374004E_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив всех вложенных элементов (рекурсивно)
AbstractDumperBase::ADList* AbstractDumper::get_all_contents () const {
	//#UC START# *4666369E01D4_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr childs = this_->get_sorted_childs ();
			
			ADList_aptr ret (new ADList ());

			if (childs.is_nil () == false && childs->empty () == false) {
				ADList::iterator it = childs->begin ();
				ADList::iterator it_end = childs->end ();

				for (; it != it_end; ++it) {
					const AbstractDumper* ad = dynamic_cast<const AbstractDumper*> (*it);
					/*const AbstractDumperBase* targ = ad->get_target ();
					if (ad->accepted_generator() && (!targ || targ->accepted_generator()))*/ {
						ret->push_back (ad);
						
						//собираем вложенные элементы ребёнка
						//предварительно ищем в кэше
						ADList_aptr all_c;
						
						if (AbstractDumper::is_functions_cache_enabled ()) {
							CleanOnStartFunctionsCache::key_type key (ad, FT_GET_ALL_CONTENTS);
							CleanOnStartFunctionsCache::iterator func_it = s_clean_on_start_list_functions_cache.find (key);
							
							if (func_it != s_clean_on_start_list_functions_cache.end ()) {
								all_c = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
							} else {
								all_c = local::impl (ad);
								(s_clean_on_start_list_functions_cache[key]).assign (all_c->begin (), all_c->end ());
							}
						} else {
							all_c = local::impl (ad);
						}

						ret->insert(ret->end(), all_c->begin(), all_c->end());
					}
				}
			}			
			return ret.forget ();
		}		
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
		
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		CleanOnStartFunctionsCache::key_type key (this, FT_GET_ALL_CONTENTS/* + AbstractDumperBase::s_current_map*/);
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
	
	ret->remove_if (not_accepted_gen_with_target ());
	return ret.forget ();
	//#UC END# *4666369E01D4_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// Возвращает список элементов,  у которых имя совпадает с текущим элементом
AbstractDumperBase::ADList* AbstractDumper::get_all_equals_name () const {
	//#UC START# *47A01E5102D1_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* exec (const AbstractDumperBase* this_) {
			ObjectTree::iterator it = s_tree->begin ();
			ObjectTree::iterator it_end = s_tree->end ();
			
			std::string this_str = this_->get_name_str ();
			ADList_aptr ret = new AbstractDumperBase::ADList ();
			for (; it != it_end; it++) {
				const AbstractDumper* dumper = dynamic_cast<const AbstractDumper*> (**it);
				if (
					dumper != this_
					&& dumper->get_name_str () == this_str
				) {
					ret->push_back (dumper);
				}
			}

			return ret.forget ();
		}
	};	
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_ALL_EQUALS_NAME);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::exec (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::exec (this);
	}
		
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *47A01E5102D1_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив всех включаемых элементов (папок) рекурсивно
AbstractDumperBase::ADList* AbstractDumper::get_all_includes () const {
	//#UC START# *4666371701F4_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());
			OTRSet incs;
			this_->collect_all_include (incs);
			incs.erase (this_);
			for (OTRSet::iterator it = incs.begin(); it != incs.end(); it++) {
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
				if (adb->accepted_generator()) {
					ret->push_back(adb);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		size_t key_part = boost::hash_value (AbstractDumperBase::s_current_map);
		boost::hash_combine (key_part, FT_GET_ALL_INCLUDES);

		FunctionsCache::key_type key (this, key_part);
		
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *4666371701F4_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// вид элемента
const std::string AbstractDumper::get_class_kind_str () const {
	//#UC START# *465FE63402FD_4571A2CB02DE*
	return "";
	//#UC END# *465FE63402FD_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив вложенных элементов
AbstractDumperBase::ADList* AbstractDumper::get_contents () const {
	//#UC START# *4666367C01D4_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr childs = this_->get_sorted_childs ();
			ADList_aptr ret (new ADList ());
			if (childs.is_nil () == false && childs->empty () == false) {
				ADList::iterator it = childs->begin ();
				ADList::iterator it_end = childs->end ();
				for (; it != it_end; ++it) {
					const AbstractDumperBase* targ = (*it)->get_target ();
					/*if ((*it)->accepted_generator() && (!targ || targ->accepted_generator()))*/ {
						ret->push_back ((*it));
					}
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		CleanOnStartFunctionsCache::key_type key (this, FT_GET_CONTENTS/* + AbstractDumperBase::s_current_map*/);
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

	ret->remove_if (not_accepted_gen_with_target ());
	return ret.forget ();
	//#UC END# *4666367C01D4_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// возвращает список элементов, от которых зависит данный
AbstractDumperBase::ADList* AbstractDumper::get_dependences () const {
	//#UC START# *46655D1D03D8_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_supplier_by_stereotype (ST_LINK_DEP);
			ADList_aptr ret (new ADList ());
				
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
				/*if (adb->accepted_generator())*/ {
					ret->push_back(adb);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_DEPENDENCES/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655D1D03D8_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив диаграмм
AbstractDumperBase::ADList* AbstractDumper::get_diagrams () const {
	//#UC START# *46663777001F_4571A2CB02DE*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	ADList_aptr ret (new ADList ());	
	for (ADList::const_iterator it = m_diagrams.begin(); it != m_diagrams.end(); it++) {
		ret->push_back(*it);		
	}
	return ret._retn ();
	//#UC END# *46663777001F_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив элементов, которые необходимо forward-декларировать для текущего элемента.
AbstractDumperBase::ADList* AbstractDumper::get_forwarded () const {
	//#UC START# *4666357500FA_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());		
			for (
				OTRSet::const_iterator it = this_->forwarded_suppliers().begin()
				; it != this_->forwarded_suppliers().end()
				; it++
			) {	
				const AbstractDumper* ad = dynamic_cast<const AbstractDumper*>(*it);
				/*if (ad->accepted_generator())*/ {
					ret->push_back(ad);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_FORWARDED/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *4666357500FA_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив базовых элементов (от которых унаследован текущий)
AbstractDumperBase::ADList* AbstractDumper::get_generalizations () const {
	//#UC START# *46655E5B01F4_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_supplier_by_stereotype (ST_LINK_INH);
			ADList_aptr ret (new ADList ());
				
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
				/*if (adb->accepted_generator ())*/ {
					ret->push_back(adb);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_GENERALIZATIONS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655E5B01F4_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив объектов наследующихся от данного
AbstractDumperBase::ADList* AbstractDumper::get_generalizator () const {
	//#UC START# *46655DC401C5_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_consumer_by_stereotype (ST_LINK_INH);
			
			ADList_aptr ret (new ADList ());				
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
				/*if (adb->accepted_generator ())*/ {
					ret->push_back(adb);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_GENERALIZATOR/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655DC401C5_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив элементов являющихся исключениями для операций  или get-исключениями для атрибутов
AbstractDumperBase::ADList* AbstractDumper::get_get_exceptions () const {
	//#UC START# *466636210271_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());
			
			const AbstractDumperBase::Template& tpl = this_->get_template ();
			if (tpl.has_get_except) {
				OTRSet supp = this_->get_supplier_by_stereotype (ST_GET_EXCEPTION);		
				for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
					const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
					/*if (adb->accepted_generator ())*/ {
						ret->push_back(adb);
					}
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_GET_EXCEPTIONS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *466636210271_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив включаемых элементов (папок)
// Включаемые папки определяются на основе зависимостей элемента. Если элемент или его вложенные
// части используют как-либо (наследуется, реализует, имеет атрибуты данного типа и т.д.) другой
// элемент, то папка, в которой содержится используемый элемент, попадет в список зависимости. Из
// результирующего списка исключаются элементы попавшие в форвард-декларирование (F)
AbstractDumperBase::ADList* AbstractDumper::get_includes () const {
	//#UC START# *466636DB035B_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret = new ADList ();
			OTRSet incs;
			this_->collect_include (incs);
			incs.erase (this_);
			for (OTRSet::iterator it = incs.begin(); it != incs.end(); it++) {
				AbstractDumper::ADList_aptr forwarded = this_->get_forwarded();
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumper*>(*it);
				if (std::find (forwarded->begin(), forwarded->end(), adb) == forwarded->end()) {
					ret->push_back(adb);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		size_t key_part = boost::hash_value (AbstractDumperBase::s_current_map);
		boost::hash_combine (key_part, FT_GET_INCLUDES);

		FunctionsCache::key_type key (this, key_part);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *466636DB035B_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// возвращает строку для сдвига
const std::string AbstractDumper::get_intend_str (short intend_shift) const {
	//#UC START# *4666BAFD038A_4571A2CB02DE*
	std::string ret;
	short intend = 0;

	OutputMap::const_iterator it = m_outputs.find(s_current_map);
	if (it != m_outputs.end()) {
		intend = (*it).second.intend;
	}
	intend += intend_shift;
	if (intend < 0) {
		intend = 0;
	}
	
	for (int i = 0; i < intend; i++) {
		ret += "\t";
	}
	return ret;
	//#UC END# *4666BAFD038A_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
const std::string AbstractDumper::get_link_type_str () const {
	//#UC START# *4666BBD903B9_4571A2CB02DE*
	return "";
	//#UC END# *4666BBD903B9_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// все элементы которые используют без учета форвард-декларирования данный (циклически) в одном
// пакете
AbstractDumperBase::ADList* AbstractDumper::get_nested_botom_consumers () const {
	//#UC START# *4666333A0261_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());

			ObjectTree::Item_ptr my_par = s_tree->parent (this_);
			for (
				OTRSet::const_iterator it = this_->m_botom_consumers.begin()
				; it != this_->m_botom_consumers.end()
				; it++
			) {
				if (my_par == s_tree->parent (*it)) {
					const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
					/*if (adb->accepted_generator ())*/ {
						ret->push_back(adb);
					}
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_NESTED_BOTOM_CONSUMERS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *4666333A0261_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив всех (рекурсивно) базовых элементов (от которых унаследован текущий)
AbstractDumperBase::ADList* AbstractDumper::get_nested_generalizations () const {
	//#UC START# *46655EC401E4_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp;
			this_->collect_reqursive_generalization(supp);
			
			ADList_aptr ret (new ADList ());
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
				ret->push_back (dynamic_cast<const AbstractDumper*>(*it));
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_NESTED_GENERALIZATIONS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655EC401E4_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив всех (рекурсивно) реализуемых элементов (которые реализует текущий)
AbstractDumperBase::ADList* AbstractDumper::get_nested_realizations () const {
	//#UC START# *46655ED0006D_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet gnrl;
			this_->collect_reqursive_generalization (gnrl);
			gnrl.insert (this_);

			OTRSet set_ret;
			for (OTRSet::iterator g_it = gnrl.begin(); g_it != gnrl.end(); g_it++) {
				OTRSet supp = (*g_it)->get_supplier_by_stereotype (ST_LINK_REL);		

				for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {	
					const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*it);
					/*if (p->accepted_generator())*/ {
						set_ret.insert (p);
						p->collect_reqursive_generalization (set_ret); // NOT realization!
					}
				}
			}

			ADList_aptr ret (new ADList ());
			for (OTRSet::iterator it = set_ret.begin(); it != set_ret.end(); it++) {
				ret->push_back (dynamic_cast<const AbstractDumper*>(*it));
			}

			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_NESTED_REALIZATIONS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655ED0006D_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// все элементы которые используются без учета форвард-декларирования данным (циклически) в одном
// пакете
AbstractDumperBase::ADList* AbstractDumper::get_nested_top_suppliers () const {
	//#UC START# *466635470186_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());

			ObjectTree::Item_ptr my_par = s_tree->parent (this_);
			for (
				OTRSet::const_iterator it = this_->m_top_suppliers.begin()
				; it != this_->m_top_suppliers.end()
				; it++) {
				if (my_par == s_tree->parent (*it)) {
					const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
					/*if (adb->accepted_generator ())*/ {
						ret->push_back(adb);
					}
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_NESTED_TOP_SUPPLIERS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *466635470186_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// то же что и Forwarded но без исключения элементов декларированных выше в предполагаемой (в
// области пакета) видимости
AbstractDumperBase::ADList* AbstractDumper::get_nsf_forwarded () const {
	//#UC START# *466635AB02AF_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());
			for (
				OTRSet::const_iterator it = this_->m_not_in_scope_forwarded_suppliers.begin()
				; it != this_->m_not_in_scope_forwarded_suppliers.end()
				; ++it
			) {
				const AbstractDumper* ad = dynamic_cast<const AbstractDumper*>(*it);
				/*if (this_->is_it_registred_supplied_by(ad))*/ {
						ret->push_back(ad);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_NSF_FORWARDED/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *466635AB02AF_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив включаемых элементов (папок), но исключаются все форвард декларированные элементы без
// учета ранней форвард деклорации (W). Кроме того, в место элементов НЕ имеющих выходных файлов, в
// список попадают, их родители (рекурсивно) имеющие таковые
AbstractDumperBase::ADList* AbstractDumper::get_nsf_includes () const {
	//#UC START# *466637380203_4571A2CB02DE*
	class local {
	public:
		static void collect_nsf_includes (OTRSet& includes, const ObjectTreeResolver* otr, const AbstractDumper::ADList& nsf_forwarded) {
			{
				OTRSet sups = otr->get_supplier_by_stereotypes(g_registred_supplier);
				for (OTRSet::iterator it = sups.begin(); it != sups.end(); it++) {
					const AbstractDumper* rad = dynamic_cast<const AbstractDumper*>(*it);
					if (
						std::find (
							nsf_forwarded.begin()
							, nsf_forwarded.end()
							, rad
							
						) == nsf_forwarded.end()
					) {
						while (rad) {
							if (!rad->create_file_name_str ().empty ()) {							
								break;
							}
							rad = dynamic_cast<const AbstractDumper*>(rad->parent());
						}

						if (rad) {
							if (rad != *it) {
								//нужно отсечь элементы, которые не имеют ни одного ребенка, отстутствующего
								//в списке форвард декларированных, при этом учитываются только дети, генерящиеся в родителя, т.е
								//не имеющие собственных исходников
								ObjectTree::Items ch = s_tree->childs (rad);
								bool has_non_fwd_child = ch.empty ();
								for (
									ObjectTree::Items::iterator ch_it = ch.begin()
									; ch_it != ch.end() && !has_non_fwd_child
									; ch_it++
								) {
									const AbstractDumper* ch_ad = dynamic_cast<const AbstractDumper*>(**ch_it);
									if (
										ch_ad->create_file_name_str ().empty ()
										&& std::find (
											nsf_forwarded.begin()
											, nsf_forwarded.end()
											, ch_ad
											
										) == nsf_forwarded.end()
									) {
										has_non_fwd_child = true;
									}
								}

								if (has_non_fwd_child) {
									includes.insert (rad);
								}
							} else {
								includes.insert (rad);
							}
						}
					}
				}
			}

			ObjectTree::Items ch = s_tree->childs (otr);
			for (ObjectTree::Items::iterator it = ch.begin(); it != ch.end(); it++) {
				collect_nsf_includes (includes, *(*it), nsf_forwarded);
			}
		}

		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
				AbstractDumper::ADList_aptr nsf_forwarded = this_->get_nsf_forwarded ();

				OTRSet incs;
				collect_nsf_includes (incs, this_, *nsf_forwarded.in ());
				incs.erase (this_);

				ADList_aptr ret (new ADList ());
				for (OTRSet::iterator it = incs.begin(); it != incs.end(); ++it) {										
					const AbstractDumper* ad = dynamic_cast<const AbstractDumper*>(*it);
					if (ad) {
						ret->push_back (ad);
					}
				}
				return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		size_t key_part = boost::hash_value (AbstractDumperBase::s_current_map);
		boost::hash_combine (key_part, FT_GET_NSF_INCLUDES);

		FunctionsCache::key_type key (this, key_part);		
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *466637380203_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив родительских элементов
// Первым элементов в массиве является ближайший родитель
AbstractDumperBase::ADList* AbstractDumper::get_parents () const {
	//#UC START# *466636560261_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* get_parents_impl (const AbstractDumperBase* this_) {
			ADList_aptr ret;
			if (AbstractDumper::is_functions_cache_enabled ()) {
				FunctionsCache::key_type key (this_, FT_GET_PARENTS);
				FunctionsCache::iterator func_it = s_functions_cache.find (key);

				if (func_it != s_functions_cache.end ()) {
					ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
				} else {
					const AbstractDumperBase* parent = this_->parent ();
					if (parent) {
						ret = get_parents_impl (parent);
						ret->push_front (parent);
					} else {
						ret = new AbstractDumperBase::ADList ();
					}
					(s_functions_cache[key]).assign (ret->begin (), ret->end ());
				}
			} else {
				const AbstractDumperBase* parent = this_->parent ();
				if (parent) {
					ret = get_parents_impl (parent);
					ret->push_front (parent);
				} else {
					ret = new AbstractDumperBase::ADList ();
				}
			}
			
			return ret.forget ();
		}

		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());
			const AbstractDumperBase* parent = this_;

			while (parent=parent->parent()) {
				ret->push_back (parent);
			}
			if (ret->empty () == false) {
				//cut Logical View
				ret->pop_back ();
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret = local::get_parents_impl (this);
	if (ret->empty () == false) {
		ret->pop_back ();
	}
	
	return ret.forget ();
	//#UC END# *466636560261_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив реализуемых элементов (которые реализует текущий)
AbstractDumperBase::ADList* AbstractDumper::get_realizations () const {
	//#UC START# *46655E930261_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_supplier_by_stereotype (ST_LINK_REL);
			ADList_aptr ret (new ADList ());
				
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
				/*if (adb->accepted_generator())*/ {
					ret->push_back(adb);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_REALIZATIONS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655E930261_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив объектов реализующих данный
AbstractDumperBase::ADList* AbstractDumper::get_realizator () const {
	//#UC START# *46655DAA008C_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_consumer_by_stereotype (ST_LINK_REL);
			ADList_aptr ret (new ADList ());
				
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
				/*if (adb->accepted_generator())*/ {
					ret->push_back(adb);
				}
			}
			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_REALIZATOR/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655DAA008C_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив объектов наследующихся от данного (рекурсивно)
AbstractDumperBase::ADList* AbstractDumper::get_req_generalizator () const {
	//#UC START# *46655E0C0242_4571A2CB02DE*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	ADList_aptr ret (this->get_req_generalizator_impl ());
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655E0C0242_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив объектов реализующих данный (рекурсивно)
AbstractDumperBase::ADList* AbstractDumper::get_req_realizator () const {
	//#UC START# *46655DF500AB_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_consumer_by_stereotype (ST_LINK_REL);
			ADList_aptr ret (new ADList ());

			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {	
				const AbstractDumper* p = dynamic_cast<const AbstractDumper*>(*it);
				/*if (p->accepted_generator())*/ {
					ret->push_back (p);
					
					ADList_aptr nr (p->get_req_generalizator_impl ()); //!!! - it is not an error !!!
					/*FunctionsCache::key_type key (p, FT_GET_REQ_REALIZATOR);
					FunctionsCache::iterator func_it = s_functions_cache.find (key);
					
					ADList_aptr nr;
					if (func_it != s_functions_cache.end ()) {
						nr = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
					} else {
						nr = local::impl (p);
						(s_functions_cache[key]).assign (nr->begin (), nr->end ());
					}*/
					ret->insert(ret->end(), nr->begin(), nr->end());
				}
			}

			return ret.forget ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_REQ_REALIZATOR/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655DF500AB_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// ВСЕ элементы которые используют текущий (циклически)
AbstractDumperBase::ADList* AbstractDumper::get_requrcive_all_consumers () const {
	//#UC START# *466635050213_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());
			OTRSet col;
			this_->collect_requrcive_all_consumers (col);

			col.erase (this_);
			for (OTRSet::iterator it = col.begin(); it != col.end(); it++) {
				ret->push_back(dynamic_cast<const AbstractDumper*>(*it));		
			}
			return ret._retn ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_REQURCIVE_ALL_CONSUMERS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *466635050213_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// возвращает рекурсивно список элементов, от которых зависит данный
AbstractDumperBase::ADList* AbstractDumper::get_reqursive_dependences () const {
	//#UC START# *46655D480261_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp;
			this_->collect_reqursive_dependences (supp);			
			
			ADList_aptr ret (new ADList ());
				
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {		
				ret->push_back(dynamic_cast<const AbstractDumper*>(*it));		
			}

			return ret._retn ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_REQURSIVE_DEPENDENCES/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46655D480261_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив элементов последовательности вызовов (для операций)
AbstractDumperBase::ADList* AbstractDumper::get_sequences () const {
	//#UC START# *466635D401C5_4571A2CB02DE*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	ADList_aptr ret (new ADList ());

	for (ADVector::const_iterator it = m_activity_seq.begin(); it != m_activity_seq.end(); it++) {
		ret->push_back(*it);
	}
	return ret._retn ();
	//#UC END# *466635D401C5_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив элементов являющихся set-исключениями для атрибутов
AbstractDumperBase::ADList* AbstractDumper::get_set_exceptions () const {
	//#UC START# *4666362C01A5_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			ADList_aptr ret (new ADList ());

			const AbstractDumperBase::Template& tpl = this_->get_template ();
			if (tpl.has_set_except) {
				OTRSet supp = this_->get_supplier_by_stereotype (ST_SET_EXCEPTION);				
							
				for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
					const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
					/*if (adb->accepted_generator())*/ {
						ret->push_back(adb);
					}
				}
			}
			return ret._retn ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_SET_EXCEPTIONS/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *4666362C01A5_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// массив объектов использующих данный в качестве своих атрибутов
AbstractDumperBase::ADList* AbstractDumper::get_source () const {
	//#UC START# *46663318034B_4571A2CB02DE*
	class local {
	public:
		static AbstractDumperBase::ADList* impl (const AbstractDumper* this_) {
			OTRSet supp = this_->get_consumer_by_stereotype (ST_TARGET);
			ADList_aptr ret (new ADList ());
				
			for (OTRSet::iterator it = supp.begin(); it != supp.end(); it++) {
				const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*>(*it);
				/*if (adb->accepted_generator())*/ {
					ret->push_back(adb);
				}
			}
			return ret._retn ();
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
#endif
	
	ADList_aptr ret;
	
	if (AbstractDumper::is_functions_cache_enabled ()) {
		FunctionsCache::key_type key (this, FT_GET_SOURCE/* + AbstractDumperBase::s_current_map*/);
		FunctionsCache::iterator func_it = s_functions_cache.find (key);

		if (func_it != s_functions_cache.end ()) {
			ret = new AbstractDumperBase::ADList (func_it->second.begin (), func_it->second.end ());		
		} else {
			ret = local::impl (this);
			(s_functions_cache[key]).assign (ret->begin (), ret->end ());
		}
	} else {
		ret = local::impl (this);
	}
	
	ret->remove_if (not_accepted_gen ());
	return ret.forget ();
	//#UC END# *46663318034B_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// возвращает стереотип элемента
const std::string AbstractDumper::get_stereotype_str () const {
	//#UC START# *465FE0B403D8_4571A2CB02DE*
	return "";
	//#UC END# *465FE0B403D8_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// возвращает цель
AbstractDumperBase* AbstractDumper::get_target () const {
	//#UC START# *466554FF030D_4571A2CB02DE*
	GCL::StrSet target_st;
	target_st.insert (ST_TARGET);
	target_st.insert (ST_USER_DEF_TARGET);
	OTRSet targets = get_supplier_by_stereotypes (target_st);
	
	if (targets.size() != 1) {
		return NULL;
	}
	
	const AbstractDumper* target = dynamic_cast<const AbstractDumper*>(*targets.begin());
	if (target->accepted_generator()) {
		return const_cast<AbstractDumper*> (target);
	} else {
		return 0;
	}
	//#UC END# *466554FF030D_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// возвращает "true", если элемент фиксированного размера
const std::string AbstractDumper::get_type_fixed_size_str () const {
	//#UC START# *4666BB64029F_4571A2CB02DE*
	return (this->is_type_fixed_size() ? "true" : "false");
	//#UC END# *4666BB64029F_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// имеет ли зарегистрированного родителя
bool AbstractDumper::has_registred_parent () const {
	//#UC START# *466555EA009C_4571A2CB02DE*
	AbstractDumperBase* par = parent();
	return par && (par->am_i_registred() || par->has_registred_parent ());
	//#UC END# *466555EA009C_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// определяет имеет ли элемент собственный поток вывода
bool AbstractDumper::own_output () const {
	//#UC START# *4666BD680128_4571A2CB02DE*
	//Core::GDS::StopWatchEx sw ("AbstractDumper::own_output");
	bool ret = false;
	//ret = m_outputs[s_current_map].own_output = get_template_body ().file_create;

	OutputMap::const_iterator it = m_outputs.find(s_current_map);
	if (it != m_outputs.end()) {
		ret = (*it).second.own_output;
	}
	
	return ret;
	//#UC END# *4666BD680128_4571A2CB02DE*
}

// implemented method from AbstractDumperBase
// возвращает родителя
AbstractDumperBase* AbstractDumper::parent () const {
	//#UC START# *4665549F0251_4571A2CB02DE*
	//Core::GDS::StopWatchEx sw ("AbstractDumper::parent");
	const AbstractDumper* parent = NULL;	
	if (s_tree) {
		const ObjectTreeResolver** otr = s_tree->parent (this);
		if (otr) {
			parent = dynamic_cast<const AbstractDumper*>(*otr);
		}
	}
	return const_cast<AbstractDumper*> (parent);
	//#UC END# *4665549F0251_4571A2CB02DE*
}

// implemented method from ObjectTreeResolver
// возвращает вес форвард декларации
long AbstractDumper::get_fwd_weight () const {
	//#UC START# *4A489B430198_4571A2CB02DE*
	return AbstractDumperBase::get_fwd_weight ();
	//#UC END# *4A489B430198_4571A2CB02DE*
}

// implemented method from ObjectTreeResolver
// возвращает true, если элемент нельяз форвард декларировать
bool AbstractDumper::is_forbiden_forward_dcl () const {
	//#UC START# *4A489B1602BA_4571A2CB02DE*
	return AbstractDumperBase::is_forbiden_forward_dcl();
	//#UC END# *4A489B1602BA_4571A2CB02DE*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

