////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NativeTypesSmallTest/NewException.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<Exception::Class>> TestModel::BasicTests::NativeTypesSmallTest::NewException
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests.NativeTypesSmallTest;

public class NewException extends java.lang.Exception {

	public NewException () {
		super ("NewException ()");
		//#UC START# *49AEDAED01F3_INIT_CTOR*
		//#UC END# *49AEDAED01F3_INIT_CTOR*
	}

	public NewException (java.lang.Throwable cause) {
		super ("NewException ()", cause);
		//#UC START# *49AEDAED01F3_CAUSE_INIT_CTOR*
		//#UC END# *49AEDAED01F3_CAUSE_INIT_CTOR*
	}
	public NewException () {
		//#UC START# *49B9227C0055_BODY*
		//#UC END# *49B9227C0055_BODY*
	}

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors

	final public String getProperty () {
		//#UC START# *49B9229C0112_GET_ACCESSOR*
		return property_;
		//#UC END# *49B9229C0112_GET_ACCESSOR*
	}

	final public void setProperty (final String property) {
		//#UC START# *49B9229C0112_SET_ACCESSOR*
		property_ = property;
		//#UC END# *49B9229C0112_SET_ACCESSOR*
	}

	final public String getRoProperty () {
		//#UC START# *49B922B002CD_GET_ACCESSOR*
		return roProperty_;
		//#UC END# *49B922B002CD_GET_ACCESSOR*
	}

	final public void setWoProperty (final String woProperty) {
		//#UC START# *49B922CA037D_SET_ACCESSOR*
		woProperty_ = woProperty;
		//#UC END# *49B922CA037D_SET_ACCESSOR*
	}

	private String attr_;
	private String property_;
	private String roProperty_;
	private String woProperty_;

} // NewException
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

