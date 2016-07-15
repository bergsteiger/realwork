unit tfwParserService;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwParserService.pas"
// ���������: "Service"
// ������� ������: "TtfwParserService" MUID: (57726B250063)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 MtfwParserService = interface
  {* �������� ������� TtfwParserService }
  function MakeCompiledCodeName(const aFileName: AnsiString;
   const anExt: AnsiString): AnsiString;
 end;//MtfwParserService
 *)

type
 ItfwParserService = interface
  {* ��������� ������� TtfwParserService }
  function MakeCompiledCodeName(const aFileName: AnsiString;
   const anExt: AnsiString): AnsiString;
 end;//ItfwParserService

 TtfwParserService = {final} class(Tl3ProtoObject)
  private
   f_CoFileDir: AnsiString;
   f_Alien: ItfwParserService;
    {* ������� ���������� ������� ItfwParserService }
  protected
   procedure pm_SetAlien(const aValue: ItfwParserService);
   procedure ClearFields; override;
  public
   function MakeCompiledCodeName(const aFileName: AnsiString;
    const anExt: AnsiString): AnsiString;
   class function Instance: TtfwParserService;
    {* ����� ��������� ���������� ���������� TtfwParserService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ItfwParserService
    write pm_SetAlien;
    {* ������� ���������� ������� ItfwParserService }
 end;//TtfwParserService

implementation

uses
 l3ImplUses
 , SysUtils
 , IniFiles
 , l3FileUtils
 , StrUtils
 , l3Base
;

var g_TtfwParserService: TtfwParserService = nil;
 {* ��������� ���������� TtfwParserService }

procedure TtfwParserServiceFree;
 {* ����� ������������ ���������� ���������� TtfwParserService }
begin
 l3Free(g_TtfwParserService);
end;//TtfwParserServiceFree

procedure TtfwParserService.pm_SetAlien(const aValue: ItfwParserService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TtfwParserService.pm_SetAlien

function TtfwParserService.MakeCompiledCodeName(const aFileName: AnsiString;
 const anExt: AnsiString): AnsiString;
//#UC START# *6CBC23B5834F_57726B250063_var*
const
 cDefaultDir = 'C:\Temp';
 //cDefaultDir = '.';
var
 l_Path : String;
 l_IniName : String;
//#UC END# *6CBC23B5834F_57726B250063_var*
begin
//#UC START# *6CBC23B5834F_57726B250063_impl*
 if (f_Alien <> nil) then
  Result := MakeCompiledCodeName(aFileName, anExt)
 else
 begin
  if (f_CoFileDir = '') then
  begin
   l_IniName := ChangeFileExt(ParamStr(0), '.ini');
   if FileExists(l_IniName) then
   begin
    with TIniFile.Create(l_IniName) do
     try
      f_CoFileDir := ReadString('SCRIPT', 'CoFileDir', cDefaultDir);
     finally
      Free;
     end;
   end;//FileExists(l_IniName)
   if (f_CoFileDir = '') then
    f_CoFileDir := cDefaultDir;
  end;//f_CoFileDir = ''
  if (f_CoFileDir = '.') then
   Result := aFileName + anExt
  else
  begin
   l_Path := ExtractFilePath(aFileName);
   if (l_Path = '') OR (l_Path = '.\') then
    l_Path := GetCurrentDir;
   l_Path := AnsiReplaceStr(l_Path, ':', '');
   l_Path := AnsiReplaceStr(l_Path, '\\', '\');
   Result := ConcatDirName(f_CoFileDir, ConcatDirName(l_Path, ExtractFileName(aFileName) + anExt));
   l_Path := ExtractFilePath(Result);
//   if (l_Path = 'C:\Temp\') then
//    l_Path := ExtractFilePath(Result);
   ForceDirectories(l_Path);
  end;//f_CoFileDir = '.'
 end;//f_Alien <> nil
//#UC END# *6CBC23B5834F_57726B250063_impl*
end;//TtfwParserService.MakeCompiledCodeName

class function TtfwParserService.Instance: TtfwParserService;
 {* ����� ��������� ���������� ���������� TtfwParserService }
begin
 if (g_TtfwParserService = nil) then
 begin
  l3System.AddExitProc(TtfwParserServiceFree);
  g_TtfwParserService := Create;
 end;
 Result := g_TtfwParserService;
end;//TtfwParserService.Instance

class function TtfwParserService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwParserService <> nil;
end;//TtfwParserService.Exists

procedure TtfwParserService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TtfwParserService.ClearFields

end.
