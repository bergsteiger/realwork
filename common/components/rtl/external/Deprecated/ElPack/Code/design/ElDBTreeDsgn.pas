{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2002, Elizabeth Krivonos,          }
{                       Alexander Hramov             }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

*)

unit ElDBTreeDsgn;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  frmStylesProp,
  ElDbTree,
  ELDBConst,
  {$ifdef VCL_6_USED}
  DesignIntf,
  DesignEditors,
  DesignConst
  {$else}
  DsgnIntf
  {$endif}
  ;

type
  TElDBTreeEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

implementation

procedure TElDBTreeEditor.ExecuteVerb(Index : Integer);
var Form : TCustomForm;
begin
  if Index = 0 then
    with TStylesPropDlg.Create(Application) do
    begin
      try
        AComp := Component;
        DStylesDefs := TCustomElDBTree(AComp).StylesDefs;
        if TCustomElDBTree(AComp).StylesDefs.Count > 0 then
          begin
            ShowModal;
            Form := GetParentForm(Component as TControl);
            if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
          end
        else ShowMessage (SNoSetInstall);
      finally
        Free;
      end;
    end;
end;

function TElDBTreeEditor.GetVerb(Index : Integer) : string;
begin
  if Index = 0 then
    Result := 'Styles...'
  else
end;

function TElDBTreeEditor.GetVerbCount : Integer;
begin
  Result := 1;
end;

end.
