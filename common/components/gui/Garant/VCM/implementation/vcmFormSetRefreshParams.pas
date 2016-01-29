unit vcmFormSetRefreshParams;
{* Параметры обновления представления сборки. }

// Библиотека : "vcm"
// Автор      : Морозов. М.А.
// Модуль     : vcmInterfaces -
// Начат      : 21.06.2007
// Версия     : $Id: vcmFormSetRefreshParams.pas,v 1.5 2015/08/19 07:03:52 morozov Exp $ }

(*-------------------------------------------------------------------------------
  $Log: vcmFormSetRefreshParams.pas,v $
  Revision 1.5  2015/08/19 07:03:52  morozov
  {RequestLink: 604494984}

  Revision 1.4  2014/09/16 15:33:24  kostitsin
  {requestlink: 555385722 }

  Revision 1.3  2014/09/16 15:24:48  kostitsin
  {requestlink: 564993742 }

  Revision 1.2  2008/11/28 19:38:40  lulin
  - избавляемся от "прокидывания данных".

  Revision 1.1  2007/06/22 08:56:23  mmorozov
  - new: параметры обновления представления сборки оформлены интерфейсом;

-------------------------------------------------------------------------------*)

interface

uses
  vcmInterfaces
  ;

function vcmMakeDataRefreshParams(const aSaveToHistory  : TvcmSaveFormSetToHistory = sfsNone;
                                  const aDataForHistory : IvcmData = nil;
                                  aLockSetFocusToMainObjectForm: Boolean = True;
                                  const aFormSetToClone : IvcmFormSet = nil): IvcmFormSetRefreshDataParams;
  {-}
function vcmMakeRefreshParams(const aParams        : IvcmFormSetRefreshDataParams;
                              const aDataSource    : IvcmFormSetDataSource;
                              const aFormSet       : IvcmFormSet;
                              const aFormSetToClone : IvcmFormSet = nil): IvcmFormSetRefreshParams;
  {-}

implementation

uses
  SysUtils,
  
  vcmBase
  ;

type

  TvcmFormSetRefreshParams = class(TvcmBase,
                                   IvcmFormSetRefreshParams)
  {* Элемент стека обновления. }
  private
  // internal methods
    f_DataSource     : IvcmFormSetDataSource;
    f_FormSet        : IvcmFormSet;
    f_SaveToHistory  : TvcmSaveFormSetToHistory;
    f_DataForHistory : IvcmData;
    f_LockSetFocusToMainObjectForm: Boolean;
    f_FormSetToClone : IvcmFormSet;
  private
  // IvcmFormSetRefreshParams
    function pm_GetLockSetFocusToMainObjectForm: Boolean;
    procedure pm_SetLockSetFocusToMainObjectForm(aValue: Boolean);
    function pm_GetDataForHistory: IvcmData;
      {-}
    function pm_GetDataSource: IvcmFormSetDataSource;
    procedure pm_SetDataSource(const aValue: IvcmFormSetDataSource);
      {-}
    function pm_GetFormSet: IvcmFormSet;
    procedure pm_SetFormSet(const aValue: IvcmFormSet);
      {-}
    function pm_GetSaveToHistory: TvcmSaveFormSetToHistory;
      {-}
    function pm_GetFormSetToClone: IvcmFormSet;
      {-}
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
  public
  // public methods
    constructor Create(const aDataSource     : IvcmFormSetDataSource;
                       const aFormSet        : IvcmFormSet;
                       const aSaveToHistory  : TvcmSaveFormSetToHistory;
                       const aDataForHistory : IvcmData;
                       aLockSetFocusToMainObjectForm: Boolean;
                       const aFormSetToClone : IvcmFormSet = nil);
      reintroduce;
      {-}
    class function Make(const aDataSource     : IvcmFormSetDataSource;
                        const aFormSet        : IvcmFormSet;
                        const aSaveToHistory  : TvcmSaveFormSetToHistory = sfsNone;
                        const aDataForHistory : IvcmData = nil;
                        aLockSetFocusToMainObjectForm: Boolean = True;
                        const aFormSetToClone : IvcmFormSet = nil): IvcmFormSetRefreshParams;
      {-}
  public
  // public properties
    property DataSource: IvcmFormSetDataSource
      read pm_GetDataSource;
      {-}
    property FormSet: IvcmFormSet
      read pm_GetFormSet;
      {-}
    property SaveToHistory: TvcmSaveFormSetToHistory
      read pm_GetSaveToHistory;
      {-}
    property DataForHistory: IvcmData
      read pm_GetDataForHistory;
      {-}
    property FormSetToClone: IvcmFormSet
      read pm_GetFormSetToClone;
  end;//TvcmFormSetRefreshParams

function vcmMakeRefreshParams(const aParams     : IvcmFormSetRefreshDataParams;
                              const aDataSource : IvcmFormSetDataSource;
                              const aFormSet    : IvcmFormSet;
                              const aFormSetToClone : IvcmFormSet = nil): IvcmFormSetRefreshParams;
  {-}
begin
 if Supports(aParams, IvcmFormSetRefreshParams, Result) then
  with Result do
  begin
   DataSource := aDataSource;
   FormSet := aFormSet
  end//with Result do
 else
  if aParams <> nil then
   Result := TvcmFormSetRefreshParams.Make(aDataSource,
                                           aFormSet,
                                           aParams.SaveToHistory,
                                           aParams.DataForHistory,
                                           aParams.LockSetFocusToMainObjectForm,
                                           aParams.FormSetToClone)
  else
   Result := TvcmFormSetRefreshParams.Make(aDataSource, aFormSet);
end;

function vcmMakeDataRefreshParams(const aSaveToHistory  : TvcmSaveFormSetToHistory = sfsNone;
                                  const aDataForHistory : IvcmData = nil;
                                  aLockSetFocusToMainObjectForm: Boolean = True;
                                  const aFormSetToClone : IvcmFormSet = nil): IvcmFormSetRefreshDataParams;
  {-}
begin
 Result := TvcmFormSetRefreshParams.Make(nil,
                                         nil,
                                         aSaveToHistory,
                                         aDataForHistory,
                                         aLockSetFocusToMainObjectForm,
                                         aFormSetToClone);
end;

{ TvcmFormSetRefreshParams }

procedure TvcmFormSetRefreshParams.Cleanup;
  // override;
  {-}
begin
 f_DataForHistory := nil;
 f_DataSource := nil;
 f_FormSet := nil;
 inherited;
end;//Cleanup

constructor TvcmFormSetRefreshParams.Create(const aDataSource     : IvcmFormSetDataSource;
                                            const aFormSet        : IvcmFormSet;
                                            const aSaveToHistory  : TvcmSaveFormSetToHistory;
                                            const aDataForHistory : IvcmData;
                                            aLockSetFocusToMainObjectForm: Boolean;
                                            const aFormSetToClone : IvcmFormSet);
  // reintroduce;
  {-}
begin
 inherited Create;
 f_DataSource := aDataSource;
 f_FormSet := aFormSet;
 f_SaveToHistory := aSaveToHistory;
 f_DataForHistory := aDataForHistory;
 f_LockSetFocusToMainObjectForm := aLockSetFocusToMainObjectForm;
 f_FormSetToClone := aFormSetToClone;
end;//Create

class function TvcmFormSetRefreshParams.Make(const aDataSource     : IvcmFormSetDataSource;
                                             const aFormSet        : IvcmFormSet;
                                             const aSaveToHistory  : TvcmSaveFormSetToHistory = sfsNone;
                                             const aDataForHistory : IvcmData = nil;
                                             aLockSetFocusToMainObjectForm: Boolean = True;
                                             const aFormSetToClone : IvcmFormSet = nil): IvcmFormSetRefreshParams;
      {-}
var
 l_Class: TvcmFormSetRefreshParams;
begin
 l_Class := Create(aDataSource, aFormSet, aSaveToHistory, aDataForHistory,
  aLockSetFocusToMainObjectForm, aFormSetToClone);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TvcmFormSetRefreshParams.pm_GetDataForHistory: IvcmData;
begin
 Result := f_DataForHistory;
end;//pm_GetDataForHistory

function TvcmFormSetRefreshParams.pm_GetDataSource: IvcmFormSetDataSource;
begin
 Result := f_DataSource;
end;//pm_GetDataSource

function TvcmFormSetRefreshParams.pm_GetFormSet: IvcmFormSet;
begin
 Result := f_FormSet;
end;//pm_GetFormSet

function TvcmFormSetRefreshParams.pm_GetLockSetFocusToMainObjectForm: Boolean;
begin
 Result := f_LockSetFocusToMainObjectForm
end;

procedure TvcmFormSetRefreshParams.pm_SetLockSetFocusToMainObjectForm(
  aValue: Boolean);
begin
 f_LockSetFocusToMainObjectForm := aValue;
end;

function TvcmFormSetRefreshParams.pm_GetSaveToHistory: TvcmSaveFormSetToHistory;
begin
 Result := f_SaveToHistory;
end;//pm_GetSaveToHistory

function TvcmFormSetRefreshParams.pm_GetFormSetToClone: IvcmFormSet;
begin
 Result := f_FormSetToClone;
end;

procedure TvcmFormSetRefreshParams.pm_SetDataSource(const aValue: IvcmFormSetDataSource);
begin
 f_DataSource := aValue;
end;//pm_SetDataSource

procedure TvcmFormSetRefreshParams.pm_SetFormSet(const aValue: IvcmFormSet);
begin
 f_FormSet := aValue;
end;//pm_SetFormSet

end.
