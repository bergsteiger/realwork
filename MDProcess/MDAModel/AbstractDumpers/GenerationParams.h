////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAModel::AbstractDumpers::GenerationParams
//
// ��������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_GENERATIONPARAMS_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_GENERATIONPARAMS_H__

#include "shared/CoreSrv/sys/std_inc.h"


// ��������� ���������
class GenerationParams {

// static member methods and data
public:
	// �������� ����������� ������ ������ ����� ����������
	static const bool get_enable_spell_explicit_call_logging () /* throw (Core::ParameterIsMissing) */;
	static void set_enable_spell_explicit_call_logging (bool value);
	static const char* enable_spell_explicit_call_logging_param_name ();

	static const unsigned long get_lock_strategy () /* throw (Core::ParameterIsMissing) */;
	static void set_lock_strategy (unsigned long value);
	static const char* lock_strategy_param_name ();

	// ������������ ��������, ������������ ���������� ����� ��������� (����� ���������)
	static const bool get_overwrite_creation_order_property () /* throw (Core::ParameterIsMissing) */;
	static void set_overwrite_creation_order_property (bool value);
	static const char* overwrite_creation_order_property_param_name ();

	// �������� ��, ���� � ������� �������� ������� �� �������������� ��������
	static const bool get_scold_if_call_tpl_function_on_null () /* throw (Core::ParameterIsMissing) */;
	static void set_scold_if_call_tpl_function_on_null (bool value);
	static const char* scold_if_call_tpl_function_on_null_param_name ();

}; // class GenerationParams



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_GENERATIONPARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

