////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewLibExecutor.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<LibExecutor::Class>> TestModel::BasicTests::NewLibSupport::NewLibExecutor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

package ru.garant.TestModel.BasicTests;

import ru.garant.shared.Core.Logs;

public class NewLibExecutor
	extends ru.garant.shared.Core.Root_i.ExecutorBase
{

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
	static class Singleton {
		private static NewLibExecutor INSTANCE = null;

		public static NewLibExecutor instance () {
			if (INSTANCE == null) {
				INSTANCE = new NewLibExecutor ();
			}
			return INSTANCE;
		}
	}

	static ru.garant.shared.Core.Root.Executor get () {
		return Singleton.instance();
	}


	protected void executeImpl () {
		try {
			//#UC START# *49AEE40E0291*
			System.out.println ("Hello world, this is NewLibExecutor!");
			//#UC END# *49AEE40E0291*
			super.executeImpl ();
		} catch (java.lang.Throwable ex) {
			this.setCurrentStatus (ru.garant.shared.Core.Root.ExecutorStatus.ES_ERROR);
			Logs.LOG_SEX(ex);
		}
	}

	protected void finalize () {
		//#UC START# *49AEE40E0291_FINI*
		//#UC END# *49AEE40E0291_FINI*
	}

}; // class NewLibExecutor
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
