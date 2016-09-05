unit alcuMdpDatedSyncronizer;

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpDatedSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpDatedSyncronizer" MUID: (574E9D3400B0)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , alcuMdpProtoSyncronizer
 , l3IniFile
;

type
 TalcuMdpDatedSyncronizer = {abstract} class(TalcuMdpProtoSyncronizer)
  protected
   f_From: TDateTime;
   f_To: TDateTime;
  private
   function GetBaseIni: Tl3IniFile;
  protected
   function GetIniParamName: AnsiString; virtual; abstract;
   procedure BeforeSync; override;
   procedure AfterSuccessfulSync; override;
 end;//TalcuMdpDatedSyncronizer

implementation

uses
 l3ImplUses
 , alcuMdpSyncIntf
 , DateUtils
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 , l3FileUtils
 , daSchemeConsts
 //#UC START# *574E9D3400B0impl_uses*
 //#UC END# *574E9D3400B0impl_uses*
;

function TalcuMdpDatedSyncronizer.GetBaseIni: Tl3IniFile;
//#UC START# *574E9F4D0162_574E9D3400B0_var*
//#UC END# *574E9F4D0162_574E9D3400B0_var*
begin
//#UC START# *574E9F4D0162_574E9D3400B0_impl*
 Result := Tl3IniFile.Create(ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, 'base.ini'));
//#UC END# *574E9F4D0162_574E9D3400B0_impl*
end;//TalcuMdpDatedSyncronizer.GetBaseIni

procedure TalcuMdpDatedSyncronizer.BeforeSync;
//#UC START# *574C36DA009E_574E9D3400B0_var*
var
 l_Ini: Tl3IniFile;
 l_DefaultDate: TDateTime;
//#UC END# *574C36DA009E_574E9D3400B0_var*
begin
//#UC START# *574C36DA009E_574E9D3400B0_impl*
 l_Ini := GetBaseIni;
 try
  l_Ini.Section := cMDPCfgSection;
  l_DefaultDate := IncDay(Now, -3); // по умолчанию - за прошлые три дня
  f_From := l_Ini.ReadParamDateTimeDef(GetIniParamName, l_DefaultDate);
  f_To := Now;
 finally
  FreeAndNil(l_Ini);
 end;
//#UC END# *574C36DA009E_574E9D3400B0_impl*
end;//TalcuMdpDatedSyncronizer.BeforeSync

procedure TalcuMdpDatedSyncronizer.AfterSuccessfulSync;
//#UC START# *574C37130370_574E9D3400B0_var*
var
 l_Ini: Tl3IniFile;
//#UC END# *574C37130370_574E9D3400B0_var*
begin
//#UC START# *574C37130370_574E9D3400B0_impl*
 l_Ini := GetBaseIni;
 try
  l_Ini.Section := cMDPCfgSection;
  l_Ini.WriteParamDateTime(GetIniParamName, f_To);
 finally
  FreeAndNil(l_Ini);
 end;
//#UC END# *574C37130370_574E9D3400B0_impl*
end;//TalcuMdpDatedSyncronizer.AfterSuccessfulSync

end.
