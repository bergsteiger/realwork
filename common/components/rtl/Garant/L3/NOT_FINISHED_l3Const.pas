unit NOT_FINISHED_l3Const;
 {* Константы библиотеки L3. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Const.pas"
// Стереотип: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

const
 rs_LongOperation = 'Выполняется длительная операция...';
 l3NilLong = High(Longint);
  {* NULL для целых. }
 l3Inch = 1440;
  {* Дюйм. }
 l3mmInInch = 254;
  {* число сантиметров в дюйме. }
 l3FontIndexDelta = l3Inch div 16;
 l3Epsilon = l3Inch div 120;
  {* предел точности. }
 l3AlingDelta = l3Epsilon * 4;
  {* Велчина выравнивания (значения отличающиеся на меньшую по модулю велчину считаются равными). }
 l3ShapeNil = Low(Longint) div 2;
  {* NULL для координат рисуемых объектов. }
 l3NULLStr = '<NULL>';

implementation

uses
 l3ImplUses
;

end.
