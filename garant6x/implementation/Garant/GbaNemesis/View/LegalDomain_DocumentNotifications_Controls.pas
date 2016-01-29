unit LegalDomain_DocumentNotifications_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LegalDomain_DocumentNotifications_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Базовые определения предметной области::LegalDomain::View::DocumentNotifications
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* Comment = operations
   ['{180B0E4C-1DF0-4C40-9979-09CFB52B5C43}']
   query Changed;
 end;//Comment*)

type
 Op_Comment_Changed = class
  {* Класс для вызова операции Comment.Changed }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Comment.Changed у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Comment.Changed у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Comment.Changed у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Comment.Changed у контейнера }
   class procedure Broadcast;
     {* Вызов операции Comment.Changed у всех зарегистрированных сущностей }
 end;//Op_Comment_Changed

const
 en_Comment = 'Comment';
 en_capComment = '';
 op_Changed = 'Changed';
 op_capChanged = '';

implementation

uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

// start class Op_Comment_Changed

class function Op_Comment_Changed.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Comment_Changed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Comment_Changed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Comment_Changed.Call

class procedure Op_Comment_Changed.Broadcast;
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_Comment_Changed, l_Params);
 end;//vcmDispatcher <> nil
end;//Op_Comment_Changed.Broadcast

end.