////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/MathImpl/CalculatorImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MathImpl::CalculatorImpl
// ��������� ���������� ������ �������� ��� ��������� Calculator
//
// ���������� ������������, ��������� ���������� ���������: ��������, ���������, ���������,
// �������, �����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ���������� ������������, ��������� ���������� ���������: ��������, ���������, ���������,
// �������, �����������.
class CalculatorImpl:
	virtual public Math::Calculator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CalculatorImpl)
	friend class CalculatorImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ������ �����
	typedef std::vector < double > DoubleVector;

	// ������� ������� ��������������� ���������
	class Rule :
		public boost::spirit::grammar<Rule>
	{
		SET_OBJECT_COUNTER (Rule)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// �����������, calculator - ������ ����������� �������������� ��������
		explicit Rule (CalculatorImpl* calculator);

	public:
		virtual ~Rule ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// ���������� ������, ����������� �������������� ��������
		const CalculatorImpl& get_calculator () const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// ������ ����������� �������������� ��������
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
	// ���������� �������� ��������
	virtual void add ();

	// ���������� �������� �������
	virtual void division ();

	// ���������� �������� ���������
	virtual void multiplication ();

	// ���������� �������� ��������� �����
	virtual void negation ();

	// ������� ������������� ��������� � ������� �����
	virtual void pop ();

	// �������� ������������� ���������
	virtual void push (double value);

	// ���������� �������� ���������
	virtual void subtraction ();

	// ��������� ������������� ��������� � ������� �����
	virtual double top ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���� ������������� ����������� ���������� ���. ���������
	DoubleVector m_stack;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Math::Calculator
	// ��������� ���. ��������� ���������� � ���� ������ � ���������� ���������, � ������
	// ������������� ��������� ��������� ��������� ����������
	virtual double evaluate (const std::string& expression) /*throw (Math::BadExpression)*/;

//#UC START# *4766351B002F*
//#UC END# *4766351B002F*
}; // class CalculatorImpl

} // namespace MathImpl
} // namespace GCI


#endif //__SHARED_GCI_MATHIMPL_CALCULATORIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
