////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/impl/ParamsImpl/ParamManagerImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::ParamsImpl::ParamManagerImpl
// ��������� ���������� ������ �������� ��� ��������� ParamManager
//
// ���������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_H__
#define __SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_H__

#include "ace/ACE.h"
#include <map>
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsCore/ParamsCore.h"

namespace Core {
namespace ParamsImpl {

class ParamManagerImpl; // self forward Var
typedef ::Core::Var<ParamManagerImpl> ParamManagerImpl_var;
typedef ::Core::Var<const ParamManagerImpl> ParamManagerImpl_cvar;

class ParamManagerImpl_factory;

// ���������� ���������
class ParamManagerImpl:
	virtual public ParamManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ParamManagerImpl)
	friend class ParamManagerImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ������ �������� ��������
	enum ReadFrom {
		COMMAND_LINE // �� ��������� ������
		, REGISTRY // �� �������
		, CONFIG_FILE // �� ����� ������������
		, READ_ONLY_SECTION_IN_CONFIG_FILE // �� RO ������ ����� ��������
		, TEMP // ��������� ����������
	};

	// ���������� � ���������
	struct KeyInfo {
		// �������� ���������
		std::string data;
		// ������, � ������� ��� ������ ��������
		std::string section;
		// ������ �������� ��������
		ReadFrom from;

		// ����������� ��-���������
		KeyInfo ();

		// ����������� ��� ������������� �����
		KeyInfo (const std::string& value, ReadFrom fr, const std::string& sect);
	};

	// ���� �������� ��������� � ���������
	typedef std::map < std::string, KeyInfo > ValuesMap;

	// ���� �������� ��� ������ � ParamManager'��
	static const char* RUN_PARAM; // ��� �����, ������������� ��� �������� ����, ��� ��� ���������� ����� ��������� �����-���� ���������. P.S: ���������� �� ������� ������ ���� �������� ����� ParamManager'�
	static const char* RUN_ARGS; // ��� ���� ��� ������� ���������� ������� ���������� ����������, ������� ����������� ��� ���������� ������. P.S: ����� ����������� �� ������� ����� ��� ��������� ����� � ParamManager'�
	static const char* ADDITIONAL_CONFIG_SECTION_KEY; // ���� � ����������, �������� �� �������� ��������� �� �������������� ������ �� ������� ����� ��������� ���������.
	static const char* CONFIG_SECTION_KEY_TEMPLATE; // ������ ��� ������������ ����� �����, ������������� ������ � ����� ��������.
	static const char* CONFIG_FILE_KEY; // ����, �� �������� �������� ���� � ����� ��������
	static const char* REGISTRY_SECTION_KEY; // ���� �� �������� ������� ������ � �������

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ���� str - ������� ���������� ���������, �� ��� ���������� ��������� ���� ���������� ���������
	static void substitute_environment_variables (std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ParamManagerImpl ();

	ParamManagerImpl (const std::string& args);

	virtual ~ParamManagerImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// "�����������" ������ � �������, ���� � ��� ���� �������
	virtual const std::string convert_string_to_in_quotes (const std::string& str) const;

	// ���������� �������� �� ����� � ������ section ����������������� �����
	virtual const std::string get_key_value (
		const std::string& file
		, const std::string& section
		, const std::string& key
	) const /*throw (
		DataNotCorrect
	)*/;

	// ���������� ����� �� �������� � ���������� �������
	virtual bool is_recognized_param (std::string& key) const;

	// ������ ��������� ������, ������� � ��� ���� ����-�������� � ���������� � ����
	virtual void parse_command_line (const ParamArgs& args);

	// ������ ������ section � ���������������� �����, ������� ���� ����-�������� � ���������� � ����
	virtual void parse_config_file (const std::string& file, const std::string& section) /*throw (DataNotCorrect)*/;

	// ������ ����� �������, �� ����� subkey, ������� ���� ����-�������� � ���������� � ����
	virtual void parse_registry (const std::string& subkey) /*throw (DataNotCorrect)*/;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������� ����������
	ValuesMap m_map;

	// ������ ���������� ��� ������������� ORB'�
	ParamArgs m_orb_init_command_line;

	// ������ ���������� ��� ������������� ���������� Smart Backend
	ParamArgs m_sbe_init_command_line;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ParamManager
	// �������� hardcode �������� ���� long, ������� ����� �������, ������ ���� ������ ��������� ���
	virtual void add_hardcode_long (const char* key, long value);

	// implemented method from ParamManager
	// �������� hardcode �������� ���� string, ������� ����� �������, ������ ���� ������ ��������� ���
	virtual void add_hardcode_string (const char* key, const char* value);

	// implemented method from ParamManager
	// �������� hardcode �������� ���� unsigned long, ������� ����� �������, ������ ���� ������
	// ��������� ���
	virtual void add_hardcode_ulong (const char* key, unsigned long value);

	// implemented method from ParamManager
	// �������� ��������� �������� ���� long - �� �� ����� �������
	virtual void add_long (const char* key, long value);

	// implemented method from ParamManager
	// �������� ��������� �������� ���� string - �� �� ����� �������
	virtual void add_string (const char* key, const char* value);

	// implemented method from ParamManager
	// �������� ��������� �������� ���� unsigned long - �� �� ����� �������
	virtual void add_ulong (const char* key, unsigned long value);

	// implemented method from ParamManager
	// ���������� ������ ���������� ��� ������������� ORB'�
	virtual ParamArgs* command_line_for_orb_init () /*throw (DataNotFound)*/;

	// implemented method from ParamManager
	// ���������� ������ ���������� ��� ���������� SBE (Smart BackEnd)
	virtual ParamArgs* command_line_for_sbe_init ();

	// implemented method from ParamManager
	// �������� �������� ��������� (key) � ���� ������, default_value - �������� �� ���������
	// (������������ � ������, ���� �� ������ �������� key)
	virtual long get_long (const char* key, long default_value = 0) const;

	// implemented method from ParamManager
	// �������� �������� ��������� (key) � ���� ������, default_value - �������� �� ���������
	// (������������ � ������, ���� �� ������ �������� key)
	virtual const std::string get_string (const char* key, const char* default_value = "") const;

	// implemented method from ParamManager
	// �������� �������� ��������� (key) � ���� ������ ��� �����, default_value - �������� ��
	// ��������� (������������ � ������, ���� �� ������ �������� key)
	virtual unsigned long get_ulong (const char* key, unsigned long default_value = 0) const;

	// implemented method from ParamManager
	// ������������� ���������:
	// args - ������ ����������, ���������� ����� ��������� ������
	// init_data -
	virtual int init (
		const ParamArgs& args
		, const ParamManagerInitData& init_data
	) /*throw (
		DataNotFound
		, DataNotCorrect
	)*/;

	// implemented method from ParamManager
	// ���������� true, ���� ������������ �������� key
	virtual bool is_exist (const char* key) const;

	// implemented method from ParamManager
	// ��������� ��������, �� ����� ������� � ������� ��� � ini-�����
	virtual void set_long (const char* key, long value) /*throw (SaveDataFailed)*/;

	// implemented method from ParamManager
	// ��������� ��������, �� ����� ������� � ������� ��� � ini-�����
	virtual void set_string (const char* key, const char* value) /*throw (SaveDataFailed)*/;

	// implemented method from ParamManager
	// ��������� ��������, �� ����� ������� � ������� ��� � ini-�����
	virtual void set_ulong (const char* key, unsigned long value) /*throw (SaveDataFailed)*/;
}; // class ParamManagerImpl

} // namespace ParamsImpl
} // namespace Core


#endif //__SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
