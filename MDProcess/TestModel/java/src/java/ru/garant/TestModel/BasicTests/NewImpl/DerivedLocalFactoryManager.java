////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewImpl/DerivedLocalFactoryManager.java"
// генератор реализации фабрик интерфейсов на java (.java)
// Generated from UML model, root element: <<LocalInterface::Class>> TestModel::BasicTests::NewImpl::DerivedLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.NewImpl;

import ru.garant.shared.Core.Logs;

import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;

import ru.garant.TestModel.BasicTests.LibHomeFactory;

////////////////////////////////////////////////////////////////////////////////////
/// factory manager for DerivedLocal
public class DerivedLocalFactoryManager {

	// abstract factory for DerivedLocal
	public interface DerivedLocalAbstractFactory
		extends ru.garant.TestModel.BasicTests.NewInterfaces.DerivedInterfaceFactoryManager.DerivedInterfaceAbstractFactory
	{
	} //DerivedLocalAbstractFactory
	
	private static class FactoryData {
		public FactoryData (DerivedLocalAbstractFactory factory, short priority) {
			factory_ = factory;
			priority_ = priority;
		}
		
		public DerivedLocalAbstractFactory factory_;
		public short priority_;
	}
	private java.util.Map<String, FactoryData> factoriesMap_ = new java.util.TreeMap<String, FactoryData> ();
	private DerivedLocalAbstractFactory singleActiveFactory_ = null;
	private short singleActiveFactoryPriority_ = 0;
	private static DerivedLocalFactoryManager sInstance_ = null;
	private boolean hasRegistredFactories_ = false;

	public static DerivedLocalFactoryManager getInstanceDoNotCallByHand () {
		if (sInstance_ == null) {
			sInstance_ = new DerivedLocalFactoryManager ();
		}
		return sInstance_;
	}

	public static void registerFactory (DerivedLocalAbstractFactory factory, short priority) throws DuplicatedFactoryKey {
		DerivedLocalFactoryManager.getInstanceDoNotCallByHand().registerFactoryImpl (factory, priority);
		ru.garant.TestModel.BasicTests.NewInterfaces.DerivedInterfaceFactoryManager.registerFactory (factory, priority);
		
	}


	protected void registerFactoryImpl (DerivedLocalAbstractFactory factory, short priority) throws DuplicatedFactoryKey {
		hasRegistredFactories_ = true;
		FactoryData factoryData = factoriesMap_.get(factory.key());
		if (factoryData != null && factoryData.priority_ == priority) {
			throw new DuplicatedFactoryKey ("BasicTests.NewImpl.DerivedLocalFactory ", factory.key().toString ());
		}
		if (factoryData == null || factoryData.priority_ <= priority) {
			factoriesMap_.put(factory.key(), new FactoryData (factory, priority));
		}
		if (singleActiveFactory_ == null || singleActiveFactoryPriority_ <= priority) {
			singleActiveFactory_ = factory;
			singleActiveFactoryPriority_ = priority;
		}
	}

	private DerivedLocalFactoryManager () {
	}

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

