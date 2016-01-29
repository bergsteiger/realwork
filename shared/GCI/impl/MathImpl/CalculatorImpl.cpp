////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MathImpl/CalculatorImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MathImpl::CalculatorImpl
//
// Реализация калькулятора, реализует простейшие выражения: сложение, умножение, вычитание,
// деление, группировка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/MathImpl/CalculatorImpl.h"

//#UC START# *4766351B002F_CUSTOM_INCLUDES*
//#UC END# *4766351B002F_CUSTOM_INCLUDES*

namespace GCI {
namespace MathImpl {

//#UC START# *4766351B002F*
//#UC END# *4766351B002F*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CalculatorImpl::CalculatorImpl ()
//#UC START# *4767A70B0107_4767A76E01BA_4766351B002F_BASE_INIT*
//#UC END# *4767A70B0107_4767A76E01BA_4766351B002F_BASE_INIT*
{
	//#UC START# *4767A70B0107_4767A76E01BA_4766351B002F_BODY*
	//#UC END# *4767A70B0107_4767A76E01BA_4766351B002F_BODY*
}

CalculatorImpl::~CalculatorImpl () {
	//#UC START# *4766351B002F_DESTR_BODY*
	//#UC END# *4766351B002F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// реализация операции сложения
void CalculatorImpl::add () {
	//#UC START# *47663636033C*
	double rhs = top ();
	pop ();	
	double lhs = top ();
	pop ();

	push (lhs + rhs);
	//#UC END# *47663636033C*
}

// реализация опреации деления
void CalculatorImpl::division () {
	//#UC START# *47663676021F*
	double rhs = top ();
	pop ();	
	double lhs = top ();
	pop ();

	push (lhs / rhs);
	//#UC END# *47663676021F*
}

// реалиазция операции умножения
void CalculatorImpl::multiplication () {
	//#UC START# *4766364B010C*
	double rhs = top ();
	pop ();	
	double lhs = top ();
	pop ();

	push (lhs * rhs);
	//#UC END# *4766364B010C*
}

// реализация операции изменения знака
void CalculatorImpl::negation () {
	//#UC START# *476636E0015F*
	double value = top ();
	pop ();
	push (-value);
	//#UC END# *476636E0015F*
}

// удаляет промежуточный результат с вершины стэка
void CalculatorImpl::pop () {
	//#UC START# *4891A1DE01F2*
	m_stack.pop_back ();
	//#UC END# *4891A1DE01F2*
}

// добавить промежуточный результат
void CalculatorImpl::push (double value) {
	//#UC START# *47663FF2038D*
	m_stack.push_back (value);
	//#UC END# *47663FF2038D*
}

// реализация операции вычитания
void CalculatorImpl::subtraction () {
	//#UC START# *476636A5038C*
	double rhs = top ();
	pop ();	
	double lhs = top ();
	pop ();

	push (lhs - rhs);
	//#UC END# *476636A5038C*
}

// возвращет промежуточный результат с вершины стэка
double CalculatorImpl::top () {
	//#UC START# *47663FBB0051*	
	double res = m_stack.back ();	
	return res;
	//#UC END# *47663FBB0051*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Math::Calculator
// вычисляет мат. выражение записанное в виде строки и возвращает результат, в случае невозможности
// разобрать выражение бросается исключение
double CalculatorImpl::evaluate (const std::string& expression) /*throw (Math::BadExpression)*/ {
	//#UC START# *4767A74A0160_4766351B002F*
	Rule rule (this);
	boost::spirit::parse_info<> info = boost::spirit::parse (
		expression.c_str(), rule, boost::spirit::space_p
	);
	if (info.full) {
		double res = top ();
		m_stack.clear ();
		return res;
	} else {
		throw Math::BadExpression ();
	}
	//#UC END# *4767A74A0160_4766351B002F*
}
} // namespace MathImpl
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

