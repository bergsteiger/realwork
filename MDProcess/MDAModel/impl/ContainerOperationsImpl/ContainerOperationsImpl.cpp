////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerOperationsImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::ContainerOperationsImpl
//
// пакет операций для работы со списками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerOperationsImpl.h"

#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"


namespace ContainerOperationsImpl {

bool LessByTemplateCommand::operator () (const AbstractDumperBase* first_param_, const AbstractDumperBase* second_param_) const {
	//#UC START# *494214030236_IMPL*
	std::string x_resolve = TemplatePainter::resolve_exp (command, TemplatePainter::TPArgs (1, first_param_), first_param_, painter);
	std::string y_resolve = TemplatePainter::resolve_exp (command, TemplatePainter::TPArgs (1, second_param_), second_param_, painter);
	return x_resolve < y_resolve;
	//#UC END# *494214030236_IMPL*
}


LessByTemplateCommand::LessByTemplateCommand (const std::string& command_, const TemplatePainter* painter_) : command(command_), painter(painter_) {
	//#UC START# *494214030236_INIT_CTOR*
	//#UC END# *494214030236_INIT_CTOR*
}


bool EqualByTemplateCommand::operator () (const AbstractDumperBase* first_param_, const AbstractDumperBase* second_param_) const {
	//#UC START# *49421527025D_IMPL*
	std::string x_resolve = TemplatePainter::resolve_exp (command, TemplatePainter::TPArgs (1, first_param_), first_param_, painter);
	std::string y_resolve = TemplatePainter::resolve_exp (command, TemplatePainter::TPArgs (1, second_param_), second_param_, painter);
	return x_resolve == y_resolve;
	//#UC END# *49421527025D_IMPL*
}


EqualByTemplateCommand::EqualByTemplateCommand (const std::string& command_, const TemplatePainter* painter_) : command(command_), painter(painter_) {
	//#UC START# *49421527025D_INIT_CTOR*	
	//#UC END# *49421527025D_INIT_CTOR*
}


} //namespace ContainerOperationsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

