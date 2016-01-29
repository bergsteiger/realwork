////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/Params/Params.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Params
//
// ����� ��� ������ � ����������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMS_H__
#define __SHARED_CORE_PARAMS_H__

#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/ParamsCore/ParamsCore.h"

namespace Core {

#pragma pack (push, 1)

// ��������� ��� ������������� ���������
struct ParamManagerInitData {
	// ��� ����������
	const char* application_name;
	// ���� �������, ������� ������������ ������� ����������
	const char* registry_subkey;
};

#pragma pack (pop)

class ParamManager;
typedef ::Core::Var<ParamManager> ParamManager_var;
typedef ::Core::Var<const ParamManager> ParamManager_cvar;
// �������� ��� ������ � ����������� ����������, ����������� ����� ��������� ������, ini-���� ���
// ������
class ParamManager
	: virtual public ::Core::IObject
{
public:
	// ������������� ���������:
	// args - ������ ����������, ���������� ����� ��������� ������
	// init_data -
	virtual int init (
		const ParamArgs& args
		, const ParamManagerInitData& init_data
	) /*throw (
		DataNotFound
		, DataNotCorrect
	)*/ = 0;

	// �������� �������� ��������� (key) � ���� ������, default_value - �������� �� ���������
	// (������������ � ������, ���� �� ������ �������� key)
	virtual const std::string get_string (const char* key, const char* default_value = "") const = 0;

	// ��������� ��������, �� ����� ������� � ������� ��� � ini-�����
	virtual void set_string (const char* key, const char* value) /*throw (SaveDataFailed)*/ = 0;

	// �������� �������� ��������� (key) � ���� ������, default_value - �������� �� ���������
	// (������������ � ������, ���� �� ������ �������� key)
	virtual long get_long (const char* key, long default_value = 0) const = 0;

	// ��������� ��������, �� ����� ������� � ������� ��� � ini-�����
	virtual void set_long (const char* key, long value) /*throw (SaveDataFailed)*/ = 0;

	// �������� �������� ��������� (key) � ���� ������ ��� �����, default_value - �������� ��
	// ��������� (������������ � ������, ���� �� ������ �������� key)
	virtual unsigned long get_ulong (const char* key, unsigned long default_value = 0) const = 0;

	// ��������� ��������, �� ����� ������� � ������� ��� � ini-�����
	virtual void set_ulong (const char* key, unsigned long value) /*throw (SaveDataFailed)*/ = 0;

	// ���������� true, ���� ������������ �������� key
	virtual bool is_exist (const char* key) const = 0;

	// �������� ��������� �������� ���� string - �� �� ����� �������
	virtual void add_string (const char* key, const char* value) = 0;

	// �������� ��������� �������� ���� long - �� �� ����� �������
	virtual void add_long (const char* key, long value) = 0;

	// �������� ��������� �������� ���� unsigned long - �� �� ����� �������
	virtual void add_ulong (const char* key, unsigned long value) = 0;

	// �������� hardcode �������� ���� string, ������� ����� �������, ������ ���� ������ ��������� ���
	virtual void add_hardcode_string (const char* key, const char* value) = 0;

	// �������� hardcode �������� ���� long, ������� ����� �������, ������ ���� ������ ��������� ���
	virtual void add_hardcode_long (const char* key, long value) = 0;

	// �������� hardcode �������� ���� unsigned long, ������� ����� �������, ������ ���� ������
	// ��������� ���
	virtual void add_hardcode_ulong (const char* key, unsigned long value) = 0;

	// ���������� ������ ���������� ��� ������������� ORB'�
	virtual ParamArgs* command_line_for_orb_init () /*throw (DataNotFound)*/ = 0;

	// ���������� ������ ���������� ��� ���������� SBE (Smart BackEnd)
	virtual ParamArgs* command_line_for_sbe_init () = 0;
};

/// factory interface for ParamManager
class ParamManagerFactory {
public:
	// �������� ��������
	static ParamManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// args - ������ ����������, ���������� ��������
	// ������� ���������� ��������� ParamManager'�, ��� ���� ����������� ������ ���������� (args), ���
	// ��������� ��������� ������.
	static ParamManager* make (const std::string& args)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Core

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Core::ParamManager> {
	typedef Core::ParamManagerFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORE_PARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
