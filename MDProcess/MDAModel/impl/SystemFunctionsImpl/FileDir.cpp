////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDir.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileDir
//
// %f_file_dir(путь к файлу) - извлекает папку из пути к файлу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDir.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FileDir::FileDir ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F463D036A_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F463D036A_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F463D036A_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F463D036A_BODY*
}

FileDir::~FileDir () {
	//#UC START# *4B4F463D036A_DESTR_BODY*
	//#UC END# *4B4F463D036A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string FileDir::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4B4F463D036A*
	return FilePathBase::execute_impl (params, painter, FilePathBase::PT_DIR);
	//#UC END# *4A2CE18202C1_4B4F463D036A*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

