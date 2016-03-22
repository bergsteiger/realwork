////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/InvbAlgorithm_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::InvbAlgorithm_i
// Заголовок реализации класса серванта для интерфеса IBlocksAlgorithm
//
// Имплементация для невидимых блочных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_INVBALGORITHM_I_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_INVBALGORITHM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyUtility.h"
#include "shared/ContextSearch/Defs/Defs.h"

//#UC START# *56C3094B0108_CUSTOM_INCLUDES*
//#UC END# *56C3094B0108_CUSTOM_INCLUDES*

namespace ContextSearch {
namespace Relevancy_i {

class InvbAlgorithm_i; // self forward Var
typedef ::Core::Var<InvbAlgorithm_i> InvbAlgorithm_i_var;
typedef ::Core::Var<const InvbAlgorithm_i> InvbAlgorithm_i_cvar;

class InvbAlgorithm_i_factory;

// Имплементация для невидимых блочных
class InvbAlgorithm_i:
	virtual public Relevancy::IBlocksAlgorithm
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (InvbAlgorithm_i)
	friend class InvbAlgorithm_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InvbAlgorithm_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

	virtual ~InvbAlgorithm_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// вычисление релевантности
	Defs::RelevancyType calculate (const RelevancyUtility::RelevancyProperties& prop);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Relevancy::AlgorithmProperties m_properties;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Relevancy::IBlocksAlgorithm
	// список релевантных фрагментов
	virtual Defs::Fragments* get_fragments (const Relevancy::BlockEntries& data, const Relevancy::DataVector& positions);

	// implemented method from Relevancy::IBlocksAlgorithm
	// расчет релевантности
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Defs::PositionsRel& rel_data
		, const Relevancy::BlockEntries& data
	);

//#UC START# *56C3094B0108*
private:
	enum CheckRes {cr_Valid, cr_Skip, cr_Invalid};

private:
	Relevancy::Positions m_chain;

	Defs::RelevancyParam m_param;

	std::vector <Relevancy::Mark> m_markup;

private:
	Defs::Positions::const_iterator seek (
		size_t pos
		, Defs::Positions::const_iterator beg
		, Defs::Positions::const_iterator end
	);

	CheckRes check (size_t pos, Defs::Position val, Relevancy::Mark type);

	Defs::RelevancyType get (const Defs::PositionsRel& rel_data, bool withZ);

	void calc (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Relevancy::BlockEntry& entry
		, const Defs::PositionsRel& rel_data
		, size_t pos
	);

	void build (
		Defs::Fragments& out
		, const Relevancy::DataVector& positions
		, const Relevancy::BlockEntry& entry
		, size_t pos
	);
//#UC END# *56C3094B0108*
}; // class InvbAlgorithm_i

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_INVBALGORITHM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
