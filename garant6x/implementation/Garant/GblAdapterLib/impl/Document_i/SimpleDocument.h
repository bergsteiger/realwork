////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::SimpleDocument
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SIMPLEDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SIMPLEDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class SimpleDocument; // self forward Var
typedef ::Core::Var<SimpleDocument> SimpleDocument_var;
typedef ::Core::Var<const SimpleDocument> SimpleDocument_cvar;

class SimpleDocument_factory;

class SimpleDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (SimpleDocument)
	friend class SimpleDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit SimpleDocument (GblPilot::Document* document);

	virtual ~SimpleDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Controllable
	// ���������� true, ���� ��������� ���������� �� ��������
	virtual const bool get_can_set_to_control () const;

	// overloaded method from Controllable
	// �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true
	// �������� � ���������� �������� �� ��������, � false �������������� � ������.
	virtual bool get_controlled () const;

	virtual void set_controlled (bool controlled);

	// overloaded method from Controllable
	// ���������� ������� �������� ������� ���������.
	virtual unsigned long get_control_status ();

	// overloaded method from Controllable
	// ��������� �������� �� ��������.
	virtual bool is_same_controllable (const Controllable* other);

	// overloaded method from Controllable
	// ���������� ������ ��������� � ����.
	virtual void reset_control_status ();

	// overloaded method from Controllable
	virtual ControlledItemType get_type () const;

	// overloaded method from Document
	virtual const NodeBase* get_attributes_root () const;
	virtual NodeBase* get_attributes_root ();

	// overloaded method from Document
	// �������� url ��� ���������������� WWW-������ ���������.
	virtual ExternalLink* get_internet_image_url (long block_id) const;

	// overloaded method from Document
	virtual TimeMachineWarning* get_time_machine_warning (const Date& date);

	// overloaded method from Document
	// �������� ������� ��������������� (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	virtual bool has_correspondents (const NodeBase* category) const;

	// overloaded method from Document
	// �������� ������� WWW-������ � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� WWW-�����.
	virtual bool has_internet_image () const;

	// overloaded method from Document
	// ������� ���������� ������� ��������� �������� ��� �������.
	// ��������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������.
	virtual bool has_next_redaction () const;

	// overloaded method from Document
	// ������� ���������� ������� ���������� �������� ��� �������.
	// ���������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������.
	virtual bool has_prev_redaction () const;

	// overloaded method from Document
	// �������� ������� ������� � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� �������.
	// 
	// ��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������"
	virtual bool has_related_doc () const;

	// overloaded method from Document
	// �������� ������� ������������ (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	virtual bool has_respondents (const NodeBase* category) const;

	// overloaded method from Document
	// ����������� ��������������.
	virtual bool has_warning () const;

	// overloaded method from Document
	// ����� ��������� ���������� �������� �� date � �������� ������������� ���������.
	virtual bool is_date_in_not_sure_interval (const Date& date) const;

	// overloaded method from Document
	// �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
	// ���������� true � ������, ���� ����� ��������� ��������.
	// 
	// ��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ ��������
	// )
	virtual bool may_show_attributes () const;

	// overloaded method from Document
	virtual const RedactionInfoList& get_redactions_list () const;

	// overloaded method from Document
	virtual const Document* get_related_doc () const;
	virtual Document* get_related_doc ();

	// overloaded method from Document
	// ������ ���������
	virtual const ItemStatus get_status () const;

	// overloaded method from Document
	// �������������� � ���������.
	virtual const GCI::IO::String& get_warning () const;
	virtual GCI::IO::String& get_warning ();

}; // class SimpleDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SIMPLEDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
