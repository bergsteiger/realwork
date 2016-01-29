////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::CategoryImpl
//
// реализация элемента-папка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CategoryImpl::CategoryImpl (IRoseCategoryPtr cat)
//#UC START# *497E915D02A7_497E91700187_497EABD1029F_BASE_INIT*
: m_cat (cat)
//#UC END# *497E915D02A7_497E91700187_497EABD1029F_BASE_INIT*
{
	//#UC START# *497E915D02A7_497E91700187_497EABD1029F_BODY*
	//#UC END# *497E915D02A7_497E91700187_497EABD1029F_BODY*
}

CategoryImpl::~CategoryImpl () {
	//#UC START# *497EABD1029F_DESTR_BODY*
	//#UC END# *497EABD1029F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Category
// определяет можно ли папку вылить в отдельный кат
bool CategoryImpl::can_control () const {
	//#UC START# *497E91D00296_497EABD1029F*
	IRoseCategoryPtr parent = m_cat->ParentCategory;
	bool res = true;
	if (parent) {
		parent = parent->ParentCategory;
		res = (parent != 0);
	} else {
		res = false;
	}
	return res;
	//#UC END# *497E91D00296_497EABD1029F*
}

// implemented method from Category
// возвращает список всех детей - папок (рекурсивно)
CategoryList* CategoryImpl::get_all_categories () const {
	//#UC START# *497EB1D9013E_497EABD1029F*
	Core::Aptr<CategoryList> cats = new CategoryList ();
	IRoseCategoryCollectionPtr r_cats = m_cat->GetAllCategories ();
	short count = r_cats->Count;

	for (short i = 1; i <= count; ++i) {
		cats->push_back (CategoryFactory::make (r_cats->GetAt (i)));
	}

	return cats.forget ();
	//#UC END# *497EB1D9013E_497EABD1029F*
}

// implemented method from Category
// возвращает список папок - непосредственных детей элемента
CategoryList* CategoryImpl::get_categories () const {
	//#UC START# *497EB23D0093_497EABD1029F*
	Core::Aptr<CategoryList> cats = new CategoryList ();
	IRoseCategoryCollectionPtr r_cats = m_cat->GetCategories ();
	short count = r_cats->Count;

	for (short i = 1; i <= count; ++i) {
		cats->push_back (CategoryFactory::make (r_cats->GetAt (i)));
	}

	return cats.forget ();
	//#UC END# *497EB23D0093_497EABD1029F*
}

// implemented method from Category
// возвращает полное имя элемента
const std::string CategoryImpl::get_full_name () const {
	//#UC START# *497E92E800E6_497EABD1029F*
	std::string ret = static_cast<const char*>(m_cat->GetQualifiedName ());
	std::string::size_type j = ret.find_last_of (':');
	std::string pack_name;
	if (j != std::string::npos) {
		pack_name = ret.substr (j+1, ret.length ()-j-1);
	} else {
		pack_name = ret;
	}
	std::string sfn = static_cast<const char*>(m_cat->GetFileName ());
	std::string::size_type i = sfn.find_last_of ('\\');
	if (i != std::string::npos) {
		sfn = sfn.substr (i+1, sfn.length ()-i-1);
	}
	if (sfn.find (pack_name) != 0) {
		ret += " (";
		ret += sfn;
		ret += ")";
	}
	return ret;
	//#UC END# *497E92E800E6_497EABD1029F*
}

// implemented method from Category
// возвращает true, если хотя бы один ребенок (рекурсивно) "вылит" в собственный cat
bool CategoryImpl::has_controlled_child () const {
	//#UC START# *497E920300F6_497EABD1029F*
	Core::Aptr<CategoryList> cats = this->get_all_categories ();
	bool res = false;
	for (CategoryList::const_iterator it = cats->begin (); it != cats->end () && !res; ++it) {
		res |= (*it)->is_controlled ();
	}

	return res;
	//#UC END# *497E920300F6_497EABD1029F*
}

// implemented method from Category
// возвращает true, если есть дочерние элементы не доступные для редактирования, т.е их нужно
// захватить для того, чтобы начать редактировать
bool CategoryImpl::has_ro_child () const {
	//#UC START# *497EB17A006A_497EABD1029F*
	Core::Aptr<CategoryList> cats = this->get_all_categories ();
	bool res = false;
	for (CategoryList::const_iterator it = cats->begin (); it != cats->end () && !res; ++it) {
		res |= (*it)->can_modify ();
	}

	return res;
	//#UC END# *497EB17A006A_497EABD1029F*
}

// implemented method from Category
// возвращает true, если элемент "вылит" в собственный cat
bool CategoryImpl::is_controlled () const {
	//#UC START# *497E91A302C2_497EABD1029F*
	return m_cat->IsControlled ();
	//#UC END# *497E91A302C2_497EABD1029F*
}

// implemented method from Element
// возвращает true, если элемент доступен для редактирования
bool CategoryImpl::can_modify () const {
	//#UC START# *497EABF900D8_497EABD1029F*
	IRoseControllableUnitPtr cat = RoseHelper::get_nearest_controllable_unit (m_cat);
	if (0 != cat && false == cat->IsModifiable ()) {
		return false;
	}
	return true;
	//#UC END# *497EABF900D8_497EABD1029F*
}

// implemented method from Element
// возвращает список всех детей элемента (с учетом вложенности)
ElementList* CategoryImpl::get_all_childs () const {
	//#UC START# *497E93B90071_497EABD1029F*
	Core::Aptr<ElementList> all_childs = this->get_childs ();
	for (ElementList::const_iterator it = all_childs->begin (); it != all_childs->end (); ++it) {
		Core::Aptr<ElementList> nested_childs = (*it)->get_all_childs ();
		all_childs->insert (all_childs->end (), nested_childs->begin (), nested_childs->end ());
	}

	return all_childs.forget ();
	//#UC END# *497E93B90071_497EABD1029F*
}

// implemented method from Element
// возвращает список непосредственных детей элемента
ElementList* CategoryImpl::get_childs () const {
	//#UC START# *497E939701AE_497EABD1029F*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *497E939701AE_497EABD1029F*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

