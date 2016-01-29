unit l3MultiThreadSortedIntegerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3MultiThreadSortedIntegerList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::MultiThread::Tl3MultiThreadSortedIntegerList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3MultiThreadIntegerList
  ;

type
 Tl3MultiThreadSortedIntegerList = class(Tl3MultiThreadIntegerList)
 protected
 // overridden protected methods
   function NeedSort: Boolean; override;
 end;//Tl3MultiThreadSortedIntegerList

implementation

// start class Tl3MultiThreadSortedIntegerList

function Tl3MultiThreadSortedIntegerList.NeedSort: Boolean;
//#UC START# *53A2C90A0344_53A2C9290311_var*
//#UC END# *53A2C90A0344_53A2C9290311_var*
begin
//#UC START# *53A2C90A0344_53A2C9290311_impl*
 Result := true;
//#UC END# *53A2C90A0344_53A2C9290311_impl*
end;//Tl3MultiThreadSortedIntegerList.NeedSort

end.