////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataDef::Category>> MDProcess::MDAFormat::ModelPartDef
//
// �������� ����������� ����� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ������ ���������������� �������
typedef std::vector < Core::Box<UserProperty> > UserPropertyList;

// ���� ��� ������������
typedef std::vector < Core::Box<Dependency> > DependencyList;

// ��� ���������
enum VisibilityType {
	VT_PUBLIC
	, VT_PROTECTED
	, VT_PRIVATE
	, VT_IMPLEMENTED
};

// ���� �������������
enum AbstractionType {
	AT_REGULAR
	, AT_ABSTRACT
	, AT_FINAL
};

// ���� ������
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

// ������ ����������
typedef std::vector < Core::Box<OperationArgument> > ArgumentList;

// ���� ��� ������������
typedef std::vector < std::string > StringList;

// ������ ���������
typedef std::vector < Core::Box<Attribute> > AttributeList;

// ������ ��������
typedef std::vector < Core::Box<Operation> > OperationList;

// ��� ���������
enum StateType {
	ST_NORMAL
	, ST_FINAL
	, ST_START
};

// ��� ��������
enum ActionType {
	AT_ENTRY
	, AT_EXIT
	, AT_DO
};

// ���� ��� ������������
typedef std::vector < Core::Box<StateAction> > StateActionList;

// ���� ��� ������������
typedef std::vector < Core::Box<Transition> > TransitionList;



// ���� ��� ������������
typedef std::vector < Core::Box<State> > StateList;

// ���� ��� ������������
typedef std::vector < Core::Box<SelfMessage> > SelfMessageList;

// ���� ��� ������������
typedef std::vector < Core::Box<ReturnMessage> > ReturnMessageList;

// ���� ��� ������������
typedef std::vector < Core::Box<Message> > MessageList;

// ���� ��� ������������
typedef std::vector < Core::Box<SequenceStartObject> > SequenceStartObjectList;

// ���� ��� ������������
typedef std::vector < Core::Box<Class> > ClassList;

// ���� ��� ������������
typedef std::vector < Core::Box<Package> > PackageList;

// ���� ��� ������������
typedef std::vector < Core::Box<Namespace> > NamespaceList;

} //namespace ModelPartDef
} // namespace MDAFormat


#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

