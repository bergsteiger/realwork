{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Memo.Types;

interface

{$SCOPEDENUMS ON}

uses
  System.Types;


type
  TInsertOption = (Selected, MoveCaret, CanUndo, UndoPairedWithPrev, Typed);
  TInsertOptions = set of TInsertOption;

  TDeleteOption = (MoveCaret, CanUndo, Selected);
  TDeleteOptions = set of TDeleteOption;

  TActionType = (Delete, Insert);

  TSelectionPointType = (Left, Right);

  { TCaretPosition }

  /// <summary>Record describes platform independant position in multiline text</summary>
  /// <remarks>Better use this type of position instead of absolute integer position. Absolute integer position includes
  /// length of the LineBreak. It's value depends on platform (e.g. on Windows LineBreak.Length=2,
  /// on OSX LineBreak.Length=1).
  /// TCaretPosition is better in cases if you want to store current caret position in your application accross
  /// multiple platforms.</remarks>
  TCaretPosition = record
    ///<summary>Text line number value</summary>
    Line: Integer;
    ///<summary>Caret position in line defined by Line value</summary>
    Pos: Integer;
  public
    ///<summary>Create new TCaretPosition with devined values of Line and Pos</summary>
    class function Create(const ALine, APos: Integer): TCaretPosition; static; inline;

    ///<summary>Overriding equality check operator</summary>
    class operator Equal(const A, B: TCaretPosition): Boolean;
    ///<summary>Overriding inequality check operator</summary>
    class operator NotEqual(const A, B: TCaretPosition): Boolean;
    ///<summary>Overriding compare operator: Less Or Equal</summary>
    class operator LessThanOrEqual(const A, B: TCaretPosition): Boolean;
    ///<summary>Overriding compare operator: Less Than</summary>
    class operator LessThan(const A, B: TCaretPosition): Boolean;
    ///<summary>Overriding compare operator: Greater Or Equal</summary>
    class operator GreaterThanOrEqual(const A, B: TCaretPosition): Boolean;
    ///<summary>Overriding compare operator: Greater Than</summary>
    class operator GreaterThan(const A, B: TCaretPosition): Boolean;
    ///<summary>Overriding implicit conversion to TPoint</summary>
    class operator Implicit(const APosition: TCaretPosition): TPoint;

    ///<summary>Returns zero caret position value (0; 0)</summary>
    class function Zero: TCaretPosition; inline; static;
    ///<summary>Resturn invalid caret position value (-1; -1)</summary>
    class function Invalid: TCaretPosition; inline; static;

    ///<summary>Increment line number value</summary>
    procedure IncrementLine;
    ///<summary>Decrement line number value</summary>
    procedure DecrementLine;
    ///<summary>Check wherever current caret position has zero value (0; 0)</summary>
    function IsZero: Boolean;
    ///<summary>Checks wherever current caret position has invalid value (either <c>Line</c> or <c>Pos</c> has -1
    ///value)</summary>
    function IsInvalid: Boolean;
  end;

  ///<summary>Information about fragment of the text that was inserted</summary>
  TFragmentInserted = record
    ///<summary>Position in text where text was inserted</summary>
    StartPos: Integer;
    ///<summary>Length of text that was inserted</summary>
    FragmentLength: Integer;
    ///<summary>Defines that change was made right after the previous and was made in the similar way
    ///(e.g. text editing (delete and insert) via keyabord)</summary>
    PairedWithPrev: Boolean;
    ///<summary>Was text inserted via typing from keyboard or not</summary>
    Typed: Boolean;
  public
    ///<summary>Create new information about inserted text with defined values</summary>
    class function Create(const StartPos, FragmentLength: Integer;
      const PairedWithPrev, Typed: Boolean): TFragmentInserted; static; inline;
  end;

  ///<summary>Information about fragment of the text that was removed</summary>
  TFragmentDeleted = record
    ///<summary>Position in text from which text was deleted</summary>
    StartPos: Integer;
    ///<summary>Fragmen of text that was deleted</summary>
    Fragment: string;
    ///<summary>Was removed text select or not</summary>
    Selected: Boolean;
    ///<summary>Was caret moved after text was removed or not</summary>
    CaretMoved: Boolean;
  public
    ///<summary>Create new information about removed text with defined values</summary>
    class function Create(const StartPos: Integer; const Fragment: string;
      const Selected, CaretMoved: Boolean): TFragmentDeleted; static; inline;
  end;

implementation

{ TCaretPosition }

class function TCaretPosition.Create(const ALine, APos: Integer): TCaretPosition;
begin
  Result.Line := ALine;
  Result.Pos := APos;
end;

class operator TCaretPosition.Equal(const A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line = B.Line) and (A.Pos = B.Pos);
end;

class operator TCaretPosition.NotEqual(const A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line <> B.Line) or (A.Pos <> B.Pos);
end;

class operator TCaretPosition.LessThanOrEqual(const A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line < B.Line) or (A.Line = B.Line) and (A.Pos <= B.Pos);
end;

class operator TCaretPosition.LessThan(const A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line < B.Line) or (A.Line = B.Line) and (A.Pos < B.Pos);
end;

class operator TCaretPosition.GreaterThanOrEqual(const A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line > B.Line) or (A.Line = B.Line) and (A.Pos >= B.Pos);
end;

class operator TCaretPosition.GreaterThan(const A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line > B.Line) or (A.Line = B.Line) and (A.Pos > B.Pos);
end;

class operator TCaretPosition.Implicit(const APosition: TCaretPosition): TPoint;
begin
  Result := TPoint.Create(APosition.Pos, APosition.Line);
end;

procedure TCaretPosition.DecrementLine;
begin
  Dec(Line);
end;

procedure TCaretPosition.IncrementLine;
begin
  Inc(Line);
end;

class function TCaretPosition.Invalid: TCaretPosition;
begin
  Result := TCaretPosition.Create(-1, -1);
end;

function TCaretPosition.IsInvalid: Boolean;
begin
  Result := (Line < 0) or (Pos < 0);
end;

function TCaretPosition.IsZero: Boolean;
begin
  Result := (Line = 0) and (Pos = 0);
end;

class function TCaretPosition.Zero: TCaretPosition;
begin
  Result := TCaretPosition.Create(0, 0);
end;

{ TFragmentInserted }

class function TFragmentInserted.Create(const StartPos, FragmentLength: Integer;
  const PairedWithPrev, Typed: Boolean): TFragmentInserted;
begin
  Result.StartPos := StartPos;
  Result.FragmentLength := FragmentLength;
  Result.PairedWithPrev := PairedWithPrev;
  Result.Typed := Typed;
end;

{ TFragmentDeleted }

class function TFragmentDeleted.Create(const StartPos: Integer; const Fragment: string;
  const Selected, CaretMoved: Boolean): TFragmentDeleted;
begin
  Result.StartPos := StartPos;
  Result.Fragment := Fragment;
  Result.Selected := Selected;
  Result.CaretMoved := CaretMoved;
end;

end.
