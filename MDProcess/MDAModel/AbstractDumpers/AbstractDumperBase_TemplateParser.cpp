////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase_TemplateParser.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase::TemplateParser
//
// парсер шаблона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "shared/GCL/alg/container_op.h"
#include "boost/algorithm/string/trim.hpp"
#include "boost/lexical_cast.hpp"

class AbstractDumperBase;
//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// регульярные выражения, используемы при парсинге шаблона
const std::string AbstractDumperBase::TemplateParser::group_regex_str = "^property group \"(.*)\"\\s*\\{"; // регульярное выражение для определения начала группы свойств
const std::string AbstractDumperBase::TemplateParser::property_regex_str = "^(p|property)\\s+([^:=\\?]*)\\s*:?\\s*([^=\\s\\?]+)?\\s*=?\\s*([^\\?]*)\\s*\\??\\s*(.*)?"; // регулярное выражение для юзер-свойства

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// возвращает true, если name - это "Attribute" или "Operation", или "Class", или "Category", или
// "Parameter", или "ClassDepenedency", иначе false
bool AbstractDumperBase::TemplateParser::is_it_classtype_name (const std::string& name) {
	//#UC START# *46F0A75E02FD*
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
	//#UC END# *46F0A75E02FD*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
AbstractDumperBase::TemplateParser::TemplateParser ()
//#UC START# *46FCA6BA03A9_BASE_INIT*
//: m_group_regex (group_regex_str), m_property_regex (property_regex_str)
//#UC END# *46FCA6BA03A9_BASE_INIT*
{
	//#UC START# *46FCA6BA03A9_BODY*	
	//#UC END# *46FCA6BA03A9_BODY*
}

AbstractDumperBase::TemplateParser::~TemplateParser () {
	//#UC START# *46E8E1430399_DESTR_BODY*
	//#UC END# *46E8E1430399_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// запускает алгоритм автоматического формирования подстереотипов на основе информации о
// наследовании
void AbstractDumperBase::TemplateParser::build_substereotypes () const {
	//#UC START# *4C0F61F40234*
	typedef std::vector<AbstractDumperBase::Templates::const_iterator> TemplateIteratorsSet;
	typedef std::map<StereotypeID, TemplateIteratorsSet> Parent2ChildsMap;
	typedef std::vector<std::pair<StereotypeID, TemplateIteratorsSet> > InheritedSubstereotypesList;

	class local {
	public:
		//собирает подстереотипы элемента - т.е стереотипы
		//имя имя которых, начинается с имени стереотипа
		static void collect_substereotypes (
			const StereotypeID& parent_st
			, const StereotypeID& self_st
			, TemplateIteratorsSet& substereotypes
		) {
			AbstractDumperBase::Templates::const_iterator it = s_templates.begin ();
			AbstractDumperBase::Templates::const_iterator it_end = s_templates.end ();
			for (; it != it_end; ++it) {
				if (
					it->first/*.get ()*/.size () > parent_st/*.get ()*/.size ()
					&& GCL::start_with (it->first, parent_st)
					&& it->first != self_st
				) {
					substereotypes.push_back (it);
				}
			}
		}

		static void collect_inherited_substereotypes (
			AbstractDumperBase::Templates::const_iterator tpl_it
			, StereotypeSet& visited
			, Parent2ChildsMap& all_substereotypes
			, InheritedSubstereotypesList& substereotypes
		) {
			if (visited.find (tpl_it->first) == visited.end ()) {
				visited.insert (tpl_it->first);

				for (
					StereotypeSet::const_iterator base_it = tpl_it->second.base_stereotypes.begin ()
					; base_it != tpl_it->second.base_stereotypes.end ()
					; ++base_it
				) {
					Parent2ChildsMap::const_iterator all_st_it = all_substereotypes.find (*base_it);
					if (all_st_it == all_substereotypes.end ()) {
						TemplateIteratorsSet collected_substrereotypes;
						collect_substereotypes (*base_it, tpl_it->first, collected_substrereotypes);

						all_st_it = all_substereotypes.insert (std::make_pair (*base_it, collected_substrereotypes)).first;
					}

					substereotypes.push_back (std::make_pair (*base_it, all_st_it->second));
				}

				for (
					StereotypeSet::const_iterator base_it = tpl_it->second.base_stereotypes.begin ()
					; base_it != tpl_it->second.base_stereotypes.end ()
					; ++base_it
				) {
					AbstractDumperBase::Templates::const_iterator base_tpl_it = s_templates.find (*base_it);
					if (base_tpl_it != s_templates.end ()) {
						collect_inherited_substereotypes (base_tpl_it, visited, all_substereotypes, substereotypes);
					}
				}
			}
		}
	};

	bool new_substereotypes_added = false;
	
	do {
		AbstractDumperBase::Templates::const_iterator tpl_it = s_templates.begin ();
		AbstractDumperBase::Templates::const_iterator tpl_it_end = s_templates.end ();
	
		AbstractDumperBase::Templates new_substereotypes;
	
		Parent2ChildsMap all_substereotypes;
		for (; tpl_it != tpl_it_end; ++tpl_it) {
			const StereotypeID& stereotype = tpl_it->first;

			InheritedSubstereotypesList substereotypes;
			StereotypeSet visited;
			local::collect_inherited_substereotypes (tpl_it, visited, all_substereotypes, substereotypes);
	
			for (
				InheritedSubstereotypesList::const_iterator sub_it = substereotypes.begin ()
				; sub_it != substereotypes.end ()
				; ++sub_it
			) {
				for (
					TemplateIteratorsSet::const_iterator it = sub_it->second.begin ()
					; it != sub_it->second.end ()
					; ++it
				) {
					std::string new_st ((*it)->first);
					GCL::str_replace (new_st, sub_it->first, stereotype);
					
					AbstractDumperBase::StereotypeID new_st_id (new_st);
					if (
						m_excluded_stereotypes.find (new_st_id) == m_excluded_stereotypes.end ()
						&& new_substereotypes.find (new_st_id) == new_substereotypes.end ()
						&& s_templates.find (new_st_id) == s_templates.end ()
					) {
						//emulate inheritance
						AbstractDumperBase::Template& new_tpl = new_substereotypes[new_st_id];
						new_tpl = (*it)->second;
						new_tpl.classtype_name = (*it)->second.classtype_name;
						new_tpl.stereotype_name = (*it)->second.stereotype_name;
						new_tpl.is_internal = (*it)->second.is_internal;
	
						new_tpl.base_stereotypes.insert ((*it)->first);
					}			
				}
			}
		}
		new_substereotypes_added = !new_substereotypes.empty ();
		s_templates.insert (new_substereotypes.begin (), new_substereotypes.end ());
	} while (new_substereotypes_added);

	for (
		StereotypeSet::const_iterator it = m_excluded_stereotypes.begin ()
		; it != m_excluded_stereotypes.end ()
		; ++it
	) {
		s_templates.erase (*it);
	}
	//#UC END# *4C0F61F40234*
}

// обработчик начала нового стереотипа - если предыдущий стереотип был переопределением, обновляет
// шаблон для всех его наследников рекурсивно
void AbstractDumperBase::TemplateParser::on_new_stereotype (
	const StereotypeID& prev_stereotype
	, bool prev_was_redefinition
) {
	//#UC START# *4BB481C8037C*
	if (prev_was_redefinition && !prev_stereotype/*.get ()*/.empty ()) {
		//т.к началось объявление нового стереотипа нужно обновить
		//шаблон для наследников предыдущего обработанного стереотипа (prev_stereotype)
		update_descendants_recursively (prev_stereotype);
	}

	m_cur_stereotype_is_redefinition = false;
	//#UC END# *4BB481C8037C*
}

// парсит шаблон, в случае ошибки при разборе шаблона выбрасывается исключение.
// \template_data - скленный в один массив строк шаблон
void AbstractDumperBase::TemplateParser::parse (const TemplateData& template_data) {
	//#UC START# *46E8E1CB032C*
	class TransformatorWrapper {
	public:
		TransformatorWrapper ()
			: m_cur_transformer (0)
		{
		}
		
		AbstractDumperBase::Transformator* get_transformer () {
			return m_cur_transformer;
		}

		void set_transformer (AbstractDumperBase::Transformator* transf) {
			GDS_ASSERT(transf);
			
			reset ();			
			m_cur_transformer = transf;
		}
		

		void add_row (const AbstractDumperBase::TransformatorBody& tb) {
			m_current_rows.push_back (tb);
		}
		
		bool is_rows_empty () {
			bool res = m_current_rows.empty ();
			if (m_cur_transformer) {
				res &= m_cur_transformer->rows.empty ();
			}

			return res;
		}
		
		void reset () {
			if (m_cur_transformer != 0) {
				for (
					AbstractDumperBase::TransformatorBodyList::const_iterator it = m_cur_transformer->rows.begin ()
					; it != m_cur_transformer->rows.end ()
					; ++it
				) {
					m_current_rows.push_back (*it);
				}
				m_cur_transformer->rows = m_current_rows;
				m_cur_transformer = 0;
			}
			m_current_rows.clear ();
		}
	private:
		AbstractDumperBase::TransformatorBodyList m_current_rows;
		AbstractDumperBase::Transformator* m_cur_transformer;
	};
	class local {
	public:
		//пытается сковертировать строчку записанную в виде последовательности шестнадцатеричных чисел
		//например: 0D0A
		static bool try_encode (std::string& source) {
			bool res = true;
			if (source.size () % 2 == 0) {
				std::string in (source);
				source.clear ();
				for (
					size_t i = 0
					; i < in.size () && res
					;
				) {
					std::istringstream is (in.substr(i, 2));
					int value;
					if (is >> std::hex >> value) {
					  source += static_cast<char>(value);
					  i += 2;
					} else {
						res = false;
						break;
					}
				}
				
			} else {
				res = false;
			}

			return res;
		};
	};
	Core::GDS::StopWatch ex (GDS_CURRENT_FUNCTION);
	
	try {
		m_group_regex = group_regex_str;
		m_property_regex = property_regex_str;
	} catch (boost::regex_error& ex) {
		std::string mess ("Error ");
		mess += boost::lexical_cast<std::string> (ex.code ());
		mess += " while parse regexp, ";
		mess += boost::lexical_cast<std::string> (ex.position ());
		
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	}

	if (template_data.empty ()) {
		std::string mess ("Template file is empty");

		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);

		return;
	} else {
		TemplateData::const_iterator data_it = template_data.begin ();
		TemplateData::const_iterator it_end = template_data.end ();

		//первая строчка должна быть определённого формата
		if (*data_it != FILE_SIGNATURE) {
			std::string mess ("Invalid Template File, it must have signature \"");
			mess += FILE_SIGNATURE;
			mess += "\"";
			
			GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
			GenSupport::LogManagerFactory::get ().log_error (mess);

			return;
		} else {
			std::string line;
			static const std::string GEN_DEF ("Generator definitions:");
			static const std::string ST_DEF ("Stereotype definitions:");
			static const std::string REP_DEF ("Reports definitions:");
			
			TransformatorWrapper cur_transformer;

			AbstractDumperBase::FunctionID cur_func_id;
			AbstractDumperBase::FunctionID cur_st_func_id;
			GCL::StrVector cur_columns_id;
			AbstractDumperBase::GenID cur_gen_id;

			// текущий стереотип
			m_cur_stereotype.clear ();

			m_cur_stereotype_is_redefinition = false;

			Core::Var<AbstractDumperBase::GenTreeItem> current_gen_item;
			Core::Var<AbstractDumperBase::ReportsTreeItem> current_rep_item;
			m_current_prop_item = 0;
					
			enum DefPart {
				DP_GEN
				, DP_ST
				, DP_REP
			};

			DefPart in_def_part = DP_ST;

			//unsigned line_num = 0;
			
			std::string mess;
			long property_group_scopes = 0;
			boost::smatch what;

			for (data_it++; data_it != it_end; ++data_it) {
				try {				
					line = *data_it;
					mess.clear ();

					if (line == GEN_DEF) {
						in_def_part = DP_GEN;
						continue;
					}

					if (line == ST_DEF) {
						in_def_part = DP_ST;
						continue;
					}

					if (line == REP_DEF) {
						in_def_part = DP_REP;
						continue;
					}
					

					if (in_def_part == DP_GEN) {
						GCL::StrVector split_line = GCL::split_string_by (line.data (), '"');
						if (split_line.size() == 3) {
							if (GCL::trim_ws(split_line[0].data()) == "group") {
								AbstractDumperBase::GenTreeItem* new_item = new AbstractDumperBase::GenTreeItem (split_line[1].data());
								if (AbstractDumperBase::s_gen_tree.is_nil()) {
									AbstractDumperBase::s_gen_tree = new_item;
								} else {
									current_gen_item->insert_back_child (new_item);
								}
								current_gen_item = AbstractDumperBase::GenTreeItem::_duplicate(new_item);					
							} else if (GCL::trim_ws(split_line[0].data()) == "generator") {
								if (AbstractDumperBase::s_gen_infos.find(split_line[1]) != s_gen_infos.end()) {
									mess = "Dublicated generator id (";
									mess += split_line[1];
									mess += ")";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								} else {
									AbstractDumperBase::GenTreeItem* new_item = new AbstractDumperBase::GenTreeItem (split_line[1].data());
									current_gen_item->insert_back_child (new_item);
									current_gen_item = GenTreeItem::_duplicate(new_item);					
									AbstractDumperBase::s_gen_infos[split_line[1]] = new_item;
								}
							}
						} else {
							if (GCL::trim_ws(line.data ()) == "}") {
								current_gen_item = dynamic_cast<AbstractDumperBase::GenTreeItem*>(current_gen_item->parent());
							} else {
								split_line = GCL::split_string_by (line.data (), ':');
								if (split_line.size() == 2) {
									if (GCL::trim_ws(split_line[0].data()) == "Description") {
										std::string desc = GCL::trim_ws(split_line[1].data());
										current_gen_item->description (desc);
									} else {
										std::string prop_id = GCL::trim_ws(split_line[0].data());
										std::string prop_value = GCL::trim_ws(split_line[1].data());
										current_gen_item->set_property (prop_id, prop_value);
									}
								}
							}
						}
						continue;
					} else if (in_def_part == DP_REP) {
						GCL::StrVector split_line = GCL::split_string_by (line.data (), '"');
						if (split_line.size() == 3 && GCL::trim_ws(split_line[0].data()) == "group") {

							AbstractDumperBase::ReportsTreeItem* new_item = new AbstractDumperBase::ReportsTreeItem (split_line[1].data());
							if (AbstractDumperBase::s_reports_tree.is_nil()) {
								AbstractDumperBase::s_reports_tree = new_item;
							} else {
								current_rep_item->insert_back_child (new_item);
							}
							current_rep_item = AbstractDumperBase::ReportsTreeItem::_duplicate(new_item);
						} else if (split_line.size() == 3 && GCL::trim_ws(split_line[0].data()) == "report") {
							if (AbstractDumperBase::s_report_infos.find(split_line[1]) != AbstractDumperBase::s_report_infos.end()) {
								mess = "Dublicated report id (";
								mess += split_line[1];
								mess += ")";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							} else {
								AbstractDumperBase::ReportsTreeItem* new_item = new AbstractDumperBase::ReportsTreeItem (split_line[1].data());
								current_rep_item->insert_back_child (new_item);
								current_rep_item = ReportsTreeItem::_duplicate(new_item);					
								s_report_infos[split_line[1]] = new_item;
							}
						} else if (GCL::trim_ws(line.data ()) == "}") {
							current_rep_item = dynamic_cast<ReportsTreeItem*>(current_rep_item->parent());
						} else {
							std::string std_line = line;
							split_line = GCL::split_string_by (std_line.begin(), std_line.end(), ':', '{', '\\', '}');
							if (split_line.size() == 2 && GCL::trim_ws(split_line[0].data()) == "query") {
								std::string q = "[";
								q += GCL::trim_ws(split_line[1].data());
								q += "true]";
								current_rep_item->query (q);
							} else if (split_line.size() == 2 && GCL::trim_ws(split_line[0].data()) == "auto") {
								current_rep_item->set_auto(GCL::trim_ws(split_line[1].data()));
							} else if (split_line.size() == 3) {
								std::string view_name = GCL::trim_ws(split_line[0].data());
								std::string view_value = boost::trim_copy_if (
									GCL::trim_ws(split_line[1].data())
									, boost::is_any_of ("{}")
								);
								std::string view_len = GCL::trim_ws(split_line[2].data());
								current_rep_item->set_view (view_name, view_value, atoi(view_len.data()));
							} else if (GCL::trim_ws(line.data ()) != "" && line[0] != '/') {
								mess = "Bad report format (";
								mess += line;
								mess += ")";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
						}
						continue;
					} else if (boost::regex_match (line, what, m_group_regex)) {					
						std::string name (what[1].first, what[1].second);
						this->process_property_group (name, data_it, it_end, property_group_scopes);
						if (property_group_scopes != 0) {
							mess = boost::lexical_cast<std::string> (abs (property_group_scopes));
							mess += " unclosed property group in line \"";
							mess += line;
							mess += "\"";
							
							GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
							GenSupport::LogManagerFactory::get ().log_error (mess);

							continue;
						}
						continue;
					}

					switch (line[0]) {
						case SX_1_INCLUDED_ST: {
							if (line.length () > 2) {
								std::string temp = line;
								temp.erase (0, 2);

								AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);
								if (temp == "!") {
									Template& tpl = s_templates[cur_stereotype_id];
									tpl.inherit_child_constraint = false;
									//очищаем список включаемых стереотипов, т.к 
									//он может быть не пуст, например для переопределений
									//поэтому признак всегда должен идти ДО реального списка включений/исключений
									tpl.child_st_constraints.clear ();
									tpl.child_internal_st_constraints.clear ();
								} else {
									if (
										s_templates[cur_stereotype_id].child_st_constarint_type != CSCT_UNDEFINED 
										&& s_templates[cur_stereotype_id].child_st_constarint_type != CSCT_INCLUDED
									) {
										mess = "Can't use INCLUIDE and EXCLUDE paremeters together in \"";
										mess += m_cur_stereotype;
										mess += "\"";
										
										GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
										GenSupport::LogManagerFactory::get ().log_error (mess);

										continue;
									} else {				
										GCL::StrVector sv = GCL::split_string_by (temp.c_str (), ',');
										s_templates[cur_stereotype_id].child_st_constarint_type = CSCT_INCLUDED;

										for (GCL::StrVector::iterator it = sv.begin(); it != sv.end(); it++) {
											std::string stereotype = GCL::trim_ws (it->c_str ());
											if (GCL::end_with (stereotype.c_str (), SX_1_INTERNAL_STEREOTYPE_MARK)) {
												stereotype.erase(stereotype.length () - 1);
												s_templates[cur_stereotype_id].child_internal_st_constraints.insert (stereotype);
											} else {
												s_templates[cur_stereotype_id].child_st_constraints.insert (stereotype);
											}
											
										}
									}
								}
							} else {
								mess = "Wrong include format in line \"";
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						}
						case SX_1_EXCLUDED_ST: {
							if (line.length () > 2) {
								std::string temp = line;
								temp.erase (0, 2);

								AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);
								if (temp == "!") {
									Template& tpl = s_templates[cur_stereotype_id];
									tpl.inherit_child_constraint = false;
									//очищаем список включаемых стереотипов, т.к 
									//он может быть не пуст, например для переопределений
									//поэтому признак всегда должен идти ДО реального списка включений/исключений
									tpl.child_st_constraints.clear ();
									tpl.child_internal_st_constraints.clear ();
								} else {
									if (
										s_templates[cur_stereotype_id].child_st_constarint_type != CSCT_UNDEFINED 
										&& s_templates[cur_stereotype_id].child_st_constarint_type != CSCT_EXCLUDED
									) {
										mess = "Can't use INCLUIDE and EXCLUDE paremeters together in \"";
										mess += m_cur_stereotype;
										mess += "\"";
										
										GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
										GenSupport::LogManagerFactory::get ().log_error (mess);

										continue;
									}
									GCL::StrVector sv = GCL::split_string_by (temp.c_str (), ',');
									s_templates[cur_stereotype_id].child_st_constarint_type = CSCT_EXCLUDED;

									for (GCL::StrVector::iterator it = sv.begin(); it != sv.end(); it++) {
										std::string stereotype = GCL::trim_ws (it->c_str ());
										if (GCL::end_with (stereotype.c_str (), SX_1_INTERNAL_STEREOTYPE_MARK)) {
											stereotype.erase(stereotype.length () - 1);
											s_templates[cur_stereotype_id].child_internal_st_constraints.insert (stereotype);
										} else {
											s_templates[cur_stereotype_id].child_st_constraints.insert (stereotype);
										}
									}
								}
							} else {
								mess = "Wrong exclude format in line \"";
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						}
						case SX_1_VISABILTY_TYPE: {
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.visability_type = 0;
							tpl.on_property_set (TP_VISABILITY_TYPE, false);
							if (line.length () > 2) {
								std::string temp = line;
								temp.erase (0, 2);
								std::string::const_iterator it_begin = temp.begin ();
								std::string::const_iterator it_end = temp.end ();
								for (std::string::const_iterator it = it_begin; it != it_end; ++it) {
									switch (*it) {
										case SX_VT_PUBLIC:
											tpl.visability_type |= VTF_PUBLIC;
											tpl.on_property_set (TP_VISABILITY_TYPE);
											if (it == it_begin) {
												tpl.def_visability_type = "PublicAccess";
												tpl.on_property_set (TP_DEF_VISABILITY_TYPE);
											}
											break;
										case SX_VT_PROTECTED:
											tpl.visability_type |= VTF_PROTECTED;
											tpl.on_property_set (TP_VISABILITY_TYPE);
											if (it == it_begin) {
												tpl.on_property_set (TP_DEF_VISABILITY_TYPE);
												tpl.def_visability_type = "ProtectedAccess";
											}
											break;
										case SX_VT_PRIVATE:
											tpl.visability_type |= VTF_PRIVATE;
											tpl.on_property_set (TP_VISABILITY_TYPE);
											if (it == it_begin) {
												tpl.on_property_set (TP_DEF_VISABILITY_TYPE);
												tpl.def_visability_type = "PrivateAccess";
											}
											break;
										case SX_VT_IMPL:
											tpl.visability_type |= VTF_IMPL;
											tpl.on_property_set (TP_VISABILITY_TYPE);
											if (it == it_begin) {
												tpl.on_property_set (TP_DEF_VISABILITY_TYPE);
												tpl.def_visability_type = "ImplementationAccess";
											}
											break;
										default: {
											mess = "Invalid Visability Type \"";
											mess += line;
											mess += "\" for stereotype \"";
											mess += m_cur_stereotype;
											mess += "\"";
											
											GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
											GenSupport::LogManagerFactory::get ().log_error (mess);

											continue;
										}
									}								
								}
							}
							break;
						}
						case SX_1_ABSTRACTION_TYPE: {
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.abstraction_type = 0;
							tpl.on_property_set (TP_ABSTRACTION_TYPE, false);
							if (line.length () > 2) {
								std::string temp = line;
								temp.erase (0, 2);
								std::string::const_iterator it_begin = temp.begin ();
								std::string::const_iterator it_end = temp.end ();							
								for (std::string::const_iterator it = it_begin; it != it_end; ++it) {
									switch (*it) {
										case SX_AT_ABSTRACT:
											tpl.abstraction_type |= AbstractDumperBase::ATF_ABSTRACT;
											tpl.on_property_set (TP_ABSTRACTION_TYPE);
											if (it == it_begin) {
												tpl.def_abstraction_type = "abstract";
												tpl.on_property_set (TP_DEF_ABSTRACTION_TYPE);
											}
											break;
										case SX_AT_REGULAR:
											tpl.abstraction_type |= AbstractDumperBase::ATF_REGULAR;
											tpl.on_property_set (TP_ABSTRACTION_TYPE);
											if (it == it_begin) {
												tpl.def_abstraction_type = "regular";
												tpl.on_property_set (TP_DEF_ABSTRACTION_TYPE);
											}
											break;
										case SX_AT_FINAL:
											tpl.abstraction_type |= AbstractDumperBase::ATF_FINAL;
											tpl.on_property_set (TP_ABSTRACTION_TYPE);
											if (it == it_begin) {
												tpl.def_abstraction_type = "final";
												tpl.on_property_set (TP_DEF_ABSTRACTION_TYPE);
											}
											break;
										case SX_AT_OPTION:
											tpl.abstraction_type |= AbstractDumperBase::ATF_OPTIONAL;
											tpl.on_property_set (TP_ABSTRACTION_TYPE);
											if (it == it_begin) {
												tpl.def_abstraction_type = "optional";
												tpl.on_property_set (TP_DEF_ABSTRACTION_TYPE);
											}
											break;
										default: {
											mess = "Invalid Abstarction Type \"";
											mess += line;
											mess += "\" for stereotype \"";
											mess += m_cur_stereotype;
											mess += "\"";
											
											GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
											GenSupport::LogManagerFactory::get ().log_error (mess);

											continue;
										}
									}
								}
							}
							break;
						}
						case SX_1_LINK_TYPE: {
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.link_type = 0;
							tpl.on_property_set (TP_LINK_TYPE, false);
							if (line.length () > 2) {
								std::string temp = line;
								temp.erase (0, 2);
								std::string::const_iterator it_begin = temp.begin ();
								std::string::const_iterator it_end = temp.end ();							
								for (std::string::const_iterator it = it_begin; it != it_end; ++it) {
									switch (*it) {								
										case SX_LT_REF:
											tpl.link_type |= LTF_REF;
											tpl.on_property_set (TP_LINK_TYPE);
											if (it == it_begin) {
												tpl.def_link_type = "ref";
												tpl.on_property_set (TP_DEF_LINK_TYPE);
											}
											break;
										case SX_LT_AGR:
											tpl.link_type |= LTF_AGR;
											tpl.on_property_set (TP_LINK_TYPE);
											if (it == it_begin) {
												tpl.def_link_type = "agr";
												tpl.on_property_set (TP_DEF_LINK_TYPE);
											}
											break;
										case SX_LT_LNK:
											tpl.link_type |= LTF_LNK;
											tpl.on_property_set (TP_LINK_TYPE);
											if (it == it_begin) {
												tpl.def_link_type = "lnk";
												tpl.on_property_set (TP_DEF_LINK_TYPE);
											}
											break;							
										default: {
											mess = "Invalid Link Type \"";
											mess += line;
											mess += "\" for stereotype \"";
											mess += m_cur_stereotype;
											mess += "\"";
											
											GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
											GenSupport::LogManagerFactory::get ().log_error (mess);

											continue;
										}
									}
								}
							}
							break;
						}
						case SX_1_IMPLEMENTATION_TYPE: {
							if (line.length () > 1) {
								AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);
								switch (line[2]) {
									case SX_IT_TRUE:
										s_templates[cur_stereotype_id].implementation_type = SX_IT_TRUE;
										s_templates[cur_stereotype_id].on_property_set (TP_IMPLEMENTATION_TYPE);
										break;
									case SX_IT_FALSE:
										s_templates[cur_stereotype_id].implementation_type = SX_IT_FALSE;
										s_templates[cur_stereotype_id].on_property_set (TP_IMPLEMENTATION_TYPE);
										break;
								}
							}
							break;
						}
						case SX_1_PARAMETERIZATION_TYPE: {
							bool value_b = true;
							if (line.length () > 1) {
								std::string value = line;
								value.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							
							AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);

							s_templates[cur_stereotype_id].parameterization_type = value_b;
							s_templates[cur_stereotype_id].on_property_set (TP_PARAMETERIZATION_TYPE);
							break;
						}
						case SX_1_HAS_DERIVED_IMPL: {
							if (line.length () > 2) {
								AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);

								switch (line[2]) {
									case '0':
										s_templates[cur_stereotype_id].has_derived_impl = false;
										s_templates[cur_stereotype_id].on_property_set (TP_HAS_DERIVED_IMPL);
										break;
									default:
										s_templates[cur_stereotype_id].has_derived_impl = true;
										s_templates[cur_stereotype_id].on_property_set (TP_HAS_DERIVED_IMPL);
										break;
								}
							}
							break;
						}
						case SX_1_COLORIZE_OPTION: {
							if (line.length () > 2) {
								AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);

								switch (line[2]) {
									case SX_C_ST_ICONIC_VIEW:
										if (line.length () <= 4) {
											mess = "Invalid Iconic View Type \"";
											mess += line;
											mess += "\" for stereotype \"";
											mess += m_cur_stereotype;
											mess += "\"";
											
											GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
											GenSupport::LogManagerFactory::get ().log_error (mess);

											continue;
										} else {
											switch (line[4]) {
												case 'i':
													s_templates[cur_stereotype_id].clrz_iconic_view = IVT_ICON;
													s_templates[cur_stereotype_id].on_property_set (TP_CLRZ_ICONIC_VIEW);
													break;
												case 'd':
													s_templates[cur_stereotype_id].clrz_iconic_view = IVT_DECOR;
													s_templates[cur_stereotype_id].on_property_set (TP_CLRZ_ICONIC_VIEW);
													break;
												case 'n':
													s_templates[cur_stereotype_id].clrz_iconic_view = IVT_NONE;
													s_templates[cur_stereotype_id].on_property_set (TP_CLRZ_ICONIC_VIEW);
													break;
												case 's':
													s_templates[cur_stereotype_id].clrz_iconic_view = IVT_ST;
													s_templates[cur_stereotype_id].on_property_set (TP_CLRZ_ICONIC_VIEW);
													break;
												default:
													mess = "Invalid Iconic View Type \"";
													mess += line;
													mess += "\" for stereotype \"";
													mess += m_cur_stereotype;
													mess += "\"";
													
													GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
													GenSupport::LogManagerFactory::get ().log_error (mess);

													continue;
												}
										}
										break;
									case SX_C_SUPPRES_OPERATION: {
										bool value_b = true;
										if (line.length () > 3) {									
											std::string value = line;
											value.erase (0, 4);
											if (value == "true") {
												value_b = true;
											} else if (value == "false") {
												value_b = false;
											}
										}
										s_templates[cur_stereotype_id].clrz_suppres_operation = value_b;
										s_templates[cur_stereotype_id].on_property_set (TP_CLRZ_SUPPRES_OPERATION);
										break;
									}
									case SX_C_SUPPRES_ATTRIBUTE	: {
										bool value_b = true;
										if (line.length () > 3) {									
											std::string value = line;
											value.erase (0, 4);
											if (value == "true") {
												value_b = true;
											} else if (value == "false") {
												value_b = false;
											}
										}
										s_templates[cur_stereotype_id].clrz_suppres_atribute = value_b;
										s_templates[cur_stereotype_id].on_property_set (TP_CLRZ_SUPPRES_ATRIBUTE);
										break;
									}
									case SX_C_FILL_COLOR: {
										std::string temp = line;
										temp.erase (0, 3);
										GCL::StrVector rgb_colors = GCL::split_string_by (temp.c_str (), ',');

										Template& tpl = s_templates[cur_stereotype_id];
										tpl.clrz_fill_color.clear ();
										for (GCL::StrVector::iterator it = rgb_colors.begin(); it  != rgb_colors.end(); it++) {
											tpl.clrz_fill_color.push_back (atoi (it->data()));
										}
										tpl.on_property_set (TP_CLRZ_FILL_COLOR);
										break;
									}
									case SX_C_LINE_COLOR: {
										std::string temp = line;
										temp.erase (0, 3);
										GCL::StrVector rgb_colors = GCL::split_string_by (temp.c_str (), ',');

										Template& tpl = s_templates[cur_stereotype_id];
										tpl.clrz_line_color.clear ();
										for (GCL::StrVector::iterator it = rgb_colors.begin(); it  != rgb_colors.end(); it++) {
											tpl.clrz_line_color.push_back (atoi (it->data()));
										}
										tpl.on_property_set (TP_CLRZ_LINE_COLOR);
										break;
									}
									case SX_C_FONT_COLOR: {
										std::string temp = line;
										temp.erase (0, 3);
										GCL::StrVector rgb_colors = GCL::split_string_by (temp.c_str (), ',');

										Template& tpl = s_templates[cur_stereotype_id];
										tpl.clrz_font_color.clear ();
										for (GCL::StrVector::iterator it = rgb_colors.begin(); it  != rgb_colors.end(); it++) {
											tpl.clrz_font_color.push_back (atoi (it->data()));
										}
										tpl.on_property_set (TP_CLRZ_FONT_COLOR);
										break;
									}
									case SX_C_FORIEN_LINE_COLOR: {
										std::string temp = line;
										temp.erase (0, 3);
										GCL::StrVector rgb_colors = GCL::split_string_by (temp.c_str (), ',');

										Template& tpl = s_templates[cur_stereotype_id];
										tpl.clrz_forien_line_color.clear ();
										for (GCL::StrVector::iterator it = rgb_colors.begin(); it  != rgb_colors.end(); it++) {
											tpl.clrz_forien_line_color.push_back (atoi (it->data()));
										}
										tpl.on_property_set (TP_CLRZ_FORIEN_LINE_COLOR);
										break;
									}
									case SX_C_FORIEN_FONT_COLOR: {
										std::string temp = line;
										temp.erase (0, 3);
										GCL::StrVector rgb_colors = GCL::split_string_by (temp.c_str (), ',');

										Template& tpl = s_templates[cur_stereotype_id];
										tpl.clrz_forien_font_color.clear ();
										for (GCL::StrVector::iterator it = rgb_colors.begin(); it  != rgb_colors.end(); it++) {
											tpl.clrz_forien_font_color.push_back (atoi (it->data()));
										}
										tpl.on_property_set (TP_CLRZ_FORIEN_FONT_COLOR);
										break;
									}
								}
							}
							break;
						}
						case SX_1_MAIN_BASE_STEREOTYPE: 
							if (line.size () > 1) {
								line.erase (0, 2);
								AbstractDumperBase::Templates::iterator f = s_templates.find (AbstractDumperBase::StereotypeID (line));
								if (f == s_templates.end ()) {
									mess = "Use undefinded main base stereotype \"";
									mess += line;
									mess += "\" for stereotype \"";
									mess += m_cur_stereotype;
									mess += "\"";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].main_base_stereotype = line;
							}
							break;

						case SX_1_EXCLUDED_STEREOTYPE_MARK: 
							if (line.size () > 1) {
								line.erase (0, 2);								
								m_excluded_stereotypes.insert (AbstractDumperBase::StereotypeID (line));
							}
							break;
		
						case SX_1_STEREOTYPE: {
							if (line.size () > 1) {
								on_new_stereotype (AbstractDumperBase::StereotypeID (m_cur_stereotype), m_cur_stereotype_is_redefinition);
								
								static boost::regex stereotype_exp ("^:\\s*([^()]*)\\s*(\\(redefinition\\))?");
								boost::smatch st_match;
								if (!regex_match (line, st_match, stereotype_exp)) {
									mess = "Invalid stereotype format in line \"";
									mess += line;
									mess += "\"";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}
								std::string redefinition_str (st_match[2].first, st_match[2].second);

								m_cur_stereotype.assign (st_match[1].first, st_match[1].second);							
								m_cur_stereotype = GCL::trim_ws(m_cur_stereotype.c_str ());
								bool is_internal = false;
								if (GCL::end_with (m_cur_stereotype.c_str (), SX_1_INTERNAL_STEREOTYPE_MARK)) {
									m_cur_stereotype.erase(m_cur_stereotype.length () - 1);
									is_internal = true;
								}

								cur_gen_id.clear ();
								cur_st_func_id = AbstractDumperBase::FunctionID ("");
								cur_func_id = AbstractDumperBase::FunctionID ("");
								cur_transformer.reset ();

								GCL::StrVector parts = GCL::split_string_by_sub_string (m_cur_stereotype.data(), "::");
								if (parts.size() < 2) {
									if (parts[0] != "default") {
										mess = "Invalid stereotype format \"";
										mess += line;
										mess += "\" for stereotype \"";
										mess += m_cur_stereotype;
										mess += "\"";
										
										GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
										GenSupport::LogManagerFactory::get ().log_error (mess);

										continue;
									}
									Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
									tpl.stereotype_name = "<default>";
									tpl.classtype_name = "<default>";
								} else if (parts.size() == 2) {
									if (parts[1] == "Category") {
										std::string class_st = parts[0] + "::Class";
										if (s_templates.find (AbstractDumperBase::StereotypeID (class_st)) != s_templates.end ()) {
											mess = "Error, already exists stereotype \"";
											mess += parts[0];
											mess += "\" as Class, stereotype class and category can't be called equally";
											
											GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
											GenSupport::LogManagerFactory::get ().log_error (mess);

											continue;
										}
									} else if (parts[1] == "Class") {
										std::string cat_st = parts[0] + "::Category";
										if (s_templates.find (AbstractDumperBase::StereotypeID (cat_st)) != s_templates.end ()) {
											mess = "Error, already exists stereotype \"";
											mess += parts[0];
											mess += "\" as Category, stereotype class and category can't be called equally";
											
											GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
											GenSupport::LogManagerFactory::get ().log_error (mess);

											continue;
										}
									}
								}
								
								AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);

								if (
									s_templates.find(cur_stereotype_id) != s_templates.end()
									&& redefinition_str.empty ()
									&& AbstractDumperBase::DEFAULT_STEREOTYPE_ID != m_cur_stereotype
								) {
									mess = "Stereotype \"";
									mess += m_cur_stereotype;
									mess += "\"  already defined";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								} else if (
									s_templates.find (cur_stereotype_id) == s_templates.end ()
									&& !redefinition_str.empty ()
								) {
									mess = "Stereotype \"";
									mess += m_cur_stereotype;
									mess += "\" can't be redefinition, because it is not exist yet";
																	
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}

								if (!redefinition_str.empty ()) {
									m_cur_stereotype_is_redefinition = true;
									//если это переопределение существующего стереотипа, нужно
									//данные переопределяемого стереотипа сохранить!
									Template& curr_template = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
									Template base_templ = curr_template;

									//добавляем к имени стереотипа префиксфикс, чтобы отличать
									//именно перфикс, т.к если добавлять в постфикс (в конец), то могут быть проблемы
									//если текущий стереотип например операция - тогда в элементе контэйнере при создании новой операции
									//в списке доступных стереотипов будет доступны и собтсвенно стереотип и база.
									//при этом ко всем уже имеющимся базовым стереотипам нужно добавить префикс
									std::string base_st_name = AbstractDumperBase::s_redefinition_postfix + m_cur_stereotype;
									
									AbstractDumperBase::StereotypeIDVector available_bases;

									while (s_templates.find (AbstractDumperBase::StereotypeID (base_st_name)) != s_templates.end ()) {
										available_bases.push_back (AbstractDumperBase::StereotypeID (base_st_name));
										base_st_name.insert (0, AbstractDumperBase::s_redefinition_postfix);
									}
									
									//добавляемым префиксы у уже найденным стереотипам (начинаем с самого дальнего родителя):
									for (
										AbstractDumperBase::StereotypeIDVector::reverse_iterator bases_it = available_bases.rbegin ()
										; bases_it != available_bases.rend ()
										; ++bases_it
									) {
										Templates::iterator available_base_template_it = s_templates.find (*bases_it);
										GDS_ASSERT(available_base_template_it != s_templates.end ());

										AbstractDumperBase::StereotypeID new_base_st_name (AbstractDumperBase::s_redefinition_postfix + (*bases_it)/*.get ()*/);

										s_templates.insert (std::make_pair (new_base_st_name, available_base_template_it->second));
										s_templates.erase (available_base_template_it);
									}

									base_st_name = AbstractDumperBase::s_redefinition_postfix + m_cur_stereotype;
									s_templates.insert (std::make_pair (AbstractDumperBase::StereotypeID (base_st_name), base_templ));
									
									curr_template.base_stereotypes.insert (AbstractDumperBase::StereotypeID (base_st_name));

									//нужно обновить информацию о базовом стеротипе:

									for (
										AbstractDumperBase::StereotypeIDVector::reverse_iterator bases_it = available_bases.rbegin ()
										; bases_it != available_bases.rend ()
										; ++bases_it
									) {
										Templates::iterator available_base_template_it = s_templates.find (*bases_it);
										GDS_ASSERT(available_base_template_it != s_templates.end ());

										StereotypeSet::iterator base_base_st = available_base_template_it->second.base_stereotypes.find (*bases_it);
										if (base_base_st != available_base_template_it->second.base_stereotypes.end ()) {
											available_base_template_it->second.base_stereotypes.erase (base_base_st);
											available_base_template_it->second.base_stereotypes.insert (
												AbstractDumperBase::StereotypeID (AbstractDumperBase::s_redefinition_postfix + (*bases_it)/*.get ()*/)
											);
										}
									}

									//нужно всем функциям и трансформаторам переопределяемого стереотипа
									//выставить в качестве реализации - вызов базового трансформатора
									for (
										Functions::iterator it = curr_template.functions.begin ()
										; it != curr_template.functions.end ()
										; ++it
									) {
										it->second.function_tpl = "%S%[inherited]";
									}

									for (
										Transformators::iterator it = curr_template.transformators.begin ()
										; it != curr_template.transformators.end ()
										; ++it
									) {
										for (
											TransformatorBodyList::iterator row_it = it->second.rows.begin ()
											; row_it != it->second.rows.end ()
											; ++row_it
										) {
											for (
												TransformatorRow::iterator body_it = row_it->row.begin ()
												; body_it != row_it->row.end ()
												; ++body_it
											) {
												body_it->second = "%S%[inherited]";
											}
										}
									}
								}

								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
								if (parts.size() == 2) { // like: BinaryFunctor::Class		
									tpl.stereotype_name = parts[0];
									tpl.classtype_name = parts[1];
								} else if (parts.size () == 3) { // like: BinaryFunctor::Class::Attribute
									tpl.stereotype_name = "<default>";
									tpl.classtype_name = parts[2];
								} else if (parts.size () == 4) { // like: BinaryFunctor::Class::first param::Attribute
																// or: Interface::Class::Operation::Parameter
									if (!is_it_classtype_name (parts[2])) {
										tpl.classtype_name = parts[3];
										tpl.stereotype_name = parts[2];
									} else {
										tpl.classtype_name = parts[3];
										tpl.stereotype_name = "<default>";
									}
								} else if (parts.size () == 5) { // like Interface::Class::chg::Operation::Parameter
									if (!is_it_classtype_name (parts[3])) {
										tpl.classtype_name = parts[4];
										tpl.stereotype_name = parts[3];
									} else {
										tpl.classtype_name = parts[4];
										tpl.stereotype_name = "<default>";
									}
								}
								
								tpl.is_internal = is_internal;
								// convert
								if (tpl.stereotype_name == "default") {
									tpl.stereotype_name = "<default>";
								}
							}
							break;
						}
						case SX_1_STEREOTYPE_EQ: {
							if (line.length () > 1) {
								std::string::size_type pos = line.find_first_of (';');
								std::string stereotype;
								std::string gen_id;							
								if (pos != std::string::npos) {
									stereotype = line.substr (2, pos - 2);
									gen_id = line.substr (pos + 1);
								} else {
									stereotype = line;
									stereotype.erase (0, 2);
								}							
								if (cur_gen_id == "" && pos != std::string::npos) {
									mess = "Stereotype \"";
									mess += m_cur_stereotype;
									mess += "\" in line \"";
									mess += line;
									mess += "\"";
																
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}
								
								AbstractDumperBase::Templates::iterator f;
								if (cur_gen_id == "" || pos != std::string::npos) {
									f = s_templates.find(AbstractDumperBase::StereotypeID (stereotype));

									if (f == s_templates.end ()) {
										mess = "Use undefined stereotype in EQ opertaion (\"";
										mess += m_cur_stereotype;
										mess += "= ";
										mess += stereotype;
										mess += "), line \"";
										mess += line;
										mess += "\"";

										GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
										GenSupport::LogManagerFactory::get ().log_error (mess);

										continue;
									}
								}

								AbstractDumperBase::StereotypeID cur_stereotype_id (m_cur_stereotype);

								if (cur_gen_id.empty ()) {
									s_templates[cur_stereotype_id] = f->second;
									s_templates[cur_stereotype_id].base_stereotypes.insert (f->first);
								} else {
									const TemplateBody* tpl = 0;
									if (pos == std::string::npos) {
										//s_templates[m_cur_stereotype].generators[cur_gen_id] = s_templates[m_cur_stereotype].generators[stereotype];
										tpl = &s_templates[cur_stereotype_id].generators[stereotype];
									} else {
										//s_templates[m_cur_stereotype].generators[cur_gen_id] = f->second.generators[gen_id];
										tpl = &f->second.generators[gen_id];
									}
									if  (tpl != 0) {
										TemplateBody& curr_tpl = s_templates[cur_stereotype_id].generators[cur_gen_id];
										AbstractDumperBase::CodeTemplate curr_tpl_saved_code = curr_tpl.code_template;
										curr_tpl = *tpl;
										curr_tpl.code_template = curr_tpl_saved_code;
										curr_tpl.code_template += tpl->code_template;
									}
								}
							}
							break;
						}
						case SX_1_STEREOTYPE_ADD: {
							std::string::size_type pos = line.find_first_of (';');
							if (pos == std::string::npos) {
								mess = "\"";
								mess += m_cur_stereotype;
								mess += "\" ";
								mess += "Invalid stereotype ADD format in line \"";
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							} else {
								std::string stereotype = line.substr (2, pos - 2);
								std::string what_add = line.substr (pos + 1);
								AbstractDumperBase::Templates::iterator f = s_templates.find(AbstractDumperBase::StereotypeID (stereotype));
								if (f == s_templates.end ()) {
									mess = "Use undefinded stereotype in ADD opertaion (";
									mess += m_cur_stereotype;
									mess += " && ";
									mess += stereotype;
									mess += "), line: \"";
									mess += line;
									mess += "\"";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}							 
								if (what_add == "f") {
									copy_map (
										f->second.functions.begin ()
										, f->second.functions.end ()
										, s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].functions
									);						
								} else if (what_add == "t") {
									copy_map (
										f->second.transformators.begin ()
										, f->second.transformators.end ()
										, s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].transformators
									);
								} else {
									mess = "Use undefinded param (";
									mess += what_add;
									mess += ") in ADD opertaion (";
									mess += " && ";
									mess += stereotype;
									mess += "), line: \"";
									mess += line;
									mess += "\"";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}
							}
							break;
						}
						case SX_1_AVAILABLE_TARGET_STREOTYPES: {
							if (line.length () > 1) {
								line.erase (0, 2);
								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
								
								tpl.available_target_stereotypes = GCL::split_string_by (line.c_str (), '|');
								tpl.on_property_set (TP_AVAILABLE_TARGET_STEREOTYPES);
							}
							break;
						}
						case SX_1_PARENT_VISABILITY: {
							if (line.length () > 1) {
								line.erase (0, 2);
								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
								GCL::split_string_by (tpl.parent_visability, line.c_str (), '|');							
								tpl.on_property_set (TP_PARENT_VISABILITY);
							}						
							break;
						}
						case SX_1_USER_PROPERTY: {						
							AbstractDumperBase::PropertyGroupTreeItem_var& root = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].user_properties_group;
							std::string root_name (m_cur_stereotype);
							root_name += " user properties";
							if (root.is_nil ()) {							
								root = new AbstractDumperBase::PropertyGroupTreeItem (root_name);
							} else {							
								root->set_name (root_name);							
							}
							m_current_prop_item = root;
							this->process_property (line);
							break;
						}
						case SX_1_ALLOW_EMPTY_TARGET: {
							bool value_b = true;
							if (line.length () > 1) {						
								std::string value = line;
								line.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.allow_empty_target = value_b;
							tpl.on_property_set (TP_ALLOW_EMPTY_TARGET);
							break;
						}
						case SX_1_IS_FFD: {
							bool value_b = true;
							if (line.length () > 1) {						
								std::string value = line;
								line.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.forbiden_forward_decl = value_b;
							tpl.on_property_set (TP_FORBIDEN_FORWARD_DECL);
							break;
						}
						case SX_1_IS_HOME: {
							bool value_b = true;
							if (line.length () > 1) {						
								std::string value = line;
								line.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.is_home = value_b;
							tpl.on_property_set (TP_IS_HOME);
							break;
						}
						case SX_1_SKIPED_ITEM: {
							bool value_b = true;
							if (line.length () > 1) {						
								std::string value = line;
								line.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.skiped_item = value_b;
							tpl.on_property_set (TP_SKIPED_ITEM);
							break;
						}
						case SX_1_LABELS: {
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.labels.clear();
							if (line.length () > 1) {
								line.erase (0, 2);
								GCL::split_string_by (
									tpl.labels
									, GCL::trim_ws (line.c_str ()).c_str ()
									, ','
								);
								tpl.on_property_set (TP_LABELS);
							}
							break;
						}
						case SX_1_GENID:				
							
							if (line.length () < 3) {
								mess = "Invalid generator id in line \"";
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
							}
							line.erase (0, 2);
							cur_gen_id = GCL::trim_ws (line.c_str ());

							if (s_gen_infos.find(cur_gen_id) == s_gen_infos.end()) {
								if (cur_gen_id != AbstractDumperBase::SPELL_GENERATOR_ID) {
									mess = "Invalid generator id (";
									mess += cur_gen_id;
									mess += ") in line \"";
									mess += line;
									mess += "\"";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								} else {
									break;
								}
							}

							s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].reset (); // push them into template
							cur_func_id = AbstractDumperBase::FunctionID ("");
							cur_transformer.reset ();
							break;
						case SX_1_OUTPUT_DIR_TPL_CREATE: {
								size_t len = line.length ();
								if (len > 1) {
									std::string dir_tpl_start;
									if (line[2] == '*') {								
										if (len > 2) {
											dir_tpl_start = line;
											dir_tpl_start.erase (0, 3);
										}
										s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].use_current_root = true;
									} else {
										dir_tpl_start = line;
										dir_tpl_start.erase (0, 2);
									}
									s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].dir_template = dir_tpl_start;
								}
							}
							break;
						case SX_1_OUTPUT_TPL_CREATE: {
								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
								if (line.length () > 1) {
									line.erase (0, 2);
									tpl.generators[cur_gen_id].file_template = line;
									tpl.generators[cur_gen_id].file_create = true;
								} else {
									tpl.generators[cur_gen_id].file_template.clear ();
									tpl.generators[cur_gen_id].file_create = false;
								}
							}
							break;
						case SX_1_OUTPUT_TPL: {
								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];

								if (line.length () > 1) {
									line.erase (0, 2);
									tpl.generators[cur_gen_id].file_template = line;
								}

								tpl.generators[cur_gen_id].file_create = false;
							}
							break;
						case SX_1_POST_COMMAND_TPL:
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].post_command_template = line;
							}
							break;
						case SX_1_LINK_GUID_TPL: {
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];						
							if (line.length () > 1) {
								line.erase (0, 2);
								tpl.link_guid_template = line;
							} else {
								tpl.link_guid_template = "";
							}
							tpl.on_property_set (TP_LINK_GUID_TEMPLATE);
							break;
						}
						case SX_1_IMAGE_FILE_NAME: {
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];	
							if (line.length () > 1) {
								line.erase (0, 2);
								tpl.image_file_name = line;
							} else {
								tpl.image_file_name = "";
							}
							tpl.on_property_set (TP_IMAGE_FILE_NAME);
							break;
						}
						case SX_1_GEN_OR_ST_INFO: {
								line.erase (0, 2);
								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
								if (line.length () > 1 && cur_gen_id .empty ()) {							
									if (tpl.st_description_header/*.get ()*/.empty ()) {
										tpl.st_description_header += line;
									} else {
										if (!tpl.st_description/*.get ()*/.empty ()) {
											tpl.st_description += "\n";
										}
										tpl.st_description += line;
									}
								} else {
									tpl.generators[cur_gen_id].generator_info = line;
								}
							}
							break;
						case SX_1_NEWLINE_REPLACER:
							if (line.length () > 1) {
								line.erase (0, 2);
								std::string temp (line);

								//если удалось сконвертировать, то заменяем исходную строку
								if (local::try_encode (temp)) {
									line = temp;
								}

								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].newline_replacer = line;
							}
							break;
						case SX_1_TAB_REPLACER:
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].tab_replacer = line;
							}
							break;
						case SX_1_USER_FILE: {
							if (line.length () > 1) {
								line.erase (0, 2);							
							} else {
								line = "true";
							}
							
							if (line.empty ()) {
								line = "true";
							}

							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.generators[cur_gen_id].user_file_template = line;
							break;
						}
						case SX_1_MAIN_ST: {
							bool value_b = true;
							if (line.length () > 1) {
								std::string value = line;
								value.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.main_st = value_b;
							tpl.on_property_set (TP_MAIN_ST);
							break;
						}
						case SX_1_VISIBILITY_LEVEL_SETTABLE: {
							bool value_b = true;
							if (line.length () > 1) {
								std::string value = line;
								value.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.visibility_level_settable = value_b;
							tpl.on_property_set (TP_VISIBILITY_LEVEL_SETTABLE);
							break;
						}	
						case SX_1_OPEN_SCOPE_TPL:
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].open_scope_template = line;
							}
							break;
						case SX_1_CLOSE_SCOPE_TPL:
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].close_scope_template = line;
							}
							break;
						case SX_1_FORWARD_TPL:
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].forward_template = line;
							}
							break;
						case SX_1_IS_PLAIN: {
							bool value_b = true;
							if (line.length () > 1) {
								std::string value = line;
								value.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].plain = value_b;
							break;
						}
						case SX_1_IS_EXCEPTION:
							s_exception_stereotypes.insert(AbstractDumperBase::StereotypeID (m_cur_stereotype));
							break;
						case SX_1_HAS_EXCEPTION: {
							char ex_t = 'g';
							if (line.length () > 2) {
								ex_t = line[2];
							}
							Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
							tpl.on_property_set (TP_HAS_GET_EXCEPT);
							tpl.on_property_set (TP_HAS_SET_EXCEPT);

							switch (ex_t) {
								case 'a':
									tpl.has_get_except = true;
									tpl.has_set_except = true;
									break;
								case 's':
									tpl.has_set_except = true;
									tpl.has_get_except = false;
									break;
								case 'g':
									tpl.has_get_except = true;
									tpl.has_set_except = false;
									break;
								default:
									mess = "Invalid HAS exception type \"";
									mess += ex_t;
									mess += "\" in line \"";
									mess += line;
									mess += "\" format";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}
							break;
						}
						case SX_1_CODE_TPL: {
							std::string code = line;
							code.erase (0, 1);
							if (cur_gen_id != "") {
								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
								TemplateBody& gen_tpl = tpl.generators[cur_gen_id];

								CodeTemplate ct = gen_tpl.code_template;

								if (ct == "") {
									gen_tpl.code_template = code;	
								} else {
									gen_tpl.code_template = ct + "\n" + code;
								}
							} else if (cur_st_func_id != "") {
								FunctionTemplate& ft = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].functions[cur_st_func_id].function_tpl;
								if (ft == "") {
									ft = code;				
								} else {
									ft = ft + "\n" + code;
								}
							} else if (cur_func_id != "") {
								FunctionTemplate ft = s_functions[cur_func_id].function_tpl;
								if (ft == "") {
									s_functions[cur_func_id].function_tpl = code;
								} else {
									s_functions[cur_func_id].function_tpl = ft + "\n" + code;
								}
							}
							break;
						}
						case SX_1_ST_MEMBERS: {
							if (line.length () > 4) {
								switch (line[1]) {
									case SX_1_FUNCTION_TPL:
										line.erase (0, 3);
										cur_st_func_id = GCL::trim_ws(line.c_str ());
										s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].functions[cur_st_func_id].function_tpl.clear ();
										s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].functions[cur_st_func_id].id = AbstractDumperBase::FunctionID (
											cur_st_func_id/*.get ()*/ + "st_function" //функция стереотипа
										);
						
										cur_func_id = AbstractDumperBase::FunctionID ("");
										cur_gen_id.clear ();
										cur_transformer.reset ();
										break;
									case SX_1_TRANSFORMER_TPL: {
											cur_transformer.reset ();
											line.erase (0, 3);

											AbstractDumperBase::TransformatorID t_name (GCL::trim_ws(line.c_str ()));
											
											AbstractDumperBase::Transformators& ts = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].transformators;
											AbstractDumperBase::Transformators::iterator t_it = ts.find (t_name);
											if (t_it != ts.end ()) {
												mess = "Duplicate stereotype transformator \"";
												mess += m_cur_stereotype;
												mess += "::";
												mess += t_name;
												mess += "\" definition in line \"";
												mess += line;
												mess += "\"";

												GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
												GenSupport::LogManagerFactory::get ().log_error (mess);

												continue;
											}
											
											if (t_it == ts.end ()) {
												t_it = ts.insert (std::make_pair (t_name, Transformator ())).first;
											}

											Transformator* tf = &(t_it->second);
											tf->name = GCL::trim_ws(t_name/*.get ()*/.c_str ());
											tf->id = AbstractDumperBase::TransformatorID (tf->name/*.get ()*/ + "st_transformator");

											cur_transformer.set_transformer (tf);
											
											
											cur_func_id = AbstractDumperBase::FunctionID ("");
											cur_gen_id .clear ();
											cur_st_func_id = "";
										}
										break;
									default:
										mess = "Invalid stereotype's member declaration in line \"";
										mess += line;
										mess += "\" format";
										
										GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
										GenSupport::LogManagerFactory::get ().log_error (mess);

										continue;
								}
							} else {
								mess = "Invalid stereotype's member declaration in line \"";
								mess += line;
								mess += "\" format";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						}
						case SX_1_FUNCTION_TPL:
							if (
								cur_transformer.get_transformer ()
								&& cur_transformer.is_rows_empty ()
							) {
								mess = "Invalid transformer \"";
								mess += cur_transformer.get_transformer ()->name;
								mess += "\" in line \"";
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							if (line.length () > 2) {//имя функции не может быть пустым
								line.erase (0, 2);
								cur_func_id = GCL::trim_ws(line.c_str ());
							
								s_functions[cur_func_id].function_tpl = "";
								s_functions[cur_func_id].id = AbstractDumperBase::FunctionID (cur_func_id/*.get ()*/ + "function");

								cur_gen_id = "";
								cur_transformer.reset ();
								cur_st_func_id = "";
							} else {
								mess = "Unknown transformator name in line \"";							
								mess += line;
								mess += "\"";

								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						case SX_1_TRANSFORMER_TPL:
							if (cur_transformer.get_transformer () && cur_transformer.is_rows_empty ()) {
								mess = "Invalid transformer \"";
								mess += cur_transformer.get_transformer ()->name;
								mess += "\" in line \"";
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							cur_transformer.reset ();
							if (line.size () > 2) {//имя трансформатора не может быть пустым
								line.erase (0, 2);
								static boost::regex transformator_exp ("^\\s*([^()]*)\\s*(\\(redefinition\\))?");
								boost::smatch st_match;
								if (!regex_match (line, st_match, transformator_exp)) {								
									mess = "Invalid transformator definition format in line \"";
									mess += line;
									mess += "\"";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}
								
								AbstractDumperBase::TransformatorID t_name (GCL::trim_ws(std::string (st_match[1].first, st_match[1].second).c_str ()));
								std::string redefinition_str (st_match[2].first, st_match[2].second);										
								
								AbstractDumperBase::Transformators& ts = s_transformators;
								AbstractDumperBase::Transformators::iterator t_it = ts.find (t_name);
								if (t_it != ts.end () && redefinition_str.empty ()) {
									mess = "Duplicate transformator \"";
									mess += t_name;
									mess += "\" definition in line \"";
									mess += line;
									mess += "\" format";

									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}
								
								if (t_it == ts.end ()) {
									t_it = ts.insert (std::make_pair (t_name, Transformator ())).first;
								}

								Transformator* tf = &(t_it->second);
								tf->name = GCL::trim_ws(t_name/*.get ()*/.c_str ());
								tf->id = AbstractDumperBase::TransformatorID (tf->name/*.get ()*/ + "transformator");

								cur_transformer.set_transformer (tf);

								cur_func_id = AbstractDumperBase::FunctionID ("");
								cur_gen_id.clear ();
								cur_st_func_id = "";

								cur_columns_id.clear();
							} else {
								mess = "Unknown transformator name in line \"";							
								mess += line;
								mess += "\" format";

								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						case SX_1_TRANSFORMER_COLUMN /*SX_1_CODING*/: {
							line.erase (0, 2);
							if (!cur_gen_id.empty () && cur_transformer.get_transformer () == 0) {
								Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
								tpl.generators[cur_gen_id].output_coding_template = line;
							} else {
								cur_columns_id = GCL::split_string_by_fragment (line.c_str (), '{', '}');
							}
							break;
						}
						case SX_1_TRANSFORMER_ROW: {
							TransformatorBody tb;
							GCL::StrVector row_data;
							
							{
								std::string _str = line;
								_str.erase (0, 2);
								std::string::const_iterator it_exp_end = _str.begin ();
								std::string::const_iterator it_exp_begin = _str.begin ();
								std::string::const_iterator it_data_begin;

								bool res;
								if (line.length () > 1 && line[2] == '{') {
									// new raw format
									res = GCL::find_char_ex (it_exp_end, _str.end (), ':', '{', '}', '\\');
									it_data_begin = it_exp_end;
									it_exp_end--;
									it_exp_begin++;
								} else {
									// old raw format
									res = GCL::find_char_ex (it_exp_end, _str.end (), ':', '"', '"', '\\');
									it_data_begin = it_exp_end;
								}

								if (!res) {
									mess = "Invalid transformer row \"";							
									mess += cur_transformer.get_transformer ()->name;
									mess += "\" format in line \"";
									mess += line;
									mess += "\"";
									
									GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
									GenSupport::LogManagerFactory::get ().log_error (mess);

									continue;
								}

								tb.row_exp = std::string(it_exp_begin, it_exp_end);
								row_data = GCL::split_string_by_fragment (&(*it_data_begin), '{', '}');
							}
							if (row_data.size () != cur_columns_id.size ()) {
								mess = "Invalid transformer row \"";							
								mess += cur_transformer.get_transformer ()->name;
								mess += "\" in line \"";
								mess += line;
								mess += "\", cause row's datas count not equal columns count";

								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							} else {
								unsigned i=0; // unsigned siz = cur_columns_id.size();
								for (GCL::StrVector::iterator it=row_data.begin(); it!=row_data.end(); it++) {
									//if (i < siz) { 
										tb.row[cur_columns_id[i++]] = (*it); // GARANT_SEGMENTATION_FAULT
									//}
								}
								
								cur_transformer.add_row (tb);
							}						
							break;
						}
						case SX_1_UC_OPEN_START_ID:
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].user_code_open_start_id = line;
							} else {
								mess = "Invalid UC open start ID in line \"";							
								mess += line;
								mess += "\"";

								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						case SX_1_UC_OPEN_END_ID:
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].user_code_open_end_id = line;
							} else {
								mess = "Invalid UC open end ID in line \"";							
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						case SX_1_UC_CLOSE_START_ID: 
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].user_code_close_start_id = line;
							} else {
								mess = "Invalid UC close start ID in line \"";							
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						case SX_1_UC_CLOSE_END_ID: 
							if (line.length () > 1) {
								line.erase (0, 2);
								s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].user_code_close_end_id = line;
							} else {
								mess = "Invalid UC close end ID in line \"";							
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						case SX_1_UC_UNIQUE: {
							bool value_b = true;
							if (line.length () > 1) {
								std::string value = line;
								value.erase (0, 2);
								if (value == "true") {
									value_b = true;
								} else if (value == "false") {
									value_b = false;
								}
							}
							s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].generators[cur_gen_id].user_code_unique = value_b;
							break;
						}
						case SX_1_FWD_WEIGHT: {
							long weight = 0;
							bool success = true;
							if (line.length () > 1) {
								std::string value = line;
								value.erase (0, 2);
								try {
									weight = boost::lexical_cast<long> (value);
									Template& tpl = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)];
									tpl.fwd_weight = weight;
									tpl.on_property_set (TP_FWD_WEIGHT);
								} catch (boost::bad_lexical_cast&) {	
									success = false;
								}
							} else {
								success = false;
							}
							if (!success) {
								mess = "Invalid FWD weight ID in line \"";							
								mess += line;
								mess += "\"";
								
								GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
								GenSupport::LogManagerFactory::get ().log_error (mess);

								continue;
							}
							break;
						}
						case SX_1_FUN_CACHE_KEY_TPL: {
							if (line.length () > 1) {
								line.erase (0, 2);
								if (cur_st_func_id != "") {
									s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].functions[cur_st_func_id].key_tpl = line;								
								} else if (cur_func_id != "") {
									s_functions[cur_func_id].key_tpl = line;
								} else if (cur_transformer.get_transformer () != 0) {
									cur_transformer.get_transformer ()->key_tpl = line;
								}
							}						
							break;
						}
						default:
							mess = "Invalid Start-line character in line \"";							
							mess += line;
							mess += "\"";
							
							GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
							GenSupport::LogManagerFactory::get ().log_error (mess);

							continue;
							break;
					} //switch (line[0])
				} catch (Base::FatalError& ex) {
					throw ex;
				} catch (...) {
					mess = "Unknown exception in \"";							
					mess += GDS_CURRENT_FUNCTION;
					mess += "\", while parse line \"";
					mess += line;
					mess += "\"";
					
					GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
					GenSupport::LogManagerFactory::get ().log_error (mess);
				}
			}
			if (!m_cur_stereotype.empty ()) {
				on_new_stereotype (AbstractDumperBase::StereotypeID (m_cur_stereotype), m_cur_stereotype_is_redefinition);
			}

			build_substereotypes ();

			if (cur_transformer.get_transformer ()) {
				if (cur_transformer.is_rows_empty ()) {
					mess = "Invalid transformer \"";							
					mess += cur_transformer.get_transformer ()->name;				
					mess += "\" format";

					GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
					GenSupport::LogManagerFactory::get ().log_error (mess);
				}
			}
			cur_transformer.reset ();
			m_excluded_stereotypes.clear ();
		}
	}
	//#UC END# *46E8E1CB032C*
}

// разбирает строку, поределяющую юзер-свойство и добавляет его в текущую группу свойств
void AbstractDumperBase::TemplateParser::process_property (const std::string& prop_line) {
	//#UC START# *46FC7A9402EE*
	std::string mess;
	if (m_current_prop_item.is_nil ()) {
		mess = "Ungrouped property: \"";
		mess += prop_line;
		mess += "\"";
		
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	} else {
		boost::smatch property_match;	
		if (
			!regex_match (prop_line, property_match, m_property_regex)
		) {
			mess = "Wrong property format: \"";
			mess += prop_line;
			mess += "\"";
			
			GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
			GenSupport::LogManagerFactory::get ().log_error (mess);
		} else {
			std::string property_name (property_match[2].first, property_match[2].second);
			std::string property_type (property_match[3].first, property_match[3].second);
			std::string property_value (property_match[4].first, property_match[4].second);
			std::string property_description (property_match[5].first, property_match[5].second);
			
			property_name = GCL::trim_ws (property_name.c_str ());
			if (m_current_prop_item->is_exists (property_name)) {
				mess = "Duplicate property \"";
				mess += property_name;
				mess += "\" in stereotype \"";
				mess += m_cur_stereotype;
				mess += "\"";
				
				GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
				GenSupport::LogManagerFactory::get ().log_error (mess);
			} else {
				UserPropertyData user_property;
				user_property.type = UPT_STRING;
				//= s_templates[m_cur_stereotype].user_properties[GCL::trim_ws (property_name.c_str ())];
				if (property_type == "b" || property_type == "bool") {
					user_property.type = UPT_BOOL;
				} else if (property_type == "s" || property_type == "string") {
					user_property.type = UPT_STRING;
				} else if (property_type == "file") {
					user_property.type = UPT_FILE;
				} else if (property_type == "color") {
					user_property.type = UPT_COLOR;						
				} else if (property_type == "t" || property_type == "text") {
					user_property.type = UPT_TEXT;						
				} else if (property_type == "tribool") {
					user_property.type = UPT_TRIBOOL;
					if (property_value.empty ()) {
						property_value = "undefined";
					}
				} else if (
					property_type.empty ()
					|| property_type == "l" 
					|| property_type == "list"
				) {
					//это список
					GCL::StrVector list_property = GCL::split_string_by (
						GCL::trim_ws (property_value.c_str ()).c_str (), '|'
					);
					
					user_property.type = UPT_LIST;
					user_property.value_list = list_property;


					property_value = list_property.empty () ? "" : list_property[0];
				}

				user_property.def_value = GCL::trim_ws (property_value.c_str ());
				user_property.description = GCL::trim_ws (property_description.c_str ());
										
				m_current_prop_item->add_property (property_name, user_property);
			}
		}
	}
	//#UC END# *46FC7A9402EE*
}

// запускает процес разбора свойств
// по завершении scopes содержит количество не закрытых скобо "{"
void AbstractDumperBase::TemplateParser::process_property_group (
	const std::string& group_name
	, TemplateData::const_iterator& it_in
	, const TemplateData::const_iterator& it_end
	, long& scopes
) {
	//#UC START# *46FC71C30232*
	bool close = false;
	scopes++;
	if (group_name.empty ()) {
		std::string mess ("Wrong property group format: ");
		mess += it_in != it_end ? *it_in : "";
		
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	} else {
		AbstractDumperBase::PropertyGroupTreeItem* new_item = new AbstractDumperBase::PropertyGroupTreeItem (group_name);
		AbstractDumperBase::PropertyGroupTreeItem_var& root = s_templates[AbstractDumperBase::StereotypeID (m_cur_stereotype)].user_properties_group;

		std::string root_name (m_cur_stereotype);
		root_name += " user properties";
		if (root.is_nil ()) {		
			root = new AbstractDumperBase::PropertyGroupTreeItem (root_name);
			//if (m_current_prop_item.is_nil ()) {
			root->insert_back_child (new_item);
			//}
		} else {		
			root->set_name (root_name);
			m_current_prop_item->insert_back_child (new_item);
		}		
		m_current_prop_item = AbstractDumperBase::PropertyGroupTreeItem::_duplicate(new_item);	

		GDS_ASSERT(m_current_prop_item.is_nil () == false);
		
		boost::smatch what;
		for (++it_in; it_in != it_end && !close; ++it_in) {
			std::string temp_line = boost::trim_left_copy_if (*it_in, boost::is_any_of (" \t"));		
			if (boost::regex_match(temp_line, what, m_group_regex)) {
				//вложенная группа
				std::string name (what[1].first, what[1].second);

				this->process_property_group (name, it_in, it_end, scopes);
			} else if (temp_line == "}") {
				//группа закрылась
				close = true;
				m_current_prop_item = dynamic_cast<AbstractDumperBase::PropertyGroupTreeItem*>(
					m_current_prop_item->parent()
				);
				scopes--;
				break;
			} else if (
				boost::regex_match(temp_line, what, m_property_regex)
			) {
				//свойство
				this->process_property (temp_line);
			} else if (temp_line.empty () == false) {
				break;
			}
		}
	}
	//#UC END# *46FC71C30232*
}

// обновляет шаблон наследников (рекурсивно) стереотипа base - присваивает шаблону наследника
// шаблон базового класса, аналогично тому, как если бы в шаблоне еще раз было объявлено
// наследование:
// {code}
// : DescendantStereotype
// = base
// {code}
void AbstractDumperBase::TemplateParser::update_descendants_recursively (const StereotypeID& base) const {
	//#UC START# *4BB482D100F7*
	typedef std::vector<Templates::iterator> TemplatesEntries;
	typedef std::set<AbstractDumperBase::StereotypeID> StereotypeIds;

	class local {
	public:
		static void update_descendants_recursively_impl (
			const AbstractDumperBase::StereotypeID& base
			, StereotypeIds& proccessed_stereotypes
		) {
			Templates::const_iterator base_tpl_it = s_templates.find (base);
			//проверяем, что еще не обрабатывали стереотип
			if (
				proccessed_stereotypes.find (base) == proccessed_stereotypes.end ()
				&& base_tpl_it != s_templates.end ()
			) {
				proccessed_stereotypes.insert (base);

				TemplatesEntries descandants;

				for (Templates::iterator it = s_templates.begin (); it != s_templates.end (); ++it) {
					if (it->second.base_stereotypes.find (base) != it->second.base_stereotypes.end ()) {
						descandants.push_back (it);
					}
				}

				for (
					TemplatesEntries::const_iterator it = descandants.begin ()
					; it != descandants.end ()
					; ++it
				) {
					update_template (*it, base_tpl_it->second);
					update_descendants_recursively_impl ((*it)->first, proccessed_stereotypes);
				}
			}
		}

		static void update_template (
			Templates::iterator st_tpl_it
			, const AbstractDumperBase::Template& base_tpl
		) {
			//update tempalte of st with base_tpl
			if (st_tpl_it != s_templates.end ()) {
				st_tpl_it->second.inherite (base_tpl);
			}
		}
	};
	
	StereotypeIds processed_stereotypes;
	local::update_descendants_recursively_impl (base, processed_stereotypes);
	//#UC END# *4BB482D100F7*
}
//////////////////////////////////////////////////////////////////////////////////////////
// template methods implementation

// функция для копирования одной мапы в другую
template <class IteratorType, class OutputType>
void AbstractDumperBase::TemplateParser::copy_map (const IteratorType& begin, const IteratorType& end, OutputType& dest) {
	//#UC START# *46F0A8370177_46E8E1430399*
	for (IteratorType it = begin; it != end; ++it) {
		dest[it->first] = it->second;
	}
	//#UC END# *46F0A8370177_46E8E1430399*
}




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

