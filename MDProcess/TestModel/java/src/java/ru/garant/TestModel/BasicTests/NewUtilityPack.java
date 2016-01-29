////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewUtilityPack.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<UtilityPack::Class>> TestModel::BasicTests::ComplexTypesSmallTest::NewUtilityPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests;

import ru.garant.shared.Core.Logs;


public final class NewUtilityPack {
	public static class NewBitMask extends java.util.BitSet {
		private static NewBitMask sA3 = null;
		private static NewBitMask sA7 = null;

		public NewBitMask () {
			super (2);
		}

		public static NewBitMask A3 () {
			if (sA3 == null) {
				sA3 = new NewBitMask ();
				sA3.set (0);
			}
			return sA3;
		}

		public static NewBitMask A7 () {
			if (sA7 == null) {
				sA7 = new NewBitMask ();
				sA7.set (1);
			}
			return sA7;
		}

	};


	public static class DerivedBitMask extends java.util.BitSet {
		private static DerivedBitMask sA9 = null;

		public DerivedBitMask () {
			super (1);
		}

		public static DerivedBitMask A9 () {
			if (sA9 == null) {
				sA9 = new DerivedBitMask ();
				sA9.set (0);
			}
			return sA9;
		}

	};



} // class NewUtilityPack
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
