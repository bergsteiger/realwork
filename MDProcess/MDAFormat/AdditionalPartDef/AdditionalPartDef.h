////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataDef::Category>> MDProcess::MDAFormat::AdditionalPartDef
//
// Описание вспомогательной части формата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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

// пока нет документации
typedef std::vector < Core::Box<Property> > PropertyList;

// пока нет документации
typedef std::vector < Core::Box<Attribute> > AttributeList;

// пока нет документации
typedef std::vector < Core::Box<Dependency> > DependencyList;

// пока нет документации
typedef std::vector < Core::Box<Parameter> > ParameterList;

// пока нет документации
typedef std::vector < Core::Box<InheriteView> > InheriteViewList;

// пока нет документации
typedef std::vector < Core::Box<RealizeView> > RealizeViewList;

// пока нет документации
typedef std::vector < Core::Box<AssociationView> > AssociationViewList;

// пока нет документации
typedef std::vector < Core::Box<NoteView> > NoteViewList;

// пока нет документации
typedef std::vector < Core::Box<ClassView> > ClassViewList;

// пока нет документации
typedef std::vector < Core::Box<ParamView> > ParamViewList;

// пока нет документации
typedef std::vector < Core::Box<StereotypeView> > StereotypeViewList;

// пока нет документации
typedef std::vector < Core::Box<StateView> > StateViewList;

// пока нет документации
typedef std::vector < Core::Box<TransitionView> > TransitionViewList;

// пока нет документации
typedef std::vector < Core::Box<ReturnMessage> > ReturnMessageList;

// пока нет документации
typedef std::vector < Core::Box<SelfMessage> > SelfMessageList;

// пока нет документации
typedef std::vector < Core::Box<Message> > MessageList;

// пока нет документации
typedef std::vector < Core::Box<SequenceStartObject> > SequenceStartObjectList;

// пока нет документации
typedef std::vector < Core::Box<ObjectView> > ObjectViewList;

// пока нет документации
typedef std::vector < Core::Box<MessageView> > MessageViewList;

// пока нет документации
typedef std::vector < Core::Box<SelfMessageView> > SelfMessageViewList;

// пока нет документации
typedef std::vector < Core::Box<ReturnMessageView> > ReturnMessageViewList;

// пока нет документации
typedef std::vector < Core::Box<SequenceDiagram> > SequenceDiagramList;

// пока нет документации
typedef std::vector < Core::Box<StateAction> > StateActionList;

// пока нет документации
typedef std::vector < Core::Box<StateDiagram> > StateDiagramList;

// пока нет документации
typedef std::vector < Core::Box<ClassDiagramView> > ClassDiagramViewList;

// пока нет документации
typedef std::vector < Core::Box<SequenceDiagramView> > SequenceDiagramViewList;

// пока нет документации
typedef std::vector < Core::Box<StateDiagramView> > StateDiagramViewList;

// пока нет документации
typedef std::vector < Core::Box<ClassDiagram> > ClassDiagramList;

// пока нет документации
typedef std::vector < Core::Box<Transition> > TransitionList;

// пока нет документации
typedef std::vector < Core::Box<State> > StateList;

// пока нет документации
typedef std::vector < Core::Box<Operation> > OperationList;

// пока нет документации
typedef std::vector < Core::Box<Class> > ClassList;

// пока нет документации
typedef std::vector < Core::Box<Namespace> > NamespaceList;

// пока нет документации
typedef std::vector < Core::Box<Package> > PackageList;

} //namespace AdditionalPartDef
} // namespace MDAFormat


#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

