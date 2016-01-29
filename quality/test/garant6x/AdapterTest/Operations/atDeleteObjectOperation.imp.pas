{$IfNDef atDeleteObjectOperation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atDeleteObjectOperation.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::Operations::atDeleteObjectOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atDeleteObjectOperation_imp}
 _atDeleteObjectOperation_ = {mixin} class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 protected
 // protected fields
   f_Matcher : IatFoldersNodeMatcher;
 protected
 // protected methods
   procedure InitMatcher; virtual;
 end;//_atDeleteObjectOperation_

{$Else atDeleteObjectOperation_imp}

// start class _atDeleteObjectOperation_

procedure _atDeleteObjectOperation_.InitMatcher;
//#UC START# *484FDD22003E_484FDCD001F4_var*
//#UC END# *484FDD22003E_484FDCD001F4_var*
begin
//#UC START# *484FDD22003E_484FDCD001F4_impl*
  // здесь просто создаем сравниватель
  f_Matcher := _FoldersNodeMatcher_.Make;
  Assert(f_Matcher <> nil, 'f_Matcher <> nil');
//#UC END# *484FDD22003E_484FDCD001F4_impl*
end;//_atDeleteObjectOperation_.InitMatcher

procedure _atDeleteObjectOperation_.ExecuteSelf;
//#UC START# *48089F460352_484FDCD001F4_var*
  var
    l_DelCount : Integer;
    l_IsDeleteFromCurrentFolder : Boolean;
    l_IsRecursive : Boolean;
    l_RootFolder : IFoldersNode;
//#UC END# *48089F460352_484FDCD001F4_var*
begin
//#UC START# *48089F460352_484FDCD001F4_impl*
  InitMatcher;
  //
  l_IsDeleteFromCurrentFolder := Parameters['is_delete_from_current_folder'].AsBool;
  l_IsRecursive := Parameters['is_recursive'].AsBool;
  //
  if l_IsDeleteFromCurrentFolder then
    l_RootFolder := ExecutionContext.USerWorkContext.CurrFolder
  else
    l_RootFolder := TatFoldersHelper.GetMyDocuments;
  Assert(l_RootFolder <> nil, 'l_RootFolder <> nil');
  // удаляем объекты
  l_DelCount := TatFoldersHelper.DeleteAllChildFoldersNode(l_RootFolder, f_Matcher, l_IsRecursive );
  // пишем в лог
  Logger.Info('Удалено %d объектов.', [l_DelCount]);
//#UC END# *48089F460352_484FDCD001F4_impl*
end;//_atDeleteObjectOperation_.ExecuteSelf

procedure _atDeleteObjectOperation_.InitParamList;
//#UC START# *48089F3701B4_484FDCD001F4_var*
//#UC END# *48089F3701B4_484FDCD001F4_var*
begin
//#UC START# *48089F3701B4_484FDCD001F4_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('is_delete_from_current_folder', 'Удалять из текущей папки', 'false') );
    Add( ParamType.Create('is_recursive', 'Удалять рекурсивно', 'false') );
  end;
//#UC END# *48089F3701B4_484FDCD001F4_impl*
end;//_atDeleteObjectOperation_.InitParamList

{$EndIf atDeleteObjectOperation_imp}
