////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseTypes/RationalRoseTlb.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseTypes::RationalRoseTlb
// Файл реализации утилитного набора RationalRoseTlb
//
// файл заглушка для включения КОМ-овского описания розовского интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/Base/Base.h"

//#UC START# *4571DD8C003E_CUSTOM_INCLUDES*
#import "X:\support\import\RationalRose.tlb"                                            \
	no_namespace                                                                    \
	rename ("GetClassName", "GetRoseClassName")                                     \
	rename ("GetProfileString", "GetRoseProfileString")                             \
	rename ("WriteProfileString", "WriteRoseProfileString")				\
	rename ("GetUniqueID", "DeprecatedGetUniqueID")					\
	implementation_only
//#UC END# *4571DD8C003E_CUSTOM_INCLUDES*


//#UC START# *4571DD8C003E*
//#UC END# *4571DD8C003E*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

bool RoseElementComparator::operator () (const RoseElementWrapper& first_param_, const RoseElementWrapper& second_param_) const {
	//#UC START# *47D8D9830155_IMPL*
	return get_rose_element_uid(first_param_.element) < get_rose_element_uid(second_param_.element);
	//#UC END# *47D8D9830155_IMPL*
}


// контсруктор, задёт обертку над элементом
RoseElementWrapper::RoseElementWrapper (IRoseElementPtr elem)
//#UC START# *47D8F66A0388_INIT_CTOR_BASE_INIT*
//#UC END# *47D8F66A0388_INIT_CTOR_BASE_INIT*
{
	//#UC START# *47D8F66A0388_CTOR_BODY*
	element = elem;
	//#UC END# *47D8F66A0388_CTOR_BODY*
}


// Возвращает идентификатор элемента. Т.к при перемещении некоторых элементов приходится удалять
// старый элемент и создавать новый, при этом меняется идентификатор элемента, что приводит к
// неприятным последствями - "отъезжают" юзер секции. Для решения этой проблемы, при таком
// перемещении в свойства нового элемента по ключу Base::STORED_UID_KEY записывается идентификатор
// удаленного элемента. В связи с этим, весь код должен использовать ТОЛЬКО этот метод для
// получения идентификатора
const std::string get_rose_element_uid (IRoseElementPtr elem) {
	//#UC START# *4BAC9F21036C*
	std::string uid (static_cast<const char*>(elem->GetPropertyValue (TOOL_NAME, Base::STORED_UID_KEY.c_str ())));
	if (uid.empty ()) {
		uid = static_cast<const char*>(elem->DeprecatedGetUniqueID ());
	}

	return uid;
	//#UC END# *4BAC9F21036C*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

