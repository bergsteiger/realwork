////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/NewServerLibrary/LibHomeFactory.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::NewServerLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.NewServerLibrary;

import ru.garant.shared.Core.Logs;
import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;
import ru.garant.shared.CoreSrv.Root_i.CorbaLibHomeBase;

public class LibHomeFactory {
	public static ru.garant.shared.CoreSrv.Root.CorbaLibHome get () {
		return LibHomeImpl.getInstace ();
	}
	
	private static class LibHomeImpl extends ru.garant.shared.CoreSrv.Root_i.CorbaLibHomeBase {
	
		private static ru.garant.shared.CoreSrv.Root.CorbaLibHome getInstace () {
			return sInstance_;
		}
		
		public void publishAllServersFactories () {
		}
	
		private LibHomeImpl () {
		}
	
		public void registrateAllFactories () {
			//#UC START# *49AECD640165_ENVIRONMENTS_CONFIG*
			//#UC END# *49AECD640165_ENVIRONMENTS_CONFIG*

		}
	
		public void finalize () {
		}
	
		private static LibHomeImpl sInstance_ = new LibHomeImpl ();
	
	} // class LibHomeImpl
} // class LibHomeFactory
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
