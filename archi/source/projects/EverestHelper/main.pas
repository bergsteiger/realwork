unit Main;

// $Id: main.pas,v 1.6 2005/05/27 14:44:28 lulin Exp $

// $Log: main.pas,v $
// Revision 1.6  2005/05/27 14:44:28  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.5  2004/12/23 11:47:11  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.4  2001/09/25 06:42:51  law
// no message
//
// Revision 1.3  2001/09/14 12:33:29  law
// - change: вставлены директивы CVS.
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, l3Base, l3InterfacedComponent, vtDirector, ExtCtrls,
  l3ProgressComponent, OvcBase,  W95Meter;

type
  TMainForm = class(TForm)
    DirNavigator: TvtDirNavigator;
    pnFileName: TPanel;
    pnProgress: TPanel;
    Meter: TvtW95Meter;
    OvcController: TOvcController;
    procedure MeterSetStr(const aStr: String);
  public
    { Public declarations }
    procedure ProcessFiles;
      {-}  
  end;

var
  MainForm: TMainForm;

implementation

uses
  ShellAPI,
  
  evPasHelper,
  
  l3IniFile
  ;

{$R *.dfm}

procedure TMainForm.ProcessFiles;
  {-}
var
 l_Helper        : TevPasHelper;
 l_WithDir       : Bool;
 l_SpecialChar   : String;
 l_Title         : String;
 l_ShortName     : String;
 l_OutAllUnits   : Bool;
 l_OutAllMethods : Bool;
begin
 if (UserConfig = nil) then UserConfig:=TCfgList.Create('xHelpGen.ini');
 try
  UserConfig.Section := 'Settings';
  l_WithDir := UserConfig.ReadParamBoolDef('Subfolders', true);
  l_OutAllUnits := UserConfig.ReadParamBoolDef('OutAllUnits', false);
  l_OutAllMethods := UserConfig.ReadParamBoolDef('OutAllMethods', false);
  l_SpecialChar := UserConfig.ReadParamStrDef('SpecialChar', '*');
  l_Title := UserConfig.ReadParamStrDef('Title', '');
  l_ShortName := UserConfig.ReadParamStrDef('Title', l_Title);
  UserConfig.Section := 'Source';
  l_Helper := TevPasHelper.Create(UserConfig.ReadParamStrDef('SourcePath', ''),
                                  UserConfig.ReadParamStrDef('ResultPath', ''),
                                  l_WithDir,
                                  l_SpecialChar,
                                  l_OutAllUnits,
                                  l_OutAllMethods,
                                  l_Title,
                                  l_ShortName,
                                  Meter);
  try
   ShellExecute(0, nil, PChar(l_Helper.Execute), nil, nil, SW_Show);
  finally
   l3Free(l_Helper);
  end;//try..finally
 finally
  l3Free(UserConfig);
 end;//try..finally
end;
  
procedure TMainForm.MeterSetStr(const aStr: String);
begin
 pnFileName.Caption := aStr;
end;

end.
