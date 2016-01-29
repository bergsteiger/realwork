////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/Base/Base.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::Base
//
// ����� ������� ����� (� ������� ��� ������ ���� ����� � ������������ ��������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASE_H__
#define __MDPROCESS_MDAMODEL_BASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>

namespace Base {

class AbstractTemplatePainter;
typedef ::Core::Var<AbstractTemplatePainter> AbstractTemplatePainter_var;
typedef ::Core::Var<const AbstractTemplatePainter> AbstractTemplatePainter_cvar;
// ����� ��� ����, ����� �� �������� �� AbstractDumpers - � ������ ����� ���� AbstractDumpers
// ������ ���� ������� �� ��������� � ���������� - ������ ��� ���������.
class AbstractTemplatePainter
	: virtual public ::Core::IObject
{
};

class NamedElement;
typedef ::Core::Var<NamedElement> NamedElement_var;
typedef ::Core::Var<const NamedElement> NamedElement_cvar;
// ������� ��������� ��� ������������ ��������
class NamedElement
	: virtual public ::Core::IObject
{
public:
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const = 0;
};

class Dumper;
typedef ::Core::Var<Dumper> Dumper_var;
typedef ::Core::Var<const Dumper> Dumper_cvar;
// ������� ��������� ��� ���� �������� (���� ������� ������� �� ��� ��� - ����� �������� ��� ��
// ��������� ������ � AbstractDumperBase ���������� �� ���� ��� ��� � ��������� ������ ������
// ����������� ��������)
class Dumper
	: virtual public NamedElement
{
};

// ���������� ����������� � �������� ���������
class FatalError : public ::Core::Exception {
public:
	FatalError (const std::string& info);

	virtual ~FatalError () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ���������� - ��� ���������
	std::string m_info;
};

// ��������� ������������ �������������� �������� ���������
static const std::string VISIBILITY_LEVEL_KEY = "VisibilityLevel"; // ������� ��������� �����
static const std::string RESOLVED_TYPE_GUID = "ResolvedTypeGuid"; // ��� ��������, ��� �������� �������������� ����, � ������� ������ ������� (�������� ��� ���� ��������, ���������)
static const std::string GLOBAL_LOCALLY_KEY = "GlobalLocally"; // ���� ��� �������� ��������� ������������
static const std::string STORED_UID_KEY = "StoredUIDKey"; // ��� �������� ��� �������� �������������� ��������
static const char* OVERRIDEN_ELEMENTS_PROPERTIES = "OverridenElementsProperties";
static const char* USER_PROPERTY_TOOL = "MDA Generator User Properties";
static const char* ABSTRACTION_TYPE = "AbstarctOperation"; // ���� � ��������� ���������, �� �������� �������� ��� �������������
static const char* VISIBILITY_TYPE = "VisabilityType"; // ���� � ��������� ��������, �� �������� �������� ��� ���������
static const char* IS_OVERRIDEN_WRAPPER = "IsOverridenWrapper"; // ���� ��� ����, ����� ��������, ��� ������� �� ����� ���� - ������� ��� ���������������� ��������/��������/������ � �.�
static const std::string ELEMENT_CREATION_ORDER = "ElementCreationOrder"; // ���� ��������, ������������� ���������� ����� �������� ��������

// �������� ��� ������������� ������� ���������� ����������� �������
static const std::string ALL = "all"; // ���
static const std::string INCLUDE = "include"; // �������
static const std::string EXCLUDE = "exclude"; // ��������

// ���������� ���������, ���� � ����� ����� ��������� 2 ����-������ � ����������� ����������������
class MultipleUCSections : public ::Core::Exception {
public:
	MultipleUCSections (const std::string& info);

	virtual ~MultipleUCSections () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ����������
	std::string m_info;
};

// ���� �������
typedef std::map < std::string, std::string > PropertyMap;

typedef std::map < std::string, PropertyMap > ToolPropertyMap;

} // namespace Base


#endif //__MDPROCESS_MDAMODEL_BASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
