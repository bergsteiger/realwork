////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/Helpers/Helpers.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Helpers
//
// ����� ��������������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERS_H__
#define __MDPROCESS_MDAADDINLIB_HELPERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <vector>
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/GCL/data/std_defs.h"

namespace Helpers {

// ���� ��� �������� ������� ������������� ����������
typedef std::map < AbstractDumperBase::StereotypeID, unsigned long > StereotypeUseMap;

// ������ �����������
typedef std::vector < AbstractDumperBase::StereotypeID > StereotypeList;

class StereotypeManager;
typedef ::Core::Var<StereotypeManager> StereotypeManager_var;
typedef ::Core::Var<const StereotypeManager> StereotypeManager_cvar;
// �������������� ��������� ��� ������ �� ������������ ���������
class StereotypeManager
	: virtual public ::Core::IObject
{
public:
	// ��������� ���� ������� ������������� ����������� ������ ��������� ��������
	virtual StereotypeUseMap* make_use_map (IRoseElementPtr elem) const = 0;

	// ��������� ������ ����������� ���������, ����������� ��������� � �������� ��������.
	// �������������� ������ ������������ �� ������� ������������� ����������� ������ ������!
	virtual StereotypeList* make_allowable_stereotypes (IRoseElementPtr elem, IRoseElementPtr context) const = 0;
};

/// factory interface for StereotypeManager
class StereotypeManagerFactory {
public:
	// ������� ��� ��������� ���������� ����������
	static StereotypeManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class KViewElement;
typedef ::Core::Var<KViewElement> KViewElement_var;
typedef ::Core::Var<const KViewElement> KViewElement_cvar;
// ��������������� ��������� ��� �������� �������� �������� � �
class KViewElement
	: virtual public ::Core::IObject
{
public:
	// ���������� �������� �������� � �
	virtual void view (IRoseElementPtr elem) const = 0;

	// ��������� ������ ��� �������� �������� �������� � �
	virtual const std::string make_view_link (IRoseElementPtr elem) const = 0;
};

/// factory interface for KViewElement
class KViewElementFactory {
public:
	// ���������� ���������
	static KViewElement& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ������� ���������� ������
struct ReportResultItem {
	// �������������� ���������
	GCL::StrVector messages;
	// �������
	const RoseAbstractDumper* element;
};

#pragma pack (pop)

// ��������� ������
typedef std::vector < ReportResultItem > ReportResult;

class ReportBuilder;
typedef ::Core::Var<ReportBuilder> ReportBuilder_var;
typedef ::Core::Var<const ReportBuilder> ReportBuilder_cvar;
// "�����������" ������. ����� - ��� ������, ������� ����������� � ���������, ���� ���������
// ���������� ����� ������� true - �������, � �������� �� ���������� �������� � ��������������
// ������ ������ � ��������� ����� ������
class ReportBuilder
	: virtual public ::Core::IObject
{
public:
	// ��������� ������ ������ � �������� � ���� ��� �����
	virtual ReportResult* build (
		const RoseAbstractDumper* from
		, const AbstractDumperBase::ReportsTreeItem* report
	) const = 0;
};

/// factory interface for ReportBuilder
class ReportBuilderFactory {
public:
	// �������
	static ReportBuilder* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Helpers

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Helpers::StereotypeManager> {
	typedef Helpers::StereotypeManagerFactory Factory;
};
template <>
struct TypeTraits <Helpers::KViewElement> {
	typedef Helpers::KViewElementFactory Factory;
};
template <>
struct TypeTraits <Helpers::ReportBuilder> {
	typedef Helpers::ReportBuilderFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAADDINLIB_HELPERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
