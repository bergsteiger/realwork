////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/SubServerLibrary/ServerLibHomeFactory.java"
// генератор реализации фабрик интерфейсов на java (.java)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::SubServerLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.SubServerLibrary;

import ru.garant.shared.Core.Logs;
import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;
import ru.garant.shared.Core.Root_i.StdLibHomeBase;

public class ServerLibHomeFactory {
	public static ru.garant.shared.Core.Root.LibHome get () {
		return ServerLibHomeImpl.getInstace ();
	}
	
	private static class ServerLibHomeImpl extends ru.garant.shared.Core.Root_i.StdLibHomeBase {
	
		private static ru.garant.shared.Core.Root.LibHome getInstace () {
			return sInstance_;
		}
	
		private ServerLibHomeImpl () {
		this.setRequestedStatus (ru.garant.shared.Core.Root.ExecutorStatus.ES_IDLE);
		}
	
		public void registrateAllFactories () {
			//#UC START# *49AED1DB00DE_ENVIRONMENTS_CONFIG*
			//#UC END# *49AED1DB00DE_ENVIRONMENTS_CONFIG*

		}
	
		public void finalize () {
		}
	
		private static ServerLibHomeImpl sInstance_ = new ServerLibHomeImpl ();
	
	} // class ServerLibHomeImpl
} // class ServerLibHomeFactory
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
