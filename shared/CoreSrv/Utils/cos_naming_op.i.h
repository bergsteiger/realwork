////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Utils/cos_naming_op.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::Utils::cos_naming_op
// Файл inline реализации утилитного набора cos_naming_op
//
// вспомогательные функции упрощающие работу с CosNaming
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *4503D72603B9_CUSTOM_INCLUDES*
#include "shared/GCL/str/str_op.h"
//#UC END# *4503D72603B9_CUSTOM_INCLUDES*

namespace CoreSrv {

//#UC START# *4503D72603B9*
inline void bind_path (CosNaming::NamingContext_ptr root, CORBA::Object_ptr source, const char* path) {
	GCL::StrVector paths = GCL::split_string_by_chars (path, "\\/");

	CosNaming::NamingContext_var ctx = CosNaming::NamingContext::_duplicate(root);
	for (GCL::StrVector::iterator it = paths.begin(); it != paths.end(); it++) {
		CosNaming::Name cos_name;
		cos_name.length(1);
		cos_name[0].kind = (const char*)"";
		cos_name[0].id = it->data(); 
		
		if (std::distance(it, paths.end()) > 1) {
			try {
				ctx = ctx->bind_new_context(cos_name);
			} catch(CosNaming::NamingContext::AlreadyBound&) {
				CORBA::Object_var obj;

				obj = ctx->resolve(cos_name);
				ctx = CosNaming::NamingContext::_narrow(obj);
			}			
		} else {
			try {
				ctx->bind(cos_name, source);
			} catch(CosNaming::NamingContext::AlreadyBound&){
				ctx->rebind(cos_name, source);
			}			
		}		
	}
}

inline CosNaming::NamingContext_ptr create_path (CosNaming::NamingContext_ptr root, const char* path) {
	GCL::StrVector paths = GCL::split_string_by_chars (path, "\\/");

	CosNaming::NamingContext_var ctx = CosNaming::NamingContext::_duplicate(root);
	for (GCL::StrVector::iterator it = paths.begin(); it != paths.end(); it++) {
		CosNaming::Name cos_name;
		cos_name.length(1);
		cos_name[0].kind = (const char*)"";
		cos_name[0].id = it->data(); 
		
		try {
			ctx = ctx->bind_new_context(cos_name);
		} catch(CosNaming::NamingContext::AlreadyBound&) {
			CORBA::Object_var obj;
			obj = ctx->resolve(cos_name);
			ctx = CosNaming::NamingContext::_narrow(obj);
		}			
	}

	return ctx._retn();
}

inline CORBA::Object_ptr resolve_path (CosNaming::NamingContext_ptr root, const char* path) {
	GCL::StrVector paths = GCL::split_string_by_chars (path, "\\/");

	CORBA::Object_var obj;
	CosNaming::NamingContext_var ctx = CosNaming::NamingContext::_duplicate(root);
	for (GCL::StrVector::iterator it = paths.begin(); it != paths.end(); it++) {
		CosNaming::Name cos_name;
		cos_name.length(1);
		cos_name[0].kind = (const char*)"";
		cos_name[0].id = it->data(); 
		
		obj = ctx->resolve(cos_name);

		if (std::distance(it, paths.end()) > 1) {
			ctx = CosNaming::NamingContext::_narrow(obj);							
		} 		
	}
	return obj._retn();
}
//#UC END# *4503D72603B9*

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

