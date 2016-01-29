////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileExtension
//
// %f_file_extension(путь к файлу) - извлекает расширение файла из пути к файлу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FileExtension::FileExtension ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F45340275_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F45340275_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F45340275_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F45340275_BODY*
}

FileExtension::~FileExtension () {
	//#UC START# *4B4F45340275_DESTR_BODY*
	//#UC END# *4B4F45340275_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string FileExtension::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4B4F45340275*
	return FilePathBase::execute_impl (params, painter, FilePathBase::PT_EXT);
	//#UC END# *4A2CE18202C1_4B4F45340275*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

