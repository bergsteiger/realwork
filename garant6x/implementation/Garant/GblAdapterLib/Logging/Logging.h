////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Logging/Logging.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Logging
//
// �������� ����������� �������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_LOGGING_H__
#define __GARANT6X_GBLADAPTERLIB_LOGGING_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

namespace GblAdapterLib {

// ������� �����������
enum LogEvent {
	LE_OPEN_DOCUMENT_FROM_LIST // �������� ��������� �� ������
	, LE_OPEN_DOCUMENT_FROM_LINK // �������� ��������� �� ������
	, LE_OPEN_MAIN_MENU // �������� ��������� ����
	, LE_OPEN_DICTIONARY // �������� ��������� �������
	, LE_ADD_TO_LIST // ���������� ���������� � ������
	, LE_DELETE_FROM_LIST // �������� ���������� �� ������
	, LE_GET_DOCUMENT_STRUCTURE // ������ ��������� ��������
	, LE_SEARCH_IN_DOCUMENT // ����� � ���������
	, LE_OPEN_RELATED // �������� �������
	, LE_OPEN_ANNOTATION
	, LE_EXPORT_TO_FILE // ������� � ����
	, LE_EXPORT_TO_WORD // ������� � ����
	, LE_USER_OPERATION // ����� ���������������� �������� �� ����, ������� ���
	, LE_OPEN_DOCUMENT_FROM_FOLDERS // �������� ��������� �� �����
	, LE_SAVE_DOCUMENT_TO_FOLDERS // ���������� ��������� � �����
	, LE_PRIMARY_MONITOR_RESOLUTION // ���������� �� �������� ��������
	, LE_DPI // ������ ���������� ������
	, LE_FONT_SIZE // ������ ���������� ������
	, LE_FIND_CONTEXT_IN_LIST // ����� ��������� � ������
	, LE_OPEN_DOCUMENT_FROM_HISTORY // �������� ��������� �� �������
	, LE_LIST_PRINT // ������ ������
	, LE_LIST_PRINT_PREVIEW // ��������������� �������� ������ ������
	, LE_LIST_SORT // ����������� � ������� ���������� ������
	, LE_LIST_REFERENCE_ACTIVATE
	, LE_SYNCHROVIEW_ACTIVATE // ������� ���������� ��������
	, LE_TIME_MACHINE_ON // ��������� ������ �������
	, LE_TIME_MACHINE_OFF // ���������� ������ �������
	, LE_NEXT_DOCUMENT // ������� �� ���� �������� � ������
	, LE_PREV_DOCUMENT // ������� �� ���������� �������� � ������
	, LE_VIEW_DOCUMENT_EDITION_LIST // �������� ������ �������� ���������
	, LE_VIEW_DOCUMENT_ATTRIBUTES // �������� ��������� ���������
	, LE_BACK // ��� �����
	, LE_FORWARD // ��� ������
	, LE_INC_FONT // ���������� ������
	, LE_DEC_FONT // ���������� ������
	, LE_OPEN_NEWS_LINE // �������� ��������� �����
	, LE_OPEN_CONSULTATION // �������� ��� ������������
	, LE_SAVE_QUERY // ���������� ������� � �����
	, LE_LOAD_QUERY // �������� ������� �� �����
	, LE_LOAD_QUERY_FROM_HISTORY // �������� ������� �� �������
	, LE_CONTEXT_FILTER_IN_TREE // ����������� ���������� ������
	, LE_DOCUMENT_PRINT // ������ ���������
	, LE_DOCUMENT_PRINT_PREVIEW // ��������������� �������� ������
	, LE_VIEW_SAME_DOCUMENTS // �������� ������� ����������
	, LE_SEND_DOCUMENT_BY_EMAIL // �������� ��������� �� �����
	, LE_SEND_LIST_BY_EMAIL // �������� ������ �� ������
	, LE_UNKNOWN // ����������� ������� - ����� ������������ ��� ������������ �������/�������� ��� ����������� ����� �������
	, LE_SEND_TEST_REQUEST_TO_LEGAL_ADVISE // �������� ���������� � ��� (�������� ��������� �������)
	, LE_OPEN_MEDIC_FIRMS // �������� ������ ����
	, LE_OPEN_MEDIC_DICTIONARY // �������� ��������� ������������ �������
	, LE_USE_SUB_PANEL_DOCUMENT_OPERATION // ���� ������ ����� �������� �� ���� � ��������� ��������� �� ����� ���������
	, LE_USE_BASE_SEARCH_EXAMPLE // ���������� ����������� � ������ �� ������� �� ��������
	, LE_USE_TASK_PANEL_OPERATION // ���������� ������� �������� � ������� "������ �����"
	, LE_SEND_REQUEST_TO_LEGAL_ADVISE // �������� ������� � ���
	, LE_OPEN_DOCUMENT_BY_NUMBER // �������� ��������� �� ������
	, LE_OPEN_PHARM_DOCUMENT // �������� ��������� - �������� ���������
	, LE_OPEN_PHARM_FIRM_DOCUMENT // �������� ��������� �������� �����
	, LE_USE_BASE_SEARCH_HINT
	, LE_LIST_EXPORT_TO_FILE
	, LE_LIST_EXPORT_TO_WORD
	, LE_USE_BACK_SEARCH_BUTTON // ��� ����������� ������ ������ ��������� ������� �� ������ "�����"
	, LE_OPEN_INTERNET_AGENT // �������� ���� ��������-������
	, LE_SWITCH_VERSION_COMMENTS // ���������-���������� ���������� ������������
	, LE_CHAT_WINDOW_OPENS_COUNT // ������ � �����
	, LE_SEARCH_IN_DOCUMENT_DONE // ����� � ��������� ��������
	, LE_NEXT_SEARCH_IN_DOCUMENT // ����� ���������� ��������� � ���������
	, LE_PREVIOUS_SEARCH_IN_DOCUMENT // ����� ����������� ��������� � ���������
	, LE_DOCUMENT_NOT_EXIST // ��������� ��� � ���� ��� �������� � ���������
	, LE_OPEN_DOCUMENT_FROM_SEARCH_HINT // �������� ��������� �� ������� ���������
};

class LogEventData;
typedef ::Core::Var<LogEventData> LogEventData_var;
typedef ::Core::Var<const LogEventData> LogEventData_cvar;
// ������ ������� �����������
class LogEventData
	: virtual public ::Core::IObject
{
public:
	virtual void add_object (const Core::IObject* data) = 0;

	virtual void add_string (const char* data) = 0;

	virtual void add_ulong (unsigned long data) = 0;

	virtual void add_date (const Date& data) = 0;

	// �������� � ���
	virtual void write_to_log (LogEvent log_event) const = 0;
};

/// factory interface for LogEventData
class LogEventDataFactory {
public:
	static LogEventData* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class LogManager;
typedef ::Core::Var<LogManager> LogManager_var;
typedef ::Core::Var<const LogManager> LogManager_cvar;
// �������� ������ � ���
class LogManager
	: virtual public ::Core::IObject
{
public:
	virtual void add_event (LogEvent log_event, LogEventData* data) = 0;
};

/// factory interface for LogManager
class LogManagerFactory {
public:
	static LogManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::LogEventData> {
	typedef GblAdapterLib::LogEventDataFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::LogManager> {
	typedef GblAdapterLib::LogManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_LOGGING_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
