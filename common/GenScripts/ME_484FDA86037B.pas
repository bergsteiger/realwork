unit atSaveListToFolderOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atSaveListToFolderOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatSaveListToFolderOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
 end;//TatSaveListToFolderOperation

implementation

uses
 l3ImplUses
 , atLogger
 , atFoldersHelper
 , BaseTreeSupportUnit
 , BaseTypesUnit
 , DynamicDocListUnit
 , atGblAdapterWorker
 , DynamicTreeUnit
 , SysUtils
 , atCommon
 , atStringHelper
;

procedure TatSaveListToFolderOperation.ExecuteSelf;
//#UC START# *48089F460352_484FDA86037B_var*
  var
    l_ListName : String;
    l_AddedNode : INode;
    l_List : IDynList;
    l_IsSaveToCurrentFolder : Boolean;
//#UC END# *48089F460352_484FDA86037B_var*
begin
//#UC START# *48089F460352_484FDA86037B_impl*
  Assert(ExecutionContext.UserWorkContext.CurrList <> nil, 'ExecutionContext.UserWorkContext.CurrList <> nil');
  // разбираем параметры
  l_ListName := Parameters['list_name'].AsStr;
  l_IsSaveToCurrentFolder := Parameters['is_save_to_current_folder'].AsBool;
  //
  l_List := ExecutionContext.UserWorkContext.CurrList;//l_Clone as IDynList;
  // присваеваем имя
  if (l_ListName = '') then
    l_ListName := 'Список сохраненный ' + GetTimeStamp;
  l_List.SetName( TatStringHelper.DStr2AStr(l_ListName) );
  // сохраняем куда сказано
  if l_IsSaveToCurrentFolder then
    TatFoldersHelper.AddToFolder( ExecutionContext.UserWorkContext.CurrFolder, l_List as IEntityBase, l_AddedNode )
  else
    TatFoldersHelper.AddToMyDocuments( l_List as IEntityBase, l_AddedNode);
  Assert(l_AddedNode <> nil, 'l_SavedList <> nil');
//#UC END# *48089F460352_484FDA86037B_impl*
end;//TatSaveListToFolderOperation.ExecuteSelf

procedure TatSaveListToFolderOperation.InitParamList;
//#UC START# *48089F3701B4_484FDA86037B_var*
//#UC END# *48089F3701B4_484FDA86037B_var*
begin
//#UC START# *48089F3701B4_484FDA86037B_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('list_name', 'Имя списка', '') );
    Add( ParamType.Create('is_save_to_current_folder', 'Сохранять список в текущую папку', 'false') );
  end;
//#UC END# *48089F3701B4_484FDA86037B_impl*
end;//TatSaveListToFolderOperation.InitParamList

end.
