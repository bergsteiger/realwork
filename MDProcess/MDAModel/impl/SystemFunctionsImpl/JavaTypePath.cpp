////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaTypePath.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::JavaTypePath
//
// Возвращает полный путь к элементу по правилам java
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaTypePath.h"
// by <<uses>> dependencies
#include "shared/GCL/os/FileOp.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

JavaTypePath::JavaTypePath ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEBB60378_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEBB60378_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEBB60378_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEBB60378_BODY*
}

JavaTypePath::~JavaTypePath () {
	//#UC START# *4A2CEBB60378_DESTR_BODY*
	//#UC END# *4A2CEBB60378_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string JavaTypePath::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEBB60378*
	class local {
	public:
		static const std::string make_path (const std::string& file_path) {
			static std::string java_substr ("java/src/java/");
			static size_t java_substr_len (java_substr.length ());
			
			std::string res (file_path);			
			std::string::size_type pos = res.find (java_substr);
			if (pos != std::string::npos) {
				res = res.substr (pos + java_substr_len);
			}
			return res;
		}
	};

	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	std::string dumper_id = TemplatePainter::resolve_exp (params[0], painter);
	std::string::const_iterator it = dumper_id.begin();
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, dumper_id.end ());
	std::string res;
	if (adb) {
		
		std::string file_name = adb->create_file_name ();
		bool has_self_output = file_name.empty () == false;
		const AbstractDumperBase* parent_with_output = adb;
		if (!has_self_output) {			
			while (
				(parent_with_output = parent_with_output->parent ())
				&& file_name.empty ()
			) {
				file_name = parent_with_output->create_file_name ();
			}
		}
		if (file_name.empty () == false) {
			std::string drive;
			std::string dir;
			std::string fname;
			std::string ext;
			
			if (file_name.find ("/") != std::string::npos) {
			
				GCL::FileOp::splitpath (file_name, drive, dir, fname, ext, false);
				res = drive;
				res += dir;
				res += fname;
				res = local::make_path (res);
				GCL::str_replace (res, "/", ".");
			} else {
				res = file_name;
			}
			if (!has_self_output && parent_with_output) {
				GCL::StrVector path_to_parent;
				const AbstractDumperBase* parent = adb;
				path_to_parent.insert (path_to_parent.begin (), adb->get_name_str ());
				while (
					(parent = parent->parent ())
					&& parent != parent_with_output
				) {
					path_to_parent.insert (path_to_parent.begin (), parent->get_name_str ());
				}
				std::string temp = GCL::join (path_to_parent, ".");
				if (temp.empty () == false) {
					res += ".";
					res += temp;
				}
			}
		}
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += ": dumper ";
		mess += dumper_id;
		mess += " is null";
		throw Base::FatalError (mess);
	}
	return res;
	//#UC END# *4A2CE18202C1_4A2CEBB60378*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

