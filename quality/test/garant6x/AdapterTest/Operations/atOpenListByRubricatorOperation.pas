unit atOpenListByRubricatorOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atOpenListByRubricatorOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatOpenListByRubricatorOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatOpenListByRubricatorOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatOpenListByRubricatorOperation

implementation

uses
  atNodeHelper,
  atListHelper,
  DynamicDocListUnit,
  DynamicTreeUnit,
  BaseTypesUnit,
  atLogger,
  SysUtils,
  Classes
  ;

// start class TatOpenListByRubricatorOperation

procedure TatOpenListByRubricatorOperation.ExecuteSelf;
//#UC START# *48089F460352_4B97918002C8_var*
  var
    l_PathStr : String;
    l_Node, l_ListRoot : INodeBase;
    l_Entity : IEntityBase;
    l_DynList : IDynList;
//#UC END# *48089F460352_4B97918002C8_var*
begin
//#UC START# *48089F460352_4B97918002C8_impl*
  inherited;
  //
  l_PathStr := Parameters['path'].AsStr;
  //
  Logger.Info('Попытаемся открыть список в рубрикаторе по пути "%s"', [l_PathStr]);

  // ищем ноду
  l_Node := TatNodeHelper.FindNodeByPath(
    ExecutionContext.GblAdapterWorker.MainMenuRoot,
    l_PathStr,
    '\',
    true
  );
  if (l_Node = nil) then
  begin
    Logger.Error('Указанный путь не существует!');
    Exit;
  end;

  // получаем список
  try
    l_Node.GetEntity(l_Entity);
  except
    on ex : ENoEntity do
    begin
      Logger.Error('Ничего не открылось!');
      Exit;
    end;
  end;
  // открываем список
  if Supports(l_Entity, IDynList, l_DynList) then
  begin
    TatListHelper.LoadList(l_DynList, 20);
    //
    l_DynList.GetRoot(l_ListRoot);
    Assert(l_ListRoot <> nil, 'l_ListRoot <> nil');
    Logger.Info('Получили список. В нем %d документов', [l_ListRoot.GetChildCount]);
    ExecutionContext.UserWorkContext.AddListToHistory(l_DynList);
  end
  else
    Logger.Error('Не могу получить IDynList');
//#UC END# *48089F460352_4B97918002C8_impl*
end;//TatOpenListByRubricatorOperation.ExecuteSelf

procedure TatOpenListByRubricatorOperation.InitParamList;
//#UC START# *48089F3701B4_4B97918002C8_var*
//#UC END# *48089F3701B4_4B97918002C8_var*
begin
//#UC START# *48089F3701B4_4B97918002C8_impl*
  inherited;
  //
  with f_ParamList do
  begin
    Add( ParamType.Create('path') );
  end;
//#UC END# *48089F3701B4_4B97918002C8_impl*
end;//TatOpenListByRubricatorOperation.InitParamList

end.