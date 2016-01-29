////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::PageProxyImpl
// ��������� ���������� ������ �������� ��� ��������� PageProxy
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContents.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

namespace GenSupportImpl {

class PageProxyImpl; // self forward Var
typedef ::Core::Var<PageProxyImpl> PageProxyImpl_var;
typedef ::Core::Var<const PageProxyImpl> PageProxyImpl_cvar;

class PageProxyImpl_factory;

class PageProxyImpl:
	virtual public GenSupport::PageProxy
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PageProxyImpl)
	friend class PageProxyImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PageProxyImpl (ServerGate::GenerationContents::ModelElementId_const page_guid);

	virtual ~PageProxyImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������
	mutable ServerGate::GenerationContents::Page* m_delegate;

	// ������������ ����� ������ �������� (��� UC). ��������� ������� ������� ������� �����
	// ����������� ������ ��� �������� commit.  ��� ������ �������� ������������ ������ ����������
	// ���� ������ �� ����� ������, ��� ������������� � ��������� ������. ������� ������������ ������
	// �������� � ����������
	mutable std::auto_ptr<std::string> m_generated_text;

	// ���� ��������
	std::string m_guid;

	// ������������ �������� ������ is_modified
	mutable Core::Box<bool> m_is_modified;

	// ������������ �������� ������ is_new_page
	mutable Core::Box<bool> m_is_new_page;

	// ������������ ������� ����� �������
	mutable std::auto_ptr<std::string> m_labels;

	mutable std::auto_ptr<std::string> m_path;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_guid () const;
private:
	ServerGate::GenerationContents::Page* get_delegate () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GenSupport::PageProxy
	// ��������� ��������� � �����
	virtual void add_diagram (
		const char* name
		, const ServerGate::GenerationContents::Diagram& d
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
	)*/;

	// implemented method from GenSupport::PageProxy
	// ��������� ��� �������� �������� �������� ���������
	virtual void add_property_map (
		const ServerGate::GenerationContents::PropertyMapEntryList& map
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
		, ServerGate::GenerationContents::ContentUpdateError
		, ServerGate::GenerationContents::PathNotValid
	)*/;

	// implemented method from GenSupport::PageProxy
	// ������������ ����� ������ �������� (��� UC). ��������� ������� ������� ������� �����
	// ����������� ������ ��� �������� commit.  ��� ������ �������� ������������ ������ ����������
	// ���� ������ �� ����� ������, ��� ������������� � ��������� ������. ������� ������������ ������
	// �������� � ����������
	virtual const std::string& get_generated_text () const;

	virtual void set_generated_text (const std::string& generated_text)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// ���������� ����������� ����� ��� ���� ������� �������� ��������� (����� ��� ����, ����� ������,
	// ��� �������� ��� ����� ������� ���������� � ������� ���������)
	virtual long long get_all_property_cheksum () const;

	// implemented method from GenSupport::PageProxy
	// �� ����� ��������� ���������� �� ���
	virtual char* get_diagram_hash (const char* name) const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// ���������� ��� ���� �������� ���� ��������
	virtual bool is_modified () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// ���������� ��� ���� �������� �����
	virtual bool is_new_page () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// ������������ ������� ����� �������
	virtual const std::string& get_labels () const;

	virtual void set_labels (const std::string& labels)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// �������� �������� �� ��������. �������� �������� ���������� ��� �������
	virtual void mark_for_remove () /*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// r/o ��������� �������� �� �� ������������� ���������
	virtual ServerGate::GenerationContents::Page* get_page_before_changes () const;

	// implemented method from GenSupport::PageProxy
	virtual const std::string& get_path () const;

	virtual void set_path (const std::string& path);

	// implemented method from GenSupport::PageProxy
	// ���������� ��� ���� ������
	virtual void reset ();

	// implemented method from GenSupport::PageProxy
	virtual void rollback_all_changes () /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;
}; // class PageProxyImpl

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
