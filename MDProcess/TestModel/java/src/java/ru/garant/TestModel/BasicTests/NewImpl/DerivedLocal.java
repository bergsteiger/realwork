////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewImpl/DerivedLocal.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<LocalInterface::Class>> TestModel::BasicTests::NewImpl::DerivedLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.NewImpl;

import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;
import ru.garant.TestModel.BasicTests.NewInterfaces.*;


public interface DerivedLocal
	extends BaseLocal
		, DerivedInterface
{

	/// factory interface for DerivedLocal
	public static class Factory {

		public static ru.garant.TestModel.BasicTests.NewImpl.DerivedLocal factory () throws NoActiveFactory {
			DerivedInterface ret = DerivedInterfaceFactoryManager.getInstanceDoNotCallByHand ().factory ();
			if (ret instanceof ru.garant.TestModel.BasicTests.NewImpl.DerivedLocal) {
				return (ru.garant.TestModel.BasicTests.NewImpl.DerivedLocal) ret;
			} else {
				throw new NoActiveFactory ("BasicTests::NewImpl::DerivedLocalFactory");
			}
		}

	}// factory interface for DerivedLocal
} //interface DerivedLocal
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
