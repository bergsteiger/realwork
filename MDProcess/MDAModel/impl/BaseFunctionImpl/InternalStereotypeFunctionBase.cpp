////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::BaseFunctionImpl::InternalStereotypeFunctionBase
//
// базовая реализация встроенной функции стереотипа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"

namespace BaseFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InternalStereotypeFunctionBase::InternalStereotypeFunctionBase ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFD580067_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFD580067_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFD580067_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFD580067_BODY*
}

InternalStereotypeFunctionBase::~InternalStereotypeFunctionBase () {
	//#UC START# *4A2DFD580067_DESTR_BODY*
	//#UC END# *4A2DFD580067_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// метод вызываемый после вызовы реализации функции
void InternalStereotypeFunctionBase::post_execute () const {
	//#UC START# *4AF7C25002E4*
	//#UC END# *4AF7C25002E4*
}

// метод вызываемый перед вызовом реализации функции
void InternalStereotypeFunctionBase::pre_execute () const {
	//#UC START# *4AF7C219001D*
	//#UC END# *4AF7C219001D*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TemplateFunctions::BaseFunction
// выполнение функции шаблона
const std::string InternalStereotypeFunctionBase::execute (
	const TemplateFunctions::FunctionParams& params
	, Base::AbstractTemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFBAB0285_4A2DFD580067*
	TemplatePainter* real_painter = dynamic_cast<TemplatePainter*> (painter);
	
	const AbstractDumperBase* self = real_painter->get_args ().empty () ? real_painter->get_owner () : (real_painter->get_args ())[0];
	
	TemplatePainter::TPArgs args (
		real_painter->get_args ().begin () + 1	//+ 1 - потому, что первым лежит контекст вызова
												//его нужно убрать, чтобы параметры операции вычислялись правильно
		, real_painter->get_args ().end ()
	);
	
	TemplatePainter copy_painter (real_painter);
	copy_painter.set_args (args);

	this->pre_execute ();
	std::string res = this->execute_impl (self, params, &copy_painter);
	this->post_execute ();

	return res;
	//#UC END# *4A2DFBAB0285_4A2DFD580067*
}
} // namespace BaseFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

