unit atSemaphoreOperation;
 {* Обеспечивает выполнение вложенных операций одновременно не более чем заданному количеству клиентов }

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atSemaphoreOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSemaphoreOperation" MUID: (4A4DF86D0208)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatSemaphoreOperation = class(TatOperationBase)
  {* Обеспечивает выполнение вложенных операций одновременно не более чем заданному количеству клиентов }
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
   procedure ExecuteChilds; override;
 end;//TatSemaphoreOperation

implementation

uses
 l3ImplUses
 , atFileBasedSemaphore
 , atLogger
 , SysUtils
;

procedure TatSemaphoreOperation.ExecuteSelf;
//#UC START# *48089F460352_4A4DF86D0208_var*
  var
    l_PathToFile : String;
    l_MaxEntered, l_Timeout : Integer;
    l_TFBS : TatFileBasedSemaphore;
//#UC END# *48089F460352_4A4DF86D0208_var*
begin
//#UC START# *48089F460352_4A4DF86D0208_impl*
  inherited;
  l_PathToFile := Parameters['path_to_file'].AsStr;
  l_MaxEntered := Parameters['max_entered'].AsInt;
  l_Timeout := Parameters['timeout'].AsInt;
  //
  l_TFBS := TatFileBasedSemaphore.Create(l_PathToFile, l_MaxEntered);
  try
    Logger.Info('Ждем входа в секцию защищеную семафором');
    if l_TFBS.Enter(l_Timeout) then
    begin
      Logger.Info('Вошли в секцию, защищеную семафором');
      try
        inherited ExecuteChilds;
      finally
        l_TFBS.Leave();
        Logger.Info('Покинули секцию, защищеную семафором');
      end;
    end
    else
      Logger.Info('Не удалось войти в защищеную секцию в течение %d мс', [l_Timeout]);
  finally
    FreeAndNil(l_TFBS);
  end;
//#UC END# *48089F460352_4A4DF86D0208_impl*
end;//TatSemaphoreOperation.ExecuteSelf

procedure TatSemaphoreOperation.InitParamList;
//#UC START# *48089F3701B4_4A4DF86D0208_var*
//#UC END# *48089F3701B4_4A4DF86D0208_var*
begin
//#UC START# *48089F3701B4_4A4DF86D0208_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('max_entered', 'Максимальное количество вошедших', '1') );
    Add( ParamType.Create('timeout', 'Максимальное время ожидания', '-1') );
    Add( ParamType.Create('path_to_file', 'Путь к файлу') );
  end;
//#UC END# *48089F3701B4_4A4DF86D0208_impl*
end;//TatSemaphoreOperation.InitParamList

procedure TatSemaphoreOperation.ExecuteChilds;
//#UC START# *48089F660238_4A4DF86D0208_var*
//#UC END# *48089F660238_4A4DF86D0208_var*
begin
//#UC START# *48089F660238_4A4DF86D0208_impl*
  // дети явно выполняются в ExecuteSelf
//#UC END# *48089F660238_4A4DF86D0208_impl*
end;//TatSemaphoreOperation.ExecuteChilds

end.
