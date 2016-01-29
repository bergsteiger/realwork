////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/StateMachine/sm/NewStateMachine/NewState.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<StateMachine::Class::StateMachine::State>> TestModel::BasicTests::StateMachine::NewStateMachine::StateModel::NewState
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.StateMachine.sm.NewStateMachine;

import ru.garant.shared.Core.Logs;
import ru.garant.shared.GCI.I18N.Messages;
import ru.garant.TestModel.BasicTests.StateMachine.NewStateMachineImpl;

public class NewState extends ru.garant.shared.FSM.BaseState {

	public NewState () {
		//#UC START# *49B940B00191_CTOR_NEWSTATE*
		//#UC END# *49B940B00191_CTOR_NEWSTATE*
	}
	
	public String getName () {
		return Messages.Factory.messages ().get (
			"TestModel.BasicTests.StateMachine.NewStateMachine.StateModel.NewState"
		);
	}
	
	public void validate () throws ru.garant.shared.FSM.ValidationFailed {
		NewStateMachineImpl context = (NewStateMachineImpl)this.getContext ();
		context.validateNewState ();
	}
	
	public void preEnterAction (final ru.garant.shared.FSM.BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed {
		NewStateMachineImpl context = (NewStateMachineImpl)this.getContext ();
		context.preEnterActionNewState (event);
	}
	
	public void preExitAction (final ru.garant.shared.FSM.BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed {
		NewStateMachineImpl context = (NewStateMachineImpl)this.getContext ();
		context.preExitActionNewState (event);
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
