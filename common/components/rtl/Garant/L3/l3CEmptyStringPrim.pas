unit l3CEmptyStringPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3CEmptyStringPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CEmptyStringPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3CProtoObject
  ;

type
 Tl3CEmptyStringPrim = class(Tl3CProtoObject, Il3CString)
 protected
 // realized methods
   function pm_GetAsWStr: Tl3WString;
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: Il3CString; reintroduce;
     {* Сигнатура фабрики Tl3CEmptyStringPrim.Make }
 end;//Tl3CEmptyStringPrim

implementation

uses
  l3String
  {$If not defined(NoScripts)}
  ,
  tfwIl3CStringPack
  {$IfEnd} //not NoScripts
  
  ;

// start class Tl3CEmptyStringPrim

constructor Tl3CEmptyStringPrim.Create;
//#UC START# *4F5CBE92035B_4F5CBD4201BE_var*
//#UC END# *4F5CBE92035B_4F5CBD4201BE_var*
begin
//#UC START# *4F5CBE92035B_4F5CBD4201BE_impl*
 inherited Create;
//#UC END# *4F5CBE92035B_4F5CBD4201BE_impl*
end;//Tl3CEmptyStringPrim.Create

class function Tl3CEmptyStringPrim.Make: Il3CString;
var
 l_Inst : Tl3CEmptyStringPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function Tl3CEmptyStringPrim.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_4F5CBD4201BEget_var*
//#UC END# *46780DEF03E5_4F5CBD4201BEget_var*
begin
//#UC START# *46780DEF03E5_4F5CBD4201BEget_impl*
 l3AssignNil(Result);
//#UC END# *46780DEF03E5_4F5CBD4201BEget_impl*
end;//Tl3CEmptyStringPrim.pm_GetAsWStr

end.