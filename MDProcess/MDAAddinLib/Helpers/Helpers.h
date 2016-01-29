////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Helpers/Helpers.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Helpers
//
// набор вспомогательных интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERS_H__
#define __MDPROCESS_MDAADDINLIB_HELPERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <vector>
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/GCL/data/std_defs.h"

namespace Helpers {

// мапа дла хранения частоты использования стереотипа
typedef std::map < AbstractDumperBase::StereotypeID, unsigned long > StereotypeUseMap;

// список стереотипов
typedef std::vector < AbstractDumperBase::StereotypeID > StereotypeList;

class StereotypeManager;
typedef ::Core::Var<StereotypeManager> StereotypeManager_var;
typedef ::Core::Var<const StereotypeManager> StereotypeManager_cvar;
// вспомагетльный интерфейс для работы со стереотипами элементов
class StereotypeManager
	: virtual public ::Core::IObject
{
public:
	// формирует мапу частоты использования стереотипов внутри заданного элемента
	virtual StereotypeUseMap* make_use_map (IRoseElementPtr elem) const = 0;

	// Формирует список стереотипов элементов, разрешённых создавать в заданном элементе.
	// Результирующий список отсортирован по частоте использования стереотипов внутри пакета!
	virtual StereotypeList* make_allowable_stereotypes (IRoseElementPtr elem, IRoseElementPtr context) const = 0;
};

/// factory interface for StereotypeManager
class StereotypeManagerFactory {
public:
	// фабрика для получения экземпляра интерфейса
	static StereotypeManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class KViewElement;
typedef ::Core::Var<KViewElement> KViewElement_var;
typedef ::Core::Var<const KViewElement> KViewElement_cvar;
// вспомогательный интерфейс для открытия описания элемента в К
class KViewElement
	: virtual public ::Core::IObject
{
public:
	// показывает описание элемента в К
	virtual void view (IRoseElementPtr elem) const = 0;

	// формирует ссылку для открытия описания элемента в К
	virtual const std::string make_view_link (IRoseElementPtr elem) const = 0;
};

/// factory interface for KViewElement
class KViewElementFactory {
public:
	// возвращает экземпляр
	static KViewElement& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// элемент результата отчета
struct ReportResultItem {
	// дополнительные сообщения
	GCL::StrVector messages;
	// элемент
	const RoseAbstractDumper* element;
};

#pragma pack (pop)

// результат отчета
typedef std::vector < ReportResultItem > ReportResult;

class ReportBuilder;
typedef ::Core::Var<ReportBuilder> ReportBuilder_var;
typedef ::Core::Var<const ReportBuilder> ReportBuilder_cvar;
// "Построитель" отчета. Отчет - это шаблон, который применяется к элементам, если результат
// выполенеия этого шаблона true - элемент, к которому он применялся попадает в результирующий
// список вместе с описанием этого отчета
class ReportBuilder
	: virtual public ::Core::IObject
{
public:
	// выполняет шаблон отчета к элементу и всем его детям
	virtual ReportResult* build (
		const RoseAbstractDumper* from
		, const AbstractDumperBase::ReportsTreeItem* report
	) const = 0;
};

/// factory interface for ReportBuilder
class ReportBuilderFactory {
public:
	// фабрика
	static ReportBuilder* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Helpers

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Helpers::StereotypeManager> {
	typedef Helpers::StereotypeManagerFactory Factory;
};
template <>
struct TypeTraits <Helpers::KViewElement> {
	typedef Helpers::KViewElementFactory Factory;
};
template <>
struct TypeTraits <Helpers::ReportBuilder> {
	typedef Helpers::ReportBuilderFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAADDINLIB_HELPERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
