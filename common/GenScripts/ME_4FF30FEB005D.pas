unit atLoginFromListOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atLoginFromListOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
 , atLockFile
;

type
 TatLoginFromListOperation = class(TatOperationBase)
  private
   f_LockFile: TatLockFile;
   f_IsLoop: Boolean;
   f_UsedFN: AnsiString;
   f_FreeFN: AnsiString;
   f_LPStr: AnsiString;
  protected
   procedure ExecuteSelf; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitParamList; override;
  public
   procedure AfterFillingParamList; override;
    {* Вызывается генератором сценария после заполнения значений параметров.
Если операции надо что-то инициализировать, и для этого нужны значения параметров из сценария. }
 end;//TatLoginFromListOperation

implementation

uses
 l3ImplUses
 , Classes
 , SysUtils
 , atLogger
 , atLoginOperation
 , XMLDoc
 , XMLIntf
;

procedure TatLoginFromListOperation.ExecuteSelf;
//#UC START# *48089F460352_4FF30FEB005D_var*
  const
    WAIT_TIME = 5000;
    LP_DELIM : Char = #01;
  var
    l_LoginsFN : String;
    l_LP : TStringList;
    l_Login, l_Password : String;
    l_IsWait : Boolean;

  // заполняем f_LP из текстового файла, где построчно записаны логины и пароли, разделенные пробелами
  procedure FillLPFromTextFile;
    var
      i : Integer;
      l_Str : String;
  begin
    with TStringList.Create do
    try
      CaseSensitive := true;
      Duplicates := dupError;
      //
      try
        LoadFromFile(l_LoginsFN);
      except
        on ex : EStringListError do
        begin
          Logger.Error('Ошибка при чтении файла с логинами-паролями: %s', [ex.Message]);
          Raise;
        end;
      end;
      for i:= 0 to Count-1 do
      begin
        l_Str := StringReplace(TrimLeft(Strings[i]), ' ', LP_DELIM, []);
        if l_Str <> '' then
        begin
          if Pos(LP_DELIM, l_Str) = 0 then
            l_Str := l_Str + LP_DELIM;
          l_LP.Append(l_Str);
        end;
      end;
    finally
      Free;
    end;
  end;

  procedure FillLPFromXML;
    var
      i : Integer;
  begin
    with TXMLDocument.Create(l_LoginsFN) as IXMLDocument do
      with ChildNodes.Nodes['profiles'].ChildNodes do
        for i := 0 to Count-1 do
          with Nodes[i] do
            if (NodeName = 'user') and NOT AnsiSameText(Attributes['login'], 'ADMIN') then
              l_LP.Append(Attributes['login'] + LP_DELIM + Attributes['password']);
  end;

//#UC END# *48089F460352_4FF30FEB005D_var*
begin
//#UC START# *48089F460352_4FF30FEB005D_impl*
  l_LoginsFN := Parameters['logins_file'].AsStr;
  if NOT FileExists(l_LoginsFN) then
  begin
    Logger.Error('Не найден файл с логинами-паролями %s', [l_LoginsFN]);
    Exit;
  end;

  // файлы данных будем располагать там же где и файл синхронизации
  f_FreeFN := f_LockFile.FileName + '.free.data';
  f_UsedFN := f_LockFile.FileName + '.used.data';

  l_LP := TStringList.Create;
  l_LP.Duplicates := dupError;
  l_LP.CaseSensitive := true;
  try
    l_IsWait := false;
    // получаем строку с парой логин-пароль
    while (f_LPStr = '') do
    begin
      if l_IsWait then
        Sleep(WAIT_TIME);
      //
      if f_LockFile.Acquire then
      try
        // пробуем загрузить свободные логины-пароли из файла свободных
        if FileExists(f_FreeFN) then
        begin
          l_LP.LoadFromFile(f_FreeFN);
          if l_LP.Count = 0 then // кончились свободные логины
            if f_IsLoop then
            begin // крутимся в цикле пока не появятся свободные
              Logger.Info('Свободных логинов пока нет, ждем когда освободятся...');
              l_IsWait := true;
              continue;
            end
            else
            begin
              Logger.Info('Свободные логины закончились, завершаем работу');
              Abort;
            end;
        end
        else // файла нет, заполняем из исходного
        begin
          if AnsiSameText(ExtractFileExt(l_LoginsFN), '.xml') then
            FillLPFromXML
          else
            FillLPFromTextFile;
          if l_LP.Count = 0 then
          begin
            Logger.Error('Не получилось найти в файле "%s" ни одного логина', [l_LoginsFN]);
            Abort;
          end;
        end;

        // к этой строке есть кем логиниться
        // извлекаем первую строку с логином-паролем
        f_LPStr := l_LP.Strings[0];
        l_LP.Delete(0);
        // обновляем список свободных обратно
        l_LP.SaveToFile(f_FreeFN);

        // добавляем пару в список уже использованных
        if FileExists(f_UsedFN) then
          l_LP.LoadFromFile(f_UsedFN)
        else
          l_LP.Clear;
        l_LP.Append(f_LPStr);
        l_LP.SaveToFile(f_UsedFN);
      finally
        f_LockFile.Release;
      end;
    end;
  finally
    FreeAndNil(l_LP);
  end;

  // разбиваем пару логин-пароль на логин и пароль
  with TStringList.Create do
  try
    NameValueSeparator := LP_DELIM;
    Text := f_LPStr;
    l_Login := Names[0];
    l_Password := Values[l_Login];
  finally
    Free;
  end;

  // Логинимся
  Logger.Info('Логинимся пользователем %s', [l_Login]);
  //
  with ExecutionContext.F_LoginData do
  begin
    Login := l_Login;
    Password := l_Password;
  end;
  //
  with TatLoginOperation.Create() do
  try
    Execute(ExecutionContext);
  finally
    Free;
  end;
//#UC END# *48089F460352_4FF30FEB005D_impl*
end;//TatLoginFromListOperation.ExecuteSelf

procedure TatLoginFromListOperation.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FF30FEB005D_var*
//#UC END# *479731C50290_4FF30FEB005D_var*
begin
//#UC START# *479731C50290_4FF30FEB005D_impl*
  if f_IsLoop AND (f_LPStr <> '') AND f_LockFile.Acquire then
  try
    // перекладываем логин из использованных в свободные
    with TStringList.Create do
    try
      LoadFromFile(f_UsedFN);
      Delete(IndexOf(f_LPStr));
      SaveToFile(f_UsedFN);

      LoadFromFile(f_FreeFN);
      Append(f_LPStr);
      SaveToFile(f_FreeFN);
    finally
      Free;
    end;
  finally
    f_LockFile.Release;
  end;
  //  
  FreeAndNil(f_LockFile);
  inherited;
//#UC END# *479731C50290_4FF30FEB005D_impl*
end;//TatLoginFromListOperation.Cleanup

procedure TatLoginFromListOperation.InitParamList;
//#UC START# *48089F3701B4_4FF30FEB005D_var*
//#UC END# *48089F3701B4_4FF30FEB005D_var*
begin
//#UC START# *48089F3701B4_4FF30FEB005D_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('logins_file', 'Файл с логинами/паролями') );
    Add( ParamType.Create('sync_file', 'Файл синхронизации') );
    Add( ParamType.Create('is_loop', 'Логинится в цикле', 'false') );
  end;
//#UC END# *48089F3701B4_4FF30FEB005D_impl*
end;//TatLoginFromListOperation.InitParamList

procedure TatLoginFromListOperation.AfterFillingParamList;
 {* Вызывается генератором сценария после заполнения значений параметров.
Если операции надо что-то инициализировать, и для этого нужны значения параметров из сценария. }
//#UC START# *492188F70140_4FF30FEB005D_var*
//#UC END# *492188F70140_4FF30FEB005D_var*
begin
//#UC START# *492188F70140_4FF30FEB005D_impl*
  inherited;
  f_LockFile := TatLockFile.Create( Parameters['sync_file'].AsStr );
  f_IsLoop := Parameters['is_loop'].AsBool;
//#UC END# *492188F70140_4FF30FEB005D_impl*
end;//TatLoginFromListOperation.AfterFillingParamList

end.
