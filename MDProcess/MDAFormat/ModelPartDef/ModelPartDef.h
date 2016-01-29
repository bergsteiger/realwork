////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataDef::Category>> MDProcess::MDAFormat::ModelPartDef
//
// ќписани€ структурной части формата
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>

//forward decl
namespace MDAFormat {
namespace ModelPartDef {
	class UserProperty;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Dependency;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Package;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Class;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Operation;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class OperationArgument;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Attribute;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class State;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class StateAction;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Transition;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class SelfMessage;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class ReturnMessage;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Message;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class SequenceStartObject;
} // namespace ModelPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace ModelPartDef {
	class Namespace;
} // namespace ModelPartDef
} // namespace MDAFormat


namespace MDAFormat {
namespace ModelPartDef {

// список пользовательских свойств
typedef std::vector < Core::Box<UserProperty> > UserPropertyList;

// пока нет документации
typedef std::vector < Core::Box<Dependency> > DependencyList;

// тип видимости
enum VisibilityType {
	VT_PUBLIC
	, VT_PROTECTED
	, VT_PRIVATE
	, VT_IMPLEMENTED
};

// типы абстрактности
enum AbstractionType {
	AT_REGULAR
	, AT_ABSTRACT
	, AT_FINAL
};

// типы св€зей
enum LinkType {
	LT_AGREGATION
	, LT_REFERENCE
	, LT_LINK
};

// in/inout/out
enum ArgumentQualifier {
	AQ_IN
	, AQ_INOUT
	, AQ_OUT
};

// список аргументов
typedef std::vector < Core::Box<OperationArgument> > ArgumentList;

// пока нет документации
typedef std::vector < std::string > StringList;

// список атрибутов
typedef std::vector < Core::Box<Attribute> > AttributeList;

// список операций
typedef std::vector < Core::Box<Operation> > OperationList;

// тип состо€ни€
enum StateType {
	ST_NORMAL
	, ST_FINAL
	, ST_START
};

// тип действи€
enum ActionType {
	AT_ENTRY
	, AT_EXIT
	, AT_DO
};

// пока нет документации
typedef std::vector < Core::Box<StateAction> > StateActionList;

// пока нет документации
typedef std::vector < Core::Box<Transition> > TransitionList;



// пока нет документации
typedef std::vector < Core::Box<State> > StateList;

// пока нет документации
typedef std::vector < Core::Box<SelfMessage> > SelfMessageList;

// пока нет документации
typedef std::vector < Core::Box<ReturnMessage> > ReturnMessageList;

// пока нет документации
typedef std::vector < Core::Box<Message> > MessageList;

// пока нет документации
typedef std::vector < Core::Box<SequenceStartObject> > SequenceStartObjectList;

// пока нет документации
typedef std::vector < Core::Box<Class> > ClassList;

// пока нет документации
typedef std::vector < Core::Box<Package> > PackageList;

// пока нет документации
typedef std::vector < Core::Box<Namespace> > NamespaceList;

} //namespace ModelPartDef
} // namespace MDAFormat


#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

