////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::MakeAccessable
//
// %S%f_make_accessable(идентификатор элемента) - делает видимым элемент - расставляет необходимые
// связи (виртуальные), при этом связи расставляются между родителями этих элементов, между самими
// элементами никаких новых связей не добавляется!. Пример:
// {code}
// %S%f_make_accessable(%TГ)
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/EmptyDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "boost/lambda/lambda.hpp"
#include "boost/lambda/bind.hpp"
#include "boost/lambda/casts.hpp"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MakeAccessable::MakeAccessable ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B1E314C0373_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B1E314C0373_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B1E314C0373_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B1E314C0373_BODY*
}

MakeAccessable::~MakeAccessable () {
	//#UC START# *4B1E314C0373_DESTR_BODY*
	//#UC END# *4B1E314C0373_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string MakeAccessable::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4B1E314C0373*	
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	std::string uid = TemplatePainter::resolve_exp(params[0], painter);

	EmptyDumper empty (uid);
	ObjectTreeResolver::ObjectTree::Item_ptr it =  ObjectTreeResolver::s_tree->find (&empty);
	const AbstractDumper* target = it ? dynamic_cast<const AbstractDumper*> (*it) : 0;

	if (!target) {
		throw Base::FatalError (std::string ("Не удалось найти элемент: ") + uid);
	}

	const AbstractDumper* self_ad = dynamic_cast<const AbstractDumper*> (self);
	if (!self_ad->check_access (target)) {

		self_ad->set_dependencies (
			target
			, boost::lambda::bind (
				&AddDependencyLocal::create_dep_for_others
				, &AddDependencyLocalFactory::get ()
				, boost::lambda::ll_dynamic_cast<const AbstractDumper*> (boost::lambda::_1)
				, boost::lambda::ll_dynamic_cast<const AbstractDumper*> (boost::lambda::_2)
			)
		);

		if (!self_ad->check_access (target)) {
			throw Base::FatalError (
				std::string ("Ошибка в простановке зависимости между \"")
				+ self_ad->get_full_name ()
				+ std::string ("\" и \"")
				+ target->get_full_name ()
				+ std::string ("\"")
			);
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4B1E314C0373*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

