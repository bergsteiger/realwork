////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileName.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileName
//
// %f_file_name(путь к файлу) - извлекает имя файла из пути
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileName.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FileName::FileName ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BODY*
}

FileName::~FileName () {
	//#UC START# *4B4F445201A1_DESTR_BODY*
	//#UC END# *4B4F445201A1_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string FileName::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4B4F445201A1*
	return FilePathBase::execute_impl (params, painter, FilePathBase::PT_NAME);
	//#UC END# *4A2CE18202C1_4B4F445201A1*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

