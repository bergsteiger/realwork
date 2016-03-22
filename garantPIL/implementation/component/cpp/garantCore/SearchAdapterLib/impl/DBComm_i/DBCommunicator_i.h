////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::DBCommunicator_i
//
// ���������� ���������� ������������ � ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DBCOMMUNICATOR_I_H__
#define __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DBCOMMUNICATOR_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/DB/DBCore/DBCore.h"

namespace SearchAdapterLib {
namespace DBComm_i {

// ���������� ���������� ������������ � ����������
class DBCommunicator_i;
typedef Core::Var<DBCommunicator_i> DBCommunicator_i_var;
typedef Core::Var<const DBCommunicator_i> DBCommunicator_i_cvar;

class DBCommunicator_i :
	virtual public ContextSearch::DBComm::IDBCommunicator
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DBCommunicator_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ���� ��� ���������
	struct SynKey {
		// ��������
		std::string key;
		// ���������� �����
		size_t i;
		//#UC START# *535A2A490135*
		bool operator < (const SynKey& val) const {
			if (key.size () == val.key.size ()) {
				return key [0] < val.key [0];
			}
			return key.size () > val.key.size ();
		}
		//#UC END# *535A2A490135*
	};

	// ������ ������������ ������
	typedef std::vector < SynKey > SynKeys;

	// ������ �������� ���������
	typedef std::vector < GCL::StrVector > SynValues;

	// ������� ��������� ������������ ��������
	struct PatternCompare : public std::binary_function<SynKey, SynKey, bool> {
		bool operator () (const SynKey& first_param_, const SynKey& second_param_) const;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ������������� ������� �����
	static void init_str_vector (const char* buf, size_t size, GCL::StrVector& out);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit DBCommunicator_i (DBCore::IBase* base);

public:
	virtual ~DBCommunicator_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ����
	void dump ();

	// �������� ���������
	void init_syns (const char* buf, size_t size, SynKeys& keys, SynValues& data);

	// �������� �������� ������ ����
	void load_PSD_templates (DBCore::IIndex* index);

	// �������� ���� ������, ����������� � �������� �� ���������� ������
	void load_blocks_lengths (DBCore::IIndex* index);

	// �������� ����-���� � ����-����
	void load_exclude_data (DBCore::IIndex* index);

	// �������� ������� ����
	void load_hard_phrases (DBCore::IIndex* index);

	// �������� ������� ��� ��������� �������
	void load_invb_index (DBCore::IIndex* index);

	// �������� �������� ������������� ��� �������� ���������� ������
	void load_invisible_rel (DBCore::IIndex* index);

	// �������� ������� ���������� �����
	void load_phrasal_replacement (DBCore::IIndex* index);

	// �������� ����������� ���������
	void load_ssyns (DBCore::IIndex* index);

	// �������� ���������
	void load_syns (DBCore::IIndex* index);

	// �������� ������ ��� ��������� ����������� �������� �������������
	void load_tune_data (DBCore::IIndex* index);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCL::StrVector m_excluded;

	GCL::StrVector m_hard_phrases;

	ContextSearch::DBComm::InvisibleDataIndex m_invb_index;

	ContextSearch::Defs::InvisibleBlocks m_invisible_blocks;

	ContextSearch::Defs::InvisibleRel m_invisible_rel;

	ContextSearch::DBComm::StrPairVector m_phrasal_pair;

	ContextSearch::DBComm::Synonyms m_ssyns;

	ContextSearch::DBComm::Synonyms m_syns;

	DBCore::PSDTemplates m_templates;

	ContextSearch::DBComm::Synonyms m_templates_syns;

	DBCore::RelTuneData m_tune_data;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ����-����� � ����-�����
	virtual const GCL::StrVector& get_exclude_data () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ���������� ��������������
	virtual const GCL::StrVector& get_hard_phrases () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ������ � ���������� ��������
	virtual const ContextSearch::DBComm::InvisibleDataIndex& get_invb_index () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ����� ������ ����������� � �������� �� ���������� ������
	virtual const ContextSearch::Defs::InvisibleBlocks& get_invisible_blocks () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// "����� �������������" ��� ������� �� �������� ���������� ������ ���������
	virtual const ContextSearch::Defs::InvisibleRel& get_invisible_rel () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ���������� ������
	virtual const ContextSearch::DBComm::StrPairVector& get_phrasal_replacement () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ����������� ��������
	virtual const ContextSearch::DBComm::Synonyms& get_ssyns () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ��������
	virtual const ContextSearch::DBComm::Synonyms& get_syns () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ������� ����������� ������
	virtual const DBCore::PSDTemplates& get_templates () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ��������� ��������
	virtual const ContextSearch::DBComm::Synonyms& get_templates_syns () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// ������ ��� ��������� ����������� �������� �������������
	virtual const DBCore::RelTuneData& get_tune_data () const;
}; // class DBCommunicator_i

} // namespace DBComm_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DBCOMMUNICATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

