////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/NewTestLibrary/LibHomeFactory.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<TestLibrary::Category>> TestModel::NewTestLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.NewTestLibrary;

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
		}
	
		public void registrateAllFactories () {
			//#UC START# *49AECD6F03D5_ENVIRONMENTS_CONFIG*
			//#UC END# *49AECD6F03D5_ENVIRONMENTS_CONFIG*

		}
	
		public void finalize () {
		}
	
		private static LibHomeImpl sInstance_ = new LibHomeImpl ();
	
	} // class LibHomeImpl
} // class LibHomeFactory
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
