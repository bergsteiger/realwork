////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewImpl/NoDefFactoryServantFactoryImpl.java"
// генератор реализации фабрик интерфейсов на java (.java)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NoDefFactoryServant
// Заголовок реализации фабрик интерфейса DerivedLocal для серванта NoDefFactoryServant
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

/// Interface-factory implementation for NoDefFactoryServant
public final class NoDefFactoryServantFactoryImpl implements ru.garant.TestModel.BasicTests.NewImpl.DerivedLocalFactoryManager.DerivedLocalAbstractFactory
{

	public NoDefFactoryServantFactoryImpl () {
	}

	public final void registrateMe (short priority) throws DuplicatedFactoryKey {
		ru.garant.TestModel.BasicTests.NewImpl.DerivedLocalFactoryManager.registerFactory (this, priority);

	}

	public final String key () {
		return "NoDefFactoryServant";
	}

	public final ru.garant.TestModel.BasicTests.NewInterfaces.DerivedInterface factory () {
		//#UC START# *49B93A3403B049AEE4B5036E_49B93A3403B0_IMPL*
		//#UC END# *49B93A3403B049AEE4B5036E_49B93A3403B0_IMPL*
	}

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

