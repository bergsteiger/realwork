////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/ParamsHelper/ParamConvert.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Core::ParamsHelper::ParamConvert
//
// ����� ��������� ������� ��� ����������� ������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"
// by <<uses>> dependencies
#include "ace/ARGV.h"

//#UC START# *4833E32102FC_CUSTOM_INCLUDES*
//#UC END# *4833E32102FC_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *4833E32102FC*
ParamArgs ParamConvert::make_arg_list (int argc, char** argv) {
	ParamArgs ret;
	for (int i = 0; i < argc; i++) {
		ret.push_back (argv[i]);
	}
	return ret;
}
//#UC END# *4833E32102FC*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// �� ������ ���������� ���� ParamArgs ��������� ������ � ���� ACE_ARGV
ACE_ARGV* ParamConvert::make_ace_argv (const ParamArgs& args) {
	//#UC START# *4833E3E80346*
	//!!!
	//����� ����� ret ������ ���� �� ������, ��� ����� ����� args
	//�.� ret ������ � ���� ����� �� ������ � args
	Core::Aptr<ACE_ARGV> ret = new ACE_ARGV ();
	for (Core::ParamArgs::const_iterator it = args.begin (); it != args.end (); ++it) {
		ret->add (it->c_str ());
	}

	return ret.forget ();
	//#UC END# *4833E3E80346*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

