////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/Base/NamedElement.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::Base::NamedElement
//
// ������� ��������� ��� ������������ ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASE_NAMEDELEMENT_H__
#define __MDPROCESS_MDAMODEL_BASE_NAMEDELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"


// ������� ��������� ��� ������������ ��������
class NamedElement {
// virtual void destructor
public:
	virtual ~NamedElement () {};

//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const = 0;

}; // class NamedElement



#endif //__MDPROCESS_MDAMODEL_BASE_NAMEDELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

