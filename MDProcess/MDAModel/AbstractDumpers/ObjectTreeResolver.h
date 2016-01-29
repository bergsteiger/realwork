////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::ObjectTreeResolver
//
// �������� ���������� ����� ������������ ����� ������� �������� �� ������ ������ ����� ����. ����
// ���������� ������� ���������� ��������� � ����������� �������� �����, � ��� ��  �� �����
// �������� ������� ������� ��������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_OBJECTTREERESOLVER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_OBJECTTREERESOLVER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include <set>
#include <vector>
#include "shared/Core/data/unsorted_containers.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractLogger.h"
#include "MDProcess/MDAModel/AbstractDumpers/DependencyGraph.h"
#include "MDProcess/MDAModel/Base/Base.h"

//#UC START# *4571A0B90148_CUSTOM_INCLUDES*
#include <algorithm>
#include <fstream>
#include <functional>
#include <list>
#include <map>
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/data/Tree.h"

int odp_compare_ex (const void *a1, const void *a2);
#define ST_LINK_INH "Inheretance"
#define ST_LINK_DEP "Dependence"
#define ST_LINK_REL "Realize"
#define ST_SET_EXCEPTION "Set Exception"
#define ST_GET_EXCEPTION "Get Exception"
#define ST_TARGET "Target"
#define ST_CATEGORY_NESTED_DEPENDENCE "Nested dependence"
#define ST_SEQ_LINK_DEP "Sequence use"

#define ST_USER_DEF_TARGET "UserTarget" // do not include in RegistredSupplierSt!
#define ST_INIT_VALUE "InitValue" // do not include in RegistredSupplierSt!


//#UC END# *4571A0B90148_CUSTOM_INCLUDES*

// forward decls for defined friends
	class RoseOverridenElementDumper;



// �������� ���������� ����� ������������ ����� ������� �������� �� ������ ������ ����� ����. ����
// ���������� ������� ���������� ��������� � ����������� �������� �����, � ��� ��  �� �����
// �������� ������� ������� ��������������.
class ObjectTreeResolver;
typedef Core::Var<ObjectTreeResolver> ObjectTreeResolver_var;
typedef Core::Var<const ObjectTreeResolver> ObjectTreeResolver_cvar;

class ObjectTreeResolver :
	virtual public Base::NamedElement
	, virtual public AbstractLogger
{
	SET_OBJECT_COUNTER (ObjectTreeResolver)
	friend class RoseOverridenElementDumper; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��� �����
	enum SupplierType {
		ST_NAVIGABLE // ������� �����
		, ST_NOT_NAVIGABLE // �� ������� �����
		, ST_IGNORED
	};

	// ������� ��� ���������� ����� ����� ����� ����������
	typedef boost::function<void (const ObjectTreeResolver*, const ObjectTreeResolver*)> AddDependencyFunctor;

	// ���������� ���������� � �������-������������ (�.�. �� ������� ������ ������ ���������� �����-
	// ���� ������ ������)
	struct ConsumerInfo {
		// ��� �����
		const std::string link_stereotype;
		// ������-������������
		const ObjectTreeResolver* consumer;

		ConsumerInfo (const std::string& link_stereotype_, const ObjectTreeResolver* consumer_);
		bool operator < (const ConsumerInfo& y) const;
	};

	// ������ ���������
	typedef std::vector < const ObjectTreeResolver* > OTRVector;

	struct OTRPair {
		ObjectTreeResolver* first;
		ObjectTreeResolver* second;
		bool operator < (const OTRPair& y) const;
	};

	// ��������� ��������-�������������
	typedef std::set < ConsumerInfo > Consumer_set;

	// set ��������� ������
	typedef boost::unordered_set <const ObjectTreeResolver*> UnorderedOTRSet;

	typedef std::set < OTRPair > OTRPairSet;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ����� ������� ����� - ������ ����������� ���������� ��� �������� ������ ������ ��� ���
	// ��������� �������
	static void clean_up ();

	// ����� ������� ������ �� ����� (��� ����� ��������� ���� �� �������� ��� ����� ������� ������) -
	// ���������� ������ ��������� ���������
	static OTRVector* find_by_name (const std::string& name);

	// C��������� ��� �������� ���������� -1, ���� x ��������� ����� � ������ c����� �������������, 1,
	// ���� ����� y, � ��������� ������� ���������� 0. ������ ����� ������������ ��� ����������
	// ��������� ����������.
	static int odp_compare (const ObjectTreeResolver* x, const ObjectTreeResolver* y);

	// ���������� ��� ������ ��������� - ������� ������������� ���� (���� ����� �������, �.�
	// ���������� ������ ��� ����������� ������, �� ����� ����������� ��������� spell)
	static void on_generation_start ();

protected:
	// ������� �����
	static void clear_graph ();

	// ��������� ����� �������������, ���� �������� ������� � ���� root
	static void fill_graph (const ObjectTreeResolver* root);

	// ��������� �������� ������ ��������� �� �������������, � ���������� ������ ����� �����������
	// ��������������� � ������� ������������� ������ ���������, ������� ����� �������������� �
	// ��������� ����������
	static void sort_tree (const ObjectTreeResolver* root);

private:
	// ����, ���������� ��� (������� � ��������� �����)
	static Core::Box<DependencyGraph> s_all_link_graph;

	// ����, ���������� ������ ������� �����
	static Core::Box<DependencyGraph> s_hard_link_graph;

	// ������ ��������� ������ ���������, ��������������� � ������� �������������
	struct SortedTreeItemsSingletonDataType {
		OTRVector ptr;
	};
	
	typedef ACE_Singleton <
		SortedTreeItemsSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> SortedTreeItemsSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ObjectTreeResolver ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ������ ��������� �� ������� ������� ������, ������ ��� ����������
	virtual void collect_suppliers_by_type (SupplierType type, OTRVector& collection) const;

	// ���������� ��������� ������ ��������� �� ������� ������� ������, ������ ��� ����������
	virtual void collect_suppliers_by_type_recursive (SupplierType type, OTRVector& collection) const;

	// ������������ ��������� ������
	virtual int compare (const ObjectTreeResolver* od) const;

	// ���������� true, ���� ������� ����� �� ������ ����� ������, �������� ����� � ���������� ������
	virtual bool is_global_visible () const;

	// �������� �� obj supplier'�� � �������� �����������
	virtual bool is_supplier_with_stereotype (const ObjectTreeResolver* obj, const std::string& stereotype) const;

	// ��������� ����� ��������� ���� � ��������� ����������
	virtual void remove_supplier (const ObjectTreeResolver* supplier, SupplierType type, const std::string& stereotype);

	// �������� ����������� ������ ����� ���������� ��������� source � target
	virtual void set_dependencies (const ObjectTreeResolver* target, const AddDependencyFunctor& add_dep) const;

protected:
	// ������� ��������� �����, ���� -1 - ������ ������� �� �����
	virtual int get_childs_visibility_level () const;

	// ����������� �� �������� � ������� �������� (� ������� �������� �� ������) - ����� �������� ��
	// ����� �������� � ����.
	virtual bool sort_in_model_order () const;

private:
	// C������� ��������� ������������ - ���� � ������ ���������� ����� ��������, �� ���������, ����
	// ������� - ������� �������� �������� �� ���� � ��� ����� �������� �������� �������, �.� ��� ���-
	// �� ����� ���� ��������� ����� � ��� �������
	virtual bool is_global_locally () const;


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers () = 0;

protected:
	// ���������� ��� ������� ����������
	virtual long get_fwd_weight () const = 0;

	// ���������� true, ���� ������� ������ ������� �������������
	virtual bool is_forbiden_forward_dcl () const = 0;


//#UC START# *4571A0B90148*
public:
	//���������� ��� 
	//virtual void on_partially_remove ();
protected:
	struct SortByUID : public std::binary_function<const ObjectTreeResolver*, const ObjectTreeResolver*, bool> {
		bool operator()(const ObjectTreeResolver* const x, const ObjectTreeResolver* const y) const;
    };

	struct PSortByUID : public std::binary_function<const ObjectTreeResolver*, const ObjectTreeResolver*, bool> {
		bool operator()(const ObjectTreeResolver** const x, const ObjectTreeResolver** const y) const;
    };

	struct ExistsInHardGraph : public std::unary_function<const ObjectTreeResolver*, bool> {
		bool operator()(const ObjectTreeResolver** const x) const;
    };

	/*struct PSortByWeightAndUID : public std::binary_function<const ObjectTreeResolver*, const ObjectTreeResolver*, bool> {
		bool operator()(const ObjectTreeResolver** const x, const ObjectTreeResolver** const y) const;
    };*/
	
public:
	typedef GCL::Tree<const ObjectTreeResolver*, false, SortByUID> ObjectTree;

	struct SupplierInfo {
		const ObjectTreeResolver* supplier;
		GCL::StrSet link_stereotypes;
		
		SupplierInfo (const ObjectTreeResolver* s) : supplier(s) {
		}
		SupplierInfo (const ObjectTreeResolver* s, std::string st) : supplier(s) {
			link_stereotypes.insert(st);
		}
		bool operator < (const SupplierInfo& c) const {
				return supplier < c.supplier;
		}
	};

	typedef std::set<const ObjectTreeResolver*, SortByUID> OTRSet;

	/*class OTRSet {
	public:
		typedef std::vector<const ObjectTreeResolver*> Container;
		typedef Container::const_iterator const_iterator;
		typedef Container::iterator iterator;
		typedef Container::value_type value_type;
		typedef Container::size_type size_type;
	public:
		bool empty () const {
			return m_base.empty ();
		}
		
		size_type size () const {
			return m_base.size ();
		}
		
		void clear () {
			m_base.clear ();
		}

		const_iterator begin () const {
			return m_base.begin ();
		}

		const_iterator end () const {
			return m_base.end ();
		}

		iterator begin () {
			return m_base.begin ();
		}

		iterator end () {
			return m_base.end ();
		}
		
		void insert(const_iterator first, const_iterator last) {
			for (; first != last; ++first) {
				insert (*first);
			}
		}

		std::pair<iterator, bool> insert (const value_type& x) {
			std::pair<iterator, bool> res;
			
			res.first = end ();
			res.second = this->find (x) == res.first;

			if (res.second) {
				m_base.push_back (x);
				
				std::sort (begin (), end (), SortByUID ());
				res.first = this->find (x);
			}

			return res;
		}

		void push_back(const value_type& x) {
			this->insert (x);
		}
		
		iterator find (const value_type& x) {
			return std::find (begin (), end (), x);
		}

		const_iterator find (const value_type& x) const {
			return std::find (begin (), end (), x);
		}

		void erase (const value_type& x) {
			iterator it = find (x);
			if (it != end ()) {
				m_base.erase (it);
			}
		}

	private:
		Container m_base;
	};*/
protected:
	typedef std::set<SupplierInfo> Supplier_set;	

public:
	ObjectTreeResolver(const ObjectTreeResolver* parent);
	ObjectTreeResolver();
	void init (const ObjectTreeResolver* parent );

public:
	enum VisibilityType {
		VT_PUBLIC
		, VT_PROTECTED
		, VT_PRIVATE
		, VT_IMPL
	};

	virtual VisibilityType get_visibility_type () const {
		return VT_PUBLIC;
	}

public:
	OTRSet get_supplier_by_stereotype (const std::string& stereotype) const;
	OTRSet get_supplier_by_stereotypes (const GCL::StrSet& stereotypes) const;
	OTRSet get_consumer_by_stereotype (const std::string& stereotype) const;
	OTRSet get_all_suppliers () const;
	const Consumer_set& ObjectTreeResolver::get_consumer_infos () const;
	
	void add_forward_supplier (const ObjectTreeResolver* sup);
	
	void add_supplier_spec (
		const ObjectTreeResolver* sup
		, SupplierType supl_type
		, const std::string& link_stereotype
		, bool need_check_visibility = true
		, bool need_check_access = true
	);

	//������� ���� �� ������� ��������� ���������
	void remove_from_consumers ();

	void remove_supplier (const ObjectTreeResolver* supplier);	

	void remove_consumer (const ObjectTreeResolver* consumer) const;
	void remove_consumer (const ObjectTreeResolver* consumer, const std::string& link_stereotype) const;

	void add_supplier (const ObjectTreeResolver* sup, SupplierType supl_type, const std::string& link_stereotype);

	void add_consumer (const ObjectTreeResolver* consumer, std::string link_stereotype) const;
	void link_all_suppliers ();	
	virtual bool is_it_first (const ObjectTreeResolver* od) const;

private:
	bool is_it_supplier (
		const ObjectTreeResolver* supplier, 
		bool& is_navigable, 
		bool& is_root, 
		OTRVector& base = OTRVector()
	) const;
	
	void set_suppler_position ( ObjectTreeResolver* od );

public:
	static ObjectTree* s_tree;

protected:
	typedef std::map<std::pair<const ObjectTreeResolver*, const ObjectTreeResolver*>, bool> AlgorithmMap;

	//��� ������ ��������� ������ ��������� is_it_first
	//���� ��� ����������� ������ ���� ������� ����� �������������� �����
	static AlgorithmMap s_is_it_first_cache;

protected:
	enum ItemType {
		IT_PACKAGE
		, IT_CLASS
		, IT_ATTRIBUTE
		, IT_OPERATION
		, IT_PARAMETR
		, IT_OTHER
	};
/*	virtual void write_error_log ( std::string mess, bool fatal = false ) const = 0;	
	virtual void write_info_log ( std::string mess ) const = 0;	
	virtual void write_warning_log ( std::string mess ) const = 0;	*/
protected:	
	unsigned suppliers_count () const;
	virtual bool is_it_scope ( const ObjectTreeResolver* od, OTRVector& base ) const;
	virtual bool is_it_scope_no_forward ( const ObjectTreeResolver* od, OTRVector& base ) const;
	virtual void clear_suppliers ();

public:
	typedef std::vector<std::pair<ObjectTreeResolver*, ObjectTreeResolver*> > SortPairVec;
	typedef std::set<std::pair<ObjectTreeResolver*, ObjectTreeResolver*> > SortedPairSet;
	
	virtual bool is_global() const;
	virtual const ObjectTreeResolver* get_parent_category () const;			
	virtual const ObjectTreeResolver* get_nearest_container () const;
	void sort_suppliers (SortedPairSet& sorted_elems);

	bool check_access (const ObjectTreeResolver* sup) const;
	bool check_visibility (const ObjectTreeResolver* sup, const std::string& link_stereotype) const;
	virtual bool check_protected_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const;
	virtual bool check_private_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const;

protected:
	virtual void clean_forward ( OTRSet& scope) = 0;	
	
	const OTRSet& forwarded_suppliers () const;	
	
protected:
	OTRSet m_top_suppliers;
	OTRSet m_botom_consumers;
	OTRSet m_not_in_scope_forwarded_suppliers;
	OTRSet m_forwarded_suppliers;

	mutable Consumer_set m_consumers;

private:
	size_t m_fwd_weight;
	bool m_own_tree;
	Supplier_set m_suppliers;
	Supplier_set m_directive_suppliers;
	Supplier_set m_other_suppliers;
//#UC END# *4571A0B90148*
}; // class ObjectTreeResolver



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_OBJECTTREERESOLVER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

