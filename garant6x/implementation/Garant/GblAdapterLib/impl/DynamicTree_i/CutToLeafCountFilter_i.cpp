////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CutToLeafCountFilter_i
//
// реализация фильтра усечения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CutToLeafCountFilter_i::CutToLeafCountFilter_i (unsigned long leaf_count)
//#UC START# *483547CA00B2_483548E800F4_48354ADB0216_BASE_INIT*
: m_leaf_count (leaf_count)
//#UC END# *483547CA00B2_483548E800F4_48354ADB0216_BASE_INIT*
{
	//#UC START# *483547CA00B2_483548E800F4_48354ADB0216_BODY*
	//#UC END# *483547CA00B2_483548E800F4_48354ADB0216_BODY*
}

CutToLeafCountFilter_i::CutToLeafCountFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_48354ADB0216_BASE_INIT*
: m_leaf_count (0)
//#UC END# *45EEBB9B01F4_45F6A01A007D_48354ADB0216_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_48354ADB0216_BODY*
	// сейчас оболочка очень хочет дёргать этот конструктор
	//GDS_ASSERT (!"this constructor is not allowed, please use make (leaf_count)");
	//#UC END# *45EEBB9B01F4_45F6A01A007D_48354ADB0216_BODY*
}

CutToLeafCountFilter_i::~CutToLeafCountFilter_i () {
	//#UC START# *48354ADB0216_DESTR_BODY*
	//#UC END# *48354ADB0216_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CutToLeafCountFilter
// получить число листьев для фильтра
unsigned long CutToLeafCountFilter_i::get_leaf_count () const {
	//#UC START# *483553A10236_48354ADB0216_GET*
	return m_leaf_count;
	//#UC END# *483553A10236_48354ADB0216_GET*
}

void CutToLeafCountFilter_i::set_leaf_count (unsigned long leaf_count) {
	//#UC START# *483553A10236_48354ADB0216_SET*
	m_leaf_count = leaf_count;
	//#UC END# *483553A10236_48354ADB0216_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

