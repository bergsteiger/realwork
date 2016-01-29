////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::TemplateFunctions
//
// пакет интерфейсов для работы с встроенными функциями генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_TEMPLATEFUNCTIONS_H__
#define __MDPROCESS_MDAMODEL_TEMPLATEFUNCTIONS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/MDAModel/Base/Base.h"
#include "shared/GCL/data/std_defs.h"

namespace TemplateFunctions {

// контэйнер для хранения параметров функций
typedef GCL::StrVector FunctionParams;

// Неправильно заданы параметры функции
class BadParams : public Base::FatalError {
public:
	// конструктор
	BadParams (const std::string& function, unsigned short min_count, unsigned short max_count, unsigned short provided);

	// конструктор
	BadParams (const std::string& function, unsigned short params_count, unsigned short provided);

	BadParams (const std::string& function, unsigned short min_expected_params_count, unsigned short provided_params_count, unsigned short max_expected_params_count, const std::string& info);

	virtual ~BadParams () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// функция
	std::string m_function;
	// минимальное ожидаемое количество параметров
	unsigned short m_min_expected_params_count;
	// заданное количество параметров
	unsigned short m_provided_params_count;
	// максимальное ожидаемое колчество параметров
	unsigned short m_max_expected_params_count;
};

class BaseFunction;
typedef ::Core::Var<BaseFunction> BaseFunction_var;
typedef ::Core::Var<const BaseFunction> BaseFunction_cvar;
// базовая функция шаблона
class BaseFunction
	: virtual public ::Core::IObject
{
public:
	// выполнение функции шаблона
	virtual const std::string execute (
		const FunctionParams& params
		, Base::AbstractTemplatePainter* painter
	) const /*throw (
		BadParams
	)*/ = 0;
};

class InternalStereotypeFunction;
typedef ::Core::Var<InternalStereotypeFunction> InternalStereotypeFunction_var;
typedef ::Core::Var<const InternalStereotypeFunction> InternalStereotypeFunction_cvar;
// встроенная функция стереотипа
class InternalStereotypeFunction
	: virtual public BaseFunction
{
};

/// factory interface for InternalStereotypeFunction
class InternalStereotypeFunctionFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	// получить экземпляр функции
	static InternalStereotypeFunction& make (const std::string& key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class InternalFunction;
typedef ::Core::Var<InternalFunction> InternalFunction_var;
typedef ::Core::Var<const InternalFunction> InternalFunction_cvar;
// встроенная функция шаблона
class InternalFunction
	: virtual public BaseFunction
{
};

/// factory interface for InternalFunction
class InternalFunctionFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	// получить экземпляр функции
	static InternalFunction& make (const std::string& key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace TemplateFunctions

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <TemplateFunctions::InternalStereotypeFunction> {
	typedef TemplateFunctions::InternalStereotypeFunctionFactory Factory;
};
template <>
struct TypeTraits <TemplateFunctions::InternalFunction> {
	typedef TemplateFunctions::InternalFunctionFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_TEMPLATEFUNCTIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
