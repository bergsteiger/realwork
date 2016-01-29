////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplateDumperDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplateDumperDumper
//
// Псевдо дампер для доступа к описанию и свойствам текущего генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplateDumperDumper.h"

//#UC START# *4571A39F0280_CUSTOM_INCLUDES*
//#UC END# *4571A39F0280_CUSTOM_INCLUDES*


//#UC START# *4571A39F0280*
TemplateDumperDumper::TemplateDumperContainer TemplateDumperDumper::s_dumpers;

//фабрика - возвращает дампер по заданному идентификатору, результат не нужно складывать в Var
TemplateDumperDumper* TemplateDumperDumper::get_by_id (const std::string& gen_id) {
	TemplateDumperDumper::TemplateDumperContainer::iterator it = s_dumpers.find (gen_id);

	if (it == s_dumpers.end ()) {
		TemplateDumperDumper* dumper = new TemplateDumperDumper (gen_id);

		it = s_dumpers.insert (
			TemplateDumperDumper::TemplateDumperContainer::value_type (gen_id, dumper)
		).first;
	}

	return it->second.ptr ();
}
//#UC END# *4571A39F0280*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// принудительно сбрасываем кэш (пока самого кэша на модели нет)
void TemplateDumperDumper::reset_dumpers_list () {
	//#UC START# *459CFE7C00E0*
	TemplateDumperDumper::s_dumpers.clear ();
	//#UC END# *459CFE7C00E0*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TemplateDumperDumper::~TemplateDumperDumper () {
	//#UC START# *4571A39F0280_DESTR_BODY*
	//#UC END# *4571A39F0280_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает имя
const std::string TemplateDumperDumper::get_name_str () const {
	//#UC START# *466554D9006D_4571A39F0280*
	GenInfos::iterator f = s_gen_infos.find (m_gen_id);
	if (f != s_gen_infos.end()) {
		return f->second->description ();
	} else {
		return "";
	}
	//#UC END# *466554D9006D_4571A39F0280*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает мэйн элемент
AbstractDumperBase* TemplateDumperDumper::get_main_element () const {
	//#UC START# *4665552403B9_4571A39F0280*
	if (!s_model_main_element) {
		throw Base::FatalError ("No Main element was defined");
	}
	return const_cast<AbstractDumperBase*> (s_model_main_element);
	//#UC END# *4665552403B9_4571A39F0280*
}

// overloaded method from AbstractDumperBase
// возвращает GUID элемента
const std::string& TemplateDumperDumper::get_model_unique_id_str () const {
	//#UC START# *465E51860213_4571A39F0280*
	return m_gen_id;
	//#UC END# *465E51860213_4571A39F0280*
}

// overloaded method from AbstractDumperBase
// значение рутовой дирректории для генерации
const std::string TemplateDumperDumper::get_root_dir (bool direct_get) const {
	//#UC START# *4666BC450203_4571A39F0280*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4666BC450203_4571A39F0280*
}

// overloaded method from AbstractDumperBase
// выводит значение пользовательского свойства «prop_name»
const std::string TemplateDumperDumper::get_user_property_str (const std::string& prop_name) const {
	//#UC START# *4666BC09003E_4571A39F0280*
	GenInfos::iterator f = s_gen_infos.find (m_gen_id);
	if (f != s_gen_infos.end()) {
		std::string ret;
		f->second->get_property (prop_name, ret);
		return ret;
	} else {
		return "";
	}
	//#UC END# *4666BC09003E_4571A39F0280*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

