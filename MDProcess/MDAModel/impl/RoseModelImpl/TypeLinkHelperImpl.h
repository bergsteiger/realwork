////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::TypeLinkHelperImpl
// Заголовок реализации класса серванта для интерфеса TypeLinkHelper
//
// сервант
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class TypeLinkHelperImpl; // self forward Var
typedef ::Core::Var<TypeLinkHelperImpl> TypeLinkHelperImpl_var;
typedef ::Core::Var<const TypeLinkHelperImpl> TypeLinkHelperImpl_cvar;

class TypeLinkHelperImpl_factory;

// сервант
class TypeLinkHelperImpl:
	virtual public TypeLinkHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TypeLinkHelperImpl)
	friend class TypeLinkHelperImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TypeLinkHelperImpl ();

	virtual ~TypeLinkHelperImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from TypeLinkHelper
	// возвращает идентифкатор элемента, с которым связан элемент
	virtual const std::string get_linked (IRoseElementPtr source) const;

	// implemented method from TypeLinkHelper
	// Прописывает в свойства элемента, что он связан с элементом, имеющим гуид target_uid
	virtual void link (IRoseElementPtr source, const std::string& target_uid) const;

	// implemented method from TypeLinkHelper
	// разрывает связь для элемента
	virtual void unlink (IRoseElementPtr source) const;
}; // class TypeLinkHelperImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
