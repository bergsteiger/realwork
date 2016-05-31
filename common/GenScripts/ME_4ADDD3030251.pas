unit OfficeLikeMain_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeMain_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "OfficeLikeMain" MUID: (4ADDD3030251)
// Имя типа: "TOfficeLikeMainForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmMainForm
 , OfficeLike_Usual_Controls
 , vcmExternalInterfaces
 , Classes
 , vcmInterfaces
;

type
 TOfficeLikeMainForm = class(TvcmMainForm)
  protected
   procedure DoBack(const aParams: IvcmExecuteParamsPrim); virtual;
   procedure DoForward(const aParams: IvcmExecuteParamsPrim); virtual;
   function NeedTerminateOnExit: Boolean; virtual;
   function AskMayExit: Boolean; virtual;
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
  public
   procedure Common_Exit_Test(const aParams: IvcmTestParamsPrim);
   procedure Common_Exit_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure History_Back_Test(const aParams: IvcmTestParamsPrim);
    {* Назад }
   procedure History_Back_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Назад }
   procedure History_Forward_Test(const aParams: IvcmTestParamsPrim);
    {* Вперёд }
   procedure History_Forward_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Вперёд }
   constructor Create(AOwner: TComponent); override;
 end;//TOfficeLikeMainForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , Windows
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , StdRes
 //#UC START# *4ADDD3030251impl_uses*
 //#UC END# *4ADDD3030251impl_uses*
;

procedure TOfficeLikeMainForm.DoBack(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDE6B01A6_4ADDD3030251_var*
//#UC END# *4C8DDE6B01A6_4ADDD3030251_var*
begin
//#UC START# *4C8DDE6B01A6_4ADDD3030251_impl*
 Self.History.Back(aParams);
//#UC END# *4C8DDE6B01A6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoBack

procedure TOfficeLikeMainForm.DoForward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDEA5007E_4ADDD3030251_var*
//#UC END# *4C8DDEA5007E_4ADDD3030251_var*
begin
//#UC START# *4C8DDEA5007E_4ADDD3030251_impl*
 Self.History.Forward(aParams);
//#UC END# *4C8DDEA5007E_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoForward

function TOfficeLikeMainForm.NeedTerminateOnExit: Boolean;
//#UC START# *4ADDD31E0091_4ADDD3030251_var*
//#UC END# *4ADDD31E0091_4ADDD3030251_var*
begin
//#UC START# *4ADDD31E0091_4ADDD3030251_impl*
 Result := false;
//#UC END# *4ADDD31E0091_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.NeedTerminateOnExit

function TOfficeLikeMainForm.AskMayExit: Boolean;
//#UC START# *4ADDD5A30139_4ADDD3030251_var*
//#UC END# *4ADDD5A30139_4ADDD3030251_var*
begin
//#UC START# *4ADDD5A30139_4ADDD3030251_impl*
 Result := true;
//#UC END# *4ADDD5A30139_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.AskMayExit

procedure TOfficeLikeMainForm.Common_Exit_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4ADDD377028F_4ADDD3030251test_var*
//#UC END# *4ADDD377028F_4ADDD3030251test_var*
begin
//#UC START# *4ADDD377028F_4ADDD3030251test_impl*
 // - ничего не делаем
//#UC END# *4ADDD377028F_4ADDD3030251test_impl*
end;//TOfficeLikeMainForm.Common_Exit_Test

procedure TOfficeLikeMainForm.Common_Exit_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ADDD377028F_4ADDD3030251exec_var*
//#UC END# *4ADDD377028F_4ADDD3030251exec_var*
begin
//#UC START# *4ADDD377028F_4ADDD3030251exec_impl*
 if not NeedTerminateOnExit then
 begin
  if AskMayExit then
   DoExitApplication;
 end//not NeedTerminateOnExit
 else
  TerminateProcess(GetCurrentProcess, 255);
//#UC END# *4ADDD377028F_4ADDD3030251exec_impl*
end;//TOfficeLikeMainForm.Common_Exit_Execute

procedure TOfficeLikeMainForm.History_Back_Test(const aParams: IvcmTestParamsPrim);
 {* Назад }
//#UC START# *4ADDDC550118_4ADDD3030251test_var*
var
 l_History: IvcmHistory;
//#UC END# *4ADDDC550118_4ADDD3030251test_var*
begin
//#UC START# *4ADDDC550118_4ADDD3030251test_impl*
 l_History := Self.History;
 aParams.Op.Flag[vcm_ofEnabled] := l_History.CanBack;
 l_History.GetBackStrings(aParams);
//#UC END# *4ADDDC550118_4ADDD3030251test_impl*
end;//TOfficeLikeMainForm.History_Back_Test

procedure TOfficeLikeMainForm.History_Back_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Назад }
//#UC START# *4ADDDC550118_4ADDD3030251exec_var*
//#UC END# *4ADDDC550118_4ADDD3030251exec_var*
begin
//#UC START# *4ADDDC550118_4ADDD3030251exec_impl*
 DoBack(aParams);
//#UC END# *4ADDDC550118_4ADDD3030251exec_impl*
end;//TOfficeLikeMainForm.History_Back_Execute

procedure TOfficeLikeMainForm.History_Forward_Test(const aParams: IvcmTestParamsPrim);
 {* Вперёд }
//#UC START# *4ADDDC630097_4ADDD3030251test_var*
var
 l_History: IvcmHistory;
//#UC END# *4ADDDC630097_4ADDD3030251test_var*
begin
//#UC START# *4ADDDC630097_4ADDD3030251test_impl*
 l_History := Self.History;
 aParams.Op.Flag[vcm_ofEnabled] := l_History.CanForward;
 l_History.GetForwardStrings(aParams);
//#UC END# *4ADDDC630097_4ADDD3030251test_impl*
end;//TOfficeLikeMainForm.History_Forward_Test

procedure TOfficeLikeMainForm.History_Forward_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Вперёд }
//#UC START# *4ADDDC630097_4ADDD3030251exec_var*
//#UC END# *4ADDDC630097_4ADDD3030251exec_var*
begin
//#UC START# *4ADDDC630097_4ADDD3030251exec_impl*
 DoForward(aParams);
//#UC END# *4ADDDC630097_4ADDD3030251exec_impl*
end;//TOfficeLikeMainForm.History_Forward_Execute

constructor TOfficeLikeMainForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4ADDD3030251_var*
//#UC END# *47D1602000C6_4ADDD3030251_var*
begin
//#UC START# *47D1602000C6_4ADDD3030251_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=470847610
{$If defined(Admin)}
 with dmStdRes.MenuManager.GetItemByName('enHistory') do
 begin
  with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opBack')) do
   Options := Options - [vcm_ooShowInMainMenu, vcm_ooShowInMainToolbar];
  with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opForward')) do
   Options := Options - [vcm_ooShowInMainMenu, vcm_ooShowInMainToolbar];
 end;
{$IfEnd defined(Admin)}
 inherited;
//#UC END# *47D1602000C6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.Create

procedure TOfficeLikeMainForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Common, nil);
  PublishFormEntity(en_History, nil);
  PublishOp(en_Common, op_Exit, Common_Exit_Execute, Common_Exit_Test, nil);
  PublishOp(en_History, op_Back, History_Back_Execute, History_Back_Test, nil);
  PublishOp(en_History, op_Forward, History_Forward_Execute, History_Forward_Test, nil);
 end;//with Entities.Entities
end;//TOfficeLikeMainForm.InitEntities

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOfficeLikeMainForm);
 {* Регистрация OfficeLikeMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
