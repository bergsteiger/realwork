unit TypInfo;
 {* Методы для работы с RTTI. }

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Rtl\Common\TypInfo.pas"
// Стереотип: "Interfaces"

interface

uses
 l3IntfUses
;

type
 TTypeInfo = record
  {* Информация о типе. }
 end;//TTypeInfo

 PTypeInfo = ^TTypeInfo;
  {* Информация о типе. }

 TTypeData = record
 end;//TTypeData

 PTypeData = ^TTypeData;

 GetObjectProp = procedure;

 PPropInfo = ^;

implementation

uses
 l3ImplUses
;

end.
