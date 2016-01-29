unit scParameters;

interface

  uses
    IniFiles
    , SysUtils
    ;

  type
    TscParameters = class
      private
        f_INIFile : TIniFile;
        function pm_GetPassword: String;
        function pm_GetUserName: String;
      public
        constructor Create;
        destructor Destroy; override;
        property UserName : String read pm_GetUserName;
        property Password : String read pm_GetPassword;
    end;

    ECanNotFindINIFile = class(Exception)
    end;

    EInvalidINIFile = class(Exception)
    end;

implementation

  const
    SECTION_NAME = 'F1ServerChecker';
    NOT_INITIALIZED_VALUE = '{C4FF1919-2A1D-4415-BB29-A511FBB26929}';
{ TscParameters }

  constructor TscParameters.Create;
    var
      l_PathToINIFile : String;
  begin
    inherited;
    // ���������� �� ����� ���-���� ������������
    if (ParamCount > 0) then
    begin
      // � ������ �������, ����� ���� ��� ���� � ���� �������� ��� ��������
      l_PathToINIFile := ParamStr(1);
    end
    else
    begin
      // ������ ������� ����� ini-���� ��� ������ � ������ ����� �� ��� � ����������
      l_PathToINIFile := ChangeFileExt(ParamStr(0), '.ini');
    end;

    // ��������� ��� ���� ����������
    if (l_PathToINIFile <> '') AND NOT FileExists(l_PathToINIFile) then
      Raise ECanNotFindINIFile.Create('Can not find ini-file'); // �������� �������, �� ���� �� ������

    // ���-���� ����, ������ ���������, ���� �� ��� ������ ���������
    f_INIFile := TIniFile.Create(l_PathToINIFile);
    if (Password = NOT_INITIALIZED_VALUE) OR (UserName = NOT_INITIALIZED_VALUE) then
      Raise EInvalidINIFile.Create('Bad ini-file');
  end;

  destructor TscParameters.Destroy;
  begin
    FreeAndNil(f_INIFile);
    inherited;
  end;

  function TscParameters.pm_GetPassword: String;
  begin
    Result := Trim(f_INIFile.ReadString(SECTION_NAME, 'Password', NOT_INITIALIZED_VALUE));
  end;

  function TscParameters.pm_GetUserName: String;
  begin
    Result := Trim(f_INIFile.ReadString(SECTION_NAME, 'UserName', NOT_INITIALIZED_VALUE));
  end;

end.
