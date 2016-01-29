////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FilePathBase
//
// базовый сервант для работы с файлом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.h"
// by <<uses>> dependencies
#include "shared/GCL/os/FileOp.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FilePathBase::FilePathBase ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F458B0386_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F458B0386_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F458B0386_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F458B0386_BODY*
}

FilePathBase::~FilePathBase () {
	//#UC START# *4B4F458B0386_DESTR_BODY*
	//#UC END# *4B4F458B0386_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Собственно реализации встроенной функции.
const std::string FilePathBase::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
	, PathComponent path_component
) const {
	//#UC START# *4B4F466C01AC*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	std::string path = TemplatePainter::resolve_exp(params[0], painter);

	std::string drive;
	std::string dir;
	std::string fname;
	std::string ext;

	GCL::FileOp::splitpath (path, drive, dir, fname, ext);

	switch (path_component) {
		case PT_DIR:
			if (GCL::end_with (dir.c_str (), '/') || GCL::end_with (dir.c_str (), '\\')) {
				dir.erase (dir.size () - 1);
			}
			return dir;
			break;
		case PT_EXT:
			return ext;
			break;
		case PT_NAME:
			return fname;
			break;
		case PT_DRIVE:
			return drive;
			break;
		default:
			GDS_ASSERT(false);
	}

	return std::string ();
	//#UC END# *4B4F466C01AC*
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

