////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewInterfaces/DerivedInterface.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<Interface::Class>> TestModel::BasicTests::NewInterfaces::DerivedInterface
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.NewInterfaces;

import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;

public interface DerivedInterface
	extends BaseInterface
{

	public void myFunc (final java.util.List<Long> a);

	/// factory interface for DerivedInterface
	public static class Factory {

		public static DerivedInterface factory () throws NoActiveFactory {
			return DerivedInterfaceFactoryManager.getInstanceDoNotCallByHand ().factory ();
		}

	}// factory interface for DerivedInterface
} //interface DerivedInterface
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
