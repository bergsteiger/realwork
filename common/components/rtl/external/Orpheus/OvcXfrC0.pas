{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCXFRC0.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

unit OvcXfrC0;
  {-transfer component editor}

{$I l3Define.inc }  

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  ExtCtrls, Forms, Messages, StdCtrls, SysUtils,
  OvcData;

type
  {component editor for the transfer component}
  TOvcTransferEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index : Integer);
      override;
    function GetVerb(Index : Integer): AnsiString;
      override;
    function GetVerbCount : Integer;
      override;
  end;


implementation

uses
  OvcConst, OvcEf, {OvcRLbl,} OvcXfer, OvcXfrC1{, OvcWebP0};



{*** TOvcTransferEditor ***}

procedure TOvcTransferEditor.ExecuteVerb(Index: Integer);
var
  frmTransfer: TOvcfrmTransfer;
  I   : Integer;
  Len : Integer;
  Tab : Integer;
  L   : TList;
  C   : TComponent;
  S   : string;
  DU  : Integer;
begin
  {we only have one verb, so exit if this ain't it}
  if Index = 0 then begin
    with TOvcTransfer(Component) do begin
      L := TList.Create;
      try
        frmTransfer := TOvcfrmTransfer.Create(Application);
        try
          {get list of components that are involved in transfer}
          GetTransferList(L);

          with frmTransfer do begin

            {find longest name in list}
            Len := 0;
            for I := 0 to L.Count-1 do begin
              C := TComponent(L.Items[I]);
              if Length(C.Name) > Len then begin
                S := C.Name;
                Len := Length(S);
              end;
            end;

            {force handle creation}
            lbAllComponents.HandleNeeded;

            {get length of longest name in pixels}
            I := lbAllComponents.Canvas.TextWidth(S + ':WW');

            {calculate listbox base dialog units}
            S := GetOrphStr(SCAlphaString);
            DU := (lbAllComponents.Canvas.TextWidth(S) div Length(S));

            {calculate tab based on longest name}
            Tab := (4 * I) div DU;

            {set tab stop position}
            lbAllComponents.Perform(LB_SETTABSTOPS, 1, LongInt(@Tab));

            {fill listbox with component and class names}
            for I := 0 to L.Count-1 do begin
              C := TComponent(L.Items[I]);
              S := C.Name + ':' + #9 + C.ClassName;
              lbAllComponents.Items.Add(S);
            end;
          end;

          {tell property editor form the components form}
          frmTransfer.ComponentForm := Component.Owner;

          {let form use our component list}
          frmTransfer.ComponentList := L;

          {display the form}
          frmTransfer.ShowModal;
        finally
          frmTransfer.Free;
        end;
      finally
        L.Free;
      end;
    end;
  end{ else if Index = 1 then
    ShellWebCall
  else if Index = 2 then
    ShellMailCall};
end;

function TOvcTransferEditor.GetVerb(Index: Integer): AnsiString;
begin
  case Index of
    0 : Result := 'Generate Transfer Buffer';
//    1 : Result := WebText;
//    2 : Result := MailText;
  else
    Result := '?';
  end;
end;

function TOvcTransferEditor.GetVerbCount: Integer;
begin
  Result := 1{3};
end;


end.