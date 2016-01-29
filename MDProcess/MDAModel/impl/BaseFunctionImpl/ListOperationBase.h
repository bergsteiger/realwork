////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::BaseFunctionImpl::ListOperationBase
//
// ������� ����� ��� ������ � ����������� - ���� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_LISTOPERATIONBASE_H__
#define __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_LISTOPERATIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace BaseFunctionImpl {

// ������� ����� ��� ������ � ����������� - ���� ������
class ListOperationBase {
	SET_OBJECT_COUNTER (ListOperationBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ListOperationBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// ���������� ��������� (��� ���������� �������� ������) �� ��� ��������������, ���� �����
	// ��������� �� ��� ������ - ������� ���
	virtual TemplatePainter::ContainerDumper* get_container (const std::string& id) const;

	// ���������� ��������� � �������� id (���� ������ ���������� ��� - ���������� 0)
	virtual TemplatePainter::ContainerDumper* get_container_if_exists (const std::string& id) const;

}; // class ListOperationBase

} // namespace BaseFunctionImpl


#endif //__MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_LISTOPERATIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

