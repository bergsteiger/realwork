////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseCopyHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseDumpers::RoseCopyHelper
//
// ����� ��������������� ������� ��� ����������� ��������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSECOPYHELPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSECOPYHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

namespace RoseCopyHelper {

// ����� ��� ����������� �������� - � ���������� dest - ������ ����� source � ��� �� �����������,
// ���������� � �.�, �� - ��� ������ ������
void copy (IRoseAttributePtr source, IRoseAttributePtr& dest, bool copy_for_relocate);

// ����� ��� �����������  �������� - � ���������� dest - ������ ����� source � ��� �� �����������,
// ���������� � �.�, �� - ��� ������ ������
void copy (IRoseOperationPtr source, IRoseOperationPtr& dest, bool copy_for_relocate);

// �������� ��� mda-�������� �������� (������ ����������, ����-�������� � �.�)
void copy_mda_property (IRoseElementPtr source, IRoseElementPtr& dest, bool copy_for_relocate);


} // namespace RoseCopyHelper


#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSECOPYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
