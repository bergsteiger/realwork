program CalcBuild; {$R *.RES}

{$APPTYPE  CONSOLE}
{$WARNINGS ON}

uses
 Windows
 , SysUtils
 ;

procedure DoParseAndCalculate (const a_Expression: string);
 //
 function TrimSpaces (const a_String: string): string;
 const
  c_SpaceSet: set of Char = [#09, ' '];
 begin
  Result := a_String;
  //
  while ((Length (Result) > 0) and (Result [1] in c_SpaceSet)) do
   Delete (Result, 1, 1);
  //
  while ((Length (Result) > 0) and (Result [Length (Result)] in c_SpaceSet)) do
   SetLength (Result, Pred (Length (Result)));
 end;
 //
var
 l_Expression: string;
 l_Format: string;
 l_OperandA: string;
 l_OperandB: string;
 l_Operation: Char;
 l_Position: Integer;
 l_Result: Integer;
begin
 l_Expression := a_Expression;
 //
 l_Position := Pos ('=', l_Expression);
 //
 if (l_Position > 0) then begin
  l_Format := TrimSpaces (Copy (l_Expression, 1, Pred (l_Position)));
  //
  if (l_Format <> '') then begin
   Delete (l_Expression, 1, l_Position);
   //
   l_Position := Pos ('+', l_Expression);
   //
   if (l_Position = 0) then begin
    l_Position := Pos ('-', l_Expression);
    //
    if (l_Position = 0) then begin
     l_Position := Pos ('*', l_Expression);
     //
     if (l_Position = 0) then
      l_Position := Pos ('/', l_Expression);
    end;
   end;
   //
   if (l_Position > 0) then begin
    l_OperandA := TrimSpaces (Copy (l_Expression, 1, Pred (l_Position)));
    //
    if (l_OperandA <> '') then begin
     l_Operation := l_Expression [l_Position];
     //
     Delete (l_Expression, 1, l_Position);
     //
     l_OperandB := TrimSpaces (l_Expression);
     //
     if (l_OperandB <> '') then begin
      l_Result := 0;
      //
      case l_Operation of
       '+': l_Result := StrToInt (l_OperandA)  +  StrToInt (l_OperandB);
       '-': l_Result := StrToInt (l_OperandA)  -  StrToInt (l_OperandB);
       '*': l_Result := StrToInt (l_OperandA)  *  StrToInt (l_OperandB);
       '/': l_Result := StrToInt (l_OperandA) div StrToInt (l_OperandB);
      end;
      //
      WriteLN (Format (l_Format, [l_Result]));
     end;
    end;
   end;
  end;
 end;
end;

begin
 try
  if (ParamCount > 0) then
   DoParseAndCalculate (ParamStr (1));
 except
  // do nothing
 end;
end.
