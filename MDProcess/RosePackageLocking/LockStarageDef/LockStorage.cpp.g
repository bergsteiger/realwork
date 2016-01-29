header "pre_include_hpp" {
#include "shared/Core/sys/std_inc.h"
}

header "post_include_hpp" {
#include "MDProcess/RosePackageLocking/LockStarageDef/LockStarageDef.h"
#include "MDProcess/RosePackageLocking/LockStarageDef/PackageInfo.h"

#include <boost/lexical_cast.hpp>
#include <vector>
#include <map>
}
options {
	language = "Cpp";
	genHashLines=false;
	namespace = "RosePackageLocking::LockStarageDef";
}

{
	//helper functions
	namespace {
		typedef std::vector<unsigned long> AttributeIDList;
		typedef std::map<unsigned long, std::string> DescriptionMap;
		
		const std::string get_attribute_description (
			unsigned long attr_id
			, const DescriptionMap& description_map
		) {
			std::string res;
			DescriptionMap::const_iterator it = description_map.find (attr_id);
			if (it != description_map.end ()) {
				res = it->second;
			}
			
			return res;
		}
		
		unsigned long check_attribute_originality (
			unsigned long accumulated_flag
			, unsigned long attr_id
			, const antlr::RefToken& token
			, const DescriptionMap& description_map
		) /*throw (antlr::RecognitionException)*/
		{
			if (attr_id != 0 && accumulated_flag & attr_id) { //attr_id == 0 - it is container type, no exception
				std::string mess ("Attribute \"");
				mess += get_attribute_description (attr_id, description_map);
				mess += "\" already defined";
				
				throw antlr::RecognitionException (
					mess
					, token->getFilename ()
					, token->getLine ()
					, token->getColumn ()
				);
			} else {
				accumulated_flag |= attr_id;
			}
			return accumulated_flag;
		}
		
		void check_all_necessary_parsed (
			unsigned long accumulated_flag
			, const AttributeIDList& attr_ids
			, const DescriptionMap& description_map
			, const antlr::RefToken& token
		)
			/*throw (antlr::RecognitionException)*/
		{
			AttributeIDList::const_iterator it = attr_ids.begin ();
			AttributeIDList::const_iterator it_end = attr_ids.end ();
			
			std::string error_message ("Not all necessary attributes defined: ");
			bool not_all_defined = false;
			for (; it != it_end; ++it) {
				if ((accumulated_flag & *it) == false) {
					if (not_all_defined) {
						error_message += ", ";
					}
					error_message += get_attribute_description (*it, description_map);
					not_all_defined = true;
				}
			}
			
			if (not_all_defined) {
				throw antlr::RecognitionException (
					error_message
					, token->getFilename ()
					, token->getLine ()
					, token->getColumn ()
				);
			}
		}
	} //namespace

	void LockStorageParser::rule_begin () {
		this->reset_error_stack ();
	}
	
	void LockStorageParser::rule_end () {
		this->reset_error_stack ();
	}
}
class LockStorageParser extends Parser;
options {
	defaultErrorHandler=false;
}
{
	public:
		void rule_begin ();
		
		void rule_end ();
}
packages
	returns [PackageInfoList packages_ret]
	:	(packages_ret=package_info_list)?

	;


package_info_list returns [PackageInfoList package_info_list_ret]
	{
		Core::Box<PackageInfo> item;
	}
	:	(item=package_info
		{
			package_info_list_ret.push_back (item);
		}
		)+
	;

package_info returns [Core::Box<PackageInfo> package_info_ret]
	{
		package_info_ret = new PackageInfo ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "owner_id"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "full_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "time"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		package_info_group_0[package_info_ret]
		(flag=package_info_group_1[package_info_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 2);
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_1
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

package_info_group_0
	[Core::Box<PackageInfo>& package_info_ret]
	:	{rule_begin ();}
		guid_:STRING {package_info_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

package_info_group_1
	[Core::Box<PackageInfo>& package_info_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	"owner" owner_id_:SIGNED {type = 1 << 2; package_info_ret->set_owner_id (boost::lexical_cast<CORBA::Long> (owner_id_->getText ()));} ";"
		|	"name" full_name_:STRING {type = 1 << 3; package_info_ret->set_full_name (full_name_->getText ());} ";"
		|	"time" time_:STRING {type = 1 << 4; package_info_ret->set_time (time_->getText ());} ";"
		)
		{rule_end ();}
	;







class LockStorageLexer extends Lexer;
options {
	k = 2;
	testLiterals = false;
	charVocabulary = '\003'..'\377'
					;
}
ALL_POST_AND_PREFIXES
	options {testLiterals=true;}
	:	("owner") => "owner"
	|("time") => "time"
	|("name") => "name"
	|"}"
	|"{"
	|";"
	;

STRING
	:	'"'! (ESC|'"' '"'|~'"')* '"'!
	;

protected
ESC	:	'\\'
		(	'n'
		|	'r'
		|	't'
		|	'b'
		|	'f'
		|	'w'
		|	'a'
		|	'"'
		|	'\''
		|	'\\'
		|	('0'..'3')
			(
				options {
					warnWhenFollowAmbig = false;
				}
			:
	('0'..'9')
				(
					options {
						warnWhenFollowAmbig = false;
					}
				:
	'0'..'9'
				)?
			)?
		|	('4'..'7')
			(
				options {
					warnWhenFollowAmbig = false;
				}
			:
	('0'..'9')
			)?
		|	'u' XDIGIT XDIGIT XDIGIT XDIGIT
		)
	;

protected
XDIGIT :
		'0' .. '9'
	|	'a' .. 'f'
	|	'A' .. 'F'
	;

SIGNED
	: ('+'|'-')?('0'..'9')+
	;


WS_
	:	(	' '
	|	'\t'
	|	'\f'
	// handle newlines
	|	(	'\r' '\n'  // Evil DOS
		|	'\r'        // Macintosh
		|	'\n'        // Unix (the right way)
		)
		{ newline(); }
	)
	{_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP;}
	;
