////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/StateMachine/NewStateMachineImpl.java"
// генератор реализации фабрик интерфейсов на java (.java)
// Generated from UML model, root element: <<StateMachine::Class>> TestModel::BasicTests::StateMachine::NewStateMachine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.StateMachine;

import java.util.Arrays;
import ru.garant.shared.FSM.BaseEvent;
import ru.garant.shared.FSM.BaseStateMachine;
import ru.garant.shared.FSM.BaseState.AccessibleData;
import ru.garant.shared.FSM.IContext;
import ru.garant.TestModel.BasicTests.StateMachine.sm.NewStateMachine.*;

public class NewStateMachineImpl
	extends BaseStateMachine
	implements NewStateMachine
{
	//callback-interface
	public interface NewStateMachineComm extends IContext {
		//validation states methods and preEnter/preExit actions

		public void validateStart () throws ru.garant.shared.FSM.ValidationFailed;
		
		public void preEnterActionStart (final BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed;
		
		public void preExitActionStart (final BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed;

		public void validateNewState () throws ru.garant.shared.FSM.ValidationFailed;
		
		public void preEnterActionNewState (final BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed;
		
		public void preExitActionNewState (final BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed;

		public void validateEnd () throws ru.garant.shared.FSM.ValidationFailed;
		
		public void preEnterActionEnd (final BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed;
		
		public void preExitActionEnd (final BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed;


	}

	public NewStateMachineImpl (NewStateMachineComm comm) {
		this.registerComm (comm);
	}

	public void executeTransitionAction (
		final String actionId
		, final BaseEvent event
	) {
		if (getComm () != null) {
			getComm ().executeTransitionAction (actionId, event);
		}
	}

	public boolean executeTransitionGuard (final String guradId) {
		if (getComm () != null) {
			return comm_.executeTransitionGuard (guradId);
		}
		return false;
	}
	
	public void executeSave () throws ru.garant.shared.FSM.SaveFailed {
		if (getComm () != null) {
			getComm ().executeSave ();
		}
	}

	protected void init () {

		NewStateMachine.end evend = new NewStateMachine.end ();

		Start stStart = new Start ();

		NewState stNewState = new NewState ();

		End stEnd = new End ();

		stStart.addGuardedTransition (stNewState, null, null, null);

		stNewState.addTriggedTransition (stEnd, evend, null, null);

		this.add (stStart);

		this.add (stNewState);

		this.add (stEnd);

	}

	//validation states methods and preEnter/preExit actions
	public void validateStart () throws ru.garant.shared.FSM.ValidationFailed {
		if (getComm () != null) {
			getComm ().validateStart ();
		}
	}
	
	public void preEnterActionStart (final BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed {
		if (getComm () != null) {
			getComm ().preEnterActionStart (event);
		}
	}
	
	public void preExitActionStart (final BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed {
		if (getComm () != null) {
			getComm ().preExitActionStart (event);
		}
	}
	
	public void validateNewState () throws ru.garant.shared.FSM.ValidationFailed {
		if (getComm () != null) {
			getComm ().validateNewState ();
		}
	}
	
	public void preEnterActionNewState (final BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed {
		if (getComm () != null) {
			getComm ().preEnterActionNewState (event);
		}
	}
	
	public void preExitActionNewState (final BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed {
		if (getComm () != null) {
			getComm ().preExitActionNewState (event);
		}
	}
	
	public void validateEnd () throws ru.garant.shared.FSM.ValidationFailed {
		if (getComm () != null) {
			getComm ().validateEnd ();
		}
	}
	
	public void preEnterActionEnd (final BaseEvent event) throws ru.garant.shared.FSM.PreEnterFailed {
		if (getComm () != null) {
			getComm ().preEnterActionEnd (event);
		}
	}
	
	public void preExitActionEnd (final BaseEvent event) throws ru.garant.shared.FSM.PreExitFailed {
		if (getComm () != null) {
			getComm ().preExitActionEnd (event);
		}
	}
	
	protected NewStateMachineComm getComm () {
		return comm_;
	}
	
	final public void registerComm (NewStateMachineComm comm) {
		comm_ = comm;
	}

	final public void unregisterComm () {
		comm_ = null;
	}

	private NewStateMachineComm comm_ = null;

} //class NewStateMachineImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
