unit nscFormsPageControl;

// Библиотека : "Визуальные компоненты проекта Немезис"
// Автор      : Р. Лукьянец.
// Начат      : 06.12.2006 г.
// Назначение : Компонент с вкладками-формами
// Версия     : $Id: nscFormsPageControl.pas,v 1.3 2012/03/15 10:55:12 lulin Exp $

// $Log: nscFormsPageControl.pas,v $
// Revision 1.3  2012/03/15 10:55:12  lulin
// {RequestLink:344754050}
//
// Revision 1.2  2009/01/12 11:12:06  oman
// - new: Обрабатываем в дочерней зоне (К-113508400)
//
// Revision 1.1  2009/01/12 10:07:19  oman
// - new: Готовим компонент для дочерней зоны (К-113508400)
//
//

interface

uses
 classes,
 
 vcmExternalInterfaces,

 vtNavigatorFormList,

 nscPageControl
 ;

type
 TnscFormsPageControl = class(TnscPageControl,
                              IvcmOperationsProvider,
                              IvcmCloseFormHandlerWatcher)
 protected
  private
    f_List: TvtNavigatorFormList;
  private
    procedure CloseChildExecute(const aParams : IvcmExecuteParamsPrim);
      {-}
    procedure CloseChildTest(const aParams : IvcmTestParamsPrim);
      {-}
    function HandlerList: TvtNavigatorFormList;
      {-}
    function GetCloseHandler: IvcmFormHandler;
      {-}
  protected
  // IvcmOperationsProvider
    procedure ProvideOps(const aPublisher : IvcmOperationsPublisher);
      {* - предоставить список доступных операций. }
  // IvcmCloseFormHandlerWatcher
    procedure SetWatch(const aHandler: IvcmFormHandler);
      {-}
  protected
    procedure Cleanup;
     override;
      {-}
  public
    procedure Notification(AComponent : TComponent;
                           Operation  : TOperation);
     override;
      {-}
 end;//TnscFormsPageControl

implementation

uses
 SysUtils,
 Forms,

 vtNavigatorForm,
 vtNavigatorFormListPrim
 ;

const
 vcm_deEnclosedForms = 'EnclosedForms';
  vcm_doCloseChild = 'CloseChild';

{ TnscFormsPageControl }

procedure TnscFormsPageControl.Cleanup;
begin
 FreeAndNil(f_List);
 inherited;
end;

procedure TnscFormsPageControl.CloseChildExecute(
  const aParams: IvcmExecuteParamsPrim);
begin
 GetCloseHandler.Handler(GetCloseHandler.Form);
end;

procedure TnscFormsPageControl.CloseChildTest(
  const aParams: IvcmTestParamsPrim);
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := (GetCloseHandler <> nil);
end;

function TnscFormsPageControl.GetCloseHandler: IvcmFormHandler;
var
 l_Index : Integer;
begin
 Result := nil;
 if Assigned(f_List) and (ActivePage <> nil) and (ActivePage.ControlCount > 0) and
    HandlerList.FindData(TvtFormHandlerID_C(ActivePage.Controls[0]), l_Index) then
  Result := HandlerList.Items[l_Index].CloseHandler
 else
  Result := nil;
end;

function TnscFormsPageControl.HandlerList: TvtNavigatorFormList;
begin
 if f_List = nil then
  f_List := TvtNavigatorFormList.Create;
 Result := f_List;
end;

procedure TnscFormsPageControl.Notification(AComponent: TComponent;
  Operation: TOperation);
var
 l_Item : Integer;
begin
 inherited Notification(aComponent, Operation);
 if (Operation = opRemove) then
 begin
  if Assigned(f_List) and HandlerList.FindData(TvtFormHandlerID_C(aComponent), l_Item) then
  begin
   AComponent.RemoveFreeNotification(Self);
   HandlerList.Delete(l_Item);
  end;//if HandlerList.FindData(l_Form, l_Item) then
 end;//if (Operation = opRemove) then
end;

procedure TnscFormsPageControl.ProvideOps(
  const aPublisher: IvcmOperationsPublisher);
begin
 aPublisher.PublishOp(vcm_deEnclosedForms, vcm_doCloseChild, CloseChildExecute, CloseChildTest);
end;

procedure TnscFormsPageControl.SetWatch(const aHandler: IvcmFormHandler);
var
 l_Class: TvtNavigatorForm;
begin
 l_Class := TvtNavigatorForm.Create(aHandler);
 try
  HandlerList.Add(l_Class);
  aHandler.Form.FreeNotification(Self);
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;

end.
