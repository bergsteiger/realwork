////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToRGB
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _to_rgb
// _to_rgb(«число», «разделитель») - преобразует цвет заданный числом в формат RGB, возвращает
// строчку, «разделитель» - разделитель используемый для отделения цветов (по умолчанию
// используется ","), Например:
// %f_to_rgb(100) - вернёт 100,0,0
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TORGB_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TORGB_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ToRGB; // self forward Var
typedef ::Core::Var<ToRGB> ToRGB_var;
typedef ::Core::Var<const ToRGB> ToRGB_cvar;

class ToRGB_factory;

// реализация встроенной функции генератора _to_rgb
// _to_rgb(«число», «разделитель») - преобразует цвет заданный числом в формат RGB, возвращает
// строчку, «разделитель» - разделитель используемый для отделения цветов (по умолчанию
// используется ","), Например:
// %f_to_rgb(100) - вернёт 100,0,0
class ToRGB:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToRGB)
	friend class ToRGB_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToRGB ();

	virtual ~ToRGB ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class ToRGB

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TORGB_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
