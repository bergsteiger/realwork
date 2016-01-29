////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// ���������� ��� �������������� � ������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garantServer/src/Business/GblConsulting/GblConsultingC.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "shared/GCI/IO/IO.h"
// forward decls for friend interface's servants

namespace HCAdapterLib {
namespace HCInterfaces_i {
	class ConsultingRequests_i;
} // namespace HCInterfaces_i
} // namespace HCAdapterLib


namespace HCAdapterLib {
namespace HCInterfaces {

class ConsultingData;
typedef ::Core::Var<ConsultingData> ConsultingData_var;
typedef ::Core::Var<const ConsultingData> ConsultingData_cvar;
// ��������� ��� ��������� � ������������� ����� ��������� �������.
class ConsultingData
	: virtual public ::Core::IObject
{
public:
	// ��������� ������ �������. ������������ ������ (������) � XML ������� (�������� �� � ���������).
	virtual GCI::IO::Stream* get_data () = 0;

	// ������������� ��������� ������ �������� �������. ��� ������ ����� ������ ������ ���������� ���
	// ���������� �� ��������� (��� ��������� ������, ��� ��������� ������������).
	virtual void data_received () const = 0;
};

// ��������� �������� ������������ �������� �������
enum ResultValue {
	RV_SUCCESS // ������� ���������� �������
	, RV_DUPLICATED // ������ � ���� ��� �������, ��� ����������.
	, RV_EMPTY // �� ������ ������ ��� �������� ������� ����
	, RV_ERROR // ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
	, RV_BAD_XML // ������ ������ �� ������������� "���������" �������.
	, RV_COMPLECT_REMOVED_ERROR // �������� ��� ����� �� ���-� (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402)
	, RV_INVALID_QUERY_ID // ������� �������������� ��� � ����
};

typedef char* QueryID;
typedef const char* QueryID_const;


// �� ������ ��������� ���������� ��� ������ � XML
class CantFindXerces : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class OnlineData;
typedef ::Core::Var<OnlineData> OnlineData_var;
typedef ::Core::Var<const OnlineData> OnlineData_cvar;
// ������������, ���������� ����� ��. ����� ���������� �������������.
class OnlineData
	: virtual public ConsultingData
{

	// forward decls for friend interface's servant
	friend class HCInterfaces_i::ConsultingRequests_i;
};

/// factory interface for OnlineData
class OnlineDataFactory {
	friend class HCInterfaces_i::ConsultingRequests_i; //friend's servants

public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
protected:
	// ������� ��� ��������� ����������
	static OnlineData* make (
		GCI::IO::Stream* xml_stream
		, const GblConsultingDef::ConsultationID& consultation_id
	, const char* key
	) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��������� ��� �������� ������������.
static const char* STATISTIC_PACKET_SIZE_PARAMETER = "-StatisticPacketSize"; // �������� ��������� ������, �������� ������������ ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic)
static const size_t STATISTIC_PACKET_SIZE = 500; // �������� ��-��������� ��� ������������� ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic)
static const char* STATISTIC_SLEEP_TIME_PARAMETER = "-StatisticSleepTime"; // �������� ��������� ������, �������� ����� �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������.
static const unsigned int STATISTIC_SLEEP_TIME = 1; // ����� �������� � �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������.

class BusinessLogicLifeCycle;
typedef ::Core::Var<BusinessLogicLifeCycle> BusinessLogicLifeCycle_var;
typedef ::Core::Var<const BusinessLogicLifeCycle> BusinessLogicLifeCycle_cvar;
// ��������� ��� ���������� ��������� ������ ������-�������� ��������
class BusinessLogicLifeCycle
	: virtual public ::Core::IObject
{
public:
	// ����� ������ ���� ������ ������ ����� �������� dll ����������
	virtual void start () = 0;

	// ����� ������ ���� ������ ����� ����������� ������ ����������
	virtual void stop () = 0;

	// �������� ��������� � ��  ������ 7
	virtual GblConsulting::ConsultationManager70& get_consultation_manager70 () const = 0;
};

/// factory interface for BusinessLogicLifeCycle
class BusinessLogicLifeCycleFactory {
public:
	// ������������ ������� �������
	static BusinessLogicLifeCycle* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��������� �������� ������ � xml ��� �������� �������� �� ����.
static const char* EES_INVALID_STATUS = "INVALID_STATUS"; // ������������ � ������� �������� �� ����� ���� ������� (����� � ������� ���������� ������� ������� force="yes")
static const char* EES_NOT_FOUND = "NOT_FOUND"; // ������������ � �������� ��������������� �� ������� (�������� ��������� �� ���� 6-�� � ���� 7-��)
static const char* EES_UNKNOWN = "UNKNOWN"; // ���������� ������ ��

// ����� ������ ������ ��� ���������� ������������
static const char* QUERY70 = "QUERY70";
static const char* MARK70 = "MARK70";

class ConsultingRequests;
typedef ::Core::Var<ConsultingRequests> ConsultingRequests_var;
typedef ::Core::Var<const ConsultingRequests> ConsultingRequests_cvar;
// ��������� ��� ��������� �������� �� ������������� � �� ������.
class ConsultingRequests
	: virtual public ::Core::IObject
{
public:
	// �������� ��������� ������ ��� ���������
	virtual ResultValue get_query_by_id (QueryID_const query_id, ConsultingData*& data) const = 0;

	// ��������� ��������� ������ �� ������.
	// ��� ������ ���� �������� ���������� �������� ������� "������" ��� ��������� ������. �� ��� ���
	// ���� �� ����� �������� ����� DataRecieved, ��� �������� ����� ���������� ���� ������.
	// ���� ��� �� ������ ������ �������, ����������� ������ ������������, ������������ ������� ������.
	virtual ResultValue get_next_mark (ConsultingData*& data) const = 0;

	// ����� �� ������ ��� ��������������� ����������� � ������ ��������� �������.
	// ����� �������� � XML ������� (�������� c�. � ���������).
	// �������� ������������ ��������:
	// [0] - ���� ����� ������� ������� � ����.
	// [1] - ���� ������ � ���� ��� �������, ��� ����������.
	// [-1] - ���� ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-
	// �� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
	// [-2] - ���� ������ ������ �� ������������� "���������" �������.
	virtual ResultValue set_answer (GCI::IO::Stream* answer) const = 0;

	// ������� ����� ������� ������������ � ���� �� ��������� ����������� �� �� ���������������.
	virtual ResultValue get_status_statistic (GCI::IO::Stream* query, GCI::IO::Stream*& result) const = 0;

	// ������� ������� �� ���� ��
	virtual ResultValue erase_queries_by_id (GCI::IO::Stream* query, GCI::IO::Stream*& result) const = 0;

	// �������� � xml ����������� �����
	virtual ResultValue sign_query (GCI::IO::Stream* query, GCI::IO::Stream*& signed_query) const = 0;

	// �������� ������ ��������������� ������������, ������� ����� ������� �� ��������� � ���
	virtual ResultValue get_list_of_new_queries (GCI::IO::Stream*& result) const = 0;
};

/// factory interface for ConsultingRequests
class ConsultingRequestsFactory {
public:
	// �������� ��������� ������  � ��������� ���������������� ������
	static ConsultingRequests* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace HCInterfaces
} // namespace HCAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <HCAdapterLib::HCInterfaces::OnlineData> {
	typedef HCAdapterLib::HCInterfaces::OnlineDataFactory Factory;
};
template <>
struct TypeTraits <HCAdapterLib::HCInterfaces::BusinessLogicLifeCycle> {
	typedef HCAdapterLib::HCInterfaces::BusinessLogicLifeCycleFactory Factory;
};
template <>
struct TypeTraits <HCAdapterLib::HCInterfaces::ConsultingRequests> {
	typedef HCAdapterLib::HCInterfaces::ConsultingRequestsFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
