////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDictDocument.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmDictDocument
// ��������� ���������� ������ �������� ��� ��������� 
//
// �������� ���������� ������������ ��������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDICTDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDICTDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class PharmDictDocument; // self forward Var
typedef ::Core::Var<PharmDictDocument> PharmDictDocument_var;
typedef ::Core::Var<const PharmDictDocument> PharmDictDocument_cvar;

class PharmDictDocument_factory;

// �������� ���������� ������������ ��������� �������
class PharmDictDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (PharmDictDocument)
	friend class PharmDictDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit PharmDictDocument (GblPilot::Document* document);

	PharmDictDocument (const GCD::PID& pid, const char* name);

	virtual ~PharmDictDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	virtual DocumentType get_doc_type () const;

}; // class PharmDictDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMDICTDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
