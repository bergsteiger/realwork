////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataDef::Category>> MDProcess::MDAFormat::AdditionalPartDef
//
// �������� ��������������� ����� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"

//forward decl
namespace MDAFormat {
namespace AdditionalPartDef {
	class Package;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Property;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Dependency;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Attribute;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Parameter;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Operation;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class ClassView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class InheriteView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class RealizeView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class AssociationView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class NoteView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class ClassDiagram;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class StateView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class ParamView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class StereotypeView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class TransitionView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class StateDiagram;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class ReturnMessage;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class SelfMessage;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Message;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class SequenceStartObject;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class SequenceDiagram;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class ObjectView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class MessageView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class SelfMessageView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class ReturnMessageView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Class;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class State;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Transition;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class ClassDiagramView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class SequenceDiagramView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class StateDiagramView;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class Namespace;
} // namespace AdditionalPartDef
} // namespace MDAFormat

namespace MDAFormat {
namespace AdditionalPartDef {
	class StateAction;
} // namespace AdditionalPartDef
} // namespace MDAFormat


namespace MDAFormat {
namespace AdditionalPartDef {

// ���� ��� ������������
typedef std::vector < Core::Box<Property> > PropertyList;

// ���� ��� ������������
typedef std::vector < Core::Box<Attribute> > AttributeList;

// ���� ��� ������������
typedef std::vector < Core::Box<Dependency> > DependencyList;

// ���� ��� ������������
typedef std::vector < Core::Box<Parameter> > ParameterList;

// ���� ��� ������������
typedef std::vector < Core::Box<InheriteView> > InheriteViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<RealizeView> > RealizeViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<AssociationView> > AssociationViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<NoteView> > NoteViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<ClassView> > ClassViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<ParamView> > ParamViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<StereotypeView> > StereotypeViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<StateView> > StateViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<TransitionView> > TransitionViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<ReturnMessage> > ReturnMessageList;

// ���� ��� ������������
typedef std::vector < Core::Box<SelfMessage> > SelfMessageList;

// ���� ��� ������������
typedef std::vector < Core::Box<Message> > MessageList;

// ���� ��� ������������
typedef std::vector < Core::Box<SequenceStartObject> > SequenceStartObjectList;

// ���� ��� ������������
typedef std::vector < Core::Box<ObjectView> > ObjectViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<MessageView> > MessageViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<SelfMessageView> > SelfMessageViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<ReturnMessageView> > ReturnMessageViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<SequenceDiagram> > SequenceDiagramList;

// ���� ��� ������������
typedef std::vector < Core::Box<StateAction> > StateActionList;

// ���� ��� ������������
typedef std::vector < Core::Box<StateDiagram> > StateDiagramList;

// ���� ��� ������������
typedef std::vector < Core::Box<ClassDiagramView> > ClassDiagramViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<SequenceDiagramView> > SequenceDiagramViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<StateDiagramView> > StateDiagramViewList;

// ���� ��� ������������
typedef std::vector < Core::Box<ClassDiagram> > ClassDiagramList;

// ���� ��� ������������
typedef std::vector < Core::Box<Transition> > TransitionList;

// ���� ��� ������������
typedef std::vector < Core::Box<State> > StateList;

// ���� ��� ������������
typedef std::vector < Core::Box<Operation> > OperationList;

// ���� ��� ������������
typedef std::vector < Core::Box<Class> > ClassList;

// ���� ��� ������������
typedef std::vector < Core::Box<Namespace> > NamespaceList;

// ���� ��� ������������
typedef std::vector < Core::Box<Package> > PackageList;

} //namespace AdditionalPartDef
} // namespace MDAFormat


#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

