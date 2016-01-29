////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelSearcherImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassImpl.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
#include "boost/lambda/lambda.hpp"
#include "boost/lambda/bind.hpp"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ModelSearcherImpl::ModelSearcherImpl ()
//#UC START# *4C0E1224034D_4C0E12480243_4C0E13340030_BASE_INIT*
//#UC END# *4C0E1224034D_4C0E12480243_4C0E13340030_BASE_INIT*
{
	//#UC START# *4C0E1224034D_4C0E12480243_4C0E13340030_BODY*
	//#UC END# *4C0E1224034D_4C0E12480243_4C0E13340030_BODY*
}

ModelSearcherImpl::~ModelSearcherImpl () {
	//#UC START# *4C0E13340030_DESTR_BODY*
	//#UC END# *4C0E13340030_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ModelSearcher
// обработка удаления элемента с модели
void ModelSearcherImpl::on_delete_element (IRoseElementPtr elem) const {
	//#UC START# *4C1F6FB100AA_4C0E13340030*
	std::string old_uid = get_rose_element_uid (elem);
	m_old_uid_to_new_uid.erase (old_uid);
	//#UC END# *4C1F6FB100AA_4C0E13340030*
}

// implemented method from ModelSearcher
// обработка создания нового элемента (или загрузка из модели старого)
void ModelSearcherImpl::on_new_element (IRoseElementPtr element) const {
	//#UC START# *4C1F6F6D001D_4C0E13340030*
	std::string old_uid = get_rose_element_uid (element);
	std::string new_uid = element->DeprecatedGetUniqueID ();

	m_old_uid_to_new_uid[old_uid] = new_uid;
	//#UC END# *4C1F6F6D001D_4C0E13340030*
}

// implemented method from ModelSearcher
// ищет элемент модели по идентификатору, если не находит - возвращает 0
IRoseElementPtr ModelSearcherImpl::search (const std::string& uid) const {
	//#UC START# *4C0E1294034D_4C0E13340030*
	IRoseElementPtr res = 0;

	const RoseAbstractDumper* rad = !RoseTreeState::instance ()->is_changed () ? RoseAbstractDumper::find_in_tree (uid) : 0;
	if (rad) {
		res = rad->rose_element();
	} else {
		IRoseApplicationPtr app = RoseHelper::rose_app ();
		if (app) {
			IRoseModelPtr model = app->CurrentModel;
			if (model) {
				Str2StrMap::const_iterator it = m_old_uid_to_new_uid.find (uid);
				if (it != m_old_uid_to_new_uid.end ()) {
					res = model->FindItemWithID (it->second.c_str ());
				}
				if (!res) {
					res = model->FindItemWithID (uid.c_str ());
				}

				if (res) {
					m_old_uid_to_new_uid[uid] = res->DeprecatedGetUniqueID ();
				}
			}
		}
	}

	return res;
	//#UC END# *4C0E1294034D_4C0E13340030*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

