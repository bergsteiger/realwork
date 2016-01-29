////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewImpl/NewServantFactoryImpl.java"
// ��������� ���������� ������ ����������� �� java (.java)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NewServant
// ��������� ���������� ������ ���������� DerivedLocal ��� �������� NewServant
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

package ru.garant.TestModel.BasicTests.NewImpl;

import ru.garant.shared.Core.Logs;


import ru.garant.shared.Core.Root.UnknownFactoryKey;
import ru.garant.shared.Core.Root.NoActiveFactory;
import ru.garant.shared.Core.Root.DuplicatedFactoryKey;

/// Interface-factory implementation for NewServant
public final class NewServantFactoryImpl implements ru.garant.TestModel.BasicTests.NewImpl.DerivedLocalFactoryManager.DerivedLocalAbstractFactory
{

	public NewServantFactoryImpl () {
	}

	public final void registrateMe (short priority) throws DuplicatedFactoryKey {
		ru.garant.TestModel.BasicTests.NewImpl.DerivedLocalFactoryManager.registerFactory (this, priority);

	}

	public final String key () {
		return "NewServant";
	}

	public final ru.garant.TestModel.BasicTests.NewInterfaces.DerivedInterface factory () {
		return new NewServant ();
	}

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

