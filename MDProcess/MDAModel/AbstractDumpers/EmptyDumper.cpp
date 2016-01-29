////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/EmptyDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::EmptyDumper
//
// пустой дампер, может использоваться для поиска элемента в дереве по заданному UID
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/EmptyDumper.h"

//#UC START# *4A4892480384_CUSTOM_INCLUDES*
//#UC END# *4A4892480384_CUSTOM_INCLUDES*


//#UC START# *4A4892480384*
bool EmptyDumper::operator == (const AbstractDumperBase& c) const {
	return this->get_model_unique_id_str () == c.get_model_unique_id_str ();
}

void EmptyDumper::clean_forward ( OTRSet& scope) {
};
//#UC END# *4A4892480384*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EmptyDumper::EmptyDumper (const std::string& model_unique_id)
//#UC START# *4A4898CB0099_BASE_INIT*
: m_model_unique_id (model_unique_id)
//#UC END# *4A4898CB0099_BASE_INIT*
{
	//#UC START# *4A4898CB0099_BODY*
	//#UC END# *4A4898CB0099_BODY*
}

EmptyDumper::~EmptyDumper () {
	//#UC START# *4A4892480384_DESTR_BODY*
	//#UC END# *4A4892480384_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает имя
const std::string EmptyDumper::get_name_str () const {
	//#UC START# *466554D9006D_4A4892480384*
	return std::string ();
	//#UC END# *466554D9006D_4A4892480384*
}

// implemented method from ObjectTreeResolver
// возвращает вес форвард декларации
long EmptyDumper::get_fwd_weight () const {
	//#UC START# *4A489B430198_4A4892480384*
	return 0;
	//#UC END# *4A489B430198_4A4892480384*
}

// implemented method from ObjectTreeResolver
// возвращает true, если элемент нельяз форвард декларировать
bool EmptyDumper::is_forbiden_forward_dcl () const {
	//#UC START# *4A489B1602BA_4A4892480384*
	return false;
	//#UC END# *4A489B1602BA_4A4892480384*
}

// implemented method from ObjectTreeResolver
// связывает с элементом всех supplier
void EmptyDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4A4892480384*
	//#UC END# *465E57F1029F_4A4892480384*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает GUID элемента
const std::string& EmptyDumper::get_model_unique_id_str () const {
	//#UC START# *465E51860213_4A4892480384*
	return m_model_unique_id;
	//#UC END# *465E51860213_4A4892480384*
}

// overloaded method from Base::NamedElement
// возвращает полное имя элемента
const std::string EmptyDumper::get_full_name () const {
	//#UC START# *4AF93E9E0166_4A4892480384*
	return m_model_unique_id;
	//#UC END# *4AF93E9E0166_4A4892480384*
}

// overloaded method from ObjectTreeResolver
// сравнивнение элементов дерева
int EmptyDumper::compare (const ObjectTreeResolver* od) const {
	//#UC START# *4A489BAB00DE_4A4892480384*
	const AbstractDumperBase* ad = dynamic_cast<const AbstractDumperBase*> (od);
	if (ad) {
		return ACE_OS::strcmp (
			this->get_model_unique_id_str ().c_str ()
			, ad->get_model_unique_id_str ().c_str ()
		);
		//return this->get_model_unique_id_str () < ad->get_model_unique_id_str ();
	}

	return 0;
	//#UC END# *4A489BAB00DE_4A4892480384*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

