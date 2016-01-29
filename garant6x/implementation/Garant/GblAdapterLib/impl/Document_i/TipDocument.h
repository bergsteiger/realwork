////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TipDocument.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::TipDocument
// ��������� ���������� ������ �������� ��� ��������� 
//
// �������� ������ ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TIPDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TIPDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"

namespace GblAdapterLib {

class TipDocument; // self forward Var
typedef ::Core::Var<TipDocument> TipDocument_var;
typedef ::Core::Var<const TipDocument> TipDocument_cvar;

class TipDocument_factory;

// �������� ������ ���
class TipDocument:
	virtual public SimpleDocument
{
	SET_OBJECT_COUNTER (TipDocument)
	friend class TipDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TipDocument (const GCD::PID& pid, const char* name);

	explicit TipDocument (GblPilot::Document* document);

	virtual ~TipDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

	// overloaded method from Document
	// ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ����
	// ��������� ��� ��������� ������������ � ���������
	virtual GCI::IO::Stream* get_evd_stream () const;

	// overloaded method from Document
	// ��� ���������� ���� DT_BOOK ���������� false,
	// ��� ��������� true
	virtual bool has_attributes () const;

}; // class TipDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_TIPDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
