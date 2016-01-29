////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDrive.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileDrive
//
// %f_file_drive(путь к файлу) - извлекает имя диска из пути к файлу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDrive.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FileDrive::FileDrive ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F4487039E_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F4487039E_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F4487039E_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F4487039E_BODY*
}

FileDrive::~FileDrive () {
	//#UC START# *4B4F4487039E_DESTR_BODY*
	//#UC END# *4B4F4487039E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string FileDrive::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4B4F4487039E*
	return FilePathBase::execute_impl (params, painter, FilePathBase::PT_DRIVE);
	//#UC END# *4A2CE18202C1_4B4F4487039E*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

