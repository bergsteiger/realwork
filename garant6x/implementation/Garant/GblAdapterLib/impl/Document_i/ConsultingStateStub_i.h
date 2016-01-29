////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStateStub_i
// ��������� ���������� ������ �������� ��� ��������� ConsultingStateStub
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTATESTUB_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTATESTUB_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

namespace GblAdapterLib {

class ConsultingStateStub_i; // self forward Var
typedef ::Core::Var<ConsultingStateStub_i> ConsultingStateStub_i_var;
typedef ::Core::Var<const ConsultingStateStub_i> ConsultingStateStub_i_cvar;

class ConsultingStateStub_i_factory;

class ConsultingStateStub_i:
	virtual public ConsultingStateStub
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ConsultingStateStub_i)
	friend class ConsultingStateStub_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <ConsultingStateStub_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultingStateStub_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsultingStateStub_i ();

	virtual ~ConsultingStateStub_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocumentState
	// [$178325284]
	virtual bool can_compare_with_any_other_redaction () const;

	// implemented method from DocumentState
	virtual DocumentState* clone () const;

	// implemented method from DocumentState
	// [$178324034]
	virtual const RedactionInfoList& get_cur_and_next_redactions_list () const;

	// implemented method from DocumentState
	virtual DiffData* diff_with_redaction_by_id (RedactionID id) const;

	// implemented method from DocumentState
	virtual RedactionInfo* get_current_redaction () const;

	// implemented method from DocumentState
	// ���������� true, ���� ��� �������� ����������, �. �. ����� ���:
	// - RT_ACTUAL
	// - RT_ACTUAL_ABOLISHED
	// - RT_ACTUAL_PREACTIVE
	virtual bool is_actual () const;

	// implemented method from DocumentState
	virtual bool is_same_redactions (const DocumentState* other) const;

	// implemented method from DocumentState
	virtual Languages get_language () const;

	virtual void set_language (Languages language);

	// implemented method from DocumentState
	virtual const RedactionInfoList& get_prev_redactions_list () const;

	// implemented method from DocumentState
	virtual RedactionID redaction () const;

	// implemented method from DocumentState
	// �������� ������������� � �������� ������� ��������, ���������� �������� ��� ������� ���������.
	// ���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����,
	// ��� � �� ������ ������.
	virtual void set_actual_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// �������� ������������� � �������� ������� ��������� �������� �������.
	// ���� ��������� �������� ���, �� ������������ RedactionNotFound.
	virtual void set_next_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// Get��������������������������������. [$178325284]
	virtual void set_prev_active_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// �������� ������������� � �������� ������� ���������� �������� �������.
	// ���� ���������� �������� ���, �� ������������ RedactionNotFound.
	virtual void set_prev_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	virtual void set_redaction_on_date (const Date& date) const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// �������� ������������� � �������� ������� �������� � �������� ���������������.
	// ���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����,
	// ��� � �� ������ ������.
	// ���� ����� �������� ������������� ��������, �� ������������ InvalidRedactionId.
	virtual void set_redaction_on_id (RedactionID id) const /*throw (RedactionNotFound)*/;
}; // class ConsultingStateStub_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTATESTUB_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
