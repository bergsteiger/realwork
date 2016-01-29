//////////////////////////////////////////////////////////////////////////////////////////
// ћодуль: "RelevancyInfo_i.h"

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
	// »ндекс с длинами поисковых запросов
	typedef std::vector <size_t> SizeIndex;

private:
	// расчет релевантности цепочки
	static Defs::RelevancyType get_chain_relevancy (const Defs::RelevancyParam& in);

public:
	RelevancyInfo_i (bool in_detail);

	virtual ~RelevancyInfo_i ();

private:
	// найти элемент в контейнере с информацией о релевантности
	const Defs::DetailInfo::iterator find (unsigned long doc_id);

private:
	bool m_in_detail;

	Defs::Detail m_detail;
	Defs::DetailInfo m_data;

	SizeIndex m_sizes;

protected:
	// implemented method from Defs::IRelevancyInfo
	// добавить запрос
	virtual void add (const std::string& req);

	// implemented method from Defs::IRelevancyInfo
	// добавить документ и его релевантность
	virtual void add (unsigned long doc_id, const Defs::RelevancyInfo& info);

	// implemented method from Defs::IRelevancyInfo
	// добавить базовые параметры в формуле релевантности
	virtual void add (const Defs::RelevancyParam& param, unsigned long pos);

	// implemented method from Defs::IRelevancyInfo
	// добавить значение релевантности дл€ определенного типа
	virtual void add (unsigned long doc_id, Defs::TuneDocType type, short value);

	// implemented method from Defs::IRelevancyInfo
	// очистить кэш
	virtual void clear ();

	// implemented method from Defs::IRelevancyInfo
	// получить информацию о релевантности
	virtual const Defs::DetailInfo& get_info ();
};

#endif //__RELEVANCY_INFO_I_H__
//////////////////////////////////////////////////////////////////////////////////////////
