{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCRunner;

{$I DC.inc}

interface

uses
  Classes, SysUtils, Forms, Dialogs, Import,

  DCAPI, DCSystem, DCImportConsts, DCHelpUnit, DCMainUnit;

{------------------------------------------------------------------}

Procedure DCRunUnitImporter;

implementation

{------------------------------------------------------------------}

Procedure RunNormalMode;
begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end;

{------------------------------------------------------------------}

Procedure RunImportSilently;
Var
  I             : Integer;
  SourceWaiting : Boolean;

  Recursive  : Boolean;
  NoComments : Boolean;
  DefaultLib : Boolean;
  Source     : String;
  DestPath   : String;
  Aliases    : String;
  Defines    : String;
  Postfix    : String;
  Units      : String;
  ShowFinalDialog : Boolean;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _AddToExclude( Const AFileName : String );
  Var
    Files : TStringList;
  begin
    If Not FileExists( AFileName ) Then
      Exit;
    Files := TStringList.Create;
    try
      Files.LoadFromFile( AFileName );
      AddBadProcs( Files );
    finally
      Files.Free;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ProcessOption( Const OptionsStr : String );
  Var
    pVal : String;
  begin
    If Length( OptionsStr ) < 2 Then
      Exit;

    pVal := Copy( OptionsStr, 3, Length( OptionsStr ) - 2 );
    Case OptionsStr[2] Of
      'a', 'A' : Aliases := pVal;
      'd', 'D' : Defines := pVal;
      'e', 'E' : _AddToExclude( pVal );
      's', 'S' : Recursive := True;
      'p', 'P' : Postfix := pVal;
      'u', 'U' : Units := pVal;
      'x', 'X' : NoComments := True;
      'l', 'L' : DefaultLib := True;
      'f', 'F' : ShowFinalDialog := True;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  ShowFinalDialog := False;
  If ParamCount < 2 Then
  begin
    MessageDlg( sDCErrorParamNumber, mtError, [mbOk], 0 );
    ShowCommandLineHelp;
    RunNormalMode;
  end;

  SourceWaiting := True;
  For I := 1 To ParamCount Do
    If ParamStr( I )[1] = '-' Then
      _ProcessOption( ParamStr( I ) )
    Else
      If SourceWaiting Then
      begin
        Source := ParamStr( I );
        SourceWaiting := False;
      end
      Else
        DestPath := ParamStr( I );

  DestPath := AddSlash( DestPath );
  If Postfix = '' Then
    Postfix := '_imp';
  If Aliases = '' Then
    Aliases := SDCDefAliases;
  If ( Units = '' ) or DefaultLib Then
    Units := GetDelphiSourceDirs + ';' + Units;

  With TDCFileCounter.Create Do
  try
    ForEachFile( Source, faAnyFile And Not faDirectory, Recursive, ProcessFile );
    RunImport( FilesList, Nil, DestPath, Units, Defines, Postfix, Aliases, Not NoComments, True, False, ShowFinalDialog,False{NoDefaultDefines});
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

Procedure DCRunUnitImporter;
begin
  If ParamCount = 0 Then
    RunNormalMode
  Else
    RunImportSilently;
end;

{------------------------------------------------------------------}
initialization

end.
