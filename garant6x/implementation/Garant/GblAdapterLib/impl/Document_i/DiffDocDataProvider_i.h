////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffDocDataProvider_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DiffDocDataProvider_i
// ��������� ���������� ������ �������� ��� ��������� DiffDocDataProvider
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFDOCDATAPROVIDER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFDOCDATAPROVIDER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

//#UC START# *4D78EAEB0118_CUSTOM_INCLUDES*
//#UC END# *4D78EAEB0118_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class DiffDocDataProvider_i; // self forward Var
typedef ::Core::Var<DiffDocDataProvider_i> DiffDocDataProvider_i_var;
typedef ::Core::Var<const DiffDocDataProvider_i> DiffDocDataProvider_i_cvar;

class DiffDocDataProvider_i_factory;

class DiffDocDataProvider_i:
	virtual public DiffDocDataProvider
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DiffDocDataProvider_i)
	friend class DiffDocDataProvider_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DiffDocDataProvider_i (const Document* left, const Document* right);

	virtual ~DiffDocDataProvider_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DiffDocDataProvider
	virtual unsigned long get_all_leaf_para_count () const;

	// implemented method from DiffDocDataProvider
	virtual ChangedBlock* get_changed_block (unsigned long i) const;

	// implemented method from DiffDocDataProvider
	virtual unsigned long get_changed_block_count () const;

	// implemented method from DiffDocDataProvider
	// �������� � ������ ��������� ��������� ��� ������ ���������
	virtual bool get_date_para_left (DiffDocPara*& para) const;

	// implemented method from DiffDocDataProvider
	// �������� � ������ ��������� ��������� ��� ������� ���������
	virtual bool get_date_para_right (DiffDocPara*& para) const;

	// implemented method from DiffDocDataProvider
	// ��������� ��������� ������� ��:
	// 
	// ����� "����� ��������� ���������"
	// ������� ��� ��������� (!Name)
	// ����� "������������ ���������� �������� "������"
	// ����� "����� ��������� ������������ ��������� ��������:"
	virtual DiffDocParaList* get_header_para_list () const;

	// implemented method from DiffDocDataProvider
	// ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������ ���������)
	virtual DiffDocPara* get_redaction_name_left () const;

	// implemented method from DiffDocDataProvider
	// ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� �������
	// ���������)
	virtual DiffDocPara* get_redaction_name_right () const;

//#UC START# *4D78EAEB0118*
private:
	GblPilot::DiffDocData_var m_data;
//#UC END# *4D78EAEB0118*
}; // class DiffDocDataProvider_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFDOCDATAPROVIDER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
