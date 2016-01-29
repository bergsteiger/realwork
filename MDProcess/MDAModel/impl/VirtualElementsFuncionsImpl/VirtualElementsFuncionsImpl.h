////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::VirtualElementsFuncionsImpl
//
// пакет функций для работы с виртуальными элементами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

//forward decl
class AbstractDumper;

namespace VirtualElementsFuncionsImpl {

class AddDependencyLocal;
typedef ::Core::Var<AddDependencyLocal> AddDependencyLocal_var;
typedef ::Core::Var<const AddDependencyLocal> AddDependencyLocal_cvar;
// - локальный интерфейс для операции добавлении зависимости
class AddDependencyLocal
	: virtual public TemplateFunctions::InternalStereotypeFunction
{
public:
	// создает зависимость между элементами (НЕ классами)
	virtual void create_dep_for_others (const AbstractDumper* source, const AbstractDumper* target) const = 0;
};

/// factory interface for AddDependencyLocal
class AddDependencyLocalFactory {
public:
	static AddDependencyLocal& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
public:
	// получить экземпляр функции
	static AddDependencyLocal& make (const std::string& key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

} //namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

