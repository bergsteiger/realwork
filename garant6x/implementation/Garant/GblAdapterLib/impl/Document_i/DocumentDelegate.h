////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentDelegate
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTDELEGATE_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTDELEGATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class DocumentDelegate; // self forward Var
typedef ::Core::Var<DocumentDelegate> DocumentDelegate_var;
typedef ::Core::Var<const DocumentDelegate> DocumentDelegate_cvar;

class DocumentDelegate_factory;
class DocumentDelegateServantFactory;

class DocumentDelegate:
	virtual public Document_i
{
	SET_OBJECT_COUNTER (DocumentDelegate)
	friend class DocumentDelegate_factory; // self factory
	friend class DocumentDelegateServantFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DocumentDelegate (DocumentMaster* master, DocumentState_i* new_state);

	virtual ~DocumentDelegate ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DocumentMaster_var m_master_document;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Controllable
	// ���������� true, ���� ��������� ���������� �� ��������
	virtual const bool get_can_set_to_control () const;

	// implemented method from Controllable
	// �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true
	// �������� � ���������� �������� �� ��������, � false �������������� � ������.
	virtual bool get_controlled () const;

	virtual void set_controlled (bool controlled);

	// implemented method from Controllable
	// ���������� ������� �������� ������� ���������.
	virtual unsigned long get_control_status ();

	// implemented method from Controllable
	// ��������� �������� �� ��������.
	virtual bool is_same_controllable (const Controllable* other);

	// implemented method from Controllable
	// ���������� ������ ��������� � ����.
	virtual void reset_control_status ();

	// implemented method from Controllable
	virtual ControlledItemType get_type () const;

	// implemented method from DocWithPid
	virtual const GCD::PID& get_document_pid () const;

	// implemented method from Document
	virtual const Document* get_annotation () const;
	virtual Document* get_annotation ();

	// implemented method from Document
	virtual GCD::PID get_redaction_pid () const;

	// implemented method from Document
	// ���� �� � ��������� ���������� ������������ ��������� ����
	// K555095873
	virtual bool has_chronology () const;

	// implemented method from Document
	// �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
	// ���������� true � ������, ���� ����� ��������� ��������.
	// 
	// ��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ ��������
	// )
	virtual bool may_show_attributes () const;

	// implemented method from Document
	virtual const RedactionInfoList& get_redactions_list () const;

	// implemented method from Document
	virtual const Document* get_related_doc () const;
	virtual Document* get_related_doc ();

	// implemented method from Document
	virtual const LanguagesList& get_text_languages () const;

	// implemented method from Document_i
	virtual const DocumentMaster* get_master () const;

	// implemented method from Document_i
	virtual void load_server_doc () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual const NodeBase* get_attributes_root () const;
	virtual NodeBase* get_attributes_root ();

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

	// overloaded method from Document
	virtual void get_correspondents (const NodeBase* category, CatalogBase*& out_list) const;

	// overloaded method from Document
	virtual void get_respondents (const NodeBase* category, CatalogBase*& out_list) const;

	// overloaded method from Document
	virtual bool has_annotation () const;

	// overloaded method from Document
	// �������� ������� ��������������� (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	virtual bool has_correspondents (const NodeBase* category) const;

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
	// ������ ���������
	virtual const ItemStatus get_status () const;

}; // class DocumentDelegate

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTDELEGATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
