unit NOT_FINISHED_l3Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3$Domain"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Const.pas"
// Начат: 13.04.1998 14:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Требования к низкоуровневым библиотекам::L3$Domain::l3Const
//
// Константы библиотеки L3.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

const
  { Messages }
 rs_LongOperation = 'Выполняется длительная операция...';
  { L3 Core Consts }
 l3NilLong = High(Longint);
  { NULL для целых. }
 l3Inch = 1440;
  { Дюйм. }
 l3mmInInch = 254;
  { число сантиметров в дюйме. }
 l3FontIndexDelta = l3Inch div 16;
 l3Epsilon = l3Inch div 120;
  { предел точности. }
 l3AlingDelta = l3Epsilon * 4;
  { Велчина выравнивания (значения отличающиеся на меньшую по модулю велчину считаются равными). }
 l3ShapeNil = Low(Longint) div 2;
  { NULL для координат рисуемых объектов. }
  { Strings }
 l3NULLStr = '<NULL>';

implementation

end.