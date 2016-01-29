unit NOT_FINISHED_l3Base;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В. ©
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Base.pas"
// Начат: 12.04.1998 16:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Base
//
// Базовые объекты библиотеки L3. Часть их реализации присутствует в модуле l3List.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3ObjectRefList1,
  l3_String,
  l3CustomString,
  l3_Base,
  l3CProtoObject,
  l3MemUtils,
  l3ObjectsMemoryManager
  ;

type
 Tl3Base = class(Tl3_Base)
  {* Базовый класс библиотеки L3. Реализует интерфейс IUnknown и подсчет ссылок. }
 end;//Tl3Base

 Rl3ObjectRefList = class of l3ObjectRefList1.Tl3ObjectRefList1;

 Tl3String = l3_String.Tl3_String;
  {* Строка. }

 Tl3CustomString = l3CustomString.Tl3CustomString;

 Pl3CustomString = ^Tl3CustomString;

 Tl3CResString = class(Tl3CProtoObject, Il3CString)
 protected
 // realized methods
   function pm_GetAsWStr: Tl3WString;
 end;//Tl3CResString

 Tl3CNodeString = class(Tl3CProtoObject, Il3CString)
 protected
 // realized methods
   function pm_GetAsWStr: Tl3WString;
 end;//Tl3CNodeString

 Tl3CWideString = class(Tl3CProtoObject, Il3CString)
 protected
 // realized methods
   function pm_GetAsWStr: Tl3WString;
 end;//Tl3CWideString

 Tl3CConstDelphiString = class(Tl3CProtoObject, Il3CString)
 protected
 // realized methods
   function pm_GetAsWStr: Tl3WString;
 end;//Tl3CConstDelphiString

 Tl3CDelphiString = class(Tl3CProtoObject, Il3CString)
 protected
 // realized methods
   function pm_GetAsWStr: Tl3WString;
 end;//Tl3CDelphiString

 Tl3SystemPrim = {abstract} class(Tl3MemUtils)
  {* Базовый класс менеджеров ресурсов. }
 private
 // private fields
   f_SimpleMM : Tl3ObjectsMemoryManager;
 end;//Tl3SystemPrim

 Tl3System = class(Tl3SystemPrim)
  {* Класс менеджеров ресурсов. }
 public
 // public methods
   procedure SetClipboardData;
     {* Сигнатура метода SetClipboardData }
 end;//Tl3System

 Rl3String = class of Tl3String;

 Tl3ThreadContainer = class(Tl3_Base)
 protected
 // protected methods
   procedure DoExecute; virtual; abstract;
     {* основная процедура нити. Для перекрытия в потомках }
 end;//Tl3ThreadContainer

 Tl3ObjectHash = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//Tl3ObjectHash

 Tl3ConstString = class(Tl3CustomString)
 end;//Tl3ConstString

 Tl3IntfString = class(Tl3CustomString)
 end;//Tl3IntfString

 Tl3DataIntfString = class(Tl3IntfString)
 end;//Tl3DataIntfString

 Tl3ObjPtrString = class(Tl3_String)
 end;//Tl3ObjPtrString

 Tl3ObjPtrIntfString = class(Tl3IntfString)
 end;//Tl3ObjPtrIntfString

 Tl3ObjRefString = class(Tl3_String)
 end;//Tl3ObjRefString

function L3InterlockedDecrement(var aAddend: Integer): Integer; register;
procedure L3ZeroMemory(aDest: Pointer;
  aLen: Cardinal);
procedure L3Move(const Source;
  var Dest;
  Count: Cardinal);
procedure L3CStr;
   {* Сигнатура метода l3CStr }
procedure L3FillChar;
   {* Сигнатура метода l3FillChar }
procedure L3Set;
   {* Сигнатура метода l3Set }
procedure L3FreeAndGetRef;
   {* Сигнатура метода l3FreeAndGetRef }
procedure L3LocalStub;
   {* Сигнатура метода l3LocalStub }
procedure L3System;
   {* Сигнатура метода l3System }
procedure L3L2IA;
   {* Сигнатура метода l3L2IA }
procedure L3Free;
   {* Сигнатура метода l3Free }
procedure L3CatLongArray;
   {* Сигнатура метода l3CatLongArray }
procedure L3Swap;
   {* Сигнатура метода l3Swap }
procedure L3CStringArrayEmpty;
   {* Сигнатура метода l3CStringArrayEmpty }

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwIl3CStringPack
  {$IfEnd} //not NoScripts
  ,
  l3TwoByteCString,
  l3OneByteCString,
  l3CEmptyStringPrim,
  l3CEmptyString,
  l3FourByteCString
  ;

// start class Tl3CResString

function Tl3CResString.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_46780F2F01DDget_var*
//#UC END# *46780DEF03E5_46780F2F01DDget_var*
begin
//#UC START# *46780DEF03E5_46780F2F01DDget_impl*
 assert(false, 'Tl3CResString.pm_GetAsWStr not implemented');
//#UC END# *46780DEF03E5_46780F2F01DDget_impl*
end;//Tl3CResString.pm_GetAsWStr
// start class Tl3CNodeString

function Tl3CNodeString.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_46780F9A02A9get_var*
//#UC END# *46780DEF03E5_46780F9A02A9get_var*
begin
//#UC START# *46780DEF03E5_46780F9A02A9get_impl*
 assert(false, 'Tl3CNodeString.pm_GetAsWStr not implemented');
//#UC END# *46780DEF03E5_46780F9A02A9get_impl*
end;//Tl3CNodeString.pm_GetAsWStr
// start class Tl3CWideString

function Tl3CWideString.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_46780FC20120get_var*
//#UC END# *46780DEF03E5_46780FC20120get_var*
begin
//#UC START# *46780DEF03E5_46780FC20120get_impl*
 assert(false, 'Tl3CWideString.pm_GetAsWStr not implemented');
//#UC END# *46780DEF03E5_46780FC20120get_impl*
end;//Tl3CWideString.pm_GetAsWStr
// start class Tl3CConstDelphiString

function Tl3CConstDelphiString.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_46780FF102AEget_var*
//#UC END# *46780DEF03E5_46780FF102AEget_var*
begin
//#UC START# *46780DEF03E5_46780FF102AEget_impl*
 assert(false, 'Tl3CConstDelphiString.pm_GetAsWStr not implemented');
//#UC END# *46780DEF03E5_46780FF102AEget_impl*
end;//Tl3CConstDelphiString.pm_GetAsWStr
// start class Tl3CDelphiString

function Tl3CDelphiString.pm_GetAsWStr: Tl3WString;
//#UC START# *46780DEF03E5_467810280040get_var*
//#UC END# *46780DEF03E5_467810280040get_var*
begin
//#UC START# *46780DEF03E5_467810280040get_impl*
 assert(false, 'Tl3CDelphiString.pm_GetAsWStr not implemented');
//#UC END# *46780DEF03E5_467810280040get_impl*
end;//Tl3CDelphiString.pm_GetAsWStr
// start class Tl3System

procedure Tl3System.SetClipboardData;
//#UC START# *4CDD23D702B6_47AAB5EC03C2_var*
//#UC END# *4CDD23D702B6_47AAB5EC03C2_var*
begin
//#UC START# *4CDD23D702B6_47AAB5EC03C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDD23D702B6_47AAB5EC03C2_impl*
end;//Tl3System.SetClipboardData
// unit methods

procedure L3CStr;
//#UC START# *4AA7888B0076_4773D64E036C_var*
//#UC END# *4AA7888B0076_4773D64E036C_var*
begin
//#UC START# *4AA7888B0076_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA7888B0076_4773D64E036C_impl*
end;//L3CStr

procedure L3FillChar;
//#UC START# *4AC1F98A0155_4773D64E036C_var*
//#UC END# *4AC1F98A0155_4773D64E036C_var*
begin
//#UC START# *4AC1F98A0155_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC1F98A0155_4773D64E036C_impl*
end;//L3FillChar

procedure L3Set;
//#UC START# *4ADF092A0066_4773D64E036C_var*
//#UC END# *4ADF092A0066_4773D64E036C_var*
begin
//#UC START# *4ADF092A0066_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADF092A0066_4773D64E036C_impl*
end;//L3Set

procedure L3FreeAndGetRef;
//#UC START# *4B87D7D701D0_4773D64E036C_var*
//#UC END# *4B87D7D701D0_4773D64E036C_var*
begin
//#UC START# *4B87D7D701D0_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B87D7D701D0_4773D64E036C_impl*
end;//L3FreeAndGetRef

procedure L3LocalStub;
//#UC START# *4BA7BE3B0114_4773D64E036C_var*
//#UC END# *4BA7BE3B0114_4773D64E036C_var*
begin
//#UC START# *4BA7BE3B0114_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BA7BE3B0114_4773D64E036C_impl*
end;//L3LocalStub

procedure L3System;
//#UC START# *4CDD241C0184_4773D64E036C_var*
//#UC END# *4CDD241C0184_4773D64E036C_var*
begin
//#UC START# *4CDD241C0184_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDD241C0184_4773D64E036C_impl*
end;//L3System

procedure L3L2IA;
//#UC START# *4CED3B270143_4773D64E036C_var*
//#UC END# *4CED3B270143_4773D64E036C_var*
begin
//#UC START# *4CED3B270143_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CED3B270143_4773D64E036C_impl*
end;//L3L2IA

procedure L3Free;
//#UC START# *4DFF098B00CC_4773D64E036C_var*
//#UC END# *4DFF098B00CC_4773D64E036C_var*
begin
//#UC START# *4DFF098B00CC_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DFF098B00CC_4773D64E036C_impl*
end;//L3Free

procedure L3CatLongArray;
//#UC START# *4E367C340334_4773D64E036C_var*
//#UC END# *4E367C340334_4773D64E036C_var*
begin
//#UC START# *4E367C340334_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E367C340334_4773D64E036C_impl*
end;//L3CatLongArray

procedure L3Swap;
//#UC START# *4E55096A03E3_4773D64E036C_var*
//#UC END# *4E55096A03E3_4773D64E036C_var*
begin
//#UC START# *4E55096A03E3_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E55096A03E3_4773D64E036C_impl*
end;//L3Swap

procedure L3CStringArrayEmpty;
//#UC START# *503DFD9B0044_4773D64E036C_var*
//#UC END# *503DFD9B0044_4773D64E036C_var*
begin
//#UC START# *503DFD9B0044_4773D64E036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *503DFD9B0044_4773D64E036C_impl*
end;//L3CStringArrayEmpty
// unit methods

function L3InterlockedDecrement(var aAddend: Integer): Integer;
//#UC START# *4799F0A60236_4773D64E036C_var*
//#UC END# *4799F0A60236_4773D64E036C_var*
begin
//#UC START# *4799F0A60236_4773D64E036C_impl*
 assert(false, 'L3InterlockedDecrement not implemented');
//#UC END# *4799F0A60236_4773D64E036C_impl*
end;//L3InterlockedDecrement

procedure L3ZeroMemory(aDest: Pointer;
  aLen: Cardinal);
//#UC START# *479F31620390_4773D64E036C_var*
//#UC END# *479F31620390_4773D64E036C_var*
begin
//#UC START# *479F31620390_4773D64E036C_impl*
 assert(false, 'L3ZeroMemory not implemented');
//#UC END# *479F31620390_4773D64E036C_impl*
end;//L3ZeroMemory

procedure L3Move(const Source;
  var Dest;
  Count: Cardinal);
//#UC START# *479F3B35038C_4773D64E036C_var*
//#UC END# *479F3B35038C_4773D64E036C_var*
begin
//#UC START# *479F3B35038C_4773D64E036C_impl*
 assert(false, 'L3Move not implemented');
//#UC END# *479F3B35038C_4773D64E036C_impl*
end;//L3Move

end.