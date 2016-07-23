unit F1Like_Contracts;

// Модуль: "w:\common\components\gui\Garant\VCM\View\F1Like_Contracts.pas"
// Стереотип: "VCMContracts"
// Элемент модели: "Contracts" MUID: (5791D1FF0214)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MvcmParentAndChildService = interface
  {* Контракт сервиса TvcmParentAndChildService }
  function MakeChild(aMainForm: TvcmMainForm;
   anOwner: TvcmEntityForm): IvcmEntityForm;
  function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
 end;//MvcmParentAndChildService
 *)

type
 IvcmParentAndChildService = interface
  {* Интерфейс сервиса TvcmParentAndChildService }
  function MakeChild(aMainForm: TvcmMainForm;
   anOwner: TvcmEntityForm): IvcmEntityForm;
  function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
 end;//IvcmParentAndChildService

 TvcmParentAndChildService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IvcmParentAndChildService;
    {* Внешняя реализация сервиса IvcmParentAndChildService }
  protected
   procedure pm_SetAlien(const aValue: IvcmParentAndChildService);
   procedure ClearFields; override;
  public
   function MakeChild(aMainForm: TvcmMainForm;
    anOwner: TvcmEntityForm): IvcmEntityForm;
   function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
   class function Instance: TvcmParentAndChildService;
    {* Метод получения экземпляра синглетона TvcmParentAndChildService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IvcmParentAndChildService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IvcmParentAndChildService }
 end;//TvcmParentAndChildService

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_TvcmParentAndChildService: TvcmParentAndChildService = nil;
 {* Экземпляр синглетона TvcmParentAndChildService }

procedure TvcmParentAndChildServiceFree;
 {* Метод освобождения экземпляра синглетона TvcmParentAndChildService }
begin
 l3Free(g_TvcmParentAndChildService);
end;//TvcmParentAndChildServiceFree

procedure TvcmParentAndChildService.pm_SetAlien(const aValue: IvcmParentAndChildService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmParentAndChildService.pm_SetAlien

function TvcmParentAndChildService.MakeChild(aMainForm: TvcmMainForm;
 anOwner: TvcmEntityForm): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeChild(aMainForm, anOwner)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TvcmParentAndChildService.MakeChild

function TvcmParentAndChildService.MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeParent(aMainForm)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TvcmParentAndChildService.MakeParent

class function TvcmParentAndChildService.Instance: TvcmParentAndChildService;
 {* Метод получения экземпляра синглетона TvcmParentAndChildService }
begin
 if (g_TvcmParentAndChildService = nil) then
 begin
  l3System.AddExitProc(TvcmParentAndChildServiceFree);
  g_TvcmParentAndChildService := Create;
 end;
 Result := g_TvcmParentAndChildService;
end;//TvcmParentAndChildService.Instance

class function TvcmParentAndChildService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmParentAndChildService <> nil;
end;//TvcmParentAndChildService.Exists

procedure TvcmParentAndChildService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TvcmParentAndChildService.ClearFields

initialization

end.
