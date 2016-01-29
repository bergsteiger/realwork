////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplatePainter_DelayedFunctionParams.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplatePainter::DelayedFunctionParams
//
// параметры отложенной функции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

class TemplatePainter;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TemplatePainter::DelayedFunctionParams::DelayedFunctionParams (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, const TemplatePainter* painter
)
//#UC START# *4B2F279E001C_BASE_INIT*
	: m_self (self)
	, m_params (params) 
	, m_painter (painter->clone ())
	, m_var_dumpers (TemplatePainter::get_var_dumpers ())
//#UC END# *4B2F279E001C_BASE_INIT*
{
	//#UC START# *4B2F279E001C_BODY*
	TemplatePainter::TPArgs::const_iterator it = m_painter->get_args ().begin ();
	TemplatePainter::TPArgs::const_iterator it_end = m_painter->get_args ().end();

	for (; it != it_end; ++it) {
		m_local_args.push_back (AbstractDumperBase::_duplicate (const_cast<AbstractDumperBase*> (*it)));
	}
	//#UC END# *4B2F279E001C_BODY*
}

TemplatePainter::DelayedFunctionParams::~DelayedFunctionParams () {
	//#UC START# *4B2F277A0091_DESTR_BODY*
	//#UC END# *4B2F277A0091_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

TemplatePainter* TemplatePainter::DelayedFunctionParams::get_painter () const {
	//#UC START# *4B2F2B140088*
	return const_cast<TemplatePainter*> (m_painter.ptr ());
	//#UC END# *4B2F2B140088*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const AbstractDumperBase* TemplatePainter::DelayedFunctionParams::get_context () const {
	//#UC START# *4B62D07D01FB_GET_ACCESSOR*
	return m_context.in ();
	//#UC END# *4B62D07D01FB_GET_ACCESSOR*
}

void TemplatePainter::DelayedFunctionParams::set_context (const AbstractDumperBase* context) {
	//#UC START# *4B62D07D01FB_SET_ACCESSOR*
	m_context = AbstractDumperBase::_duplicate(context);
	//#UC END# *4B62D07D01FB_SET_ACCESSOR*
}

const TemplatePainter::DumpersHeap& TemplatePainter::DelayedFunctionParams::get_local_args () const {
	//#UC START# *4B2F2895001A_GET_ACCESSOR*
	return m_local_args;
	//#UC END# *4B2F2895001A_GET_ACCESSOR*
}

const TemplateFunctions::FunctionParams& TemplatePainter::DelayedFunctionParams::get_params () const {
	//#UC START# *4B2F2C5D01FD_GET_ACCESSOR*
	return m_params;
	//#UC END# *4B2F2C5D01FD_GET_ACCESSOR*
}

const AbstractDumperBase* TemplatePainter::DelayedFunctionParams::get_self () const {
	//#UC START# *4B2F2CEC0356_GET_ACCESSOR*
	return m_self;
	//#UC END# *4B2F2CEC0356_GET_ACCESSOR*
}

const AbstractDumperBase::VarDumpers& TemplatePainter::DelayedFunctionParams::get_var_dumpers () const {
	//#UC START# *4B2F287E0139_GET_ACCESSOR*
	return m_var_dumpers;
	//#UC END# *4B2F287E0139_GET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

