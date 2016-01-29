////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::ObjectTreeResolver
//
// Алгоритм построения графа зависимостей между деревом объектов на основе свзяей между ними. Граф
// определяет порядок следования элементов в виртуальном плосеком файле, а так же  то какие
// элементы требуют ворвард деклорирования.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
// by <<uses>> dependencies
#include "boost/lambda/bind.hpp"
#include "boost/lambda/casts.hpp"
#include "boost/lambda/lambda.hpp"

//#UC START# *4571A0B90148_CUSTOM_INCLUDES*
#include <algorithm>
#include <map>
#include <string>
#include <sstream>
#include "shared/GCL/alg/sorting.h"
//#UC END# *4571A0B90148_CUSTOM_INCLUDES*


//#UC START# *4571A0B90148*
ObjectTreeResolver::ObjectTree* ObjectTreeResolver::s_tree = NULL;

ObjectTreeResolver::AlgorithmMap ObjectTreeResolver::s_is_it_first_cache;
ObjectTreeResolver::ObjectTreeResolver() {
}

bool ObjectTreeResolver::SortByUID::operator()(const ObjectTreeResolver* const x, const ObjectTreeResolver* const y) const {
	return x->compare (y) < 0;
}

bool ObjectTreeResolver::ExistsInHardGraph::operator()(const ObjectTreeResolver** const x) const {
	return s_hard_link_graph->exists (*x);
}

bool ObjectTreeResolver::PSortByUID::operator()(const ObjectTreeResolver** const x, const ObjectTreeResolver** const y) const {
	/*bool is_navigable = false;
	bool is_root = false;
	((*x)->is_it_supplier (*y, is_navigable, is_root));
	bool cmp_res = is_navigable;
	if  (cmp_res == false) {
		((*y)->is_it_supplier (*x, is_navigable, is_root));
		cmp_res = is_navigable;
		if (cmp_res == false) {
			cmp_res = (*x)->compare ((*y));
		}
	}
	return cmp_res;*/
	return (*x)->compare ((*y)) < 0;
}

int odp_compare_ex (const void *a1, const void *a2) {
	ObjectTreeResolver** otr_x = *(ObjectTreeResolver***)a1;
	ObjectTreeResolver** otr_y = *(ObjectTreeResolver***)a2;

	return ObjectTreeResolver::odp_compare (*otr_x, *otr_y);
}

//внутренний функтор для сортировки, используется на этампе подготовки данных для сортировки
int odp_compare_internal ( const void *a1, const void *a2 ) {
	ObjectTreeResolver** x = *(ObjectTreeResolver***)a1;
	ObjectTreeResolver** y = *(ObjectTreeResolver***)a2;

	if ( (*y)->is_it_first ( *x ) ) {
		return -1;
	} else if ( (*x)->is_it_first ( *y ) ) {
		return 1;
	} else {
		return 0;
	}
}


ObjectTreeResolver::ObjectTreeResolver (const ObjectTreeResolver* parent ) {	
	init (parent);
}

void ObjectTreeResolver::init (const ObjectTreeResolver* parent ) {	
	m_own_tree = false;
	if (parent) {		
		s_tree->add_child (parent, this);
	} else {
		if (!s_tree) {
			s_tree = new ObjectTree (this);

			m_own_tree = true;
		} else {
			// looks like create temp dumper
		}
	}
}

void ObjectTreeResolver::sort_suppliers (SortedPairSet& sorted_elems) {
	GDS_ASSERT_MSG (s_all_link_graph.ptr (), ("All link graph must be initialized"));
	GDS_ASSERT_MSG (s_hard_link_graph.ptr (), ("Hard link graph must be initialized"));
	
	ObjectTree::Items items = s_tree->sublings(this);
	std::sort (items.begin(), items.end(), PSortByUID());	
	
	ObjectTree::Items resorted_items;
	resorted_items.reserve (items.size ());
	for (
		ObjectTree::Items::iterator i = items.begin ()
		; i != items.end ()
		; ++i
	) {
		ObjectTreeResolver** p = const_cast<ObjectTreeResolver**>(*i);		
		if (s_hard_link_graph->exists (*p)) {
			//элементы связанные жесткой связью кладём в начало списка
			resorted_items.insert (resorted_items.begin (), *i);
		} else {
			//остальные в конец
			resorted_items.push_back (*i);
		}
	}
		
	ObjectTree::Items::iterator it;
	
	for (it = resorted_items.begin(); it != resorted_items.end(); it++ ) {
		ObjectTreeResolver** p = const_cast<ObjectTreeResolver**>(*it);
		SortedPairSet::value_type key (this, *p);
		if (sorted_elems.find (key) == sorted_elems.end ()) {
			//пара элементов ещё не была отсортированна
			set_suppler_position (*p);
			(*p)->set_suppler_position (this);

			//запоминаем, пару элементов в списке уже сортированных
			//sorted_elems.push_back (key);
			//sorted_elems.push_back (SortedPairSet::value_type (*p, this));
			sorted_elems.insert (key);
			sorted_elems.insert (SortedPairSet::value_type (*p, this));
		}		
	}
	// sort suppliers on child
	items = s_tree->childs (this);
	std::sort (items.begin(), items.end(), PSortByUID());
	
	SortedPairSet already_sorted_elems;
	for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
		ObjectTreeResolver** p = const_cast<ObjectTreeResolver**>(*it);
		(*p)->sort_suppliers(already_sorted_elems);
	}
}

/*void ObjectTreeResolver::clean_forward ( OTRSet& scope ) {
#ifdef _DEBUG
	{
		TRACE ("dump forward for %s\n", this->get_full_name().data());

		for (OTRSet::iterator it = m_forwarded_suppliers.begin(); it != m_forwarded_suppliers.end(); it++) {
			TRACE ("\t%s\n", (*it)->get_full_name().data());
		}
	}
#endif // _DEBUG	
	{
		m_not_in_scope_forwarded_suppliers = m_forwarded_suppliers;
		// erase
		OTRSet::iterator it;
		OTRSet::iterator it_end = scope.end();
		for ( it = scope.begin(); it != it_end; it++) {
			m_forwarded_suppliers.erase (*it);
		}

		// insert
				
		scope.insert (m_forwarded_suppliers.begin(),m_forwarded_suppliers.end());
		scope.insert (this);
	}
	
	// clean on child
	ObjectTree::Items items = s_tree->childs (this);
	GCL::uqsort (items.begin(), items.size(), sizeof(ObjectTree::Item_ptr), odp_compare_internal);

	for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
		ObjectTreeResolver** p = const_cast<ObjectTreeResolver**>(*it);
		(*p)->clean_forward(scope);
	}
}*/

long g_is_it_supplier_intend = 0;

bool ObjectTreeResolver::is_it_supplier ( 
	const ObjectTreeResolver* supplier, 
	bool& is_navigable, 
	bool& is_root,
	OTRVector& base 
) const {

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("ObjectTreeResolver::is_it_supplier");	
#endif
	
	bool ret_val = false;
	is_root = false;
	is_navigable = false;


	int distance = s_all_link_graph->get_distance (this, supplier);
	if (distance > 0 && distance != DependencyGraph::UNDEFINED_DISTANCE) {
		//длина пути больше 0
		ret_val = true;
		if (distance == 1) {
			//связь прямая
			is_root = true;
		}
		int hard_distance = s_hard_link_graph->get_distance (this, supplier);
		if (hard_distance > 0 && hard_distance != DependencyGraph::UNDEFINED_DISTANCE) {
			is_navigable = true;
		}
	}

	
	return ret_val;
}

void ObjectTreeResolver::add_supplier_spec (
	const ObjectTreeResolver* sup
	, SupplierType supl_type
	, const std::string& link_stereotype
	, bool need_check_visibility
	, bool need_check_access
) {
	if (sup) {
		if (supl_type == ST_NAVIGABLE) {
			Supplier_set::iterator it = m_directive_suppliers.find(SupplierInfo(sup));
			if ( it == m_directive_suppliers.end() ) {
				m_directive_suppliers.insert(SupplierInfo(sup, link_stereotype));
			} else {
				GCL::StrSet* ptr = const_cast<GCL::StrSet*>(&((*it).link_stereotypes));
				ptr->insert(link_stereotype);
			}
		} else if (supl_type == ST_NOT_NAVIGABLE) {
			Supplier_set::iterator it2 = m_suppliers.find(SupplierInfo(sup));
			if ( it2 == m_suppliers.end() ) {
				m_suppliers.insert(SupplierInfo(sup, link_stereotype));
			} else {
				GCL::StrSet* ptr2 = const_cast<GCL::StrSet*>(&((*it2).link_stereotypes));
				ptr2->insert(link_stereotype);
			}
		} else {
			Supplier_set::iterator it2 = m_other_suppliers.find(SupplierInfo(sup));
			if ( it2 == m_other_suppliers.end() ) {
				m_other_suppliers.insert(SupplierInfo(sup, link_stereotype));
			} else {
				GCL::StrSet* ptr2 = const_cast<GCL::StrSet*>(&((*it2).link_stereotypes));
				ptr2->insert(link_stereotype);
			}
		}
	
		// link consumer
		if (need_check_access && !this->check_access (sup)) {
			this->write_error_log ("Wrong access to " + sup->get_full_name(), false);
			//link_stereotype += " WRONG ACCESS";
		}

		if (need_check_visibility && !this->check_visibility (sup, link_stereotype)) {
			//this->write_error_log ("Can't access to " + sup->get_full_name());
			//link_stereotype += " WRONG VISIBILITY";
		}

		sup->add_consumer (this, link_stereotype);
	}	
}

void ObjectTreeResolver::add_supplier (
	const ObjectTreeResolver* sup
	, SupplierType supl_type
	, const std::string& link_stereotype
) {
	add_supplier_spec (sup, supl_type, link_stereotype, true, true)	;
}

bool ObjectTreeResolver::check_protected_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const {
	const ObjectTreeResolver* par = this->get_parent_category ();
	return (sup->get_parent_category () == par);
}

bool ObjectTreeResolver::check_private_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const {
	return false;
}

bool ObjectTreeResolver::check_visibility (const ObjectTreeResolver* sup, const std::string& link_stereotype) const {
	const ObjectTreeResolver* consumer = this->get_nearest_container();
	const ObjectTreeResolver* sup_par = sup->ObjectTreeResolver::get_parent_category ();

	VisibilityType sup_vt = sup->get_visibility_type();
	if (sup_vt == VT_PROTECTED) {
		if (sup_par != consumer) {
			if (!consumer->check_protected_visibility_access (sup, link_stereotype)) {		
				this->write_error_log ("Can't access to PROTECTED " + sup->get_full_name(), false);
				return false;
			}
		}
	} else if (sup_vt == VT_PRIVATE) {
		if (sup_par != consumer) {
			if (!consumer->check_private_visibility_access (sup, link_stereotype)) {
				this->write_error_log ("Can't access to PRIVATE " + sup->get_full_name(), false);
				return false;
			}
		}
	} else if (sup_vt == VT_IMPL) {
		if (link_stereotype != ST_LINK_INH && link_stereotype != ST_LINK_DEP) {
			std::string log = "Invalid access (" + link_stereotype;
			log += ") to IMPLEMENTATION (cant only generalize) " + sup->get_full_name();
			this->write_error_log (log, false);
			return false;
		}
	}

	if (sup_par->get_visibility_type() == VT_IMPL) {
		if (sup_par != consumer->get_parent_category()) {
			if (link_stereotype != ST_LINK_INH) {
				std::string log = "Invalid access (" + link_stereotype;
				log += ") to IMPLEMENTATION (cant only generalize) " + sup->get_full_name();
				this->write_error_log (log, false);
				return false;
			}
		}
	}
	return true;
}

bool ObjectTreeResolver::check_access (const ObjectTreeResolver* sup) const {
	//TRACE ("%s::check_access to %s\n", this->get_full_name().data(), sup->get_full_name().data());
	class local {
	public:
		static bool is_global_recursive (const ObjectTreeResolver* otr) {
			bool is_global = otr->is_global ();
			while (!is_global && (otr = otr->get_parent_category ())) {
				is_global = otr->is_global ();
			}

			return is_global;
		}
	};

	const ObjectTreeResolver* sup_par = sup;
	bool this_is_global = local::is_global_recursive (this);
	do {
		bool sup_par_is_global = local::is_global_recursive (sup_par);
		std::string sup_par_name (sup_par->get_full_name ());
		bool sup_is_primitive = GCL::start_with (sup_par_name.c_str (), "Logical View::Primitives");
		if (sup_par == this || sup_par_is_global) {
			if (				
				sup_par_is_global
				&& !this_is_global //не расставляем автоматом зависимости между глобальными элементами
				&& !sup_is_primitive
			) {
				this->set_dependencies (
					sup
					, boost::lambda::bind (
						&ObjectTreeResolver::add_supplier_spec
						, boost::lambda::ll_const_cast<ObjectTreeResolver*> (boost::lambda::_1)
						, boost::lambda::_2
						, ST_NOT_NAVIGABLE
						, ST_LINK_DEP
						, false
						, false
					)
				);
			}
			
			return true;
		}
	} while (sup_par = sup_par->get_parent_category ());

	sup_par = sup->get_parent_category ();
	GDS_ASSERT (sup_par);
	
	const ObjectTreeResolver* par = this->get_parent_category ();

	if (
		par == sup_par	//если элементы лежат в одной папке
		|| par == sup	//если папка в которой лежит элемент (this) является sup
						//т.е если элемент зависит от папки, в которой находится
		|| s_tree->is_child_of_parent (sup_par, par)	//если sup лежит в папке, являющейся дочерней папкой
														//, папки в которой лежит this
	) {
		return true;
	}
	if (
		par->m_suppliers.find(sup_par) != par->m_suppliers.end()
		|| par->m_directive_suppliers.find(sup_par) != par->m_directive_suppliers.end()
		|| par->m_other_suppliers.find(sup_par) != par->m_other_suppliers.end()
		|| par->m_suppliers.find(sup) != par->m_suppliers.end()
		|| par->m_directive_suppliers.find(sup) != par->m_directive_suppliers.end()
		|| par->m_other_suppliers.find(sup) != par->m_other_suppliers.end()
		|| this->m_suppliers.find(sup_par) != this->m_suppliers.end()
		|| this->m_directive_suppliers.find(sup_par) != this->m_directive_suppliers.end()
		|| this->m_other_suppliers.find(sup_par) != this->m_other_suppliers.end()
	) {			
		return true;
	} else {
		if (
			sup_par->is_global_locally () 
			|| par->is_global_locally ()
		) {
			const ObjectTreeResolver* par_par = par->get_parent_category ();
			while (par_par->is_global_locally () || par_par == sup_par) {
				par_par = par_par->get_parent_category ();
			}

			const ObjectTreeResolver* sup_par_par = sup_par->get_parent_category ();
			while (par_par->is_global_locally () || par_par == par || par_par == sup_par_par) {
				sup_par_par = sup_par_par->get_parent_category ();
			}

			if (par_par == sup_par_par || par_par == sup_par || sup_par_par == par) {
				return true;
			} else {
				return par_par->check_access (sup_par_par);
			}

		}
		return false;
	}	
}

bool ObjectTreeResolver::is_global() const {
	return false;
}

void ObjectTreeResolver::add_consumer (const ObjectTreeResolver* consumer, std::string link_stereotype) const {
	m_consumers.insert (ConsumerInfo(link_stereotype, consumer));
}

void ObjectTreeResolver::link_all_suppliers () {
	link_suppliers();
	ObjectTree::Items items = s_tree->childs (this);
	for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
		ObjectTreeResolver** p = const_cast<ObjectTreeResolver**>(*it);
		(*p)->link_all_suppliers();
	}
}

void ObjectTreeResolver::add_forward_supplier ( const ObjectTreeResolver* sup ) {
	m_forwarded_suppliers.insert(sup);
}

unsigned ObjectTreeResolver::suppliers_count () const {
	return m_suppliers.size() + m_directive_suppliers.size() + m_other_suppliers.size();
}

void ObjectTreeResolver::clear_suppliers () {
	class local {
	public:
		static void clear_suppliers (Supplier_set& set, const ObjectTreeResolver* this_) {
			for (Supplier_set::iterator it = set.begin (); it != set.end (); ++it) {
				it->supplier->remove_consumer (this_);
			}

			set.clear ();
		}
	};
	local::clear_suppliers (m_suppliers, this);
	local::clear_suppliers (m_directive_suppliers, this);
	local::clear_suppliers (m_other_suppliers, this);
}

bool ObjectTreeResolver::is_it_first ( const ObjectTreeResolver* od ) const {
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("ObjectTreeResolver::is_it_first (const ObjectTreeResolver* od)");
#endif
	class local {
	public:
		static bool impl (const ObjectTreeResolver* this_, const ObjectTreeResolver* od) {
			if ( od ) { 
				OTRVector base;
				if (this_->is_it_scope_no_forward(od, base)) {
					return true;
				}
			}
			return false;
		}
	};
	
	bool res;
	AlgorithmMap::key_type key (this, od);
	AlgorithmMap::iterator it = s_is_it_first_cache.find (key);
	if (it == s_is_it_first_cache.end ()) {
		it = s_is_it_first_cache.insert (
			AlgorithmMap::value_type (
				key
				, local::impl (this, od)
			)
		).first;
	}
	res = it->second;
	
	//res = local::impl (this, od);
	return res;
	//return local::impl (this, od);
}

bool ObjectTreeResolver::is_it_scope ( const ObjectTreeResolver* od, OTRVector& base  ) const {
	//TRACE ("is_it_scope[%s] (%s)\n", get_full_name().data(), od->get_full_name().data());
	if ( od == this ) {
		return true;
	}

	if ( m_forwarded_suppliers.find (od) != m_forwarded_suppliers.end() ) {
		return true;
	}

	if ( std::find (base.begin(), base.end(), this) != base.end() ) {
		// cycle
		//TRACE ( "\tRET : 0 (cycle)\n");
		return false;
	} else {
		base.push_back(this);
	}

	for (OTRSet::const_iterator it = m_top_suppliers.begin(); it != m_top_suppliers.end(); it++) {
		if ( (*it)->is_it_scope(od, base) ) {
			return true;
		}
	}
	
	return false;
}

bool ObjectTreeResolver::is_it_scope_no_forward ( const ObjectTreeResolver* od, OTRVector& base ) const {
	class local {
	public:
		static bool impl (const ObjectTreeResolver* this_, const ObjectTreeResolver* od, OTRVector& base) {
			if (od == this_) {
				return true;
			}

			if (std::find (base.begin(), base.end(), this_) != base.end()) {
				return false;
			} else {
				base.push_back(this_);
			}
			
			OTRSet::const_iterator it = this_->m_top_suppliers.begin();
			OTRSet::const_iterator it_end = this_->m_top_suppliers.end();

			for (; it != it_end; ++it) {
				if (local::impl (*it, od, base)) {
					return true;
				}
			}
			return false;
		}
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("ObjectTreeResolver::is_it_scope_no_forward (const ObjectTreeResolver* od, OTRVector& base)");
#endif

	return local::impl (this, od, base);
}

void ObjectTreeResolver::set_suppler_position ( ObjectTreeResolver* od ) {
	class local {
	public:
		static bool is_self_top (
			ObjectTreeResolver* this_
			, ObjectTreeResolver* od
			, bool& is_back_root
			, bool& need_position
		) {
			need_position = true;
			is_back_root = false;

			bool self_top = false;			
			bool is_navigable = false;
			bool is_root = false;			
			bool is_back_navigable = false;			

			if (od->is_it_supplier (this_, is_navigable, is_root)) {
				//элемент od является поставщиком для текущего элемента
				self_top = true;
				//TRACE ( " *** check back suppl\n" );

				if (this_->is_it_supplier (od, is_back_navigable, is_back_root)) {
					//текущий элемент является поставщиком для элемента od
										
					// check for existent resolve
					OTRVector base;
					if (this_->is_it_scope_no_forward (od, base) ) {
						//TRACE ( "RET:set_suppler_position: allready in scope\n" );
						need_position = false;
						return false;
					}

					// resolve cycle
					bool sup_must_be_top = is_back_navigable || od->is_forbiden_forward_dcl();
					bool sup_must_be_bottom = is_navigable || this_->is_forbiden_forward_dcl();
					if ( sup_must_be_top && sup_must_be_bottom) {				
						Core::Aptr<DependencyGraph::Path> path = s_hard_link_graph->get_path (this_, od);
						const ObjectTreeResolver* fwd_item = 0;	
						if (path.is_nil () == false) {
							//если элементы жестко не связаны, то возможно можно найти промежуточный элемент, через
							//который они могут быть форвард декларированны
							if (path->empty ()) {
								//проверяем есть ли в пути зависимости элемент, который можно фарвард-декларировать
								path = s_all_link_graph->get_path (this_, od);

								bool fwd_is_navigable = false;
								bool fwd_is_root = false;
								for (
									DependencyGraph::Path::iterator it = path->begin ()
									; it != path->end ()
									; ++it
								) {
									if (
										this_->is_it_supplier (*it, fwd_is_navigable, fwd_is_root) == true
										&& od->is_it_supplier (*it, fwd_is_navigable, fwd_is_root) == true
										&& (*it)->is_forbiden_forward_dcl () == false
									) {
										fwd_item = *it;
										break;
									}
								}
							}
						}
						if (fwd_item == 0) {
							//в списке пути от элемента this к od нет элемента,
							//который бы можно было форвард декларировать
							std::ostringstream stream;
							for (
								DependencyGraph::Path::iterator it = path->begin ()
								; it != path->end ()
								; ++it
							) {
								stream << "{" << (*it)->get_full_name () << "}";
								if (std::distance (it, path->end ()) > 1) {
									stream << "->";
								}
							}
							std::string mess ("Невозможно разрешить зависимость (возможно циклическая связь: ");
							std::string err (mess);
							mess += od->get_full_name ();
							this_->write_error_log (mess, false);					
							err += stream.str ().empty () ? od->get_full_name (): stream.str ();
							err += ")";
							this_->write_error_log (err, true);					
						} else {
							need_position = false;
							return false;
						}

						// TODO : Ask user to resolve problem
						sup_must_be_top = false;
					}

					if ( !sup_must_be_bottom && sup_must_be_top ) {
						self_top = false;						
					}
				}
			}
			return self_top;
		}
	};
	
	bool need_position = true;
	bool is_back_root = false;
	
	bool self_top = local::is_self_top (this, od, is_back_root, need_position);
	if (self_top && need_position) {
		if (is_back_root) {	
			long self_fwd_weight = this->get_fwd_weight ();
			long od_fwd_weight = od->get_fwd_weight ();
			bool od_self_top = local::is_self_top (od, this, is_back_root, need_position);
			if (od_fwd_weight >= self_fwd_weight || od_self_top == false) {
				this->add_forward_supplier ( od );
			} else {
				self_top = false;
			}
		}
		if (self_top) {
			od->m_top_suppliers.insert(this);
			m_botom_consumers.insert(od);
		}
	}

	//TRACE ( "RET: set_suppler_position : %d\n", self_top );
}

ObjectTreeResolver::OTRSet ObjectTreeResolver::get_supplier_by_stereotype (const std::string& stereotype) const {
	OTRSet res; 
	Supplier_set::const_iterator it;
	for (it = m_directive_suppliers.begin(); it != m_directive_suppliers.end(); it++) {
		if ( (*it).link_stereotypes.find (stereotype) != (*it).link_stereotypes.end() ) 
			res.insert((*it).supplier);
	}
	for (it = m_suppliers.begin(); it != m_suppliers.end(); it++) {
		if ( (*it).link_stereotypes.find (stereotype) != (*it).link_stereotypes.end() )
			res.insert((*it).supplier);
	}
	for (it = m_other_suppliers.begin(); it != m_other_suppliers.end(); it++) {
		if ( (*it).link_stereotypes.find (stereotype) != (*it).link_stereotypes.end() )
			res.insert((*it).supplier);
	}
	return res;
}

ObjectTreeResolver::OTRSet ObjectTreeResolver::get_supplier_by_stereotypes (const GCL::StrSet& stereotypes) const {
	OTRSet res; 
	Supplier_set::const_iterator it;

	for (it = m_directive_suppliers.begin(); it != m_directive_suppliers.end(); it++) {
		for (GCL::StrSet::const_iterator st_it = stereotypes.begin(); st_it != stereotypes.end(); st_it++) {
			if ((*it).link_stereotypes.find (*st_it) != (*it).link_stereotypes.end()) {
				res.insert((*it).supplier);
				break;
			}
		}
	}

	for (it = m_suppliers.begin(); it != m_suppliers.end(); it++) {
		for (GCL::StrSet::const_iterator st_it = stereotypes.begin(); st_it != stereotypes.end(); st_it++) {
			if ( (*it).link_stereotypes.find (*st_it) != (*it).link_stereotypes.end() ) {
				res.insert((*it).supplier);
				break;
			}
		}
	}

	for (it = m_other_suppliers.begin(); it != m_other_suppliers.end(); it++) {
		for (GCL::StrSet::const_iterator st_it = stereotypes.begin(); st_it != stereotypes.end(); st_it++) {
			if ( (*it).link_stereotypes.find (*st_it) != (*it).link_stereotypes.end() ) {
				res.insert((*it).supplier);
				break;
			}
		}
	}

	return res;
}

/*ObjectTreeResolver::OTRSet ObjectTreeResolver::get_all_supplier_by_stereotype (std::string stereotype) const {
	ObjectTreeResolver::OTRSet& res = this->get_supplier_by_stereotype (stereotype);

	ObjectTree::Items items = s_tree->childs (this);
	for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
		ObjectTreeResolver** p = const_cast<ObjectTreeResolver**>(*it);
		res += (*p)->get_all_supplier_by_stereotype(stereotype);		
	}

	return res;
}*/


ObjectTreeResolver::OTRSet ObjectTreeResolver::get_all_suppliers () const {
	OTRSet res;
	/*DependencyGraph::ReachableItems reachable = s_all_link_graph->get_reachable (this);
	if (reachable.empty () == false) {
		res.insert (reachable.begin (), reachable.end ());
	}*/
	
	for (Supplier_set::const_iterator it = m_directive_suppliers.begin(); it != m_directive_suppliers.end(); it++) {		
		res.insert((*it).supplier);
	}
	
	for (Supplier_set::const_iterator it = m_suppliers.begin(); it != m_suppliers.end(); it++) {
		res.insert((*it).supplier);
	}
	
	for (
		Supplier_set::const_iterator it = m_other_suppliers.begin()
		; it != m_other_suppliers.end()
		; ++it
	) {
		res.insert((*it).supplier);
	}
	return res;
}

const ObjectTreeResolver::Consumer_set& ObjectTreeResolver::get_consumer_infos () const {
	return m_consumers;
}

ObjectTreeResolver::OTRSet ObjectTreeResolver::get_consumer_by_stereotype (const std::string& stereotype) const {
	OTRSet res; 
	Consumer_set::const_iterator it;
	for (it = m_consumers.begin(); it != m_consumers.end(); it++) {
		if ( (*it).link_stereotype == stereotype ) {
			res.insert((*it).consumer);
		}
	}
	return res;
}

const ObjectTreeResolver::OTRSet& ObjectTreeResolver::forwarded_suppliers () const {
	return m_forwarded_suppliers;
}

const ObjectTreeResolver* ObjectTreeResolver::get_parent_category () const {	
	return *(s_tree->parent(this));
}

const ObjectTreeResolver* ObjectTreeResolver::get_nearest_container () const {	
	return *(s_tree->parent(this));
}

//удаляет себя из списков зависимых элементов
void ObjectTreeResolver::remove_from_consumers () {	
	class local {
	public:
		static void remove_from_suppliers (Supplier_set& suppliers, const ObjectTreeResolver* elem) {
			for (
				Supplier_set::iterator it = suppliers.begin ()
				; it != suppliers.end ()
				; ++it
			) {
				it->supplier->remove_consumer (elem);
			}

			suppliers.clear ();
		}
	};

	for (
		Consumer_set::iterator c_it = this->m_consumers.begin ()
		; c_it != this->m_consumers.end ()
		;
	) {
		ObjectTreeResolver* consumer = const_cast<ObjectTreeResolver*> (c_it->consumer);
		this->m_consumers.erase (c_it++);
		
		//нужно у consumer'а удалить this из списка suppliers:
		consumer->remove_supplier (this);
	}

	local::remove_from_suppliers (m_suppliers, this);
	local::remove_from_suppliers (m_directive_suppliers, this);
	local::remove_from_suppliers (m_other_suppliers, this);
}

//удаляет supplier-а
void ObjectTreeResolver::remove_supplier (const ObjectTreeResolver* supplier) {
	m_suppliers.erase (SupplierInfo (supplier));
	m_directive_suppliers.erase (SupplierInfo (supplier));
	m_other_suppliers.erase (SupplierInfo (supplier));

	supplier->remove_consumer (this);
}


void ObjectTreeResolver::remove_consumer (const ObjectTreeResolver* consumer) const {
	for (
		Consumer_set::iterator c_it = this->m_consumers.begin ()
		; c_it != this->m_consumers.end ()
		;
	) {
		if (c_it->consumer == consumer) {
			this->m_consumers.erase (c_it++);
		} else {
			++c_it;
		}
	}
}

void ObjectTreeResolver::remove_consumer (
	const ObjectTreeResolver* consumer
	, const std::string& link_stereotype
) const {
	this->m_consumers.erase (ConsumerInfo (link_stereotype, consumer));
}
//#UC END# *4571A0B90148*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool ObjectTreeResolver::ConsumerInfo::operator < (const ConsumerInfo& y) const {
	//#UC START# *4575430E01C1_LESS*
	return y.consumer < consumer || (y.consumer == consumer && y.link_stereotype < link_stereotype);
	//#UC END# *4575430E01C1_LESS*
}

ObjectTreeResolver::ConsumerInfo::ConsumerInfo (
	const std::string& link_stereotype_
	, const ObjectTreeResolver* consumer_
)
//#UC START# *4575430E01C1_INIT_CTOR_BASE_INIT*
	: link_stereotype(link_stereotype_), consumer(consumer_)
//#UC END# *4575430E01C1_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4575430E01C1_INIT_CTOR*
	//#UC END# *4575430E01C1_INIT_CTOR*
}


bool ObjectTreeResolver::OTRPair::operator < (const OTRPair& y) const {
	//#UC START# *4A50B6F90198_LESS*
	return this->first < y.first ? true : this->second < y.second;
	//#UC END# *4A50B6F90198_LESS*
}



//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// граф, содержащий все (жесткие и нежусткие связи)
Core::Box<DependencyGraph> ObjectTreeResolver::s_all_link_graph;

// граф, содержащий только жесткие связи
Core::Box<DependencyGraph> ObjectTreeResolver::s_hard_link_graph;

// формирует графы использования, граф строится начиная с узла root
void ObjectTreeResolver::fill_graph (const ObjectTreeResolver* root) {
	//#UC START# *476FA8A00394*
	class local {
	public:
		static void fill_graph_i (
			const ObjectTreeResolver* parent
			, const ObjectTreeResolver* for_otr
			, const ObjectTreeResolver* root
		) {
			const ObjectTreeResolver* for_otr_container = *(s_tree->parent (for_otr));
			const ObjectTreeResolver* for_otr_category = for_otr->get_parent_category ();
			for_otr_container = for_otr_container ? for_otr_container->get_nearest_container () : 0;
			for (
				Supplier_set::const_iterator it = for_otr->m_directive_suppliers.begin ()
				; it != for_otr->m_directive_suppliers.end ()
				; ++it
			) {
				if (s_tree->is_child_of_parent((*it).supplier, root)) {
					//добавляем связь между родительскими контэйнерами связанных элементов
					//при этом проверяем, что эти контэйнеры - не папки!
					if (
						for_otr == parent 
						&& for_otr_container
						&& for_otr_container != for_otr_category
					) {
						const ObjectTreeResolver* supplier_container = *(s_tree->parent ((*it).supplier));
						supplier_container = supplier_container ? supplier_container->get_nearest_container () : 0;
						if (
							supplier_container 
							&& supplier_container != (*it).supplier->get_parent_category ()
							&& supplier_container != for_otr_container
						) {
							s_all_link_graph->add_edge (for_otr_container, supplier_container);
						}
					}

					s_all_link_graph->add_edge (parent, (*it).supplier);
					s_hard_link_graph->add_edge (parent, (*it).supplier);
				}
			}

			for (
				Supplier_set::const_iterator it = for_otr->m_suppliers.begin ()
				; it != for_otr->m_suppliers.end ()
				; ++it
			) {
				if (s_tree->is_child_of_parent((*it).supplier, root)) {
					//добавляем связь между родительскими контэйнерами связанных элементов
					//при этом проверяем, что эти контэйнеры - не папки!
					if (
						for_otr == parent 
						&& for_otr_container
						&& for_otr_container != for_otr_category
					) {
						const ObjectTreeResolver* supplier_container = *(s_tree->parent ((*it).supplier));
						supplier_container = supplier_container ? supplier_container->get_nearest_container () : 0;
						if (
							supplier_container 
							&& supplier_container != (*it).supplier->get_parent_category ()
							&& supplier_container != for_otr_container
						) {
							s_all_link_graph->add_edge (for_otr_container, supplier_container);
						}
					}

					s_all_link_graph->add_edge (parent, (*it).supplier);
				}
			}
			ObjectTree::Items items = s_tree->childs (for_otr);
			for (ObjectTree::Items::iterator child_it = items.begin(); child_it != items.end(); ++child_it) {
				fill_graph_i (parent, *(*child_it), root);
			}
		}
	};

#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	if (s_all_link_graph.is_nil ()) {
		//заполняем граф, только если он не уже не заполнен!!!

		s_all_link_graph = new DependencyGraph ();
		s_hard_link_graph = new DependencyGraph ();

		ObjectTree::Items childs = s_tree->all_childs (root);
		ObjectTree::Items::iterator it = childs.begin ();
		ObjectTree::Items::iterator it_end = childs.end ();
		
		for (; it != it_end; it++) {
			//элементы, которые сортируются в порядке создания не нужно добавлять в граф
			if (!(**it)->sort_in_model_order ()) {
				local::fill_graph_i (**it, **it, root);
			}
		}	
	}
	//#UC END# *476FA8A00394*
}

// очищает графы
void ObjectTreeResolver::clear_graph () {
	//#UC START# *47CFCEB9033D*
	s_all_link_graph = 0;
	s_hard_link_graph = 0;
	//#UC END# *47CFCEB9033D*
}

// сортирует элементы дерева генерации по использованию, в результате работы будет сформирован
// отсортированный в порядке использования список элементов, который может использоваться в
// функторах сортировки
void ObjectTreeResolver::sort_tree (const ObjectTreeResolver* root) {
	//#UC START# *49365B4F0134*
	class local {
	public:
		static void impl (const ObjectTreeResolver* this_) {
			ObjectTree::Items items = s_tree->childs (this_);
			if (!items.empty ()) {
				GCL::uqsort (&(*(items.begin())), items.size(), sizeof(ObjectTree::Item_ptr), odp_compare_internal);
				
				for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++ ) {
					const ObjectTreeResolver* otr = *(*it);
					ObjectTreeResolver::SortedTreeItemsSingleton::instance ()->ptr.push_back (otr);

					local::impl (otr);
				}
			}
		}
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif
	SortedTreeItemsSingleton::instance ()->ptr.clear ();
	s_is_it_first_cache.clear ();

	//сбрасываем данные для сортировки
	typedef ObjectTree::iterator tree_iterator;

	ObjectTree::Items all_childs = s_tree->all_childs (root);
	ObjectTree::Items::iterator it = all_childs.begin ();
	ObjectTree::Items::iterator it_end = all_childs.end ();
	
	for (
		; it != it_end
		; ++it
	) {
		ObjectTreeResolver* p = const_cast<ObjectTreeResolver*>(*(*it));
		p->m_top_suppliers.clear ();
		p->m_botom_consumers.clear ();
		p->m_not_in_scope_forwarded_suppliers.clear ();
		p->m_forwarded_suppliers.clear ();
	}

	//запускаем алгоритм формирования данных для сортировки по использованию
	{
		ObjectTree::Items items = s_tree->childs (root);
		std::sort (items.begin(), items.end(), PSortByUID());
		
		SortedPairSet already_sorted_elems;

		for (ObjectTree::Items::iterator it = items.begin(); it != items.end(); it++) {
			ObjectTreeResolver** p = const_cast<ObjectTreeResolver**>(*it);
			(*p)->sort_suppliers(already_sorted_elems);
		}
	}

	//формируем список всех элементов дерева генерации, отсортированных по использованию
	SortedTreeItemsSingleton::instance ()->ptr.clear ();
	local::impl (root);
	//#UC END# *49365B4F0134*
}

// Cравнивает два элемента возвращает -1, если x находится ближе к началу cписка использования, 1,
// если ближе y, в остальных случаях возвращает 0. Данный метод используется для реализации
// функторов сортировки.
int ObjectTreeResolver::odp_compare (const ObjectTreeResolver* x, const ObjectTreeResolver* y) {
	//#UC START# *4936621D01CE*
	if (x && y) {
		typedef ObjectTreeResolver::OTRVector::const_iterator otr_iterator;
		otr_iterator b_it = SortedTreeItemsSingleton::instance ()->ptr.begin ();
		otr_iterator end_it = SortedTreeItemsSingleton::instance ()->ptr.end ();
		
		otr_iterator x_it = std::find (
			b_it
			, end_it
			, x
		);

		otr_iterator y_it = std::find (
			b_it
			, end_it
			, y
		);

		if (x_it != end_it && y_it != end_it) {
			std::iterator_traits<otr_iterator>::difference_type pos_x = std::distance (b_it, x_it);
			std::iterator_traits<otr_iterator>::difference_type pos_y = std::distance (b_it, y_it);
			
			if (pos_x < pos_y) {
				return -1;
			} else if (pos_x > pos_y) {
				return 1;
			}
		} else if (x != y) {
			const ObjectTreeResolver** p_x = &x;
			const ObjectTreeResolver** p_y = &y;

			const ObjectTreeResolver*** pp_x = &p_x;
			const ObjectTreeResolver*** pp_y = &p_y;
			return odp_compare_internal (pp_x, pp_y);
		}
	}
	return 0;
	//#UC END# *4936621D01CE*
}

// найти элемент дерева по имени (имя модет содержать путь от родителя для более точного поиска) -
// возвращает список найденных элементов
ObjectTreeResolver::OTRVector* ObjectTreeResolver::find_by_name (const std::string& name) {
	//#UC START# *4A9BB6A90219*
	Core::Aptr<ObjectTreeResolver::OTRVector> elements (new ObjectTreeResolver::OTRVector ());
	if (s_tree) {
		ObjectTreeResolver::ObjectTree::iterator it = ObjectTreeResolver::s_tree->begin ();
		ObjectTreeResolver::ObjectTree::iterator end = ObjectTreeResolver::s_tree->end ();

		size_t len = name.length ();
		for (; it != end; it++) {
			const ObjectTreeResolver* otr = *(*it);
			std::string full_name = otr->get_full_name ();

			//проверяем, что полное имя элемента заканчивается на name
			size_t full_name_len = full_name.size ();
			std::string::size_type pos = full_name.rfind (name);
			if (
				pos != std::string::npos 
				&& (
					pos == 0
					|| (
						pos > 1
						&& pos + len == full_name_len
						&& full_name[pos - 1] == ':'
						&& full_name[pos - 2] == ':'
					)
				)
			) {
				elements->push_back (otr);
			}
		}
	}

	return elements.forget ();
	//#UC END# *4A9BB6A90219*
}

// метод очистки кэшей - должен обязательно вызываться при открытии другой модели или при изменении
// текущей
void ObjectTreeResolver::clean_up () {
	//#UC START# *4AA9DA5602BF*
	ObjectTreeResolver::clear_graph ();
	SortedTreeItemsSingleton::instance ()->ptr.clear ();
	s_is_it_first_cache.clear ();
	//#UC END# *4AA9DA5602BF*
}

// вызывается при начале генерации - очищает сортировочные кэши (кэши нужно очищать, т.к сортировка
// каждый раз выполняется заново, но перед сортировкой запускает spell)
void ObjectTreeResolver::on_generation_start () {
	//#UC START# *4AA9DB2C0014*
	SortedTreeItemsSingleton::instance ()->ptr.clear ();
	s_is_it_first_cache.clear ();
	//#UC END# *4AA9DB2C0014*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ObjectTreeResolver::~ObjectTreeResolver () {
	//#UC START# *4571A0B90148_DESTR_BODY*	
	//#UC END# *4571A0B90148_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает список элементов от которых зависит данный, список без дубликатов
void ObjectTreeResolver::collect_suppliers_by_type (SupplierType type, OTRVector& collection) const {
	//#UC START# *4B34A4420128*
	class local {
	public:
		static void to_vector (const Supplier_set& set, OTRVector& collection) {
			for (
				Supplier_set::const_iterator it = set.begin ()
				; it != set.end ()
				; ++it
			) {
				collection.push_back (it->supplier);
			}
		}
	};

	switch (type) {
		case ST_NAVIGABLE:
			local::to_vector (m_directive_suppliers, collection);
			break;
		case ST_NOT_NAVIGABLE:
			local::to_vector (m_suppliers, collection);
			break;
		default:
			local::to_vector (m_other_suppliers, collection);
			break;
	}
	//#UC END# *4B34A4420128*
}

// рекурсивно формирует список элементов от которых зависит данный, список без дубликатов
void ObjectTreeResolver::collect_suppliers_by_type_recursive (SupplierType type, OTRVector& collection) const {
	//#UC START# *4B34A68C010C*
	class local {
	public:
		static void collect (
			const ObjectTreeResolver* otr
			, SupplierType type
			, OTRVector& collection
			, OTRSet& visited
		) {
			if (visited.find (otr) == visited.end ()) {
				OTRVector current_suppliers;
				otr->collect_suppliers_by_type (type, current_suppliers);
				visited.insert (otr);

				collection.insert (collection.end (), current_suppliers.begin (), current_suppliers.end ());
				for (
					OTRVector::const_iterator it = current_suppliers.begin ()
					; it != current_suppliers.end ()
					; ++it
				) {
					collect (*it, type, collection, visited);
				}
			}
		}

	};

	OTRSet visited;
	local::collect (this, type, collection, visited);
	//#UC END# *4B34A68C010C*
}

// сравнивнение элементов дерева
int ObjectTreeResolver::compare (const ObjectTreeResolver* od) const {
	//#UC START# *4A489BAB00DE*
	if (this < od) {
		return -1;
	} else if (this > od) {
		return 1;
	}

	return 0;
	//#UC END# *4A489BAB00DE*
}

// уровень видимости детей, если -1 - значит уровень не задан
int ObjectTreeResolver::get_childs_visibility_level () const {
	//#UC START# *4AAF10C300D1*
	return -1;
	//#UC END# *4AAF10C300D1*
}

// Cвойство локальной глобальности - если у пакета выставлено такое свойство, то считается, всем
// пакетам - соседям доступны элементы из него и его детям доступны элементы соседей, т.е как буд-
// то между ними протянута связь в обе стороны
bool ObjectTreeResolver::is_global_locally () const {
	//#UC START# *4B4DB9F00341*
	return false;
	//#UC END# *4B4DB9F00341*
}

// возвращает true, если элемент виден из любого места модели, например лежит в глобальном пакете
bool ObjectTreeResolver::is_global_visible () const {
	//#UC START# *4B0A2F9D02C0*
	const ObjectTreeResolver* item = this;
	do {
		if (item->is_global()) {
			return true;
		}
	} while (item = item->get_parent_category ());

	return false;
	//#UC END# *4B0A2F9D02C0*
}

// является ли obj supplier'ем с заданным стереотипом
bool ObjectTreeResolver::is_supplier_with_stereotype (
	const ObjectTreeResolver* obj
	, const std::string& stereotype
) const {
	//#UC START# *4B1CD55E02F5*
	OTRSet suppliers = this->get_supplier_by_stereotype (stereotype);

	return suppliers.find (obj) != suppliers.end ();
	//#UC END# *4B1CD55E02F5*
}

// разрывает связь заданного типа и заданного стереотипа
void ObjectTreeResolver::remove_supplier (
	const ObjectTreeResolver* supplier
	, SupplierType type
	, const std::string& stereotype
) {
	//#UC START# *4B1CD6F8009C*
	class local {
	public:
		static void remove_supplier_impl (
			const ObjectTreeResolver* supplier
			, Supplier_set& suppliers
			, const std::string& link_stereotype
		) {
			Supplier_set::iterator it = suppliers.find(SupplierInfo(supplier));
			if (it != suppliers.end()) {
				GCL::StrSet& link_stereotypes = const_cast<GCL::StrSet&> (it->link_stereotypes);
				link_stereotypes.erase (link_stereotype);
				if (it->link_stereotypes.empty ()) {
					suppliers.erase (SupplierInfo(supplier));
				}
			}
		}
	};

	GDS_ASSERT(supplier);
	switch (type) {
		case ST_NAVIGABLE:
			local::remove_supplier_impl (supplier, m_directive_suppliers, stereotype);			
			break;
		case ST_NOT_NAVIGABLE:
			local::remove_supplier_impl (supplier, m_suppliers, stereotype);				
			break;
		default:
			local::remove_supplier_impl (supplier, m_other_suppliers, stereotype);
			break;
	}

	OTRSet suppliers = this->get_supplier_by_stereotype (stereotype);
	if (suppliers.find (supplier) == suppliers.end ()) {
		//удаляем consumer, только в случае, если между this и supplier 
		//больше нет связей заданного стереотипа
		supplier->remove_consumer (this, stereotype);
	}
	//#UC END# *4B1CD6F8009C*
}

// Алгоритм простановки связей между родителями элементов source и target
void ObjectTreeResolver::set_dependencies (
	const ObjectTreeResolver* target
	, const AddDependencyFunctor& add_dep
) const {
	//#UC START# *4B568C5F0079*
	class local {
	public:
		static void collect_parent_cats (const ObjectTreeResolver* item, ObjectTreeResolver::OTRVector& parents) {
			if (item) {
				const ObjectTreeResolver* item_cat = item->get_parent_category ();
				while (item_cat != 0) {
					parents.push_back (item_cat);
					item_cat = item_cat->get_parent_category ();
				}

				if (parents.empty () == false) {
					//удаляем Logical View
					parents.pop_back ();
				}
			}
		}

		static bool check_cycle (
			const ObjectTreeResolver* source
			, const ObjectTreeResolver* target
		) {
			if (source->is_forbiden_forward_dcl () || target->is_forbiden_forward_dcl ()) {
				OTRVector all_deps;
				target->collect_suppliers_by_type_recursive (ST_NOT_NAVIGABLE, all_deps);

				OTRVector::iterator f_it = std::find (all_deps.begin (), all_deps.end (), source);
				if (f_it != all_deps.end ()) {				
					for (
						OTRVector::const_iterator it = all_deps.begin ()
						; it != all_deps.end ()
						; ++it
					) {
						target->write_warning_log (std::string ("зависит от ") + (*it)->get_full_name ());
					}

					return false;
				}
			}

			return true;
		}
	};

	OTRVector source_parents;
	OTRVector target_parents;
	local::collect_parent_cats (this, source_parents);
	local::collect_parent_cats (target, target_parents);

	if (source_parents.empty () == false && target_parents.empty () == false) {
		if (source_parents.back () == target_parents.back ()) {
			//последние родители совпадают - его можно удалить
			source_parents.pop_back ();
			target_parents.pop_back ();
		}
		if (source_parents.size () > target_parents.size ()) {
			//добиваем список роделей цели, чтобы он стал равным по размеру списку родителей исходного элемента
			size_t diff = source_parents.size () - target_parents.size ();
			const ObjectTreeResolver* first = target_parents.front ();
			for (size_t i = 0; i < diff; ++i) {
				target_parents.insert (target_parents.begin (), first);
			}
		} else if (target_parents.size () > source_parents.size ()) {
			//добиваем список роделей исходного элемента, чтобы он стал равным по размеру списку родителей цели
			size_t diff = target_parents.size () - source_parents.size ();
			const ObjectTreeResolver* first = source_parents.front ();
			for (size_t i = 0; i < diff; ++i) {
				source_parents.insert (source_parents.begin (), first);
			}
		}

		GDS_ASSERT(target_parents.size () == source_parents.size ());
		
		size_t size = source_parents.size ();
		for (size_t i = 0; i < size; ++i) {
			const ObjectTreeResolver* source_item = source_parents[size - i - 1];
			const ObjectTreeResolver* dest_item = target_parents[size - i - 1];
			
			//проверяем, что не добавляем связь самому себе
			if (source_item != dest_item) {
				if (local::check_cycle (source_item, dest_item)) {
					add_dep (source_item, dest_item);
				} else {
					this->write_error_log (
						std::string ("Циклическая зависимость при автоматическом добавлении связей к: ")
							+ target->get_full_name ()
						, true
					);
					/*this->write_warning_log (
						std::string ("Циклическая зависимость при автоматическом добавлении связей к: ")
							+ target->get_full_name ()
					);*/
					break;
				}
			}
		}
	}
	//#UC END# *4B568C5F0079*
}

// Сортируется ли элементы в порядке создания (в порядке указания на модели) - такие элементы не
// нужно помещать в граф.
bool ObjectTreeResolver::sort_in_model_order () const {
	//#UC START# *4AB0CD170066*
	return false;
	//#UC END# *4AB0CD170066*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

