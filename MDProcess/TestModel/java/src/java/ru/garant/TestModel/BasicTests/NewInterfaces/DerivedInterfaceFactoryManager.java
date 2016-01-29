////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewInterfaces/DerivedInterfaceFactoryManager.java"
// генератор реализации фабрик интерфейсов на java (.java)
// Generated from UML model, root element: <<Interface::Class>> TestModel::BasicTests::NewInterfaces::DerivedInterface
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.NewInterfaces;

import ru.garant.shared.Core.Logs;

import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;

import ru.garant.TestModel.BasicTests.LibHomeFactory;

////////////////////////////////////////////////////////////////////////////////////
/// factory manager for DerivedInterface
public class DerivedInterfaceFactoryManager {

	// abstract factory for DerivedInterface
	public interface DerivedInterfaceAbstractFactory {
		public String key ();

		public ru.garant.TestModel.BasicTests.NewInterfaces.DerivedInterface factory ();
	} //DerivedInterfaceAbstractFactory
	
	private static class FactoryData {
		public FactoryData (DerivedInterfaceAbstractFactory factory, short priority) {
			factory_ = factory;
			priority_ = priority;
		}
		
		public DerivedInterfaceAbstractFactory factory_;
		public short priority_;
	}
	private java.util.Map<String, FactoryData> factoriesMap_ = new java.util.TreeMap<String, FactoryData> ();
	private DerivedInterfaceAbstractFactory singleActiveFactory_ = null;
	private short singleActiveFactoryPriority_ = 0;
	private static DerivedInterfaceFactoryManager sInstance_ = null;
	private boolean hasRegistredFactories_ = false;

	public static DerivedInterfaceFactoryManager getInstanceDoNotCallByHand () {
		if (sInstance_ == null) {
			sInstance_ = new DerivedInterfaceFactoryManager ();
		}
		return sInstance_;
	}

	public static void registerFactory (DerivedInterfaceAbstractFactory factory, short priority) throws DuplicatedFactoryKey {
		DerivedInterfaceFactoryManager.getInstanceDoNotCallByHand().registerFactoryImpl (factory, priority);
	}


	protected void registerFactoryImpl (DerivedInterfaceAbstractFactory factory, short priority) throws DuplicatedFactoryKey {
		hasRegistredFactories_ = true;
		FactoryData factoryData = factoriesMap_.get(factory.key());
		if (factoryData != null && factoryData.priority_ == priority) {
			throw new DuplicatedFactoryKey ("BasicTests.NewInterfaces.DerivedInterfaceFactory ", factory.key().toString ());
		}
		if (factoryData == null || factoryData.priority_ <= priority) {
			factoriesMap_.put(factory.key(), new FactoryData (factory, priority));
		}
		if (singleActiveFactory_ == null || singleActiveFactoryPriority_ <= priority) {
			singleActiveFactory_ = factory;
			singleActiveFactoryPriority_ = priority;
		}
	}

	private DerivedInterfaceFactoryManager () {
	}

	public ru.garant.TestModel.BasicTests.NewInterfaces.DerivedInterface factory () throws NoActiveFactory {
		if (singleActiveFactory_ == null) {
			throw new NoActiveFactory ("BasicTests.NewInterfaces.DerivedInterfaceFactory");
		}
		return singleActiveFactory_.factory ();
	}

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

