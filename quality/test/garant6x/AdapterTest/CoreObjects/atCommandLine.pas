unit atCommandLine;

// ������: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atCommandLine.pas"
// ���������: "SimpleClass"
// ������� ������: "TatCommandLine" MUID: (4808971F0196)

interface

uses
 l3IntfUses
 , atCommandLineParametersList
 , atCommandLineParameter
;

type
 TatCommandLine = class(TObject)
  private
   f_Delimiter: AnsiChar;
  protected
   f_ParamList: TatCommandLineParametersList;
  private
   procedure Parse;
  protected
   function pm_GetParameters(const aName: AnsiString): TatCommandLineParameter;
   procedure InitParamList; virtual; abstract;
  public
   constructor Create; reintroduce;
   procedure PrintUsageInfo; virtual;
   function IsAllRequiredSet: Boolean;
   destructor Destroy; override;
  public
   property Parameters[const aName: AnsiString]: TatCommandLineParameter
    read pm_GetParameters;
 end;//TatCommandLine

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *4808971F0196impl_uses*
 //#UC END# *4808971F0196impl_uses*
;

function TatCommandLine.pm_GetParameters(const aName: AnsiString): TatCommandLineParameter;
//#UC START# *480897B103E1_4808971F0196get_var*
//#UC END# *480897B103E1_4808971F0196get_var*
begin
//#UC START# *480897B103E1_4808971F0196get_impl*
    Result := f_ParamList.ParamByName[aName];
//#UC END# *480897B103E1_4808971F0196get_impl*
end;//TatCommandLine.pm_GetParameters

procedure TatCommandLine.Parse;
//#UC START# *4808975D00A9_4808971F0196_var*
    var
      i, j : integer;
      param : TatCommandLineParameter;
//#UC END# *4808975D00A9_4808971F0196_var*
begin
//#UC START# *4808975D00A9_4808971F0196_impl*
    for i := 0 to f_ParamList.Count-1 do
    begin // ���������� ��� ���������
      param := f_ParamList.ParamByIndex[i];
      if FindCmdLineSwitch(param.Name, [f_Delimiter], true) then
      begin // �������� ������
        case param.ParamType of
          clptKey : param.AsBool := true;
          clptString, clptNumber:
            for j := 1 to ParamCount do // ���� ��� ��������
              if ( UpperCase(ParamStr(j)) = UpperCase(f_Delimiter + param.Name) ) then // �����
                if (ParamStr(j+1) <> '') then // ������ ��� ���������� �� ��� �� ���
                  param.AsStr := ParamStr(j+1);
        end;
      end;
    end;
//#UC END# *4808975D00A9_4808971F0196_impl*
end;//TatCommandLine.Parse

constructor TatCommandLine.Create;
//#UC START# *4808978003B9_4808971F0196_var*
//#UC END# *4808978003B9_4808971F0196_var*
begin
//#UC START# *4808978003B9_4808971F0196_impl*
    inherited;
    //
    f_ParamList := TatCommandLineParametersList.Create;
    InitParamList;
    f_Delimiter := '-';
    Parse;
//#UC END# *4808978003B9_4808971F0196_impl*
end;//TatCommandLine.Create

procedure TatCommandLine.PrintUsageInfo;
//#UC START# *4808978C00FD_4808971F0196_var*

    var
      i : integer;
      param : TatCommandLineParameter;

    procedure PrintParams(const isRequired : boolean);
      var
        i : integer;
    begin
      for i := 0 to f_ParamList.Count-1 do
      begin
        param := f_ParamList.ParamByIndex[i];
        if (isRequired = param.IsRequired) then
        begin
          Write( Format('  %-10s - ', [param.Name]) );
          if (param.Description <> '') then
            Write( Format('%s. ', [param.Description]) );
          case param.ParamType of
            clptKey   : Write( '<boolean>' );
            clptString: Write( '<string>' );
            clptNumber: Write( '<number>' );
          end;
          WriteLn;
        end;
      end;
    end;

//#UC END# *4808978C00FD_4808971F0196_var*
begin
//#UC START# *4808978C00FD_4808971F0196_impl*
    Write('Usage: ' + ExtractFileName(ParamStr(0)));
    for i := 0 to f_ParamList.Count-1 do
    begin
      param := TatCommandLineParameter(f_ParamList.ParamByIndex[i]);
      Write(' ' + f_Delimiter + param.Name);
      case param.ParamType of
        clptKey :;
        clptString : Write(' <string>');
        clptNumber : Write(' <number>');
      end;
    end;
    WriteLn;
    //
    WriteLn('Required parameters:');
    PrintParams(true);
    //
    WriteLn;
    WriteLn('Optional parameters:');
    PrintParams(false);
//#UC END# *4808978C00FD_4808971F0196_impl*
end;//TatCommandLine.PrintUsageInfo

function TatCommandLine.IsAllRequiredSet: Boolean;
//#UC START# *4808979E03DE_4808971F0196_var*
    var
      i : integer;
      param : TatCommandLineParameter;
//#UC END# *4808979E03DE_4808971F0196_var*
begin
//#UC START# *4808979E03DE_4808971F0196_impl*
    Result := true;
    for i := 0 to f_ParamList.Count-1 do
    begin
      param := f_ParamList.ParamByIndex[i];
      if param.IsRequired AND (NOT param.IsSet) then
      begin
        Result := false;
        Exit;
      end;
    end;
//#UC END# *4808979E03DE_4808971F0196_impl*
end;//TatCommandLine.IsAllRequiredSet

destructor TatCommandLine.Destroy;
//#UC START# *48077504027E_4808971F0196_var*
//#UC END# *48077504027E_4808971F0196_var*
begin
//#UC START# *48077504027E_4808971F0196_impl*
    FreeAndNil(f_ParamList);
    inherited;
//#UC END# *48077504027E_4808971F0196_impl*
end;//TatCommandLine.Destroy

end.
