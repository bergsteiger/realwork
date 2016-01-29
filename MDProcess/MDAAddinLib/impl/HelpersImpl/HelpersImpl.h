////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAAddinLib::HelpersImpl
//
// ����� ���������� ��������������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"


namespace HelpersImpl {

// ������� ��� ���������� ����������� �� �������������
struct SortStereotypeByUse : public std::binary_function<AbstractDumperBase::StereotypeID, AbstractDumperBase::StereotypeID, bool> {
	bool operator () (const AbstractDumperBase::StereotypeID& first_param_, const AbstractDumperBase::StereotypeID& second_param_) const;

	SortStereotypeByUse (const Helpers::StereotypeUseMap& use_map_);

private:
	// ���� ������� ������������� ����������� - �� ��� ����� ����������� ����������.
	const Helpers::StereotypeUseMap* use_map;
};

} //namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

