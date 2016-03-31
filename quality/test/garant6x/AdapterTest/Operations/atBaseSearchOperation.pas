unit atBaseSearchOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atBaseSearchOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatBaseSearchOperation" MUID: (483D28C30393)

interface

uses
 l3IntfUses
 , atOperationBase
 , atBaseSearchHelper
 , atStringProvider
;

type
 _atHasStringParamAddOn_Parent_ = TatOperationBase;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atHasStringParamAddOn.imp.pas}
 TatBaseSearchOperation = class(_atHasStringParamAddOn_)
  private
   f_SearchNumber: Integer;
   f_BaseSearchHelper: TatBaseSearchHelper;
  protected
   function OnString(const aString: AnsiString): Boolean; override;
   procedure InitParamList; override;
   procedure ExecuteSelf; override;
   procedure ExecuteChilds; override;
 end;//TatBaseSearchOperation

implementation

uses
 l3ImplUses
 , SysUtils
 , atLogger
 , atSyncedStringFileReader
 , atStringFileReader
 , atConstStringProvider
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atHasStringParamAddOn.imp.pas}

function TatBaseSearchOperation.OnString(const aString: AnsiString): Boolean;
//#UC START# *503648620273_483D28C30393_var*
//#UC END# *503648620273_483D28C30393_var*
begin
//#UC START# *503648620273_483D28C30393_impl*
  Result := true;
  //
  Inc(f_SearchNumber);
  Logger.Info('Поиск № %d. Проверяем контекст "%s" на валидность.', [f_SearchNumber, aString]);
  // контекст
  f_BaseSearchHelper.Context := aString;

  if (f_BaseSearchHelper.InvalidWords <> '') then
  begin // контекст плохой, ругаемся
    Logger.Error('Задан невалидный контекст! Список неправильных слов: "%s". Скорректированный контекст: "%s".',
      [f_BaseSearchHelper.InvalidWords, f_BaseSearchHelper.CorrectedContext]
    );
  end
  else
  begin // контекст хороший, ищем
    f_BaseSearchHelper.Context := f_BaseSearchHelper.CorrectedContext;
    // выполняем поиск и обрабатываем результат
    Logger.Info('Контекст валидный. Начинаем поиск. Контекст: %s. Тип правовой информации: %s.', [f_BaseSearchHelper.Context, f_BaseSearchHelper.InfoKind]);
    if f_BaseSearchHelper.ExecuteAndBuildList then
    begin
      ExecutionContext.UserWorkContext.AddListToHistory(f_BaseSearchHelper.List);
      // вызываем детей
      inherited ExecuteChilds;
    end;
  end;  
//#UC END# *503648620273_483D28C30393_impl*
end;//TatBaseSearchOperation.OnString

procedure TatBaseSearchOperation.InitParamList;
//#UC START# *48089F3701B4_483D28C30393_var*
//#UC END# *48089F3701B4_483D28C30393_var*
begin
//#UC START# *48089F3701B4_483D28C30393_impl*
  inherited;
  with f_ParamList do
  begin
    AddAlias('str.value', 'query_text'); // Текст запроса
    AddAlias('str.file', 'query_text_file_name'); // Файл с текстами запроса
    AddAlias('str.max_count', 'from_file_searches_count'); // Сколько делать поисков
    AddAlias('str.is_random', 'is_random_context'); // Использовать случайный контекст из файла
    //
    Add( ParamType.Create('info_kind', 'Тип правовой информации', 'все документы') );
    Add( ParamType.Create('is_short_list', 'Получать короткий список', 'false') );
  end;
//#UC END# *48089F3701B4_483D28C30393_impl*
end;//TatBaseSearchOperation.InitParamList

procedure TatBaseSearchOperation.ExecuteSelf;
//#UC START# *48089F460352_483D28C30393_var*
  var
    l_InfoKindStr  : String;
    l_IsShortList : Boolean;
//#UC END# *48089F460352_483D28C30393_var*
begin
//#UC START# *48089F460352_483D28C30393_impl*
  l_InfoKindStr := Parameters['info_kind'].AsStr;
  l_IsShortList := Parameters['is_short_list'].AsBool;
  //
  f_BaseSearchHelper := TatBaseSearchHelper.Create();
  try
    // устанавливаем параметры поиска
    // вид правовой информации
    try
      f_BaseSearchHelper.InfoKind := l_InfoKindStr;
    except
      on EUnknownInfoKind do
      begin
        Logger.Error('Указан неизвестный тип правовой информации: "%s"', [l_InfoKindStr]);
        Exit;
      end;
    end;
    // короткий список
    f_BaseSearchHelper.IsShortList := l_IsShortList;

    f_SearchNumber := 0;

    //
    inherited;
  finally
    FreeAndNil(f_BaseSearchHelper);
  end;
//#UC END# *48089F460352_483D28C30393_impl*
end;//TatBaseSearchOperation.ExecuteSelf

procedure TatBaseSearchOperation.ExecuteChilds;
//#UC START# *48089F660238_483D28C30393_var*
//#UC END# *48089F660238_483D28C30393_var*
begin
//#UC START# *48089F660238_483D28C30393_impl*
  // дети вызываются явно в ExecuteSelf
//#UC END# *48089F660238_483D28C30393_impl*
end;//TatBaseSearchOperation.ExecuteChilds

end.
