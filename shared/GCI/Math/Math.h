////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/Math/Math.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::Math
//
// ����� ����������� ��������� � ��������������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MATH_H__
#define __SHARED_GCI_MATH_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace Math {

// �������� ���������, ��������� ��� ������������� ��������� �������������� ���������.
class BadExpression : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Calculator;
typedef ::Core::Var<Calculator> Calculator_var;
typedef ::Core::Var<const Calculator> Calculator_cvar;
// �����������, ��������� ��������� ���-��������� �������� � ���� ������
class Calculator
	: virtual public ::Core::IObject
{
public:
	// ��������� ���. ��������� ���������� � ���� ������ � ���������� ���������, � ������
	// ������������� ��������� ��������� ��������� ����������
	virtual double evaluate (const std::string& expression) /*throw (BadExpression)*/ = 0;
};

/// factory interface for Calculator
class CalculatorFactory {
public:
	// ������� �����������
	static Calculator& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Math
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::Math::Calculator> {
	typedef GCI::Math::CalculatorFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_MATH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
