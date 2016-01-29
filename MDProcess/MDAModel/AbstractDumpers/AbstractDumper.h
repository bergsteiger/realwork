////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumper
//
// ����� ����������� �������� ������ �������, �� ��������� �� ���������� ����������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include <set>
#include <vector>
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include <fstream>
#include "MDProcess/MDAModel/AbstractDumpers/AbstractLogger.h"

//#UC START# *4571A2CB02DE_CUSTOM_INCLUDES*
class RegistredSupplierSt: public GCL::StrSet {
public:
	RegistredSupplierSt () {
		this->insert(ST_LINK_INH);
		this->insert(ST_LINK_DEP);
		this->insert(ST_LINK_REL);
		this->insert(ST_SET_EXCEPTION);
		this->insert(ST_GET_EXCEPTION);
		this->insert(ST_TARGET);
		this->insert(ST_CATEGORY_NESTED_DEPENDENCE);
		this->insert(ST_INIT_VALUE);
	}
};
//#UC END# *4571A2CB02DE_CUSTOM_INCLUDES*

// forward decls for defined friends
	class RoseOverridenElementDumper;



// ����� ����������� �������� ������ �������, �� ��������� �� ���������� ����������� ������
class AbstractDumper;
typedef Core::Var<AbstractDumper> AbstractDumper_var;
typedef Core::Var<const AbstractDumper> AbstractDumper_cvar;

class AbstractDumper :
	public ObjectTreeResolver
	, public AbstractDumperBase
{
	SET_OBJECT_COUNTER (AbstractDumper)
	friend class RoseOverridenElementDumper; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ������ ��������� ��������� ���������
	enum SourceStatus {
		SS_EQ // �� ������������
		, SS_CHG // �����������
		, SS_NEW // �����
		, SS_DEL // ���������
	};

	// ���������� �� ������������ ���������
	struct GenArtData {
		// ����� ������ ������������ ������ ��������
		const AbstractDumperBase* dumper;
		// ������ ���������������� ���������
		SourceStatus status;
		// ���������� �� ��������� ���������
		AbstractDumperBase::GenSourceInfo source_info;

		GenArtData (
			const AbstractDumperBase* dumper_
			, SourceStatus status_
			, const AbstractDumperBase::GenSourceInfo& source_info_
		);

		GenArtData (const GenArtData& copy);

		GenArtData& operator = (const GenArtData& copy);
		bool operator < (const GenArtData& y) const;
	};

	// ��������� ����������
	typedef std::set < const GenArtData* > ArtefactSet;

	class GenArtefacts;
	typedef ::Core::Var<GenArtefacts> GenArtefacts_var;
	typedef ::Core::Var<const GenArtefacts> GenArtefacts_cvar;
	// ���������� �� ��������������� ����������. ����������� � �������� ���������, ����� ������������
	// ��� ����������� ���������� � ��� ���������� �������������� ���������
	class GenArtefacts
		: virtual public ::Core::IObject
	{
	public:
		// ��������� � ������ �������������� ���������� �����
		virtual void add (const GenArtData& art) = 0;

		// �������� ������ ���������������� ��������
		virtual void change_status (const GenArtData& art, SourceStatus stat) = 0;

		// ������������ ������ ���������������� ����������, ������� ������-���������
		virtual void correct_data () = 0;

		// ���������� ������������ ��������������� ���������� �� �� �������
		virtual ArtefactSet* get_by_status (SourceStatus stat) const = 0;

		// ���������� ������-��������� ���������, ��� ������� ��� �� ���������, � ������� ���������
		// ������ ��� ���������, ��� ���� ��� �������� �������� ���� �������������� � ���
		virtual ArtefactSet* get_fake_deleted () const = 0;

		// ��������������� �������� (�����\��������\���������)
		virtual void restore (const GenArtData& art) = 0;
	};

	// ��������� ����������
	typedef std::set < GenArtData > ArtefactSetUnic;

protected:
	// ���������� GenArtefacts
	class GenArtefacts_i;
	typedef Core::Var<GenArtefacts_i> GenArtefacts_i_var;
	typedef Core::Var<const GenArtefacts_i> GenArtefacts_i_cvar;

	class GenArtefacts_i :
		virtual public GenArtefacts
		, virtual public Core::RefCountObjectBase
	{
		SET_OBJECT_COUNTER (GenArtefacts_i)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// ���������� ������
		void reset ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		ArtefactSetUnic m_data;

		// ��������� ���������, � ������� ��������� ��������, �� �� ��������� ���� � ����� ���������.
		ArtefactSetUnic m_fake_deleted;

	//////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	protected:

		// implemented method from GenArtefacts
		// ��������� � ������ �������������� ���������� �����
		void add (const GenArtData& art);

		// implemented method from GenArtefacts
		// �������� ������ ���������������� ��������
		void change_status (const GenArtData& art, SourceStatus stat);

		// implemented method from GenArtefacts
		// ������������ ������ ���������������� ����������, ������� ������-���������
		void correct_data ();

		// implemented method from GenArtefacts
		// ���������� ������������ ��������������� ���������� �� �� �������
		ArtefactSet* get_by_status (SourceStatus stat) const;

		// implemented method from GenArtefacts
		// ���������� ������-��������� ���������, ��� ������� ��� �� ���������, � ������� ���������
		// ������ ��� ���������, ��� ���� ��� �������� �������� ���� �������������� � ���
		ArtefactSet* get_fake_deleted () const;

		// implemented method from GenArtefacts
		// ��������������� �������� (�����\��������\���������)
		void restore (const GenArtData& art);
	}; // class GenArtefacts_i

public:
	// ������� ����������� ����-������ - �����������  � ����� ����������
	typedef boost::function<void ()> UCModificationFunction;

	// ��������� �� ��������� ������
	typedef ::Core::Box<UCModificationFunction> UCModificationfunction_var;


	// ������ �������, ��� ����������� ����-�������
	typedef std::vector < UCModificationfunction_var > UCModificationFunctionList;

	// ���������� ������
	struct RelationInfo {
		std::string stereotype;
		AbstractDumper* source;
		AbstractDumper* target;
		// ��� �����
		ObjectTreeResolver::SupplierType type;
		bool operator < (const RelationInfo& y) const;
	};

	typedef std::set < RelationInfo > RelationsSet;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// �������� ����� ��� �������������� ����� ��������� ������� �����
	static void add_relation_for_restore (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// �������� �������
	static void add_uc_modification_function (const UCModificationfunction_var& func);

	// ��������� ����������� ������ � ����. ������
	static void add_virtual_dumper (const ObjectTreeResolver* rad, const AbstractDumperBase* context);

	// �������� ����������� ����� ����� ����� ����������
	static void add_virtual_relation (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// ������ ���������� ����� �������� ���������!
	static void before_dump ();

	// ���������, ��� ������� ��� ��������� �������� �� ��������� ��������� �������� ��������� (�.�
	// ���� � ��� �� ����, �������� � �)
	static void check_unique_outputs (const AbstractLogger* logger);

	// �������� dump_commit ��� ����������� ��������
	static bool commit (const GenArtData& art);

	// ������� ��� ��� ����� ��������� ���������
	static const std::string create_gen_file_name (const std::string& fn);

	// ������� ����������� �������
	static void delete_virtual_dumper (const ObjectTreeResolver* otr);

	// ��������� ��������� (���� ��������� ������),  �������� ��� �� ���������� �� �������� �������
	// �, �������� ���������� � ��������������� ���������� �� ������
	static void dump_commit (const AbstractLogger* logger);

	// ������ � ���������� � ��������������� ����������
	static GenArtefacts& get_artefacts ();

	// ���������� ���������� � ����� ��� �������������� (��������� ��� ���������� �������� ������)
	static RelationInfo* get_relation_for_restore (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// ���������� ��� ��������� ��������� � � (����� ���� ������� commit � rollback)
	static void on_end_wiki_generation ();

	// ����� ��������� ��� ������ ��������� � � (�� ������� ��������� � �������� �)
	static void on_start_wiki_generation ();

	// ��������� ��� ��������� �� ����� ��������� � ����� ������������. ��� ������� ��������� � CVS,
	// ��� ��������� ������� � MDKnow �� �������. ����� ���������� ����������, ��������� � CVS
	// ��������� ������ (����� ���� ����������� ������). �� ������� "����������� �������", ������
	// �������� ������� MDGen ������ �������� ���� ��������� ������ (� ����������).
	static void persistent_commit (bool is_minor);

	// �������������� ������� � ��������� (������������� ���������� ��� �������� � ���� ��� �����
	// ����������)
	static void prepare ();

	// ������� ����������� �����
	static void remove_virtual_relation (const AbstractDumper* source, const AbstractDumper* target, ObjectTreeResolver::SupplierType type, const std::string& stereotype);

	// ���������� ����
	static void reset ();

protected:
	// ������� ������ �������� ��������� � ������ ��������� ������, ������ ���������� ��� ������
	// ���������
	static void clear_all_var_dumpers (AbstractDumperBase::LocalVarType by_type);

	// ��������� ��� ��� �������
	static void disable_functions_cache ();

	// ������������ ��� ��� �������
	static void enable_functions_cache ();

	// ������� �� ��� ��� �������
	static bool is_functions_cache_enabled ();

	// ���������� ��� ���������� � ��������� ����� ��������� ������������
	static void prepare_internal ();

	// ��������� ��������� ����������� ���������
	static void run_spell ();

private:
	// ������� ����������� �������� �� ������
	static void delete_virtuals_from_tree ();

	// ����� ������ � ��������������� ����������
	static void reset_artefacts ();

	// ������� ������ ����������, ���������� �������, �������������� ������� �� ���
	// rollback_all_changes �� ������ ���� �������� �� �������� ����������
	static void reset_arts_for_commit ();

	// ��������� ��������, ������� ���� ��������� ����� ����� ���������� (���������� ������ run_spell)
	static void run_post_spell ();

	// ��������� �������� ��������� ������ ��� ���������� ���������
	static void run_sort (const AbstractDumper* from_node);

	// ����� ���������� �� ������ ������ �����, �������������� � �������
	static void send_labels_list ();

	// ��������� ���������� ����������, ������� ����� �����������
	struct ArtsForCommitSingletonDataType {
		ArtefactSetUnic ptr;
	};
	
	typedef ACE_Singleton <
		ArtsForCommitSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> ArtsForCommitSingleton;

	// ���� - ������� ��� ��� ��� ��� �������
	static bool s_functions_cache_enabled;

	struct GenArtsSingletonDataType {
		GenArtefacts_i ptr;
	};
	
	typedef ACE_Singleton <
		GenArtsSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> GenArtsSingleton;

	// ������ ������, ������� ����� ������������, ����� ������������ �����
	struct RelationsForRestoreSingletonDataType {
		RelationsSet ptr;
	};
	
	typedef ACE_Singleton <
		RelationsForRestoreSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> RelationsForRestoreSingleton;

	// ���� ��������������� � ��� ��������� ������ ������� �� ������ ��� ���
	static bool s_sent_labels_list;

	// ������� ����������� ����-�������, ���������� � ����� ����� ���������.
	static UCModificationFunctionList s_uc_modification_functions;

	// ������ ����������� ���������, ������� ������ ���� ������� �� ������ ����� ��������� ���������
	struct VirtualDumpersSingletonDataType {
		ObjectTreeResolver::UnorderedOTRSet ptr;
	};
	
	typedef ACE_Singleton <
		VirtualDumpersSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> VirtualDumpersSingleton;

	// ������ ���������� ������, ������� ����� ��������� ����� ��������� ����������
	struct VirtualRelationsSingletonDataType {
		RelationsSet ptr;
	};
	
	typedef ACE_Singleton <
		VirtualRelationsSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> VirtualRelationsSingleton;

	// �������� �� ��������� � �
	static bool s_wiki_generation_started;


//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors
public:
	static const RelationsSet& get_relations_for_restore ();

	static const ObjectTreeResolver::UnorderedOTRSet& get_virtual_dumpers ();
	static void set_virtual_dumpers (const ObjectTreeResolver::UnorderedOTRSet& virtual_dumpers);

	static const RelationsSet& get_virtual_relations ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~AbstractDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� true, ���� ������������� ���������� ��������� ��������� ��������, ����� false
	virtual bool check_stereotype_use () const;

	// �������� ���������, �� ������� ����
	virtual void dump_start () const;

	// ��������� ��� ������ ������� �� ������� ����������� ����
	virtual void prepare_output_cache () const;

	// ��������� � ���������� �� ���� ��� ��������������� ���������, ���������� �������� ��������� �
	// �������� ���������� � ��������������� ����������
	void push_changes () const;

protected:
	// ���������� �������� �������� �� �����
	virtual void delete_from_cache () const;

	// ����� ���������� �� ������ �������� ����� �������� �����)
	virtual void spell_generation_prepare ();

private:
	// ��������� �������� ����� � "��������" �������� ���� �� ������� ������� (�.� � ����� ������
	// ����� ��������� �����)
	virtual void close_output (std::ofstream& file) const;

	// ����-��������� ���������������� �����:
	// �������� ������ �������� ������ (���� ��� ����������) �� ���, ��� �������� � �������
	// ����������. file_path - ���� � �����, � ������� ����� �������� ���������, ����� ��������� ����
	// � ������ ���������
	virtual void file_post_process (const std::string& file_path) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ��������������� ��� ���
	virtual bool am_i_registred () const;

	// implemented method from AbstractDumperBase
	// regular/abstract/final - ��� ������������� ��������.
	virtual const std::string get_abstract_str () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ���������� �������
	virtual AbstractDumperBase::ADList* get_all_consumers () const;

	// implemented method from AbstractDumperBase
	// ������ ���� ��������� ��������� (����������)
	virtual AbstractDumperBase::ADList* get_all_contents () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ���������,  � ������� ��� ��������� � ������� ���������
	virtual AbstractDumperBase::ADList* get_all_equals_name () const;

	// implemented method from AbstractDumperBase
	// ������ ���� ���������� ��������� (�����) ����������
	virtual AbstractDumperBase::ADList* get_all_includes () const;

	// implemented method from AbstractDumperBase
	// ��� ��������
	virtual const std::string get_class_kind_str () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ���������
	virtual AbstractDumperBase::ADList* get_contents () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ���������, �� ������� ������� ������
	virtual AbstractDumperBase::ADList* get_dependences () const;

	// implemented method from AbstractDumperBase
	// ������ ��������
	virtual AbstractDumperBase::ADList* get_diagrams () const;

	// implemented method from AbstractDumperBase
	// ������ ���������, ������� ���������� forward-������������� ��� �������� ��������.
	virtual AbstractDumperBase::ADList* get_forwarded () const;

	// implemented method from AbstractDumperBase
	// ������ ������� ��������� (�� ������� ����������� �������)
	virtual AbstractDumperBase::ADList* get_generalizations () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ������������� �� �������
	virtual AbstractDumperBase::ADList* get_generalizator () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ���������� ������������ ��� ��������  ��� get-������������ ��� ���������
	virtual AbstractDumperBase::ADList* get_get_exceptions () const;

	// implemented method from AbstractDumperBase
	// ������ ���������� ��������� (�����)
	// ���������� ����� ������������ �� ������ ������������ ��������. ���� ������� ��� ��� ���������
	// ����� ���������� ���-���� (�����������, ���������, ����� �������� ������� ���� � �.�.) ������
	// �������, �� �����, � ������� ���������� ������������ �������, ������� � ������ �����������. ��
	// ��������������� ������ ����������� �������� �������� � �������-�������������� (F)
	virtual AbstractDumperBase::ADList* get_includes () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ��� ������
	virtual const std::string get_intend_str (short intend_shift) const;

	// implemented method from AbstractDumperBase
	// agr/lnk/ref - ��� ����� ���������, �� ������ � ��������� (Var ��� Box), �� ���������
	virtual const std::string get_link_type_str () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ���������� ��� ����� �������-�������������� ������ (����������) � �����
	// ������
	virtual AbstractDumperBase::ADList* get_nested_botom_consumers () const;

	// implemented method from AbstractDumperBase
	// ������ ���� (����������) ������� ��������� (�� ������� ����������� �������)
	virtual AbstractDumperBase::ADList* get_nested_generalizations () const;

	// implemented method from AbstractDumperBase
	// ������ ���� (����������) ����������� ��������� (������� ��������� �������)
	virtual AbstractDumperBase::ADList* get_nested_realizations () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ������������ ��� ����� �������-�������������� ������ (����������) � �����
	// ������
	virtual AbstractDumperBase::ADList* get_nested_top_suppliers () const;

	// implemented method from AbstractDumperBase
	// �� �� ��� � Forwarded �� ��� ���������� ��������� ��������������� ���� � �������������� (�
	// ������� ������) ���������
	virtual AbstractDumperBase::ADList* get_nsf_forwarded () const;

	// implemented method from AbstractDumperBase
	// ������ ���������� ��������� (�����), �� ����������� ��� ������� ��������������� �������� ���
	// ����� ������ ������� ���������� (W). ����� ����, � ����� ��������� �� ������� �������� ������,
	// � ������ ��������, �� �������� (����������) ������� �������
	virtual AbstractDumperBase::ADList* get_nsf_includes () const;

	// implemented method from AbstractDumperBase
	// ������ ������������ ���������
	// ������ ��������� � ������� �������� ��������� ��������
	virtual AbstractDumperBase::ADList* get_parents () const;

	// implemented method from AbstractDumperBase
	// ������ ����������� ��������� (������� ��������� �������)
	virtual AbstractDumperBase::ADList* get_realizations () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ����������� ������
	virtual AbstractDumperBase::ADList* get_realizator () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ������������� �� ������� (����������)
	virtual AbstractDumperBase::ADList* get_req_generalizator () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ����������� ������ (����������)
	virtual AbstractDumperBase::ADList* get_req_realizator () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ���������� ������� (����������)
	virtual AbstractDumperBase::ADList* get_requrcive_all_consumers () const;

	// implemented method from AbstractDumperBase
	// ���������� ���������� ������ ���������, �� ������� ������� ������
	virtual AbstractDumperBase::ADList* get_reqursive_dependences () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ������������������ ������� (��� ��������)
	virtual AbstractDumperBase::ADList* get_sequences () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ���������� set-������������ ��� ���������
	virtual AbstractDumperBase::ADList* get_set_exceptions () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ������������ ������ � �������� ����� ���������
	virtual AbstractDumperBase::ADList* get_source () const;

	// implemented method from AbstractDumperBase
	// ���������� ��������� ��������
	virtual const std::string get_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// ���������� ����
	virtual AbstractDumperBase* get_target () const;

	// implemented method from AbstractDumperBase
	// ���������� "true", ���� ������� �������������� �������
	virtual const std::string get_type_fixed_size_str () const;

	// implemented method from AbstractDumperBase
	// ����� �� ������������������� ��������
	virtual bool has_registred_parent () const;

	// implemented method from AbstractDumperBase
	// ���������� ����� �� ������� ����������� ����� ������
	virtual bool own_output () const;

	// implemented method from AbstractDumperBase
	// ���������� ��������
	virtual AbstractDumperBase* parent () const;
protected:

	// implemented method from ObjectTreeResolver
	// ���������� ��� ������� ����������
	virtual long get_fwd_weight () const;

	// implemented method from ObjectTreeResolver
	// ���������� true, ���� ������� ������ ������� �������������
	virtual bool is_forbiden_forward_dcl () const;

//#UC START# *4571A2CB02DE*
public:
	typedef std::map<const AbstractDumper*, bool> IsFixedTypeMap;
	static IsFixedTypeMap s_is_fixed_type_map;
	
	//�������, ���, ������� ����� ������� ��� ������ ���������
	enum CleanOnStartFunctionsType {
		FT_GET_ALL_CONTENTS
		, FT_GET_CONTENTS
		, FT_GET_SORTED_CHILDS
		, FT_GET_DERIVED_OVER
		, FT_GET_DERIVED_IMPL
		, FT_GET_NOT_DERIVED_ABSTRACT
	};

	//�������, ���, ������� �� ����� ������� ��� ������ ���������
	enum FunctionsType {
		FT_GET_PARENTS
		, FT_GET_ALL_CONSUMERS		
		, FT_GET_ALL_EQUALS_NAME
		, FT_GET_ALL_INCLUDES
		, FT_GET_DEPENDENCES
		, FT_GET_FORWARDED
		, FT_GET_GENERALIZATIONS
		, FT_GET_GENERALIZATOR
		, FT_GET_GET_EXCEPTIONS
		, FT_GET_INCLUDES
		, FT_GET_NESTED_BOTOM_CONSUMERS
		, FT_GET_NESTED_GENERALIZATIONS
		, FT_GET_NESTED_REALIZATIONS
		, FT_GET_NESTED_TOP_SUPPLIERS
		, FT_GET_NSF_FORWARDED
		, FT_GET_REALIZATIONS
		, FT_GET_REALIZATOR
		, FT_GET_REQ_GENERALIZATOR
		, FT_GET_REQURCIVE_ALL_CONSUMERS
		, FT_GET_REQURSIVE_DEPENDENCES
		, FT_GET_SET_EXCEPTIONS
		, FT_GET_SOURCE
		, FT_GET_NSF_INCLUDES
		, FT_GET_REQ_REALIZATOR
	};

	typedef std::map<std::pair<const AbstractDumperBase*, size_t>, AbstractDumperBase::ADList> FunctionsCache;	
	static FunctionsCache s_functions_cache;

	//��� �������, ������� ����������� ����� ��������� ��� ��������������� �����
	typedef std::map<std::pair<const AbstractDumperBase*, CleanOnStartFunctionsType>, AbstractDumperBase::ADList> CleanOnStartFunctionsCache;
	static CleanOnStartFunctionsCache s_clean_on_start_list_functions_cache;
public:
	//static methods


	void init (const AbstractDumper* parent );

	virtual void add_sequence (ADVector aads);
	virtual bool is_type_fixed_size () const;
	virtual void collect_include (OTRSet& col) const;
	virtual void collect_all_include (OTRSet& col) const;
	
	virtual std::ostream* get_output () const;

	void collect_reqursive_dependences (OTRSet& res) const;
	void collect_reqursive_generalization (OTRSet& res) const;	
	void collect_requrcive_all_consumers (OTRSet& col) const;

	void add_diagram(AbstractDumperBase* ad);
	
	bool is_child_of (const AbstractDumperBase* parent) const;
	bool is_it_registred_supplied_by (const ObjectTreeResolver* supplier) const;

	std::string file_name () const;
	const std::string temp_file_name () const;

protected:
	void check_perent_st_constraint () const;
	void own_output (bool oo);
	std::ostream* output () const;	
	virtual void clean_forward ( OTRSet& scope);

	virtual AbstractDumper::ADList* get_sorted_childs () const;
	AbstractDumperBase::ADList* get_req_generalizator_impl () const;
private:
	struct OutputDesc {
		std::string file_name;
		std::string temp_file_name;
		std::ostream* file;
		bool own_output;
		unsigned intend;
		bool is_plain;

		OutputDesc ()  {
			file = NULL;
			own_output = false;
			intend = 0;
			is_plain = false;
		}
	};
	typedef std::map <GenID, OutputDesc> OutputMap;

protected:
	static void log_mem_info (const std::string& prefix);

	mutable OutputMap m_outputs;
	ADVector m_activity_seq;
	ADList m_diagrams;

protected:
	unsigned intend () const;
	void inc_intend ();
	void dec_intend ();
//#UC END# *4571A2CB02DE*
}; // class AbstractDumper



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

