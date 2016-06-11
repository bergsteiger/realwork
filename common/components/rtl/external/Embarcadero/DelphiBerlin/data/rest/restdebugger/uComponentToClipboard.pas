{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit uComponentToClipboard;

interface

uses
  System.SysUtils, System.Types, System.Classes, Vcl.Clipbrd;

procedure StreamToClipboard(aComponents: Array of TComponent);
function ComponentToText(AComponent: TComponent): string;

implementation

procedure StreamToClipboard(aComponents: Array of TComponent);
var
  LComponentsText, LCompText, LNames: TStringList;
  LComp: TComponent;
  LLineIdx, LNameIdx: Integer;
  LLine, LDefName, LCurName: string;
begin
  LNames := nil;
  LCompText := nil;
  LComponentsText := nil;
  try
    LComponentsText := TStringList.Create;
    LNames := TStringList.Create;
    LCompText := TStringList.Create;
    for LComp in aComponents do
    begin
      if LComp <> nil then
      begin

        LCompText.Text := ComponentToText(LComp);
        // Give everything default names
        LCurName := Format('%s.%s', [LComp.Owner.Name, LComp.Name]);
        LDefName := Copy(LComp.ClassName, 2) + '1'; // Exclude 'T'
        LCompText[0] :=  StringReplace(
          LCompText[0],
          Format('object %s:', [LComp.Name]),
          Format('object %s:', [LDefName]),
          []);

        // Save the component text
        LComponentsText.AddStrings(LCompText);

        // Save the name to clean up referenes later
        LNames.Values[LCurName] := LDefName;
      end;
    end;

    // Clean up
    for LLineIdx := LComponentsText.Count - 1 downto 0 do
    begin
      // Remove Left & Top
      LLine := Trim(Copy(TrimLeft(LComponentsText[LLineIdx]), 1, 6));
      if (LLine = 'Left =') or (LLine = 'Top =') then
        LComponentsText.Delete(LLineIdx)
      else begin
        // Clean up name references
        LLine := LComponentsText[LLineIdx];
        for LNameIdx := 0 to LNames.Count - 1 do
        begin
          if Pos(Format(' = %s',[LNames.Names[LNameIdx]]), LLine) > 0 then
          begin
            LLine := LLine.Replace(LNames.Names[LNameIdx], LNames.ValueFromIndex[LNameIdx], []);
            LComponentsText[LLineIdx] := LLine;
          end;
        end;
      end;
    end;

    // Put it all in the clipboard
    Clipboard.AsText := LComponentsText.Text;

  finally
    LCompText.Free;
    LComponentsText.Free;
    LNames.Free;
  end;
end;

function ComponentToText(AComponent: TComponent): string;
var
  LStrStream: TStringStream;
  LMemStream: TMemoryStream;
begin
  if AComponent = nil then
    Exit('');

  LStrStream := nil;
  LMemStream := nil;

  try
    LMemStream := TMemoryStream.Create();
    LStrStream := TStringStream.Create();
    // Stream the component
    LMemStream.WriteComponent(AComponent);
    LMemStream.Position := 0;
    // Convert to text
    ObjectBinaryToText(LMemStream, LStrStream);
    LStrStream.Position := 0;
    // Output the text
    Result := LStrStream.ReadString(LStrStream.Size);
  finally
    LStrStream.Free;
    LMemStream.Free;
  end;
end;

end.

