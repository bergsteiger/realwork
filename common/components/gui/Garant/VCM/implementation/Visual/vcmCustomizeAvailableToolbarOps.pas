unit vcmCustomizeAvailableToolbarOps;

////////////////////////////////////////////////////////////////////////////////
// Библиотека : VCM
// Назначение : Настройка доступных для выбора операций при настройке панелей
//              инструментов
// Версия     : $Id: vcmCustomizeAvailableToolbarOps.pas,v 1.7 2016/09/13 20:48:10 lulin Exp $
////////////////////////////////////////////////////////////////////////////////

(*-------------------------------------------------------------------------------
  $Log: vcmCustomizeAvailableToolbarOps.pas,v $
  Revision 1.7  2016/09/13 20:48:10  lulin
  - подтачиваем.

  Revision 1.6  2016/09/13 18:32:44  kostitsin
  {requestlink: 630194905 }

  Revision 1.5  2009/02/12 13:33:58  lulin
  - <K>: 135604584. Выделен новый интерфейсный модуль.

  Revision 1.4  2009/02/12 12:26:41  lulin
  - <K>: 135604584. Выделен новый интерфейсный модуль.

  Revision 1.3  2008/07/21 09:39:29  mmorozov
  - new behaviour: по просбе УМ при настройке доступных операций список групп общий для всех форм.

  Revision 1.2  2008/06/25 11:23:44  mmorozov
  - new: Оптимизация панелей инструментов ... Список форм при настройке доступных операций  (CQ: OIT5-28281);

  Revision 1.1  2008/06/25 09:25:00  mmorozov
  - new: Оптимизация панелей инструментов ---|> в списке доступных форм показываем только объединенные панели инструментов + рефакторинг + список форм проекта при редактировании доступных для выбора операций (CQ: OIT5-28281);

-------------------------------------------------------------------------------*)

interface

uses
  vcmInterfaces,
  vcmTasksPanel,

  vcmTaskPanelInterfaces
  ;

type
  TvcmCustAvailableToolbarOps = class(TvcmCustOps,
                                      IvcmCustAvailableToolbarOps)
  private
    f_Form: IvcmEntityForm;
  private
  // IvcmCustAvailableToolbarOps
    function pm_GetForm: IvcmEntityForm;
      {* - редактируемая формы. }
  protected
  // methods
    function AnalyzeOpForCurrentUseCase: Boolean;
      override;
      {-}
  public
  // methods
    class function Make(const aForm: IvcmEntityForm): IvcmCustOps;
      reintroduce;
      {-}
  end;

implementation

uses
  SysUtils,
  
  vcmSettings,
  vcmBase,
  vcmDispatcher
  ;

{ TvcmCustAvailableToolbarOps }

function TvcmCustAvailableToolbarOps.AnalyzeOpForCurrentUseCase: Boolean;
begin
 Result := False;
end;

class function TvcmCustAvailableToolbarOps.Make(const aForm: IvcmEntityForm): IvcmCustOps;
var
 l_Class : TvcmCustAvailableToolbarOps;
 l_Index : Integer;
begin
 l_Class := Create(vcmAvailableOpsForCustomizeToolbar);
 try
  with l_Class do
  begin
   f_Form := aForm;
   IvcmLockListener_Lock;
   try
    AddForm(aForm);
    // Для главной формы также доступны операции модулей:
    if Supports(aForm, IvcmMainForm) then
     for l_Index := 0 to Pred(TvcmDispatcher.Instance.ModulesCount) do
      AddModule(TvcmDispatcher.Instance.Module[l_Index].ModuleDef);
   finally
    IvcmLockListener_BeforeUnlock;
   end;
  end;
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

function TvcmCustAvailableToolbarOps.pm_GetForm: IvcmEntityForm;
begin
 Result := f_Form;
end;

end.
