////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplatePainter
//
// ���������� �����, ����������� �������� �������� ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEPAINTER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEPAINTER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include <vector>
#include <list>
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/str/str_conv.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
#include <ostream>
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/Base/Base.h"

//#UC START# *477606D700B4_CUSTOM_INCLUDES*
//#define ZombieEnabled 1
//#UC END# *477606D700B4_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace SystemFunctionsImpl {
	class CycleBreak;
} // namespace SystemFunctionsImpl

class TemplatePainter;	class OutputWrapper;

namespace VirtualElementsFuncionsImpl {
	class UCModificationBase;
} // namespace VirtualElementsFuncionsImpl



// ���������� �����, ����������� �������� �������� ������ �������
class TemplatePainter;
typedef Core::Var<TemplatePainter> TemplatePainter_var;
typedef Core::Var<const TemplatePainter> TemplatePainter_cvar;

class TemplatePainter :
	public Base::AbstractTemplatePainter
	, public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TemplatePainter)
	friend class SystemFunctionsImpl::CycleBreak; // defined friend
	friend class OutputWrapper; // defined friend
	friend class VirtualElementsFuncionsImpl::UCModificationBase; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��������� ����������� ��� ������ �������
	typedef std::vector < const AbstractDumperBase* > TPArgs;

	// ��������� ��� �������� ��������� ����������� AbstractDumperBase
	typedef std::list < AbstractDumperBase_var > DumpersHeap;

	// ������ ��� ������ �� ��������
	class TextDumper;
	typedef Core::Var<TextDumper> TextDumper_var;
	typedef Core::Var<const TextDumper> TextDumper_cvar;

	class TextDumper :
		virtual public AbstractSingleDumperBase
	{
		SET_OBJECT_COUNTER (TextDumper)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// �����������
		explicit TextDumper (const char* str);

	public:
		virtual ~TextDumper ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// ��� �������
		std::string m_name;

	//////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	public:

	// implemented method from AbstractDumperBase
	// ���������� ���
	virtual const std::string get_name_str () const;
	//////////////////////////////////////////////////////////////////////////////////////////
	// overloaded base methods

	protected:

	// overloaded method from Base::NamedElement
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const;


	//#UC START# *47836F7C0343*
#if (defined(ZombieEnabled) && (ZombieEnabled == 1))
		void delete_obj () {
			m_deleted = true;
		}

		const std::string get_model_class_str () const {
			GDS_ASSERT(!m_deleted);
			return AbstractSingleDumperBase::get_model_class_str ();
		}

		void set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) const {
			GDS_ASSERT(!m_deleted);
			return AbstractSingleDumperBase::set_var_dumper (var_id, dumper);
		}

		const AbstractDumperBase* get_var_dumper (const std::string& var_id) const {
			GDS_ASSERT(!m_deleted);
			return AbstractSingleDumperBase::get_var_dumper (var_id);
		}
#endif
        bool operator == (const AbstractDumperBase& c) const;
	//#UC END# *47836F7C0343*
	}; // class TextDumper

	// ������ �������������� ����� ��������� - ������
	class ContainerDumper;
	typedef Core::Var<ContainerDumper> ContainerDumper_var;
	typedef Core::Var<const ContainerDumper> ContainerDumper_cvar;

	class ContainerDumper :
		virtual public TextDumper
	{
		SET_OBJECT_COUNTER (ContainerDumper)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit ContainerDumper (const std::string& name);

		ContainerDumper (const ContainerDumper& copy);

	public:
		virtual ~ContainerDumper ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// ��������� ������� � � ���������
		virtual void add (const AbstractDumperBase* item);

		// ��������� ��� �������� �� ������
		virtual void add (const AbstractDumperBase::VarList& items);

		// ������� ���������
		virtual void clear ();

		// ���������� ���������� ��������� � ������
		virtual size_t count (const AbstractDumperBase* item) const;

		// ������� ������� �� ����������
		virtual void erase (const AbstractDumperBase* item);

		// ���������� ���������� ���� �����������
		virtual bool is_equal (const ContainerDumper* cont) const;

		// ������� ������� � ����� ������
		virtual void pop_back ();

		// ������� ������� � ������ ������
		virtual void pop_front ();

		// ������ ������
		virtual size_t size () const;

		// ������� ���������� ���������� arg
		virtual void substract (const ContainerDumper* arg);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// �������� ������
		AbstractDumperBase::VarList m_items;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
		virtual const AbstractDumperBase::VarList& get_items () const;


	//////////////////////////////////////////////////////////////////////////////////////////
	// overloaded base methods
	public:

	// overloaded method from AbstractDumperBase
	// ������ ���� ��������� ��������� (����������)
	virtual AbstractDumperBase::ADList* get_all_contents () const;

	// overloaded method from AbstractDumperBase
	// ������ ��������� ���������
	virtual AbstractDumperBase::ADList* get_contents () const;

	}; // class ContainerDumper

	// ��������� ������� ��� ���������� ������� �������
	typedef boost::function<AbstractDumperBase::ADList* (const AbstractDumperBase*)> DumperByTemplateFunc;

	// ������� ��� �������, � ������� ����� ������������ ���������
	class OutputWrapper {
		SET_OBJECT_COUNTER (OutputWrapper)
		friend class TemplatePainter; // defined friend
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// �����������, out - �����, ��� ������� �������� ������
		OutputWrapper (std::ostream& out, const TemplatePainter* owner);

		explicit OutputWrapper (const TemplatePainter* owner);

	public:
		virtual ~OutputWrapper ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// �������������� ���������� �����
		virtual void init_buffer ();

		// ������� ���������� �����, ���������� � �������� ���������� �������� ������ ����� ��������
		virtual const std::string release_buffer ();

		// ���������� �����
		virtual void set_output (std::ostream& out);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// ���������� �����
		std::string m_buffer;

		// ���� - ����� �� ���������� �����
		bool m_need_buffer;

		// ������������� �����
		std::ostream* m_output;

		// ���� - �������� �� ������� ���������� ������
		bool m_own_output;

	//#UC START# *47762FB2013A*
			const TemplatePainter& m_owner;
		public:
			OutputWrapper& operator << (const char* str);
			OutputWrapper& operator << (const std::string& str);
			OutputWrapper& operator << (const char& str);
			void seekp (std::streampos pos);
			std::streampos tellp () const;
		//#UC END# *47762FB2013A*
	}; // class OutputWrapper

	// ��������� ���������� �������
	class DelayedFunctionParams {
		SET_OBJECT_COUNTER (DelayedFunctionParams)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		DelayedFunctionParams (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, const TemplatePainter* painter
	);

	public:
		virtual ~DelayedFunctionParams ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		virtual TemplatePainter* get_painter () const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// ��������
		AbstractDumperBase_cvar m_context;

		DumpersHeap m_local_args;

		TemplatePainter_var m_painter;

		TemplateFunctions::FunctionParams m_params;

		const AbstractDumperBase* m_self;

		AbstractDumperBase::VarDumpers m_var_dumpers;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
		virtual const AbstractDumperBase* get_context () const;

		virtual void set_context (const AbstractDumperBase* context);

		virtual const DumpersHeap& get_local_args () const;

		virtual const TemplateFunctions::FunctionParams& get_params () const;

		virtual const AbstractDumperBase* get_self () const;

		virtual const AbstractDumperBase::VarDumpers& get_var_dumpers () const;
	}; // class DelayedFunctionParams

	typedef ::Core::Box<DelayedFunctionParams> DelayedFunctionParams_box;


	// �������� ����� ���� ��������
	class TemplateCycleIterationBreak : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

	// �������� ��������� �������
	class TemplateBadSyntax : public Base::FatalError {
	public:
		TemplateBadSyntax (const std::string& info);

	private:
		const char* uid () const /*throw ()*/;

	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ������� ������ ����������
	static void clear ();

	// ������� ���������� �� ������ ���������� ����������
	static void delete_var_dumper (const std::string& var_id);

	// ���������� ���������� � ��������������� var_id, ���� ����� ���������� ��� - ���������� 0
	static const AbstractDumperBase* get_var_dumper (const std::string& var_id);

	// ��������� ������ - ����-������
	static const std::string make_uc (const std::string& uc_id, const std::string& uc_content, const AbstractDumperBase::TemplateBody& tpl);

	// ��������� �������� ��������� expression � ���������� ��������� � ���� ������
	static const bool resolve_cond (const AbstractDumperBase::CodeTemplate& expression, const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent);

	// ��������� �������� ��������� expression � ���������� ��������� � ���� ������
	static const bool resolve_cond (const AbstractDumperBase::CodeTemplate& expression, TemplatePainter* base);

	// ��������� ��������� expression � ���������� ��������� � ���� ������
	// args - ���������, ����������� ��� ������� ���������
	// main_scope - ������� ��� �������� ������������ ������ �������
	static const std::string resolve_exp (const AbstractDumperBase::CodeTemplate& expression, const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent);

	// ��������� ��������� expression � ���������� ��������� � ���� ������
	static const std::string resolve_exp (const AbstractDumperBase::CodeTemplate& expression, TemplatePainter* base);

	// ������������� ���������� � �������������� var_id
	static void set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper);

private:
	// ��������� ����������, ���������� � �������
	struct VarDumpersSingletonDataType {
		AbstractDumperBase::VarDumpers ptr;
	};
	
	typedef ACE_Singleton <
		VarDumpersSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> VarDumpersSingleton;


//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors
private:
	static const AbstractDumperBase::VarDumpers& get_var_dumpers ();
	static void set_var_dumpers (const AbstractDumperBase::VarDumpers& var_dumpers);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit TemplatePainter (const TemplatePainter* base);

	TemplatePainter (
		const TPArgs& args
		, std::ostream& output
		, const AbstractDumperBase* main_scope
		, const TemplatePainter* parent
	);

	// �����������, �����, � ������� ����� �������������� ����� �������� ������ ������ - �.� �����
	// ���������
	TemplatePainter (const TPArgs& args, const AbstractDumperBase* main_scope, const TemplatePainter* parent);

public:
	virtual ~TemplatePainter ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������� ������ ����� �������, ��� ���� ��� ���� ���������� ���� Box ���������� �� ����������
	virtual TemplatePainter* clone () const;

	// ��������� ��������� �������� [it, it_end], �������� ����� ������������� ������� � ���������
	// �������
	virtual const AbstractDumperBase::FunctionID extract_function (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, TemplateFunctions::FunctionParams& params
	);

	// ��������� ��������� �������� [it, it_end], �������� ����� ������������� � ���������
	// ��������������
	virtual const AbstractDumperBase::TransformatorID extract_transformator (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, TemplateFunctions::FunctionParams& params
	);

	// ��������� �������� �������, ��������� ��������������� id, params - ������ ���������� ��� �������
	virtual const std::string function (
		const AbstractDumperBase::FunctionID& id
		, const TemplateFunctions::FunctionParams& params
	);

	// ���������� ������� ������ ���������, �� ���������������� �������
	virtual const AbstractDumperBase* get_dumper_by_template (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// ���������� ������� ���������
	virtual GCL::code_t get_encoding () const;

	// ���������� ���� ������� �������
	virtual GCL::StrVector* get_stack () const;

	// ������������ ���������� ��� ��� �������� owner. ������ ����� ����� ��� ���� ����� ���������
	// �������������� ������, ���� � ���� �������� ��������� (��� ����������)
	virtual void invalidate_dumpers_list (char list_tpl_command, const AbstractDumper* owner);

	// ������� � ����� ��������� ������� �������, ������ ����� ����������� it � it_end
	virtual bool paint (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// ������� ��������� ������� �����
	virtual bool paint_cycle (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// ������� ��������� �������
	virtual bool paint_if (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// ������� ��������� ������� ������� ������ ��������������� ������
	virtual bool paint_user_code (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);

	// ��������� ��������� ������� �������
	virtual const std::string resolve_method (
		const AbstractDumperBase::Function& function
		, const TemplateFunctions::FunctionParams& params
		, const AbstractDumperBase* context
	);

	// ��������� ��������� ������� ��������������
	virtual const std::string resolve_method (
		const AbstractDumperBase::Transformator& transformator
		, const TemplateFunctions::FunctionParams& params
		, const AbstractDumperBase* context
	);

	// ������������� ���������
	virtual void set_encoding (GCL::code_t encoding);

	// ������������� �����, � ������� ����� ����������� ������
	virtual void set_output (std::ostream& out);

	// ��������� �������� ��������������, ��������� ��������������� id, params - ������ ���������� ���
	// ��������������
	virtual const std::string transform (
		const AbstractDumperBase::TransformatorID& id
		, const TemplateFunctions::FunctionParams& params
	);

protected:
	// ������������� ������
	virtual bool execute_paint (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, bool if_flag
		, bool cycle_flag
	);

	// ������ �������� �������, ��������:
	// %SS - ������� ��������� �������� ��������
	virtual bool paint_parameter (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
		, const AbstractDumperBase* templ_dump
	);

	// ������������� �������� �����
	virtual const AbstractDumperBase* setup_iterator (
		AbstractDumperBase::ADListIt_box& it_begin
		, AbstractDumperBase::ADList::iterator& it_end
	);

	// ��������� ������
	virtual bool sort (AbstractDumperBase::ADList_box& list);

private:
	// ���������� ���������� ������� ��� �������� ������� (arg)
	virtual DumperByTemplateFunc* get_dumper_by_template_impl (char arg) const;

	// ��������� ������ ���������� ��� �������
	virtual void make_function_args (
		const TemplateFunctions::FunctionParams& params
		, TPArgs& args
		, DumpersHeap& destruct
	);

	// ��������� ������ ���������� ��� ��������������
	virtual void make_transf_args (const TemplateFunctions::FunctionParams& params, TPArgs& args, DumpersHeap& destruct);

	// ��������� ��������� ������ �������
	virtual const std::string resolve_method (
		const AbstractDumperBase::Function& function
		, const TPArgs& args
		, const AbstractDumperBase* context
	);

	// ��������� ��������� ������ ��������������
	virtual const std::string resolve_method (
		const AbstractDumperBase::Transformator& transformator
		, const TPArgs& args
		, const AbstractDumperBase* context
	);

	// ���������� ������� � ����������� �����������
	virtual void resolve_method (const AbstractDumperBase::Function& function, DelayedFunctionParams_box& params);

	// ���������� ������������� ����������� ���������� it ������ ��������� �� �������, ���������������
	// ���.���������: "^{[^{]*}.*"
	virtual const std::string resolve_var_id (
		AbstractDumperBase::CodeTemplate::const_iterator& it
		, const AbstractDumperBase::CodeTemplate::const_iterator& it_end
	);


//////////////////////////////////////////////////////////////////////////////////////////
// template methods
public:
	// ���������� ���������� ������� ������� ��� �������������� (� ����������� �� ���������
	// IsFunction), ������������� �� ����������.  ����  ����� ������� (��� ��������������) ��
	// ���������� ��������� ����������.
	template <bool IsFunction, class ID>
	const std::string st_method (
		const ID& id
		, const TemplateFunctions::FunctionParams& params
		, const AbstractDumperBase* context
		, const AbstractDumperBase::StereotypeID& base_stereotype
		, bool need_error
		, bool use_self_args
	);



//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���������
	TPArgs m_args;

	// �������� ����������� �� ����� �����
	AbstractDumperBase::ADListIt_box m_cycle_end;

	// ������� �������� �����
	Core::Box<AbstractDumperBase::ADListIt_box> m_cycle_it;

	// ����� �������� �����
	unsigned long m_cycle_iteration;

	// ��������� ������
	GCL::code_t m_encoding;

	// ���� - ����������� ���� ��� ���
	bool m_is_reversed_cycle;

	const AbstractDumperBase* m_main_scope;

	// ������� ��� �������
	OutputWrapper m_output;

	// ��������
	const AbstractDumperBase* m_owner;

	// �������� ������� - ������� ����� ������������ ��������, ��������������� ������� � �������
	const TemplatePainter* m_parent;

	// ��������� �� ����� ������������������ ��� ����������� �������
	AbstractDumperBase::ADList::iterator m_rend_iterator;

	// ���������� �������� �����
	AbstractDumperBase::ADListIt_box m_save_cycle_it;

	// ���� - ���� �� ��� ���������� ������
	Core::Box<bool> m_sort_processed;

	// ��� ����������
	char m_sorting_type;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const TPArgs& get_args () const;

	virtual void set_args (const TPArgs& args);

	virtual const AbstractDumperBase* get_main_scope () const;

	virtual const AbstractDumperBase* get_owner () const;

//#UC START# *477606D700B4*
	struct PainterADData {
	protected:
		PainterADData () {				
		};
		~PainterADData () {				
		};
	public:
		static inline PainterADData* make () {
			//Core::GDS::StopWatchEx sw ("PainterADData::PainterADData ()");
			PainterADData* tmp = new PainterADData ();
			return tmp;
		}
		struct PainterADDataDestructor {
			static inline void destroy (PainterADData* t) {
				//Core::GDS::StopWatchEx sw ("PainterADData::~PainterADData ()");
				delete t;
			}
		};
		typedef std::pair<AbstractDumperBase::ADList_box, AbstractDumperBase::ADListIt_box> DataPair;
		typedef std::map<char, DataPair> DataMap;
		DataMap m_data_map;			
	};
	Core::Box<PainterADData, PainterADData::PainterADDataDestructor> m_data;

public:
	typedef std::map<std::string, AbstractDumperBase::ADList> DuplicatedNames;
	typedef ACE_Singleton <DuplicatedNames, ACE_SYNCH_RECURSIVE_MUTEX> DuplicatedNamesSingleton;

private:
	static bool resolve_cond_ex (
		const AbstractDumperBase::CodeTemplate& exp
		, const TPArgs& args
		, const AbstractDumperBase* main_scope
		, TemplatePainter* base
		, const TemplatePainter* parent
	);

	typedef std::map<std::string, std::string> ResolveCache;
	static ResolveCache s_resolve_cache;
	
	static const AbstractDumperBase::StereotypeID s_inherited_flag;

private:
	void replace_iterator (const AbstractDumperBase::ADList::iterator& iter);
	AbstractDumperBase::ADListIt_box& dereference ();
	bool is_valid_iterator () const;
	bool is_empty_source () const; //������ �� ���� �������� ������������������

	void increment_iterator ();
	void decrement_iterator ();
	//#UC END# *477606D700B4*
}; // class TemplatePainter



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEPAINTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

