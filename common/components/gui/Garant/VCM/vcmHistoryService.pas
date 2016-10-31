unit vcmHistoryService;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmHistoryService.pas"
// Стереотип: "Service"
// Элемент модели: "TvcmHistoryService" MUID: (559BA19C0076)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
;

 (*
 MvcmHistoryService = interface
  {* Контракт сервиса TvcmHistoryService }
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
  function Back(const aForm: IvcmEntityForm): Boolean;
  procedure MakingCloneStarted(const aContainer: IvcmContainer);
  procedure ContainerForCloneMade(const aOrgContainer: IvcmContainer;
   const aCloneContainer: IvcmContainer);
  procedure MakingCloneFinished(const aContainer: IvcmContainer);
  function IsClone(const aContainer: IvcmContainer): Boolean;
 end;//MvcmHistoryService
 *)

type
 IvcmHistoryService = interface
  {* Интерфейс сервиса TvcmHistoryService }
  function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
  procedure SaveFormState(const aForm: IvcmEntityForm);
  function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
  function IsInBF(const aForm: IvcmEntityForm): Boolean;
  function Back(const aForm: IvcmEntityForm): Boolean;
  procedure MakingCloneStarted(const aContainer: IvcmContainer);
  procedure ContainerForCloneMade(const aOrgContainer: IvcmContainer;
   const aCloneContainer: IvcmContainer);
  procedure MakingCloneFinished(const aContainer: IvcmContainer);
  function IsClone(const aContainer: IvcmContainer): Boolean;
 end;//IvcmHistoryService

 TvcmHistoryService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IvcmHistoryService;
    {* Внешняя реализация сервиса IvcmHistoryService }
  protected
   procedure pm_SetAlien(const aValue: IvcmHistoryService);
   procedure ClearFields; override;
  public
   function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
   procedure SaveFormState(const aForm: IvcmEntityForm);
   function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
   function IsInBF(const aForm: IvcmEntityForm): Boolean;
   function Back(const aForm: IvcmEntityForm): Boolean;
   procedure MakingCloneStarted(const aContainer: IvcmContainer);
   procedure ContainerForCloneMade(const aOrgContainer: IvcmContainer;
    const aCloneContainer: IvcmContainer);
   procedure MakingCloneFinished(const aContainer: IvcmContainer);
   function IsClone(const aContainer: IvcmContainer): Boolean;
   class function Instance: TvcmHistoryService;
    {* Метод получения экземпляра синглетона TvcmHistoryService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IvcmHistoryService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IvcmHistoryService }
 end;//TvcmHistoryService
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , afwFacade
 , vcmBase
 , SysUtils
 , l3Base
 //#UC START# *559BA19C0076impl_uses*
 , vcmDispatcher
 //#UC END# *559BA19C0076impl_uses*
;

var g_TvcmHistoryService: TvcmHistoryService = nil;
 {* Экземпляр синглетона TvcmHistoryService }

procedure TvcmHistoryServiceFree;
 {* Метод освобождения экземпляра синглетона TvcmHistoryService }
begin
 l3Free(g_TvcmHistoryService);
end;//TvcmHistoryServiceFree

procedure TvcmHistoryService.pm_SetAlien(const aValue: IvcmHistoryService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmHistoryService.pm_SetAlien

function TvcmHistoryService.GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
//#UC START# *559BA1B80327_559BA19C0076_var*
//#UC END# *559BA1B80327_559BA19C0076_var*
begin
//#UC START# *559BA1B80327_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetFormHistory(aForm)
 else
  Result := TvcmDispatcher.Instance.History;
//#UC END# *559BA1B80327_559BA19C0076_impl*
end;//TvcmHistoryService.GetFormHistory

procedure TvcmHistoryService.SaveFormState(const aForm: IvcmEntityForm);
//#UC START# *559BA3270003_559BA19C0076_var*
var
 l_History: IvcmHistory;
//#UC END# *559BA3270003_559BA19C0076_var*
begin
//#UC START# *559BA3270003_559BA19C0076_impl*
 if (f_Alien <> nil) then
  f_Alien.SaveFormState(aForm)
 else
 begin
  l_History := GetFormHistory(aForm);
  Assert(l_History <> nil);
  l_History.ForceSaveState(aForm);
 end;
//#UC END# *559BA3270003_559BA19C0076_impl*
end;//TvcmHistoryService.SaveFormState

function TvcmHistoryService.GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
//#UC START# *559CAE8C0067_559BA19C0076_var*
//#UC END# *559CAE8C0067_559BA19C0076_var*
begin
//#UC START# *559CAE8C0067_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetContainerHistory(aContainer)
 else
  Result := TvcmDispatcher.Instance.History;
//#UC END# *559CAE8C0067_559BA19C0076_impl*
end;//TvcmHistoryService.GetContainerHistory

function TvcmHistoryService.IsInBF(const aForm: IvcmEntityForm): Boolean;
//#UC START# *55B8A6460123_559BA19C0076_var*
var
 l_History: IvcmHistory;
//#UC END# *55B8A6460123_559BA19C0076_var*
begin
//#UC START# *55B8A6460123_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsInBF(aForm)
 else
 begin
  l_History := GetFormHistory(aForm);
  Result := l_History.InBF;
 end;
//#UC END# *55B8A6460123_559BA19C0076_impl*
end;//TvcmHistoryService.IsInBF

function TvcmHistoryService.Back(const aForm: IvcmEntityForm): Boolean;
//#UC START# *569E01920150_559BA19C0076_var*
//#UC END# *569E01920150_559BA19C0076_var*
begin
//#UC START# *569E01920150_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.Back(aForm)
 else
  Result := TvcmDispatcher.Instance.History.Back;
//#UC END# *569E01920150_559BA19C0076_impl*
end;//TvcmHistoryService.Back

procedure TvcmHistoryService.MakingCloneStarted(const aContainer: IvcmContainer);
//#UC START# *57AD88650343_559BA19C0076_var*
//#UC END# *57AD88650343_559BA19C0076_var*
begin
//#UC START# *57AD88650343_559BA19C0076_impl*
 if (f_Alien <> nil) then
  f_Alien.MakingCloneStarted(aContainer);
//#UC END# *57AD88650343_559BA19C0076_impl*
end;//TvcmHistoryService.MakingCloneStarted

procedure TvcmHistoryService.ContainerForCloneMade(const aOrgContainer: IvcmContainer;
 const aCloneContainer: IvcmContainer);
//#UC START# *57AD88AF012D_559BA19C0076_var*
//#UC END# *57AD88AF012D_559BA19C0076_var*
begin
//#UC START# *57AD88AF012D_559BA19C0076_impl*
 if (f_Alien <> nil) then
  f_Alien.ContainerForCLoneMade(aOrgContainer, aCloneContainer);
//#UC END# *57AD88AF012D_559BA19C0076_impl*
end;//TvcmHistoryService.ContainerForCloneMade

procedure TvcmHistoryService.MakingCloneFinished(const aContainer: IvcmContainer);
//#UC START# *57AD88D00074_559BA19C0076_var*
//#UC END# *57AD88D00074_559BA19C0076_var*
begin
//#UC START# *57AD88D00074_559BA19C0076_impl*
 if (f_Alien <> nil) then
  f_Alien.MakingCloneFinished(aContainer);
//#UC END# *57AD88D00074_559BA19C0076_impl*
end;//TvcmHistoryService.MakingCloneFinished

function TvcmHistoryService.IsClone(const aContainer: IvcmContainer): Boolean;
//#UC START# *57AD88DC01F7_559BA19C0076_var*
//#UC END# *57AD88DC01F7_559BA19C0076_var*
begin
//#UC START# *57AD88DC01F7_559BA19C0076_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsClone(aContainer)
 else
  Result := False;
//#UC END# *57AD88DC01F7_559BA19C0076_impl*
end;//TvcmHistoryService.IsClone

class function TvcmHistoryService.Instance: TvcmHistoryService;
 {* Метод получения экземпляра синглетона TvcmHistoryService }
begin
 if (g_TvcmHistoryService = nil) then
 begin
  l3System.AddExitProc(TvcmHistoryServiceFree);
  g_TvcmHistoryService := Create;
 end;
 Result := g_TvcmHistoryService;
end;//TvcmHistoryService.Instance

class function TvcmHistoryService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmHistoryService <> nil;
end;//TvcmHistoryService.Exists

procedure TvcmHistoryService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TvcmHistoryService.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
