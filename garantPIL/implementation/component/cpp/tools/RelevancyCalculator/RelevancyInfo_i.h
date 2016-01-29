//////////////////////////////////////////////////////////////////////////////////////////
// ������: "RelevancyInfo_i.h"

#ifndef __RELEVANCY_INFO_I_H__
#define __RELEVANCY_INFO_I_H__

#include <vector>

#include "shared/ContextSearch/Defs/Defs.h"

using namespace ContextSearch;

class RelevancyInfo_i:
	virtual public Defs::IRelevancyInfo
	, virtual public Core::RefCountObjectBase
{
private:
	// ������ � ������� ��������� ��������
	typedef std::vector <size_t> SizeIndex;

private:
	// ������ ������������� �������
	static Defs::RelevancyType get_chain_relevancy (const Defs::RelevancyParam& in);

public:
	RelevancyInfo_i (bool in_detail);

	virtual ~RelevancyInfo_i ();

private:
	// ����� ������� � ���������� � ����������� � �������������
	const Defs::DetailInfo::iterator find (unsigned long doc_id);

private:
	bool m_in_detail;

	Defs::Detail m_detail;
	Defs::DetailInfo m_data;

	SizeIndex m_sizes;

protected:
	// implemented method from Defs::IRelevancyInfo
	// �������� ������
	virtual void add (const std::string& req);

	// implemented method from Defs::IRelevancyInfo
	// �������� �������� � ��� �������������
	virtual void add (unsigned long doc_id, const Defs::RelevancyInfo& info);

	// implemented method from Defs::IRelevancyInfo
	// �������� ������� ��������� � ������� �������������
	virtual void add (const Defs::RelevancyParam& param, unsigned long pos);

	// implemented method from Defs::IRelevancyInfo
	// �������� �������� ������������� ��� ������������� ����
	virtual void add (unsigned long doc_id, Defs::TuneDocType type, short value);

	// implemented method from Defs::IRelevancyInfo
	// �������� ���
	virtual void clear ();

	// implemented method from Defs::IRelevancyInfo
	// �������� ���������� � �������������
	virtual const Defs::DetailInfo& get_info ();
};

#endif //__RELEVANCY_INFO_I_H__
//////////////////////////////////////////////////////////////////////////////////////////
