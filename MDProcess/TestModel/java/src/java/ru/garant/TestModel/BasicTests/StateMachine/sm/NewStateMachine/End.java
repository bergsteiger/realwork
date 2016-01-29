////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/StateMachine/sm/NewStateMachine/End.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<StateMachine::Class::StateMachine::State>> TestModel::BasicTests::StateMachine::NewStateMachine::StateModel::End
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.StateMachine.sm.NewStateMachine;

import ru.garant.shared.Core.Logs;
import ru.garant.shared.GCI.I18N.Messages;
import ru.garant.TestModel.BasicTests.StateMachine.NewStateMachineImpl;

public class End extends ru.garant.shared.FSM.BaseState {

	public End () {
		//#UC START# *49B940B102CA_CTOR_END*
		//#UC END# *49B940B102CA_CTOR_END*
	}
	
	public String getName () {
		return Messages.Factory.messages ().get (
			"TestModel.BasicTests.StateMachine.NewStateMachine.StateModel.End"
		);
	}
	
	public ru.garant.shared.FSM.StateType getType () {
		return ru.garant.shared.FSM.StateType.ST_FINAL;
	}
	
	public void validate () throws ru.garant.shared.FSM.ValidationFailed {
		NewStateMachineImpl context = (NewStateMachineImpl)this.getContext ();
		context.validateEnd ();
	}
	
	public void preEnterAction (final ru.garant.shared.FSM.BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed {
		NewStateMachineImpl context = (NewStateMachineImpl)this.getContext ();
		context.preEnterActionEnd (event);
	}
	
	public void preExitAction (final ru.garant.shared.FSM.BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed {
		NewStateMachineImpl context = (NewStateMachineImpl)this.getContext ();
		context.preExitActionEnd (event);
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
