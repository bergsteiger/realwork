////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/Parsers/Parsers.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::Parsers
//
// ��������������� ������� �������� �������, ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_PARSERS_H__
#define __MDPROCESS_MDAMODEL_PARSERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>

namespace Parsers {

#pragma pack (push, 1)

// ��������� ����������� �������� ��������� ��� ��������
struct AttributeData {
	// ���������� ��� ��������
	std::string name;
	// ��� ��������
	std::string type;
	// ������� ��-���������
	std::string init_value;
};

#pragma pack (pop)

// ����� ��������� ��� ����������
typedef std::vector < AttributeData > AttributeDataVector;

// parsing error
class ParseError : public ::Core::Exception {
public:
	ParseError (const std::string& info);

	virtual ~ParseError () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ������������� ���������� �� ������
	std::string m_info;
};

#pragma pack (push, 1)

// ������ ��� ��������
struct OperationData {
	// ��� �������
	std::string name;
	// ��� ������������� ��������� �������
	std::string return_type;
	// ��������� ��������
	AttributeDataVector parameters;
};

#pragma pack (pop)

class AttributeParser;
typedef ::Core::Var<AttributeParser> AttributeParser_var;
typedef ::Core::Var<const AttributeParser> AttributeParser_cvar;
// ������ ��� "������������" ���������� �������� �� ������. ������:
// <���>: <���> = <�������� ��-���������>
class AttributeParser
	: virtual public ::Core::IObject
{
public:
	// ������ ������, � ������ ������ ���������� true
	virtual AttributeData* parse (const std::string& source) /*throw (ParseError)*/ = 0;
};

/// factory interface for AttributeParser
class AttributeParserFactory {
public:
	// ������� ��������� �������
	static AttributeParser& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class OperationParser;
typedef ::Core::Var<OperationParser> OperationParser_var;
typedef ::Core::Var<const OperationParser> OperationParser_cvar;
// ������ ��������� �������
class OperationParser
	: virtual public ::Core::IObject
{
public:
	// ���������� ������ ��������
	virtual OperationData* parse (const std::string& source) = 0;
};

/// factory interface for OperationParser
class OperationParserFactory {
public:
	// ������� ��������� �������
	static OperationParser& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Parsers

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Parsers::AttributeParser> {
	typedef Parsers::AttributeParserFactory Factory;
};
template <>
struct TypeTraits <Parsers::OperationParser> {
	typedef Parsers::OperationParserFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_PARSERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
