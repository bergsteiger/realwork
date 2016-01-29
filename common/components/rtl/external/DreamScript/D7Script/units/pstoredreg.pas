{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit PStorEdReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcCommon, dcstrled, pstored, dcgenreg;

type
  TDCPropStoreEditor = class (TDefaultEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
  end;

{------------------------------------------------------------------}

function TDCPropStoreEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0:Result:=SVerbEditPropList;
    1:Result:=SVerbPropOrder;
  end;
end;

{------------------------------------------------------------------}

function TDCPropStoreEditor.GetVerbCount: Integer;
begin
  result := 2;
end;

{------------------------------------------------------------------}

procedure TDCPropStoreEditor.ExecuteVerb(index : integer);
begin
  if index = 0 then
    EditPropStore(Component as TDCPropStore)
  else
    EditStrings((Component as TDCPropStore).PropList, Component.Name);
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponentEditor(TDCPropStore, TDCPropStoreEditor);
  RegisterPropertyEditor(TypeInfo(string), TDCPropStore, 'IniFile', TFileNameEdit);
end;

procedure TDCPropStoreEditor.Edit;
begin
  ExecuteVerb(0);
end;

end.
