unit atIterateDocumentsUnderControlOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atIterateDocumentsUnderControlOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatIterateDocumentsUnderControlOperation" MUID: (50507A250036)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatIterateDocumentsUnderControlOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
   procedure ExecuteChilds; override;
 end;//TatIterateDocumentsUnderControlOperation

implementation

uses
 l3ImplUses
 , atLogger
 , UnderControlUnit
 , DocumentUnit
 , atControlStatusConverter
 //#UC START# *50507A250036impl_uses*
 //#UC END# *50507A250036impl_uses*
;

procedure TatIterateDocumentsUnderControlOperation.ExecuteSelf;
//#UC START# *48089F460352_50507A250036_var*
  var
    l_Controlled : IControlledObjects;
    l_Controllable : IControllable;
    l_IsOnlyWithStatus : Boolean;
    l_Object : IUnknown;
    l_Document : IDocument;
    i : Integer;
//#UC END# *48089F460352_50507A250036_var*
begin
//#UC START# *48089F460352_50507A250036_impl*
  l_IsOnlyWithStatus := Parameters['is_only_with_status'].AsBool;
  //
  ExecutionContext.GblAdapterWorker.ControlManager.GetControlledObjects(l_Controlled);
  if (l_Controlled = nil) OR (l_Controlled.Count = 0) then
  begin
    Logger.Info('Нет объектов на контроле');
    Exit;
  end
  else
    Logger.Info('Всего на контроле стоит %d объектов', [l_Controlled.Count]);
  //
  for i := 0 to l_Controlled.Count-1 do
  begin
    l_Controlled.pm_GetItem(i, l_Controllable);
    //
    if (l_Controllable.GetType = CIT_DOCUMENT)
      AND ((NOT l_IsOnlyWithStatus) OR (l_Controllable.GetControlStatus <> 0)) then
    begin
      l_Controllable.Open(l_Object);
      l_Document := l_Object as IDocument;
      Logger.Info('Документ %d со статусом "%s"', [l_Document.GetInternalId,
        TatControlStatusConverter.Instance.ToValues(l_Controllable.GetControlStatus, '; ')]);
      ExecutionContext.UserWorkContext.AddDocToHistory(l_Document);
      inherited ExecuteChilds;
    end;
  end;
//#UC END# *48089F460352_50507A250036_impl*
end;//TatIterateDocumentsUnderControlOperation.ExecuteSelf

procedure TatIterateDocumentsUnderControlOperation.InitParamList;
//#UC START# *48089F3701B4_50507A250036_var*
//#UC END# *48089F3701B4_50507A250036_var*
begin
//#UC START# *48089F3701B4_50507A250036_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('is_only_with_status', 'Только со статусом измененности', 'false') );
  end;
//#UC END# *48089F3701B4_50507A250036_impl*
end;//TatIterateDocumentsUnderControlOperation.InitParamList

procedure TatIterateDocumentsUnderControlOperation.ExecuteChilds;
//#UC START# *48089F660238_50507A250036_var*
//#UC END# *48089F660238_50507A250036_var*
begin
//#UC START# *48089F660238_50507A250036_impl*
  //
//#UC END# *48089F660238_50507A250036_impl*
end;//TatIterateDocumentsUnderControlOperation.ExecuteChilds

end.
