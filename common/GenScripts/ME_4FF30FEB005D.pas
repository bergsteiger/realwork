unit atLoginFromListOperation;

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atLoginFromListOperation.pas"
// ���������: "SimpleClass"

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
    {* ������� ������� ����� �������. }
   procedure InitParamList; override;
  public
   procedure AfterFillingParamList; override;
    {* ���������� ����������� �������� ����� ���������� �������� ����������.
���� �������� ���� ���-�� ����������������, � ��� ����� ����� �������� ���������� �� ��������. }
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

  // ��������� f_LP �� ���������� �����, ��� ��������� �������� ������ � ������, ����������� ���������
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
          Logger.Error('������ ��� ������ ����� � ��������-��������: %s', [ex.Message]);
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
    Logger.Error('�� ������ ���� � ��������-�������� %s', [l_LoginsFN]);
    Exit;
  end;

  // ����� ������ ����� ����������� ��� �� ��� � ���� �������������
  f_FreeFN := f_LockFile.FileName + '.free.data';
  f_UsedFN := f_LockFile.FileName + '.used.data';

  l_LP := TStringList.Create;
  l_LP.Duplicates := dupError;
  l_LP.CaseSensitive := true;
  try
    l_IsWait := false;
    // �������� ������ � ����� �����-������
    while (f_LPStr = '') do
    begin
      if l_IsWait then
        Sleep(WAIT_TIME);
      //
      if f_LockFile.Acquire then
      try
        // ������� ��������� ��������� ������-������ �� ����� ���������
        if FileExists(f_FreeFN) then
        begin
          l_LP.LoadFromFile(f_FreeFN);
          if l_LP.Count = 0 then // ��������� ��������� ������
            if f_IsLoop then
            begin // �������� � ����� ���� �� �������� ���������
              Logger.Info('��������� ������� ���� ���, ���� ����� �����������...');
              l_IsWait := true;
              continue;
            end
            else
            begin
              Logger.Info('��������� ������ �����������, ��������� ������');
              Abort;
            end;
        end
        else // ����� ���, ��������� �� ���������
        begin
          if AnsiSameText(ExtractFileExt(l_LoginsFN), '.xml') then
            FillLPFromXML
          else
            FillLPFromTextFile;
          if l_LP.Count = 0 then
          begin
            Logger.Error('�� ���������� ����� � ����� "%s" �� ������ ������', [l_LoginsFN]);
            Abort;
          end;
        end;

        // � ���� ������ ���� ��� ����������
        // ��������� ������ ������ � �������-�������
        f_LPStr := l_LP.Strings[0];
        l_LP.Delete(0);
        // ��������� ������ ��������� �������
        l_LP.SaveToFile(f_FreeFN);

        // ��������� ���� � ������ ��� ��������������
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

  // ��������� ���� �����-������ �� ����� � ������
  with TStringList.Create do
  try
    NameValueSeparator := LP_DELIM;
    Text := f_LPStr;
    l_Login := Names[0];
    l_Password := Values[l_Login];
  finally
    Free;
  end;

  // ���������
  Logger.Info('��������� ������������� %s', [l_Login]);
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
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4FF30FEB005D_var*
//#UC END# *479731C50290_4FF30FEB005D_var*
begin
//#UC START# *479731C50290_4FF30FEB005D_impl*
  if f_IsLoop AND (f_LPStr <> '') AND f_LockFile.Acquire then
  try
    // ������������� ����� �� �������������� � ���������
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
    Add( ParamType.Create('logins_file', '���� � ��������/��������') );
    Add( ParamType.Create('sync_file', '���� �������������') );
    Add( ParamType.Create('is_loop', '��������� � �����', 'false') );
  end;
//#UC END# *48089F3701B4_4FF30FEB005D_impl*
end;//TatLoginFromListOperation.InitParamList

procedure TatLoginFromListOperation.AfterFillingParamList;
 {* ���������� ����������� �������� ����� ���������� �������� ����������.
���� �������� ���� ���-�� ����������������, � ��� ����� ����� �������� ���������� �� ��������. }
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
