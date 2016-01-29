////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase
//
// Класс реализующий базовую логику Дампера. Дампер - элемент вирутального дерева модели обладающий
// знаниями о себе, своих свойствах, данных, свяызях с другими элементами. Иерархия дамперов в
// сових листьях определяет конкроетныен типы элементов модели.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/AbstractDumpers/UserCodeExtractor.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

//#UC START# *4571A2EF02CE_CUSTOM_INCLUDES*
#include <algorithm>
#include <cassert>
#include <iterator>
#include <string>
#include <strstream>
#include <ostream>
#include <boost/lexical_cast.hpp>
#include <boost/functional/hash/hash.hpp>
#include <boost/crc.hpp>  // for boost::crc_32_type

#include "AbstractSingleDumperBase.h"
#include "TemplateDumperDumper.h"
#include "ObjectTreeResolver.h"

#include "shared/GCL/alg/container_op.h"
#include "shared/GCL/alg/sorting.h"
#include "shared/GCL/os/dir_op.h"
#include "shared/GCL/str/str_conv.h"
#include "shared/GCL/str/str_op.h"
#include "shared/GCL/os/FileOp.h"
#include "shared/GCL/data/StaticNodeIterator.h"

#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

#include "boost/bind.hpp"
//#UC END# *4571A2EF02CE_CUSTOM_INCLUDES*


//#UC START# *4571A2EF02CE*
#ifdef max
#undef max
#endif

#ifdef min
#undef min
#endif

///////////////////////////////////////////////////////////////////////
// AbstractDumperBase - static initialization
///////////////////////////////////////////////////////////////////////
unsigned long AbstractDumperBase::s_error_count = 0; //счетчик ошибок
unsigned long AbstractDumperBase::s_dump_depth_entry_count = 0; //счетчик входов в метод dump

bool AbstractDumperBase::s_has_error = false;
bool AbstractDumperBase::s_shift_scope = false;
bool AbstractDumperBase::s_need_run_spell = true;

AbstractDumperBase::Templates AbstractDumperBase::s_templates;
AbstractDumperBase::GenInfos AbstractDumperBase::s_gen_infos;
AbstractDumperBase::GeneratorTree AbstractDumperBase::s_gen_tree;
AbstractDumperBase::ReportInfos AbstractDumperBase::s_report_infos;
AbstractDumperBase::ReportsTree AbstractDumperBase::s_reports_tree;
AbstractDumperBase::Transformators AbstractDumperBase::s_transformators;
AbstractDumperBase::Functions AbstractDumperBase::s_functions;

AbstractDumperBase::StringResultCache AbstractDumperBase::s_get_full_name_cache;

AbstractDumperBase::ResolveFunctionsCache AbstractDumperBase::s_resolve_functions_cache;
AbstractDumperBase::ListFunctionsCache AbstractDumperBase::s_list_functions_cache;

GCL::StrSet AbstractDumperBase::s_active_map;
std::string AbstractDumperBase::s_current_map;
AbstractDumperBase::UserCode_map_mapGenId AbstractDumperBase::s_user_code;
GCL::StrSet AbstractDumperBase::s_exception_stereotypes;

FILE* AbstractDumperBase::s_log_file = NULL;
short AbstractDumperBase::s_intend_shift = 0;
AbstractDumperBase::Counters AbstractDumperBase::s_counters_value;
const AbstractDumperBase* AbstractDumperBase::s_gen_root_element = 0;
const AbstractDumperBase* AbstractDumperBase::s_model_main_element = 0;
AbstractDumperBase::AcceptedGenMap AbstractDumperBase::s_accepted_gens;
AbstractDumperBase::RoseStereotypeMap AbstractDumperBase::s_stereotypes;

const GCL::code_t AbstractDumperBase::s_default_encoding = GCL::cd_win;
const size_t AbstractDumperBase::MAX_PICTURE_SIZE = 1992294; //1.9Mb
const std::string AbstractDumperBase::s_redefinition_postfix ("_b_");


//static StringFlyweight::initializer string_fw_init;
//
//static AbstractDumperBase::StereotypeID::initializer stereotype_id_init;
//static AbstractDumperBase::FunctionID::initializer function_id_init;
//static AbstractDumperBase::TransformatorID::initializer transformator_id_init;

//boost::regex function_exp ("(\\w+)\\((.*)\\).*");
///////////////////////////////////////////////////////////////////////
// AbstractDumperBase - static function implementation
///////////////////////////////////////////////////////////////////////

/*void check_templates (const char* mess) {
	for (
		AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
		; it != AbstractDumperBase::templates_end ()
		; it ++
	) {
		if (it->second.stereotype_name == "" || it->second.classtype_name == "") {
			TRACE ("BAD ST %s: \"%s\" (%s, %s)\n", mess, it->first.data(), it->second.stereotype_name.data(), it->second.classtype_name.data());
		}
	}
}*/

static const char NEW_LINE[] = {13,10,0};

AbstractDumperBase::UserCodeData::UserCodeData () 
	: used(false)
	, is_loaded (false)
	, is_default (true)
{
}

AbstractDumperBase::UserCodeData::UserCodeData (const UserCodeData& copy)
	: uc (copy.uc)
	, used (copy.used)
	, is_loaded (copy.is_loaded)
	, is_default (copy.is_default)
	, pre_uc_content (copy.pre_uc_content)
	, post_uc_content (copy.post_uc_content)
{
}

AbstractDumperBase::TemplateBody::TemplateBody () {
	plain = false;
	file_create = false;
	tab_replacer = "\t";
	newline_replacer = std::string (NEW_LINE);
	
	user_code_open_start_id = DEFAULT_USER_CODE_ID_START;
	user_code_close_start_id = "";

	user_code_open_end_id = DEFAULT_USER_CODE_ID_END;
	user_code_close_end_id = "";

	user_code_unique = false;			
	use_current_root = false;
}

bool AbstractDumperBase::TemplateBody::is_empty () const {
	return user_code_open_start_id == DEFAULT_USER_CODE_ID_START
		&& user_code_close_start_id.empty ()
		&& user_code_open_end_id == DEFAULT_USER_CODE_ID_END
		&& user_code_close_end_id.empty ()
		&& code_template.empty ()
		&& open_scope_template.empty ()
		&& close_scope_template.empty ()
		&& forward_template.empty ()
		&& file_template.empty ()
		&& dir_template.empty ()
		&& user_file_template.empty ()
		&& post_command_template.empty ()
		&& tab_replacer == "\t"
		&& newline_replacer == std::string (NEW_LINE)
		&& output_coding_template.empty ();
}

AbstractDumperBase::Template::Template () 
	: m_seted_values (0)
{
	allow_empty_target = false;
	forbiden_forward_decl = false;
	skiped_item = false;
	clrz_suppres_operation = false;
	clrz_iconic_view = IVT_ST;
	clrz_suppres_atribute = false;
	
	abstraction_type = ATF_REGULAR;
	def_abstraction_type = "regular";
	visability_type = VTF_PUBLIC;
	def_visability_type = "PublicAccess";
	link_type = LTF_AGR | LTF_REF | LTF_LNK;
	def_link_type = "ref";

	implementation_type = SX_IT_FALSE;
	has_derived_impl = false;
	child_st_constarint_type = CSCT_UNDEFINED;
	parameterization_type = false;
	main_st = false;
	has_set_except = false;
	has_get_except = false;
	is_home = false;
	is_internal = false;

	link_guid_template = "%SU";
	fwd_weight = 0;
	inherit_child_constraint = true;
	visibility_level_settable = false;
};

void AbstractDumperBase::Template::on_property_set (unsigned int prop_id, bool is_seted) {
	m_seted_values.set (prop_id, is_seted);
}

AbstractDumperBase::Template& AbstractDumperBase::Template::operator = (const Template& t) {
	this->inherite (t);
	
	for (GT_map::const_iterator it = t.generators.begin (); it != t.generators.end (); ++it) {
		GT_map::const_iterator self_it = generators.find (it->first);
		//если такого генератора нет в списке или он пустой - перезаписываем его
		if (self_it == generators.end () || self_it->second.is_empty ()) {
			generators[it->first] = it->second;
		}
	}

	return *this;
}

template <typename Mask, typename Property, typename BitSet>
void update_template_property (
	Mask mask
	, const Property& source
	, Property& destination
	, const BitSet& source_setted_value
	, BitSet& destination_setted_value	
) {
	if (source_setted_value.test (mask) && !destination_setted_value.test (mask)) {
		destination = source;
		destination_setted_value.set (mask);
	}
}

AbstractDumperBase::Template& AbstractDumperBase::Template::inherite (const Template& t) {
	struct SimplePropertyGroupTreeItemFilter {
		inline bool is_meet (const AbstractDumperBase::PropertyGroupTreeItem* node) const {
			return true;
		}
	};
	if (st_description_header/*.get ()*/.empty ()) {
		st_description_header = t.st_description_header;
		st_description = t.st_description;
	}
	
	if (child_st_constarint_type == CSCT_UNDEFINED) {		
		if (inherit_child_constraint) {
			child_st_constarint_type = t.child_st_constarint_type;
			child_st_constraints = t.child_st_constraints;
			child_internal_st_constraints = t.child_internal_st_constraints;
		}
	} else if (
		child_st_constarint_type == t.child_st_constarint_type
		&& inherit_child_constraint
	) {
		//дополняем список разрешённых стереотипов
		child_st_constraints.insert (
			t.child_st_constraints.begin ()
			, t.child_st_constraints.end ()
		);

		child_internal_st_constraints.insert (
			t.child_internal_st_constraints.begin ()
			, t.child_internal_st_constraints.end ()
		);
	}
	
	update_template_property (
		TP_ALLOW_EMPTY_TARGET
		, t.allow_empty_target
		, allow_empty_target
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_FORBIDEN_FORWARD_DECL
		, t.forbiden_forward_decl
		, forbiden_forward_decl
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_SKIPED_ITEM
		, t.skiped_item
		, skiped_item
		, t.m_seted_values
		, m_seted_values
	);
	
	for (GT_map::const_iterator it = t.generators.begin (); it != t.generators.end (); ++it) {
		GT_map::const_iterator self_it = generators.find (it->first);
		//если такого генератора нет в списке или он пустой - перезаписываем его
		if (self_it == generators.end () || self_it->second.is_empty ()) {
			generators[it->first] = it->second;
		}
	}

	if (t.user_properties_group.is_nil () == false) {		
		if (user_properties_group.is_nil ()) {
			user_properties_group = PropertyGroupTreeItem::clone_tree (
				t.user_properties_group.in ()
				, t.user_properties_group.in ()
				, GCL::StaticNode::VoidCloneFilter ()
			);
		} else {			
			AbstractDumperBase::UserPropertyMap props;
			t.user_properties_group->for_each (
				AbstractDumperBase::CollectUserProperty ()
				, props
			);
			user_properties_group->insert_properties (props.begin (), props.end ());
		}
	}
	
	update_template_property (
		TP_AVAILABLE_TARGET_STEREOTYPES
		, t.available_target_stereotypes
		, available_target_stereotypes
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_PARENT_VISABILITY
		, t.parent_visability
		, parent_visability
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_PARAMETERIZATION_TYPE
		, t.parameterization_type
		, parameterization_type
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_ICONIC_VIEW
		, t.clrz_iconic_view
		, clrz_iconic_view
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_SUPPRES_OPERATION
		, t.clrz_suppres_operation
		, clrz_suppres_operation
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_SUPPRES_ATRIBUTE
		, t.clrz_suppres_atribute
		, clrz_suppres_atribute
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_FILL_COLOR
		, t.clrz_fill_color
		, clrz_fill_color
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_LINE_COLOR
		, t.clrz_line_color
		, clrz_line_color
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_FONT_COLOR
		, t.clrz_font_color
		, clrz_font_color
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_FORIEN_LINE_COLOR
		, t.clrz_forien_line_color
		, clrz_forien_line_color
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_CLRZ_FORIEN_FONT_COLOR
		, t.clrz_forien_font_color
		, clrz_forien_font_color
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_IMPLEMENTATION_TYPE
		, t.implementation_type
		, implementation_type
		, t.m_seted_values
		, m_seted_values
	);
	
	update_template_property (
		TP_HAS_DERIVED_IMPL
		, t.has_derived_impl
		, has_derived_impl
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_MAIN_ST
		, t.main_st
		, main_st
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_HAS_SET_EXCEPT
		, t.has_set_except
		, has_set_except
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_HAS_GET_EXCEPT
		, t.has_get_except
		, has_get_except
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_DEF_ABSTRACTION_TYPE
		, t.def_abstraction_type
		, def_abstraction_type
		, t.m_seted_values
		, m_seted_values
	);

	
	update_template_property (
		TP_ABSTRACTION_TYPE
		, t.abstraction_type
		, abstraction_type
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_ABSTRACTION_TYPE
		, t.abstraction_type
		, abstraction_type
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_VISABILITY_TYPE
		, t.visability_type
		, visability_type
		, t.m_seted_values
		, m_seted_values
	);
	
	update_template_property (
		TP_DEF_VISABILITY_TYPE
		, t.def_visability_type
		, def_visability_type
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_LINK_TYPE
		, t.link_type
		, link_type
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_DEF_LINK_TYPE
		, t.def_link_type
		, def_link_type
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_LABELS
		, t.labels
		, labels
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_IS_HOME
		, t.is_home
		, is_home
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_LINK_GUID_TEMPLATE
		, t.link_guid_template
		, link_guid_template
		, t.m_seted_values
		, m_seted_values
	);

	update_template_property (
		TP_IMAGE_FILE_NAME
		, t.image_file_name
		, image_file_name
		, t.m_seted_values
		, m_seted_values
	);
	
	return *this;
}

void AbstractDumperBase::dump_prepare () {	
	s_counters_value.clear();
	s_intend_shift = 0;
	TemplatePainter::clear ();	
	TemplateDumperDumper::reset_dumpers_list ();	
	s_stereotypes.clear ();
	
	s_resolve_functions_cache.clear ();
	s_get_full_name_cache.clear ();
	ResolveTypeCacheSingleton::instance ()->ptr.clear ();
	
	AbstractDumperBase::s_dump_depth_entry_count = 0;
	AbstractDumperBase::s_error_count = 0;

	s_current_map.clear ();
	
	AlreadySpelledDumpersSingleton::instance ()->ptr.clear ();
	ForDelayDumpDumpersSingleton::instance ()->ptr.clear ();
}

//вызывается при изменении шаблона
void AbstractDumperBase::clean_up () {
	clear_user_code ();
	s_templates.clear();
	s_transformators.clear();
	s_functions.clear();
	
	s_counters_value.clear();
	s_intend_shift = 0;
	s_gen_infos.clear();
	s_report_infos.clear();
	s_gen_tree = 0;
	s_reports_tree = 0;
	TemplatePainter::clear ();
	s_exception_stereotypes.clear();
	AbstractDumperBase::reset_accepted_gens ();
	TemplateDumperDumper::reset_dumpers_list ();	
	s_stereotypes.clear ();
	s_resolve_functions_cache.clear ();
	s_current_map.clear ();

	//TemplatePainter::dumpers_heap ().clear ();
	s_need_run_spell = true;
}

AbstractDumperBase::Templates::const_iterator AbstractDumperBase::templates_begin () {
	return s_templates.begin();
}

const AbstractDumperBase::Templates::const_iterator AbstractDumperBase::templates_end () {
	return s_templates.end();
}

AbstractDumperBase::UserCode_map_mapGenId::const_iterator AbstractDumperBase::uc_begin () {
	return s_user_code.begin();
}

const AbstractDumperBase::UserCode_map_mapGenId::const_iterator AbstractDumperBase::uc_end () {
	return s_user_code.end();
}

void AbstractDumperBase::reset_accepted_gens () {
	s_accepted_gens.clear ();
}

void AbstractDumperBase::get_gen_ids (GCL::StrSet& ret) {	

	for (Templates::iterator it = s_templates.begin(); it != s_templates.end(); it++) {
		for (GT_map::iterator it2 = (*it).second.generators.begin(); it2 != (*it).second.generators.end(); it2++) {
			ret.insert ((*it2).first);
		}
	}
}

bool AbstractDumperBase::is_it_registred (const StereotypeID& st) {
	bool ret = false;
	
	if (st != UNSTEREOTYPED_ID) {	
		AbstractDumperBase::Templates::iterator f = s_templates.find(st);
		if (f != s_templates.end() ) {
			if (s_current_map.empty ()) {
				ret = true;
			} else {
				ret = f->second.generators.find(s_current_map) != f->second.generators.end();
			}
		}
	}

	return ret;
}

bool AbstractDumperBase::has_template (const StereotypeID& st) {
	return s_templates.find(st) != s_templates.end();
}

bool AbstractDumperBase::is_has_error () {
	return s_has_error;
}

void AbstractDumperBase::has_error ( bool error ) {
	s_has_error = error;
}

void AbstractDumperBase::clean_active_map () {
	s_active_map.clear();
}

void AbstractDumperBase::add_active_map (const GenID& gen_id) {
	s_active_map.insert(gen_id);
}

GCL::StrSet& AbstractDumperBase::exception_stereotypes() {
	return s_exception_stereotypes;
}

bool AbstractDumperBase::is_stereotype_exception(const std::string& streotype) {
	return s_exception_stereotypes.find(streotype) != s_exception_stereotypes.end();
}

bool is_it_classtype_name (const std::string& name) {
	if (
		name == "Attribute"
		|| name == "Operation"
		|| name == "Class"
		|| name == "Category"
		|| name == "Parameter"
		|| name == "ClassDepenedency"
	) {
		return true;
	} else {
		return false;
	}
}
template <class Iterator, class T>
void copy_map (const Iterator& begin, const Iterator& end, T& dest) {
	for (Iterator it = begin; it != end; ++it) {
		dest[it->first] = it->second;
	}
}


void AbstractDumperBase::load_user_code (FILE* in_file, const std::string& in_file_name) const {
	class OnNewUC {
	public:
		OnNewUC (const AbstractDumperBase* this_, const std::string& file_name) 
			: m_this (this_), m_file_name (file_name)
		{
		}
		
		void callback (
			const std::string& uc_id
			, const AbstractDumperBase::UserCode& uc_content
			, const std::string& gen_id
		) {
			AbstractDumperBase::UserCodeData& uc_data = AbstractDumperBase::s_user_code[gen_id][uc_id];
			if (uc_data.is_default || (uc_data.uc.empty () && !uc_data.is_loaded)) {
				uc_data.is_loaded = true;
				uc_data.uc = uc_content;
				uc_data.file_name = m_file_name;
				uc_data.is_default = false;
				m_this->add_user_code (gen_id, uc_id, uc_content);
			} else if (uc_data.is_loaded) {
				//ругаемся только если UC уже была загружена из файла!!!
				throw Base::MultipleUCSections (
					"Multiple user code section in GenID \"" 
					+ AbstractDumperBase::s_current_map 
					+ "\" with same ID \"" 
					+ uc_id 
					+ "\""
				);
			}
		}
	private:
		std::string m_file_name;
		const AbstractDumperBase* m_this;
	};

	if (GenSupport::EnvironmentFactory::get ().get_rewrite_user_code ()) {
		return;
	}
	if (!in_file) {
		std::string mess ("NULL Template File");

		GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	}
	
	fseek(in_file, 0, SEEK_END);
	long size = ftell(in_file);
	rewind (in_file);

	Core::Box<char> buf = new char[size+1];
	size = fread(buf.in(), 1, size, in_file);
	buf.ptr()[size] = 0;

	GCL::code_t output_coding = this->get_output_coding ();

	//текст храним всегда в cp1251, а выливаем уже в нужной
	std::string converted_str = GCL::convert (
		buf.ptr (), output_coding, AbstractDumperBase::s_default_encoding
	);

	std::string element_uid = this->get_model_unique_id_str ();

	OnNewUC on_new_uc (this, in_file_name);
	UserCodeExtractor uc_extractor;

	UserCodeExtractor::Callback callback = boost::bind (&OnNewUC::callback, &on_new_uc, _1, _2, _3);

	uc_extractor.process (converted_str, get_template_body (), element_uid, callback);
}

///////////////////////////////////////////////////////////////////////
// AbstractDumperBase - method implementation
///////////////////////////////////////////////////////////////////////
std::string AbstractDumperBase::create_file_name_str () const {
	class local {
	public:
		static const std::string impl (const AbstractDumperBase* this_) {
			bool with_parent;			
			if (this_->is_native(with_parent)) {
				std::string ret = this_->get_native_path_str ();
				if (ret != "") {
					return ret;
				}
			} else {
				const AbstractDumperBase* parent = this_->parent ();
				if (parent) {
					const Template& tpl = parent->get_template ();
					AbstractDumperBase::GT_map::const_iterator gen = tpl.generators.find(s_current_map);
					if (gen == tpl.generators.end() || gen->second.code_template.empty ()) {
						return "";
					}
				}
			}
			
			TemplatePainter::TPArgs args;
			args.push_back(this_);
			return TemplatePainter::resolve_exp(this_->get_template_body ().file_template, args, this_, NULL);
		}
	};

	std::string res;
	ResolveFunctionsCache::key_type key (this, BOOST_CURRENT_FUNCTION + s_current_map);
	ResolveFunctionsCache::iterator it = s_resolve_functions_cache.find (key);

	if (it != s_resolve_functions_cache.end ()) {
		res = it->second;
	} else {
		res = local::impl (this);
		s_resolve_functions_cache[key] = res;
	}

	return res;
}

std::string AbstractDumperBase::resolve_expression (const std::string& exp) const {
	TemplatePainter::TPArgs args;
	args.push_back(this);
	return TemplatePainter::resolve_exp(exp, args, this, NULL);	
}

std::string AbstractDumperBase::get_post_command_str () const {
	TemplatePainter::TPArgs args;
	args.push_back(this);
	return TemplatePainter::resolve_exp(get_template_body ().post_command_template, args, this, NULL);
}

std::string AbstractDumperBase::create_dir_name_str () const {
	class local {
	public:
		static const std::string impl (const AbstractDumperBase* this_) {
			TemplatePainter::TPArgs args;
			args.push_back(this_);
			return TemplatePainter::resolve_exp(this_->get_template_body ().dir_template, args, this_, NULL);
		}
	};

	std::string res;
	ResolveFunctionsCache::key_type key (this, BOOST_CURRENT_FUNCTION + s_current_map);
	ResolveFunctionsCache::iterator it = s_resolve_functions_cache.find (key);

	if (it != s_resolve_functions_cache.end ()) {
		res = it->second;
	} else {
		res = local::impl (this);
		s_resolve_functions_cache[key] = res;
	}

	return res;
}

std::string AbstractDumperBase::get_generator_info_str () const {
	
	TemplatePainter::TPArgs args;
	args.push_back(this);

	std::string info = get_template_body ().generator_info;
	try {
		return TemplatePainter::resolve_exp(info, args, this, NULL);	
	} catch (...) {
		std::string mess ("Generator info resolve failed, check description for generator: ");
		mess += s_current_map;
		this->write_error_log(mess.c_str (), false);
		throw;
	}
}

std::string AbstractDumperBase::get_st_desc_str () const {
	std::string desc = get_template ().st_description_header;
	TemplatePainter::TPArgs args;
	args.push_back(this);
	
	try {
		return TemplatePainter::resolve_exp(desc, args, this, NULL);
	} catch (...) {
		std::string mess ("Stereotype description resolve failed, check description for stereotype: ");
		mess += this->get_model_stereotype_str();
		this->write_error_log(mess.c_str (), false);
		throw;
	}
}

void AbstractDumperBase::reset_accepted_generator (const AbstractDumperBase* adb) {
	for (AcceptedGenMap::iterator it = s_accepted_gens.begin (); it != s_accepted_gens.end ();) {
		if (it->first.adb == adb) {
			s_accepted_gens.erase (it++);
		} else {
			++it;
		}
	}
}

bool AbstractDumperBase::accepted_generator() const {
	//Core::GDS::StopWatchEx sw ("AbstractDumperBase::accepted_generator ()");
	AcceptedGenMap::iterator f = s_accepted_gens.find (AcceptedGenKey (this, s_current_map));
	if (f != s_accepted_gens.end()) {
		return f->second;
	} else {
		bool ret = false;
		
		Core::Aptr<Selections> applied = this->get_applied_gens ();

		if (applied->size() == 0 || (applied->find("All") != applied->end())) {
			const AbstractDumperBase* parent = this->parent();
			if (parent) {
				ret = parent->accepted_generator ();
			} else {
				ret = true;
			}
		} else {
			if (!s_current_map.empty ()) {
				if (s_gen_infos.find(s_current_map) == s_gen_infos.end()) {
					LOG_W(("Unknown generator: %s", s_current_map.c_str ()));
				}
				Core::Var<GenTreeItem> cur_gen = GenTreeItem::_duplicate(s_gen_infos[s_current_map]);
				
				while (!cur_gen.is_nil()) {
					if (applied->find(cur_gen->name()) != applied->end()) {
						ret = true;
						break;				
					}
					cur_gen = dynamic_cast<GenTreeItem*>(cur_gen->parent());
				}
			} else {
				ret = true;
			}
		}

		s_accepted_gens[AcceptedGenKey (this, s_current_map)] = ret;
		return ret;
	}
}

void AbstractDumperBase::dump_delayed () const {
	/*AbstractDumperBaseToSet m;
	m.swap (ForDelayDumpDumpersSingleton::instance ()->ptr);
	ForDelayDumpDumpersSingleton::instance ()->ptr.clear ();
	
	AbstractDumperBaseToSet::iterator m_it = m.begin ();
	AbstractDumperBaseToSet::iterator m_it_end = m.end ();

	for (; m_it != m_it_end; ++m_it) {
		for (
			AbstractDumperBaseSet::iterator it = m_it->second.begin ()
			; it != m_it->second.end ()
			; ++it
		) {
			
			(*it)->write_warning_log ("delay dump");
			(*it)->dump ();
		}
	}*/

	while (true) {
		AbstractDumperBaseToSet::iterator f_it = ForDelayDumpDumpersSingleton::instance ()->ptr.find (this);
		if (f_it != ForDelayDumpDumpersSingleton::instance ()->ptr.end ()) {
			AbstractDumperBaseSet dumpers;
			dumpers.swap (f_it->second);
			
			ForDelayDumpDumpersSingleton::instance ()->ptr.erase (f_it);
			
			for (
				AbstractDumperBaseSet::iterator it = dumpers.begin ()
				; it != dumpers.end ()
				; ++it
			) {				
				(*it)->dump ();
			}
		} else {
			break;
		}
	}
}

void AbstractDumperBase::dump (std::ostream* output) const /*throw AbstractDumperBase::DumpRescursion*/ {	
	static const unsigned long MAX_DUMP_DEPTH = 50;

	//не запускаем повторную генерацию spell для элемента
	
	if (
		get_in_spell ()
		&& !AlreadySpelledDumpersSingleton::instance ()->ptr.insert (this).second
	) {
		return;
	}

	try {
		if (++s_dump_depth_entry_count < MAX_DUMP_DEPTH) {
			if (this->can_dump ()) {
				const TemplateBody& tpl = get_template_body ();
				GCL::code_t encoding = AbstractDumperBase::s_default_encoding;
				if (!output || own_output()) {
					if (!create_file_name ().empty ()) {
						output = get_output();
						encoding = this->get_output_coding ();
					}
				}
				TemplatePainter::TPArgs args;
				args.push_back(this);	
				TemplatePainter_var tp = output 
					? new TemplatePainter (args, *output, this, NULL)
					: new TemplatePainter (args, this, NULL);

				//tp->set_encoding (encoding);
				//this->write_warning_log ("dump ()");

				CodeTemplate templ = tpl.code_template;
				CodeTemplate::const_iterator it = templ.begin();
				CodeTemplate::const_iterator it_end = templ.end();
				tp->paint(it, it_end);

				this->dump_delayed ();
			}
		} else {
			throw AbstractDumperBase::DumpRecursion ("Превышен лимит для вложенных генераций (возможно рекурсия при запуске генерации SX)");

		}
	} catch (...) {
		--AbstractDumperBase::s_dump_depth_entry_count;
		throw;
	}

	--AbstractDumperBase::s_dump_depth_entry_count;
}

std::string AbstractDumperBase::dump_open_scope () const {
	std::string ret;
	const AbstractDumperBase* par = parent();
	if (par) {
		ret += par->dump_open_scope();

		CodeTemplate templ = par->get_template_body ().open_scope_template;
		
		TemplatePainter::TPArgs args;
		args.push_back(par);

		ret += TemplatePainter::resolve_exp(templ, args, par, NULL);
	}

	return ret;
}

std::string AbstractDumperBase::dump_close_scope () const {
	std::string ret;
	const AbstractDumperBase* par = parent();
	if (par) {
		CodeTemplate templ = par->get_template_body ().close_scope_template;	
		
		TemplatePainter::TPArgs args;
		args.push_back(par);

		ret += TemplatePainter::resolve_exp(templ, args, par, NULL);
		
		ret += par->dump_close_scope ();
	}
	return ret;
}

AbstractDumperBase::ADList* AbstractDumperBase::get_scopes(const AbstractDumperBase* main_scope) const {
	class _local_CollectParents {
	public:
		_local_CollectParents (const AbstractDumperBase* parent, ADList& ret) {
			do {
				if (parent->am_i_registred()) {
					ret.push_front(parent);
				}
			} while (parent = parent->parent());
		}
	};
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("AbstractDumperBase::get_scopes");
#endif	
	ADList full_ret;
	//std::string name1 = main_scope->get_name_str();
	//std::string name2 = this->get_name_str();
	if  (main_scope && main_scope != this) {
		const AbstractDumperBase* parent = this->parent();
		_local_CollectParents (parent, full_ret);

		ADList bases;
		
		_local_CollectParents(main_scope, bases);				

		GCL::normalize(bases, full_ret, false);
		if (full_ret.size() == 0 && AbstractDumperBase::s_shift_scope == true) {
			full_ret.push_back (parent);
		}		
	}
	if (
		full_ret.size() == 1 
		&& *full_ret.begin() == main_scope
		&& AbstractDumperBase::s_shift_scope == false
	) {
		full_ret.pop_back();
	}

	ADList_aptr ret (new ADList ());
	// remove non namespaces
	for (ADList::iterator it = full_ret.begin(); it != full_ret.end(); it++) {
		const TemplateBody& templ_body = (*it)->get_template_body ();		
		if (templ_body.open_scope_template.size()) {
	
			std::ostrstream output;
	
			TemplatePainter::TPArgs args;
			args.push_back(*it);	
			TemplatePainter tp (args, output, 0, NULL);

			CodeTemplate templ = templ_body.open_scope_template;
			CodeTemplate::const_iterator tpl_it = templ.begin();
			CodeTemplate::const_iterator tpl_it_end = templ.end();
			tp.paint(tpl_it, tpl_it_end);

			if (output.pcount() > 0) {
				ret->push_back(*it);
			}
		}
	}
		
	return ret._retn ();
}

AbstractDumperBase::Templates::const_iterator AbstractDumperBase::find_template (const StereotypeID& st) {
	return s_templates.find(st);
}

AbstractDumperBase::Template& AbstractDumperBase::get_template (const StereotypeID& st) {
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);
	if (f != s_templates.end()) {
		return f->second;
	} else {
		return s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID];
	}
}

const AbstractDumperBase::Template& AbstractDumperBase::get_template () const {
	const AbstractDumperBase::StereotypeID& st (this->get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);
	if (f != s_templates.end()) {
		return f->second;
	} else {
		return s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID];
	}
}

const AbstractDumperBase::TemplateBody& AbstractDumperBase::get_template_body () const {
	//Core::GDS::StopWatchEx sw ("AbstractDumperBase::get_template_body");
	const AbstractDumperBase::StereotypeID& st (this->get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);
	if (f != s_templates.end()) {
		AbstractDumperBase::GT_map::iterator gen = f->second.generators.find(s_current_map);
		if (gen != f->second.generators.end()
		) {
			return gen->second;
		}
	}
	return s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].generators[s_current_map];
}	

const long AbstractDumperBase::get_fwd_weight () const {
	long res = 0;
	const AbstractDumperBase::StereotypeID& st (this->get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);

	if (f != s_templates.end()) {
		res = f->second.fwd_weight;
	} else {
		res = s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].fwd_weight;
	}
	return res;
}

bool AbstractDumperBase::is_forbiden_forward_dcl () const {
	bool ret = false;
	const AbstractDumperBase::StereotypeID& st (this->get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);

	if (f != s_templates.end()) {
		ret = f->second.forbiden_forward_decl;
	} else {
		ret = s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].forbiden_forward_decl;
	}
	return ret;
}

bool AbstractDumperBase::is_allow_empty_target () const {
	bool ret = false;
	const AbstractDumperBase::StereotypeID& st (this->get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);
	if (f != s_templates.end()) {
		ret = f->second.allow_empty_target;
	} else {
		ret = s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].allow_empty_target;
	}
	return ret;
}

bool AbstractDumperBase::is_parent_visability_stereotype (const StereotypeID& st) const {
	bool ret = false;	
	const AbstractDumperBase::StereotypeID& model_stereotype (this->get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(model_stereotype);
	if (f != s_templates.end()) {
		ret = (f->second.parent_visability.find(st) != f->second.parent_visability.end());
	} else {
		ret = (s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].parent_visability.find(st) != s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].parent_visability.end());		
	}
	return ret;
}

bool AbstractDumperBase::is_plain () const {
	return get_template_body ().plain;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////

std::string AbstractDumperBase::create_relative_dir_name () const {
	std::string self_dir_name (this->create_dir_name_str ());
	if (self_dir_name.size () > 0 && self_dir_name[0] == '!') {
		return self_dir_name.substr (1);
	}

	const AbstractDumperBase* parent = 0;	
	bool flag = this->get_template ().main_st;
	if (flag == false) {
		parent = this->parent();
		flag = (parent == 0);
	}

	if (flag) {
		return self_dir_name;
	} else {
		return parent->create_relative_dir_name () + self_dir_name;
	}
}

std::string AbstractDumperBase::create_dir_name () const {
	return this->get_root_dir(false) + this->create_relative_dir_name();
}

std::string AbstractDumperBase::create_file_name () const {	
	TRACE ("%s\n", this->get_name_str ().data());
	std::string fn = this->create_file_name_str ();
	if (fn.size() > 0) {
		if (fn[0] == '/') {
			return fn.data() + 1;
		} else {
			return this->create_dir_name () + "/" + fn;
		}
	} else {
		return "";
	}
}

std::string AbstractDumperBase::create_relative_file_name () const {	
	std::string fn = this->create_file_name_str ();
	if (fn != "") {
		if (fn[0] == '/') {
			return fn.data() + 1;
		} else {
			std::string ret = this->create_relative_dir_name () + "/" + fn;
			return std::string(ret.c_str() + 1); // skip first slash
		}
	} else {
		return "";
	}
}

std::string AbstractDumperBase::create_relative_file_name_with_parent () const {
	std::string fn = this->create_file_name_str ();
	if (fn != "") {
		if (fn[0] == '/') {
			return fn.data() + 1;
		} else {
			std::string ret = this->create_relative_dir_name () + "/" + fn;
			return std::string(ret.c_str() + 1); // skip first slash
		}
	} else {
		if (this->parent()) {
			return this->parent()->create_relative_file_name_with_parent ();
		} else {
			return "";
		}
	}
}

std::string AbstractDumperBase::create_normolized_path (const char* target_path, const char* target_root) const {
	std::string self_path = this->create_relative_file_name();
	
	GCL::StrVector self_path_s = GCL::split_string_by (self_path.data(), '/');
	GCL::StrVector target_path_s = GCL::split_string_by (target_path, '/');

	if (target_path_s.size () == 0) {
		assert (0);
	} 

	if (self_path_s.size () == 0) {
		self_path_s = GCL::split_string_by (this->create_relative_dir_name ().data(), '/');		
	} else {
		self_path_s.pop_back();
	}

	std::string self_root = this->get_root_dir(false);
	if (self_root != target_root) {
		if (self_root[0] != target_root[0]) {
			// diff drive's volumes
			return std::string (target_root) + "/" + target_path;
		} else {
			GCL::StrVector self_root_s = GCL::split_string_by (self_root.data(), '/');
			GCL::StrVector target_root_s = GCL::split_string_by (target_root, '/');
			
			GCL::StrVector::iterator t_it = target_root_s.begin();
			GCL::StrVector::iterator s_it = self_root_s.begin();
			for (				
				; s_it != self_root_s.end() && t_it != target_root_s.end() && *s_it == *t_it
				; s_it++, t_it++) 
			{
			}
			self_path_s.insert (self_path_s.begin(), s_it, self_root_s.end());
			target_path_s.insert (target_path_s.begin(), t_it, target_root_s.end());
		}
	}
	
	std::string ret = "./";
	GCL::StrVector::iterator target_it = target_path_s.begin();
	bool difference = false;
	for (GCL::StrVector::iterator it = self_path_s.begin(); it != self_path_s.end(); it++) {
		if (!difference) {
			if (target_it == target_path_s.end() || *it != *target_it) {
				difference = true;
			} else {
				target_it++;
			}
		}
		if (difference) {
			ret += "../";
		}
	}
	GCL::normalize(self_path_s, target_path_s, false);

	ret += GCL::join (target_path_s, "/");
	return ret;
}

void AbstractDumperBase::write_debug_log (const std::string& mess) const {	
	if (s_log_file) {
		fprintf (s_log_file, "%s\n", mess.c_str());
	}
	LOG_D ((mess.c_str()));
}

const AbstractDumperBase::UserCodeData* AbstractDumperBase::get_uc_data (
	const GenID& gen_id
	, const UserCodeId& uc_id
) {
	UserCode_map::iterator it = s_user_code [gen_id].find (uc_id);
	if (it != s_user_code [gen_id].end ()) {
		return &it->second;
	}

	return 0;
}

void AbstractDumperBase::clear_user_code_from_file () {
	LOG_I ((GDS_CURRENT_FUNCTION));
	UserCode_map_mapGenId::iterator it_map = s_user_code.begin ();
	UserCode_map_mapGenId::iterator it_map_end = s_user_code.end ();

	for (; it_map != it_map_end; ++it_map) {
		UserCode_map::iterator it = it_map->second.begin ();
		UserCode_map::iterator it_end = it_map->second.end ();

		for (bool erased = false; it != it_end; ++it) {
			if (!it->second.file_name.empty () && it->second.is_loaded) {				
				it->second.uc.clear ();
				it->second.is_loaded = false;
				
			}			
		}
	}	
}

void AbstractDumperBase::clear_user_code () {
	LOG_I ((GDS_CURRENT_FUNCTION));
	s_user_code.clear ();
}

void AbstractDumperBase::set_user_code (const GenID& gen_id, const UserCodeId& uc_id, const UserCodeData& uc_data) {	
	s_user_code[gen_id][uc_id] = uc_data;
}
//#UC END# *4571A2EF02CE*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool AbstractDumperBase::GenSourceInfo::operator < (const GenSourceInfo& y) const {
	//#UC START# *45C9F2340119_LESS*
	return source < y.source;
	//#UC END# *45C9F2340119_LESS*
}

AbstractDumperBase::GenSourceInfo::GenSourceInfo (const GenSource& source_, const GenID& gen_id_)
//#UC START# *45C9F2340119_INIT_CTOR_BASE_INIT*
	: source (source_), gen_id (gen_id_)
//#UC END# *45C9F2340119_INIT_CTOR_BASE_INIT*
{
	//#UC START# *45C9F2340119_INIT_CTOR*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45C9F2340119_INIT_CTOR*
}
AbstractDumperBase::GenSourceInfo::GenSourceInfo (const GenSourceInfo& copy) 
//#UC START# *45C9F2340119_COPY_CTOR_BASE_INIT*
	: source (copy.source), gen_id (copy.gen_id)
//#UC END# *45C9F2340119_COPY_CTOR_BASE_INIT*
{
	//#UC START# *45C9F2340119_COPY_CTOR*
	//#UC END# *45C9F2340119_COPY_CTOR*
}

AbstractDumperBase::GenSourceInfo& AbstractDumperBase::GenSourceInfo::operator = (const GenSourceInfo& copy) {
	//#UC START# *45C9F2340119_ASSIGN_OP*
	source = copy.source;
	gen_id = copy.gen_id;
	//#UC END# *45C9F2340119_ASSIGN_OP*
	return *this;
}

// инициализирующий конструктор
AbstractDumperBase::GenSourceInfo::GenSourceInfo ()
//#UC START# *4B136543004E_INIT_CTOR_BASE_INIT*
//#UC END# *4B136543004E_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4B136543004E_CTOR_BODY*
	//#UC END# *4B136543004E_CTOR_BODY*
}


AbstractDumperBase::ContextData::ContextData (
	const StereotypeID& stereotype_id_
	, const FunctionID& function_id_
	, const TransformatorID& transformator_id_
	, const TemplateFunctions::FunctionParams& args_
)
//#UC START# *46F21A3C034B_INIT_CTOR_BASE_INIT*
:	stereotype_id (stereotype_id_)
	, function_id (function_id_)
	, transformator_id (transformator_id_)
	, args (args_)
//#UC END# *46F21A3C034B_INIT_CTOR_BASE_INIT*
{
	//#UC START# *46F21A3C034B_INIT_CTOR*
	//#UC END# *46F21A3C034B_INIT_CTOR*
}


// блок констант
const AbstractDumperBase::GenID AbstractDumperBase::SPELL_GENERATOR_ID = "spell"; // идентификатор предустановленного генератора для формирования виртуальных элементов
const AbstractDumperBase::StereotypeID AbstractDumperBase::DEFAULT_STEREOTYPE_ID = "default"; // константа для обозначения стереотипа по-умолчанию
const AbstractDumperBase::StereotypeID AbstractDumperBase::EMPTY_STEREOTYPE_ID = ""; // константа для обозначения пустого стереотипа
const AbstractDumperBase::FunctionID AbstractDumperBase::EMPTY_FUNCTION_ID = ""; // константа для обозначения пустого идентификатора функции
const AbstractDumperBase::TransformatorID AbstractDumperBase::EMPTY_TRANSFORMATOR_ID = ""; // константа для обозначения пустого идентификатора для трансформатора
const AbstractDumperBase::StereotypeID AbstractDumperBase::UNSTEREOTYPED_ID = "unstereotyped"; // константа для обозначения отсутствия стереотипа у элемента


AbstractDumperBase::TemplateResolveException::TemplateResolveException (const std::string& info)
	: FatalError (info)
//#UC START# *4B0D2CD801E2_BASE_INIT*
//#UC END# *4B0D2CD801E2_BASE_INIT*
{
	//#UC START# *4B0D2CD801E2_BODY*
	//#UC END# *4B0D2CD801E2_BODY*
}

const char* AbstractDumperBase::TemplateResolveException::uid () const /*throw ()*/ {
	return "137DDA90-FEEE-40E2-8012-C280656020D7";
}




AbstractDumperBase::DumpRecursion::DumpRecursion (const std::string& info)
	: FatalError (info)
//#UC START# *4BE00F770261_BASE_INIT*
//#UC END# *4BE00F770261_BASE_INIT*
{
	//#UC START# *4BE00F770261_BODY*
	//#UC END# *4BE00F770261_BODY*
}

const char* AbstractDumperBase::DumpRecursion::uid () const /*throw ()*/ {
	return "9FD73AEB-5575-4611-9005-4509F553DEED";
}



//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// возвращает true, если выполняется spell
bool AbstractDumperBase::s_in_spell;

// метод формирует строку, которую можно записать в свойства элемента
const std::string AbstractDumperBase::create_page_property (const char* page_id, const char* page_path) {
	//#UC START# *4640811A0119*
	std::string ret = page_path;
	ret += "|";
	ret += page_id;
	return ret;
	//#UC END# *4640811A0119*
}

// извлекает id и path из строки
void AbstractDumperBase::extract_from_page_property (const std::string& prop_str, std::string& page_id, std::string& page_path) {
	//#UC START# *464083D60196*
	std::string::size_type pos = prop_str.find ("|");
	if (pos != std::string::npos) {
		page_id = prop_str.substr (pos + 1);
		page_path = prop_str.substr (0, pos);
		//return true;
	}
	//return false;
	//#UC END# *464083D60196*
}

// возвращает список файлов, в которых есть неиспользуемые пользовательские секции
GCL::StrSet* AbstractDumperBase::get_file_with_unused_user_code () {
	//#UC START# *4785B4E703D0*
	
	Core::Aptr<GCL::StrSet> result = new GCL::StrSet ();
	for (
		AbstractDumperBase::UserCode_map_mapGenId::const_iterator it = AbstractDumperBase::uc_begin()
		; it != AbstractDumperBase::uc_end()
		; it++
	) {
		for (
			AbstractDumperBase::UserCode_map::const_iterator it2 = it->second.begin()
			; it2 != it->second.end()
			; it2++
		) {
			std::string uc_id = it2->first;
			bool used = it2->second.used;

			//разбиваем текст секции по \n
			GCL::StrVector uc_lines = GCL::split_string_by (it2->second.uc.c_str(), 10);
			if (!it2->second.used && uc_lines.size () > 2) {
				result->insert (it2->second.file_name);
			}
		}
	}
	return result.forget ();
	//#UC END# *4785B4E703D0*
}

// удаляет из кэша данные об испточнике генерации
void AbstractDumperBase::erase_source (const GenSourceInfo& arg) {
	//#UC START# *47CFD11200A2*
	SourceToDumpersSingleton::instance ()->ptr.erase (arg);
	//#UC END# *47CFD11200A2*
}

// мапа данные о источнике генерации -> список дамперов
AbstractDumperBase::GenSourceInfoToDumpersMap& AbstractDumperBase::get_source_to_dumpers () {
	//#UC START# *4A2D0003008C*
	return SourceToDumpersSingleton::instance ()->ptr;
	//#UC END# *4A2D0003008C*
}

// удалить элемент из списка элементов для отложенного dump'а
void AbstractDumperBase::remove_dumper_for_delay_dump (const AbstractDumperBase* adb) {
	//#UC START# *4AEFD5C9001B*
	AbstractDumperBaseToSet::iterator it = ForDelayDumpDumpersSingleton::instance ()->ptr.begin ();
	AbstractDumperBaseToSet::iterator it_end = ForDelayDumpDumpersSingleton::instance ()->ptr.end ();

	for (; it != it_end; ++it) {
		it->second.erase (adb);
	}
	//#UC END# *4AEFD5C9001B*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractDumperBase::~AbstractDumperBase () {
	//#UC START# *4571A2EF02CE_DESTR_BODY*
	//#UC END# *4571A2EF02CE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить элемент для отложенного dump'а
void AbstractDumperBase::add_dumper_for_delay_dump (const AbstractDumperBase* adb) const {
	//#UC START# *4AEFD5A800F2*
	ForDelayDumpDumpersSingleton::instance ()->ptr[this].insert (adb);
	//#UC END# *4AEFD5A800F2*
}

// добавляет список значений метаданных по ключу
void AbstractDumperBase::add_metadata (const MetaDataKey& key, const MetaDataList& values) {
	//#UC START# *4A03BA8C03AB*
	MetaDataList& metadata_by_key = m_metadatas[key];
	metadata_by_key.insert (metadata_by_key.end (), values.begin (), values.end ());
	//#UC END# *4A03BA8C03AB*
}

// добавляет метаданные по ключу
void AbstractDumperBase::add_metadata (const MetaDataKey& key, const MetaDataValue& value) {
	//#UC START# *4A03BAD401E6*
	m_metadatas[key].push_back (value);
	//#UC END# *4A03BAD401E6*
}

// возвращает true, если элемент можно "дампить"
bool AbstractDumperBase::can_dump () const {
	//#UC START# *4AB372760177*
	bool with_parent;
	
	return this->accepted_generator() && (!this->is_native(with_parent) || get_in_spell ());
	//#UC END# *4AB372760177*
}

// очищает список метаданных, связанных с элементом
void AbstractDumperBase::clear_metadata () {
	//#UC START# *4A10DFD50026*
	m_metadatas.clear ();
	//#UC END# *4A10DFD50026*
}

// очищаем список связанных элементов
void AbstractDumperBase::clear_var_dumpers (LocalVarType type) const {
	//#UC START# *4B21183703AA*
	if (type == LVT_ALL) {
		m_var_dumpers.clear ();
	} else {
		for (LocalVars::iterator it = m_var_dumpers.begin (); it != m_var_dumpers.end ();) {
			if (it->second.type == type) {
				m_var_dumpers.erase (it++);
			} else {
				++it;
			}
		}
	}
	//#UC END# *4B21183703AA*
}

// порядковый номер элемента (устанавливается ОДИН раз при построении дерева генерации и хранится в
// модели)
unsigned long long AbstractDumperBase::elem_creation_order () const {
	//#UC START# *4CA290A1031C*
	return std::numeric_limits<unsigned int>::max ();
	//#UC END# *4CA290A1031C*
}

// порядковый номер элемента (устанавливается при построении дерева генерации)
unsigned int AbstractDumperBase::elem_order () const {
	//#UC START# *4C174C9C0184*
	return std::numeric_limits<unsigned int>::max ();
	//#UC END# *4C174C9C0184*
}

// находит метаданные по ключу
const AbstractDumperBase::MetaDataMap::const_iterator AbstractDumperBase::find_metadata (
	const MetaDataKey& key
) const {
	//#UC START# *4A03BB97015B*
	return m_metadatas.find (key);
	//#UC END# *4A03BB97015B*
}

// возвращает имя файла с изображением, связанного с элементом
const std::string AbstractDumperBase::get_image_file () const {
	//#UC START# *46970F8401A5*
	const AbstractDumperBase::StereotypeID& st (get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);
	if (f != s_templates.end()) {
		return f->second.image_file_name;
	} else {
		return s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].image_file_name;
	}
	//#UC END# *46970F8401A5*
}

// возвращает дампер для вывода значения по-умолчанию
AbstractDumperBase* AbstractDumperBase::get_initial_value () const {
	//#UC START# *473D7883037A*
	return 0;
	//#UC END# *473D7883037A*
}

// возвращает список лэйблов (меток) соответствующих стереотипу
GCL::StrSet* AbstractDumperBase::get_labels () const {
	//#UC START# *46515F8B038A*	
	const AbstractDumperBase::StereotypeID& st (get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);
	
	GCL::StrSet ret;
	if (f != s_templates.end()) {
		ret = f->second.labels;		
	} else {
		ret = s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].labels;
	}
	return new GCL::StrSet (ret.begin (), ret. end ());
	//#UC END# *46515F8B038A*
}

// возвращает ГУИД, который используется при создании навигационной мапы диаграммы
const std::string AbstractDumperBase::get_link_guid () const {
	//#UC START# *4677CE2F006D*
	bool b;
	if (this->is_native (b) == false) {
		const AbstractDumperBase::StereotypeID& st (get_model_stereotype_str());
		AbstractDumperBase::Templates::iterator f = s_templates.find(st);
		
		std::string link_guid_template;
		if (f != s_templates.end()) {
			link_guid_template = f->second.link_guid_template;		
		} else {
			link_guid_template = s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].link_guid_template;
		}	 		
		if (link_guid_template.empty ()) {
			return "";
		}
		
		TemplatePainter::TPArgs args;
		args.push_back(this);
		return TemplatePainter::resolve_exp(link_guid_template, args, this, NULL);	
	}
	return "";
	//#UC END# *4677CE2F006D*
}

// возвращает мэйн элемент
AbstractDumperBase* AbstractDumperBase::get_main_element () const {
	//#UC START# *4665552403B9*
	return const_cast<AbstractDumperBase*> (s_gen_root_element);
	//#UC END# *4665552403B9*
}

// возвращает кодировку, с которой должен генерится файл
GCL::code_t AbstractDumperBase::get_output_coding () const {
	//#UC START# *4B5EDADC01FF*
	GCL::code_t coding = GCL::cd_win;

	CodeTemplate output_coding_template = this->get_template_body ().output_coding_template;
	if (!output_coding_template.empty ()) {
		TemplatePainter::TPArgs args;
		args.push_back (this);

		std::string output_coding = TemplatePainter::resolve_exp (output_coding_template, args, this, NULL);

		if (output_coding.empty ()) {
		} else if (output_coding == "utf8") {
			coding = GCL::cd_utf;
		} else if (output_coding == "koi8-r") {
			coding = GCL::cd_koi;
		} else if (output_coding == "cp866") {
			coding = GCL::cd_dos;
		} else if (output_coding == "cp1251") {
			coding = GCL::cd_win;
		} else {
			std::string mess ("Invalid coding \"");
			mess += output_coding;
			mess += "\" for generator \"";
			mess += s_current_map;
			mess += "\"";
			
			GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
			GenSupport::LogManagerFactory::get ().log_error (mess);
		}
	}
	
	return coding;
	//#UC END# *4B5EDADC01FF*
}

// возвращает тип сгенерированного артефакта
AbstractDumperBase::GenSourceType AbstractDumperBase::get_source_type () const {
	//#UC START# *46678170007D*
	return (AbstractDumperBase::GenSourceType)-1;
	//#UC END# *46678170007D*
}

// возвращает дампер по id-шнику, связанные с элементом
const AbstractDumperBase* AbstractDumperBase::get_var_dumper (const std::string& var_id) const {
	//#UC START# *4B2113FE000C*
	LocalVars::const_iterator it = m_var_dumpers.find (var_id);
	if (it != m_var_dumpers.end ()) {
		return it->second.value.ptr ();
	}

	return 0;
	//#UC END# *4B2113FE000C*
}

// возвращает true, если элемент был изменён (используется дл определения того, что диаграмма была
// изменена)
bool AbstractDumperBase::is_changed () const {
	//#UC START# *4745846E0191*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4745846E0191*
}

// возвращает true, если страница для элемента может быть Home - страницей, иначе - false
bool AbstractDumperBase::is_home () const {
	//#UC START# *46712F9C0177*
	bool ret = false;
	
	AbstractDumperBase::StereotypeID st (get_model_stereotype_str());
	AbstractDumperBase::Templates::iterator f = s_templates.find(st);

	if (f != s_templates.end()) {
		ret = f->second.is_home;
	} else {
		ret = s_templates[AbstractDumperBase::DEFAULT_STEREOTYPE_ID].is_home;
	}
	return ret;
	//#UC END# *46712F9C0177*
}

// возвращает true, если генератор имеет свойство "User" - результирующий файл НЕ будет/будет
// переписываться при повторной генерации
bool AbstractDumperBase::is_user_file () const {
	//#UC START# *4B4EA1500288*

	CodeTemplate user_file_template = this->get_template_body ().user_file_template;
	if (user_file_template.empty ()) {
		return false;
	}
	
	TemplatePainter::TPArgs args;
	args.push_back (this);

	std::string user_file = TemplatePainter::resolve_exp (user_file_template, args, this, NULL);
	return user_file.empty () || user_file == "true" ? true : false;
	//#UC END# *4B4EA1500288*
}

// возвращает итератор на начало метаданных
const AbstractDumperBase::MetaDataMap::const_iterator AbstractDumperBase::metadatas_begin () const {
	//#UC START# *4A03B92E01F3*
	return m_metadatas.begin ();
	//#UC END# *4A03B92E01F3*
}

// возвращает итератор на конец метаданных
const AbstractDumperBase::MetaDataMap::const_iterator AbstractDumperBase::metadatas_end () const {
	//#UC START# *4A03B95102AF*
	return m_metadatas.end ();
	//#UC END# *4A03B95102AF*
}

// сбрасывает информацию об изменённости
void AbstractDumperBase::reset_changed () const {
	//#UC START# *474584AB02B6*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *474584AB02B6*
}

// Вызывает внешний обработчик измененного файла
void AbstractDumperBase::run_post_command () const {
	//#UC START# *45C9F5EB003E*
	std::string pc = this->get_post_command_str();
	
	if (pc == "") {
		return;
	}
	std::string root_dir = this->get_root_dir(false);
	
	HANDLE hChildStdoutRd;
	HANDLE hChildStdoutWr;

	SECURITY_ATTRIBUTES saAttr;  
	// Set the bInheritHandle flag so pipe handles are inherited. 
 
	saAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
	saAttr.bInheritHandle = TRUE;
	saAttr.lpSecurityDescriptor = NULL; 

	// Get the handle to the current STDOUT. 
		 
	// Create a pipe for the child process's STDOUT. 
	 
	if (!CreatePipe(&hChildStdoutRd, &hChildStdoutWr, &saAttr, 0)) {
		MessageBox(NULL, "Stdout pipe creation failed\n", "Error", MB_OK);
	} else {
		// Ensure the read handle to the pipe for STDOUT is not inherited.
		SetHandleInformation( hChildStdoutRd, HANDLE_FLAG_INHERIT, 0);

		STARTUPINFO si;
		PROCESS_INFORMATION pi;

		ZeroMemory( &si, sizeof(si) );
		ZeroMemory( &pi, sizeof(pi) );
		si.cb = sizeof(STARTUPINFO);
		si.hStdError = hChildStdoutWr;
		si.hStdOutput = hChildStdoutWr;
		si.dwFlags |= STARTF_USESTDHANDLES;

		if (CreateProcess (
			0
			, (char*) pc.data()
			, NULL
			, NULL
			, true
			, 0
			, NULL
			, root_dir.data()
			, &si
			, &pi
		)) {
			CloseHandle(pi.hThread);

			if (WaitForSingleObject(pi.hProcess, INFINITE) == WAIT_FAILED) {
				TerminateProcess(pi.hProcess, WAIT_FAILED);
			}

			DWORD dwRead = 0; 
			CHAR chBuf[512] = {0}; 

			// Close the write end of the pipe before reading from the 
			// read end of the pipe. 

			if (!CloseHandle(hChildStdoutWr)) {
				MessageBox(NULL, "Closing handle failed", "Error", MB_OK);
			}

			// Read output from the child process, and write to parent's STDOUT.
			pc += ":\r\n";
			std::string console_output;
			//GenSupport::LogManagerFactory::get ().log_info (pc.c_str ());
			while (
				ReadFile( hChildStdoutRd, chBuf, 512, &dwRead, NULL) 
				&& dwRead != 0
			) {
				//GenSupport::LogManagerFactory::get ().log_info (chBuf);
				pc += chBuf;
			} 
			DWORD exit_code = 0;
			if (GetExitCodeProcess (pi.hProcess, &exit_code)) {
				if (exit_code == 0) {
					GenSupport::LogManagerFactory::get ().log_info (pc.c_str ());
					//GenSupport::LogManagerFactory::get ().log_info (console_output.c_str ());
				} else {
					GenSupport::LogManagerFactory::get ().log_error (pc.c_str ());
					//GenSupport::LogManagerFactory::get ().log_error (console_output.c_str ());
				}
			}
			CloseHandle(pi.hProcess);
		} else {
			std::string mess ("\"");
			mess += pc;
			mess += "\" is failed: GetLastError returned ";
			mess += boost::lexical_cast<std::string> (::GetLastError ());

			MessageBox(NULL, mess.c_str (), "Error", MB_OK); 
		}
	}
	//#UC END# *45C9F5EB003E*
}

// устанавливает дампер по id-шнику, связанный с элементом
void AbstractDumperBase::set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) const {
	//#UC START# *4B21147F0088*	
	LocalVarType new_type = AbstractDumperBase::get_in_spell () ? LVT_IN_SPELL : LVT_OTHER;
	LocalVars::iterator it = m_var_dumpers.find (var_id);
	if (it != m_var_dumpers.end () && it->second.type == LVT_IN_SPELL && new_type != it->second.type) {
		std::string mess (
			std::string ("Переменная \"")
			+ var_id
			+ std::string ("\" инициализирована при выполнении spell'а, нельзя её перезаписывать вне его!")
		);
		
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	}
	
	LocalVar& l_var = m_var_dumpers[var_id];
	
	if (dumper) {
		dumper->addref ();
	}

	l_var.value = dumper;
	l_var.type = new_type;	
	//#UC END# *4B21147F0088*
}

// логирование ошибок в шаблоне
void AbstractDumperBase::write_template_error_log (const char* log) const {
	//#UC START# *46655433001F*
	AbstractDumperBase::has_error(true);
	std::string str ("IN TEMPLATE: ");
	str += log;
	
	GenSupport::ErrorManagerFactory::get ().error (this, log, "Шаблон");
	GenSupport::LogManagerFactory::get ().log_error (str);
	//#UC END# *46655433001F*
}

// логирование предупреждений
void AbstractDumperBase::write_template_warning_log (const char* log) const {
	//#UC START# *466554660000*
	std::string str ("IN TEMPLATE: ");
	str += log;
	
	GenSupport::LogManagerFactory::get ().log_warning (str);
	//#UC END# *466554660000*
}
//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors

bool AbstractDumperBase::get_in_spell () {
	//#UC START# *4B53E3000301_GET_ACCESSOR*
	return s_in_spell;
	//#UC END# *4B53E3000301_GET_ACCESSOR*
}
void AbstractDumperBase::set_in_spell (bool in_spell) {
	//#UC START# *4B53E3000301_SET_ACCESSOR*
	s_in_spell = in_spell;
	//#UC END# *4B53E3000301_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractLogger
// метод для логирования ошибок
void AbstractDumperBase::write_error_log (const std::string& mess, bool fatal) const {
	//#UC START# *46823C1003A9_4571A2EF02CE*
	AbstractDumperBase::has_error(true);

	std::string str (this->get_full_name() + ": " + mess);
	
	if (fatal) {
		GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
	} else {
		GenSupport::ErrorManagerFactory::get ().error (this, mess, GDS_CURRENT_FUNCTION);
	}
	
	GenSupport::LogManagerFactory::get ().log_error (str);
	//#UC END# *46823C1003A9_4571A2EF02CE*
}

// implemented method from AbstractLogger
// логирование информационных сообщений
void AbstractDumperBase::write_info_log (const std::string& mess) const {
	//#UC START# *46823BFE004E_4571A2EF02CE*
	std::string str ("INFO: " + this->get_full_name() + ": " + mess);
	GenSupport::LogManagerFactory::get ().log_info(str);
	//#UC END# *46823BFE004E_4571A2EF02CE*
}

// implemented method from AbstractLogger
// логирование предупреждений
void AbstractDumperBase::write_warning_log (const std::string& mess) const {
	//#UC START# *46823BE0038A_4571A2EF02CE*
	std::string str ("WARNING: " + this->get_full_name() + ": " + mess);
	GenSupport::LogManagerFactory::get ().log_warning (str);
	//#UC END# *46823BE0038A_4571A2EF02CE*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

