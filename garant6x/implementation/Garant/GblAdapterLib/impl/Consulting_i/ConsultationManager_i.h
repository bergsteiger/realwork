////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::ConsultationManager_i
// ��������� ���������� ������ �������� ��� ��������� ConsultationManager
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATIONMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATIONMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"

//#UC START# *457026710138_CUSTOM_INCLUDES*
//#UC END# *457026710138_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class ConsultationManager_i; // self forward Var
typedef ::Core::Var<ConsultationManager_i> ConsultationManager_i_var;
typedef ::Core::Var<const ConsultationManager_i> ConsultationManager_i_cvar;

class ConsultationManager_i_factory;

// ����������
class ConsultationManager_i:
	virtual public ConsultationManager
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (ConsultationManager_i)
	friend class ConsultationManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsultationManager_i ();

	virtual ~ConsultationManager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable boost::tribool m_consulting_available;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from ConsultationManager
	// �������� � ������������� �������� ������ (true - ����� �������� ���� ��������)
	virtual bool cant_receive_answer () const;

	// implemented method from ConsultationManager
	// �������� ����������� ���������������� �����
	virtual bool check_consulting_available () const;

	// implemented method from ConsultationManager
	// �������� �������� ������
	virtual bool check_internet_channel () const;

	// implemented method from ConsultationManager
	// �������� ����������� ������������ � �����������
	virtual void create_query_with_notice_user () const;

	// implemented method from ConsultationManager
	// ������� ������������
	virtual void delete_consultation (Consultation* for_delete) const /*throw (NotDeleted, Deleted)*/;

	// implemented method from ConsultationManager
	// ��������� ������������ �� �����
	virtual void load_from_xml (const char* file_name) const /*throw (AccessDenied, InvalidXMLType)*/;

	// implemented method from ConsultationManager
	// ���������� ���������� ������������� ������������
	virtual unsigned long update_not_readed_consultations () const;

//#UC START# *457026710138*
//#UC END# *457026710138*
}; // class ConsultationManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATIONMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
