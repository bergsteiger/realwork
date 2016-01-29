////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::BaseFunctionImpl::ListOperationBase
//
// ������� ����� ��� ������ � ����������� - ���� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.h"

namespace BaseFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ListOperationBase::~ListOperationBase () {
	//#UC START# *4B581BCD0399_DESTR_BODY*
	//#UC END# *4B581BCD0399_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ���������� ��������� (��� ���������� �������� ������) �� ��� ��������������, ���� �����
// ��������� �� ��� ������ - ������� ���
TemplatePainter::ContainerDumper* ListOperationBase::get_container (const std::string& id) const {
	//#UC START# *4B581C00003B*
	const AbstractDumperBase* var = TemplatePainter::get_var_dumper (id);
	TemplatePainter::ContainerDumper* container = dynamic_cast<TemplatePainter::ContainerDumper*> (
		const_cast<AbstractDumperBase*> (var)
	);

	if (!container) {
		TemplatePainter::ContainerDumper_var newContainer = new TemplatePainter::ContainerDumper (id);
		container = newContainer.ptr ();

		TemplatePainter::set_var_dumper (id, container); //����������� ������� ������ �� container
	}

	return container;
	//#UC END# *4B581C00003B*
}

// ���������� ��������� � �������� id (���� ������ ���������� ��� - ���������� 0)
TemplatePainter::ContainerDumper* ListOperationBase::get_container_if_exists (const std::string& id) const {
	//#UC START# *4B59A5C0021A*
	const AbstractDumperBase* var = TemplatePainter::get_var_dumper (id);
	TemplatePainter::ContainerDumper* container = dynamic_cast<TemplatePainter::ContainerDumper*> (
		const_cast<AbstractDumperBase*> (var)
	);

	return container;
	//#UC END# *4B59A5C0021A*
}

} // namespace BaseFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

