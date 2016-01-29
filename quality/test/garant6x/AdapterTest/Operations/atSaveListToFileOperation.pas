unit atSaveListToFileOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atSaveListToFileOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatSaveListToFileOperation
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
 TatSaveListToFileOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatSaveListToFileOperation

implementation

uses
  atComparableList,
  SysUtils,
  atLogger
  ;

// start class TatSaveListToFileOperation

procedure TatSaveListToFileOperation.ExecuteSelf;
//#UC START# *48089F460352_539730EE009E_var*
  var
    l_FileName : String;
//#UC END# *48089F460352_539730EE009E_var*
begin
//#UC START# *48089F460352_539730EE009E_impl*
   l_FileName := Parameters['file_name'].AsStr;

   with TatComparableList.Create(ExecutionContext.UserWorkContext.CurrList) do
   try
     SaveToFile(l_FileName);
   finally
     Free;
   end;
   Logger.Info('Текущий список сохранен в файл %s', [l_FileName]);   
//#UC END# *48089F460352_539730EE009E_impl*
end;//TatSaveListToFileOperation.ExecuteSelf

procedure TatSaveListToFileOperation.InitParamList;
//#UC START# *48089F3701B4_539730EE009E_var*
//#UC END# *48089F3701B4_539730EE009E_var*
begin
//#UC START# *48089F3701B4_539730EE009E_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('file_name', 'Файл в который записываем список') );
  end;
//#UC END# *48089F3701B4_539730EE009E_impl*
end;//TatSaveListToFileOperation.InitParamList

end.