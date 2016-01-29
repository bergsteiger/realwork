{$IfNDef atProcessFoldersObjectOperation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atProcessFoldersObjectOperation.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::Operations::atProcessFoldersObjectOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atProcessFoldersObjectOperation_imp}
 _atProcessFoldersObjectOperation_ = {abstract mixin} class(TatOperationBase, IatFoldersNodeCallback)
 protected
 // realized methods
   procedure ExecuteSelf; override;
   procedure OnFoldersNode(const aFoldersNode: IFoldersNode);
 protected
 // overridden protected methods
   procedure InitParamList; override;
 protected
 // protected fields
   f_Matcher : IatFoldersNodeMatcher;
   f_ProcessedObjects : Integer;
 protected
 // protected methods
   procedure InitMatcher; virtual;
 end;//_atProcessFoldersObjectOperation_

{$Else atProcessFoldersObjectOperation_imp}

// start class _atProcessFoldersObjectOperation_

procedure _atProcessFoldersObjectOperation_.InitMatcher;
//#UC START# *484FDD22003E_484FDCD001F4_var*
//#UC END# *484FDD22003E_484FDCD001F4_var*
begin
//#UC START# *484FDD22003E_484FDCD001F4_impl*
  // здесь просто создаем сравниватель
  f_Matcher := _FoldersNodeMatcher_.Make;
  Assert(f_Matcher <> nil, 'f_Matcher <> nil');
//#UC END# *484FDD22003E_484FDCD001F4_impl*
end;//_atProcessFoldersObjectOperation_.InitMatcher

procedure _atProcessFoldersObjectOperation_.ExecuteSelf;
//#UC START# *48089F460352_484FDCD001F4_var*
  var
    l_IsFromCurrentFolder : Boolean;
    l_IsRecursive : Boolean;
    l_RootFolder : IFoldersNode;
//#UC END# *48089F460352_484FDCD001F4_var*
begin
//#UC START# *48089F460352_484FDCD001F4_impl*
  f_ProcessedObjects := 0;
  InitMatcher;
  //
  l_IsFromCurrentFolder := Parameters['is_from_current_folder'].AsBool;
  l_IsRecursive := Parameters['is_recursive'].AsBool;
  //
  if l_IsFromCurrentFolder then
    l_RootFolder := ExecutionContext.USerWorkContext.CurrFolder
  else
    l_RootFolder := TatFoldersHelper.GetMyDocuments;
  Assert(l_RootFolder <> nil, 'l_RootFolder <> nil');
  // обрабатывем объекты
  TatFoldersHelper.IterateAllChildFoldersNode(l_RootFolder, Self as IatFoldersNodeCallback, f_Matcher, l_IsRecursive );
//#UC END# *48089F460352_484FDCD001F4_impl*
end;//_atProcessFoldersObjectOperation_.ExecuteSelf

procedure _atProcessFoldersObjectOperation_.OnFoldersNode(const aFoldersNode: IFoldersNode);
//#UC START# *4FCF8EE001D4_484FDCD001F4_var*
//#UC END# *4FCF8EE001D4_484FDCD001F4_var*
begin
//#UC START# *4FCF8EE001D4_484FDCD001F4_impl*
  inherited;
  Inc(f_ProcessedObjects);
//#UC END# *4FCF8EE001D4_484FDCD001F4_impl*
end;//_atProcessFoldersObjectOperation_.OnFoldersNode

procedure _atProcessFoldersObjectOperation_.InitParamList;
//#UC START# *48089F3701B4_484FDCD001F4_var*
//#UC END# *48089F3701B4_484FDCD001F4_var*
begin
//#UC START# *48089F3701B4_484FDCD001F4_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('is_from_current_folder', 'Читать из текущей папки', 'false') );
    Add( ParamType.Create('is_recursive', 'Читать рекурсивно', 'false') );
  end;
//#UC END# *48089F3701B4_484FDCD001F4_impl*
end;//_atProcessFoldersObjectOperation_.InitParamList

{$EndIf atProcessFoldersObjectOperation_imp}
