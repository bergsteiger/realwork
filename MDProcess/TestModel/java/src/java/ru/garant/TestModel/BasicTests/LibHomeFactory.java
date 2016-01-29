////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/LibHomeFactory.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<Library::Category>> TestModel::BasicTests
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests;

import ru.garant.shared.Core.Logs;
import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;
import ru.garant.shared.Core.Root_i.StdLibHomeBase;

public class LibHomeFactory {
	public static ru.garant.shared.Core.Root.LibHome get () {
		return LibHomeImpl.getInstace ();
	}
	
	private static class LibHomeImpl extends ru.garant.shared.Core.Root_i.StdLibHomeBase {
	
		private static ru.garant.shared.Core.Root.LibHome getInstace () {
			return sInstance_;
		}
	
		private LibHomeImpl () {
			this.getExecutors ().add(ru.garant.TestModel.BasicTests.NewLibExecutor.get());
		}
	
		public void registrateAllFactories () {
			//#UC START# *49AED1C602F9_ENVIRONMENTS_CONFIG*
			//#UC END# *49AED1C602F9_ENVIRONMENTS_CONFIG*

			try {
				ru.garant.TestModel.BasicTests.NewImpl.NoDefFactoryServantFactoryImpl fctr = new ru.garant.TestModel.BasicTests.NewImpl.NoDefFactoryServantFactoryImpl ();
				fctr.registrateMe((short)0);
			} catch (DuplicatedFactoryKey ex) {
				Logs.LOG_SEX (ex);
			}

			try {
				ru.garant.TestModel.BasicTests.NewImpl.NewServantFactoryImpl fctr = new ru.garant.TestModel.BasicTests.NewImpl.NewServantFactoryImpl ();
				fctr.registrateMe((short)0);
			} catch (DuplicatedFactoryKey ex) {
				Logs.LOG_SEX (ex);
			}

		}
	
		public void finalize () {
		}
	
		private static LibHomeImpl sInstance_ = new LibHomeImpl ();
	
	} // class LibHomeImpl
} // class LibHomeFactory
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
