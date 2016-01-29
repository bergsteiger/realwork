////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/NewExeTarget/NewExeTargetMain.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<ExeTarget::Category>> TestModel::NewExeTarget
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.NewExeTarget;

import ru.garant.shared.Core.Logs;

public class NewExeTargetMain {

	public static void main (String Args[]) throws Exception {
		ru.garant.shared.CoreSrv.Root_i.CorbaLibHomeManagerFactoryImpl libHomeFactory = new ru.garant.shared.CoreSrv.Root_i.CorbaLibHomeManagerFactoryImpl ();
		libHomeFactory.registrateMe((short)0);
		
		ru.garant.shared.Core.ParamsImpl.ParamManagerImplFactoryImpl paramManagerFactory = new ru.garant.shared.Core.ParamsImpl.ParamManagerImplFactoryImpl ();
		paramManagerFactory.registrateMe((short)0);
		
		try {
			ru.garant.shared.Core.ParamManagerInitData initData = new ru.garant.shared.Core.ParamManagerInitData ();
			initData.setApplicationName("NewExeTarget");
			initData.setRegistrySubkey("Core::RegistryHelper::KEY_LOCAL_MACHINE\\Software\\Garant\\TestModel\\NewExeTarget");
			
			ru.garant.shared.Core.ParamManager.Factory.get ().init (java.util.Arrays.asList(Args), initData);
		} catch (Throwable e) {
			Logs.LOG_SEX (e);
		}
		
		ru.garant.shared.Core.Root.LibHomeManager lhm = ru.garant.shared.Core.Root.LibHomeManager.Factory.get();

		lhm.registrateLibHome (ru.garant.TestModel.BasicTests.LibHomeFactory.get());
		lhm.registrateLibHome (ru.garant.TestModel.SubTestLibrary.LibHomeFactory.get());
		lhm.registrateLibHome (ru.garant.TestModel.SubServerLibrary.LibHomeFactory.get());
		lhm.registrateLibHome (ru.garant.TestModel.NewLibrary.LibHomeFactory.get());
		lhm.registrateLibHome (ru.garant.TestModel.NewServerLibrary.LibHomeFactory.get());
		lhm.registrateLibHome (ru.garant.TestModel.NewServerLibrary.ServerLibHomeFactory.get());
		lhm.registrateLibHome (ru.garant.TestModel.NewTestLibrary.LibHomeFactory.get());


		try {
			lhm.execute();
			lhm.waitAll ();
		} catch (java.lang.Throwable ex) {
			Logs.LOG_SEX (ex);
		}
		
		lhm.finalize ();
	}
} // NewExeTargetMain

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
