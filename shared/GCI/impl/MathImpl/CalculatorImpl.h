////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MathImpl/CalculatorImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MathImpl::CalculatorImpl
// Заголовок реализации класса серванта для интерфеса Calculator
//
// Реализация калькулятора, реализует простейшие выражения: сложение, умножение, вычитание,
// деление, группировка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MATHIMPL_CALCULATORIMPL_H__
#define __SHARED_GCI_MATHIMPL_CALCULATORIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "boost/spirit.hpp"
#include "shared/GCI/Math/Math.h"

//#UC START# *4766351B002F_CUSTOM_INCLUDES*
#include "boost/bind.hpp"
//#UC END# *4766351B002F_CUSTOM_INCLUDES*

namespace GCI {
namespace MathImpl {

class CalculatorImpl; // self forward Var
typedef ::Core::Var<CalculatorImpl> CalculatorImpl_var;
typedef ::Core::Var<const CalculatorImpl> CalculatorImpl_cvar;

class CalculatorImpl_factory;

// Реализация калькулятора, реализует простейшие выражения: сложение, умножение, вычитание,
// деление, группировка.
class CalculatorImpl:
	virtual public Math::Calculator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CalculatorImpl)
	friend class CalculatorImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// вектор чисел
	typedef std::vector < double > DoubleVector;

	// Правила разбора математического выражения
	class Rule :
		public boost::spirit::grammar<Rule>
	{
		SET_OBJECT_COUNTER (Rule)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// Констурктор, calculator - объект реализующий математические операции
		explicit Rule (CalculatorImpl* calculator);

	public:
		virtual ~Rule ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// возвращает объект, реализующий математические операции
		const CalculatorImpl& get_calculator () const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// объект реализующий математические операции
		CalculatorImpl* m_calculator;

	//#UC START# *4766402B03DF*
	public:

	template <typename ScannerT>
    struct definition {
		definition(Rule const& self) {   
			CalculatorImpl* calc = const_cast<CalculatorImpl*> (&self.get_calculator ());
			expression
				=   term
				>> *(   ('+' >> term)[boost::bind (&CalculatorImpl::add, calc)]
						|   ('-' >> term)[boost::bind (&CalculatorImpl::subtraction, calc)]
						)
				;

			term
				=   factor
					>> *(
							('*' >> factor)[boost::bind (&CalculatorImpl::multiplication, calc)]
							|  ('/' >> factor)[boost::bind (&CalculatorImpl::division, calc)]

						);


			factor
				=   boost::spirit::real_p[boost::bind (&CalculatorImpl::push, calc, _1)]
				|   '(' >> expression >> ')'
				|   ('-' >> factor)[boost::bind (&CalculatorImpl::negation, calc)]           
				|   ('+' >> factor)
				;
		}

		boost::spirit::rule<ScannerT> expression, term, factor;

        boost::spirit::rule<ScannerT> const& start() const { return expression; }
    };
	//#UC END# *4766402B03DF*
	}; // class Rule

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CalculatorImpl ();

	virtual ~CalculatorImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// реализация операции сложения
	virtual void add ();

	// реализация опреации деления
	virtual void division ();

	// реалиазция операции умножения
	virtual void multiplication ();

	// реализация операции изменения знака
	virtual void negation ();

	// удаляет промежуточный результат с вершины стэка
	virtual void pop ();

	// добавить промежуточный результат
	virtual void push (double value);

	// реализация операции вычитания
	virtual void subtraction ();

	// возвращет промежуточный результат с вершины стэка
	virtual double top ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Стэк промежуточных результатов вычисления мат. выражения
	DoubleVector m_stack;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Math::Calculator
	// вычисляет мат. выражение записанное в виде строки и возвращает результат, в случае
	// невозможности разобрать выражение бросается исключение
	virtual double evaluate (const std::string& expression) /*throw (Math::BadExpression)*/;

//#UC START# *4766351B002F*
//#UC END# *4766351B002F*
}; // class CalculatorImpl

} // namespace MathImpl
} // namespace GCI


#endif //__SHARED_GCI_MATHIMPL_CALCULATORIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
