unit LegalDomain_DocumentNotifications_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LegalDomain_DocumentNotifications_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "DocumentNotifications" MUID: (4EAAE5A1005E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Op_Comment_Changed = {final} class
  {* Класс для вызова операции Comment.Changed }
  public
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
 l3ImplUses
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

class function Op_Comment_Changed.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Comment.Changed у сущности }
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
 {* Вызов операции Comment.Changed у агрегации }
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
 {* Вызов операции Comment.Changed у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Comment_Changed.Call

class function Op_Comment_Changed.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Comment.Changed у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Comment_Changed.Call

class procedure Op_Comment_Changed.Broadcast;
 {* Вызов операции Comment.Changed у всех зарегистрированных сущностей }
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_Comment_Changed, l_Params);
 end//vcmDispatcher <> nil
end;//Op_Comment_Changed.Broadcast

end.
