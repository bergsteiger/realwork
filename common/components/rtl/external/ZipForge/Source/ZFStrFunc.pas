 /////////////////////////////////////////////////////
 //                                                 //
 //   QStrings 6.03.420      ( general release )    //
 //                                                 //
 //   Quick string manipulation library             //
 //                                                 //
 //   Copyright (C) 2000,2001 Andrew N. Driazgov    //
 //   e-mail: andrey@asp.tstu.ru                    //
 //                                                 //
 //   Portions (C) 2000, Sergey G. Shcherbakov      //
 //   e-mail: mover@mail.ru, mover@rada.gov.ua      //
 //                                                 //
 //   Last updated: January 7, 2001                 //
 //                                                 //
 /////////////////////////////////////////////////////

 //-----------------------------------------------------//
 //                                                     //
 //  Modified by ComponentAce, 2003                     //
 //                                                     //
 //-----------------------------------------------------//

unit ZFStrFunc;

{$I ZFVer.Inc}

interface

uses Windows, SysUtils;

const
  WildCardMultipleChar = '*';

const
  WildCardSingleChar = '?';

const
  WildCardAnyFile = '*.*';

function Q_AnsiPCompStr(P1, P2: PChar): integer;
function Q_AnsiCompStrL(P1, P2: PChar; MaxL: cardinal): integer;
function Q_AnsiPCompText(P1, P2: PChar): integer;
function Q_AnsiCompTextL(P1, P2: PChar; MaxL: cardinal): integer;

function Q_PCompStr(P1, P2: PChar): integer;
function Q_CompStrL(const S1, S2: string; MaxL: cardinal): integer;
function Q_PCompText(P1, P2: PChar): integer;
function Q_CompTextL(const S1, S2: string; MaxL: cardinal): integer;

function Q_PStrToAnsi(P: PChar): PChar;
function Q_PStrToOem(P: PChar): PChar;

// checks if string matches pattern
function IsStrMatchPattern(StrPtr: PChar; PatternPtr: PChar;
  bIgnoreCase: boolean = True): boolean;
{$IFDEF D6H}
function WIsStrMatchPattern(StrPtr: PWideChar; PatternPtr: PWideChar;
  bIgnoreCase: boolean = True): boolean;
{$ENDIF}

var
  ToUpperChars, ToLowerChars: array[0..255] of char;
  ToOemChars, ToAnsiChars: array[0..255] of char;
  //--- Turkish support ---
  TurkishToAnsiChars:  array [0..255] of
  char = (#0, #2, #3, #4, #5, #6, #7, #8, #9, #10, #11, #12, #13, #14, #15,
    #16, #17, #18, #19, #20, #21, #22, #23, #24, #25, #26, #27, #28, #29, #30, #31,
    #32, #1, #33, #34, #35, #36, #37, #38, #39, #40, #41, #42, #43, #44, #45, #46, #47,
    #48, #49, #50, #51, #52, #53, #54, #55, #56, #57, #58, #59, #60, #61, #62, #63, #64,
    #72, #82, #84, #88, #94, #100, #102, #106, #112, #120, #122, #124, #126, #129,
    #136, #144, #146, #148, #150, #155, #160, #167, #169, #171, #174, #176, #177,
    #178, #179, #180, #181, #182, #65, #81, #83, #87, #89, #99, #101, #105, #117, #119,
    #121, #123, #125, #127, #131, #143, #145, #147, #149, #154, #156, #166, #168, #170,
    #172, #175, #183, #184, #185, #186, #187, #248, #249, #188, #189, #190, #191, #192,
    #193, #194, #195, #196, #197, #198, #250, #251, #252, #253, #199, #200, #201, #202,
    #203, #204, #205, #206, #207, #208, #209, #210, #254, #255, #211, #212, #213, #214,
    #215, #216, #217, #218, #219, #220, #221, #222, #223, #224, #225, #226, #227, #228,
    #229, #230, #231, #232, #233, #234, #235, #236, #237, #238, #239, #240, #241, #242,
    #243, #74, #76, #75, #77, #80, #73, #78, #86, #98, #95, #96, #97, #116, #113, #114, #115,
    #104, #130, #139, #137, #138, #140, #142, #244, #245, #163, #161, #162, #165, #118, #153,
    #151, #67, #69, #68, #70, #79, #66, #71, #85, #93, #90, #91, #92, #111, #110, #109, #108,
    #103, #128, #133, #132, #134, #135, #141, #246, #247, #158, #159, #157, #164, #107, #152, #173);
  TurkishToUpperChars: array [0..255] of
  char = (#0, #1, #2, #3, #4, #5, #6, #7, #8, #9, #10, #11, #12, #13, #14, #15,
    #16, #17, #18, #19, #20, #21, #22, #23, #24, #25, #26, #27, #28, #29, #30, #31, #0,
    #33, #34, #35, #36, #37, #38, #39, #40, #41, #42, #43, #44, #45, #46, #47, #48, #49,
    #50, #51, #52, #53, #54, #55, #56, #57, #58, #59, #60, #61, #62, #63, #64, #65, #66,
    #67, #68, #69, #70, #71, #72, #73, #74, #75, #76, #77, #78, #79, #80, #81, #82, #83,
    #84, #85, #86, #87, #88, #89, #90, #91, #92, #93, #94, #95, #96, #65, #66, #67, #68,
    #69, #70, #71, #72, #221, #74, #75, #76, #77, #78, #79, #80, #81, #82, #83, #84, #85,
    #86, #87, #88, #89, #90, #123, #124, #125, #126, #127, #128, #129, #130, #131, #132,
    #133, #134, #135, #136, #137, #138, #139, #140, #141, #142, #143, #144, #145, #146,
    #147, #148, #149, #150, #151, #152, #153, #154, #155, #156, #157, #158, #159, #160,
    #161, #162, #163, #164, #165, #166, #167, #168, #169, #170, #171, #172, #173, #174,
    #175, #176, #177, #178, #179, #180, #181, #182, #183, #184, #185, #186, #187, #188,
    #189, #190, #191, #192, #193, #194, #195, #196, #197, #198, #199, #200, #201, #202,
    #203, #204, #205, #206, #207, #208, #209, #210, #211, #212, #213, #214, #215, #216,
    #217, #218, #219, #220, #221, #222, #223, #192, #193, #194, #195, #196, #197, #198,
    #199, #200, #201, #202, #203, #204, #205, #206, #207, #208, #209, #210, #211, #212,
    #213, #214, #247, #248, #217, #218, #219, #220, #73, #222, #255);
  TurkishToLowerChars: array [0..255] of
  char = (#32, #1, #2, #3, #4, #5, #6, #7, #8, #9, #10, #11, #12, #13, #14, #15, #16, #17, #18, #19,
    #20, #21, #22, #23, #24, #25, #26, #27, #28, #29, #30, #31, #32, #33, #34, #35, #36, #37,
    #38, #39, #40, #41, #42, #43, #44, #45, #46, #47, #48, #49, #50, #51, #52, #53, #54, #55,
    #56, #57, #58, #59, #60, #61, #62, #63, #64, #97, #98, #99, #100, #101, #102, #103, #104,
    #253, #106, #107, #108, #109, #110, #111, #112, #113, #114, #115, #116, #117, #118, #119,
    #120, #121, #122, #91, #92, #93, #94, #95, #96, #97, #98, #99, #100, #101, #102, #103, #104,
    #105, #106, #107, #108, #109, #110, #111, #112, #113, #114, #115, #116, #117, #118, #119,
    #120, #121, #122, #123, #124, #125, #126, #127, #128, #129, #130, #131, #132, #133, #134,
    #135, #136, #137, #138, #139, #140, #141, #142, #143, #144, #145, #146, #147, #148, #149,
    #150, #151, #152, #153, #154, #155, #156, #157, #158, #159, #160, #161, #162, #163, #164,
    #165, #166, #167, #168, #169, #170, #171, #172, #173, #174, #175, #176, #177, #178, #179,
    #180, #181, #182, #183, #184, #185, #186, #187, #188, #189, #190, #191, #224, #225, #226,
    #227, #228, #229, #230, #231, #232, #233, #234, #235, #236, #237, #238, #239, #240, #241,
    #242, #243, #244, #245, #246, #215, #216, #249, #250, #251, #252, #105, #254, #223, #224,
    #225, #226, #227, #228, #229, #230, #231, #232, #233, #234, #235, #236, #237, #238, #239,
    #240, #241, #242, #243, #244, #245, #246, #247, #248, #249, #250, #251, #252, #253, #254, #255);

implementation

uses Math;

var
  p1, p2:  PChar;
  i, j, n: byte;
  bCodePagesInitialized: boolean;
  LCID:    integer;

function Q_PCompStr(P1, P2: PChar): integer;
asm
  TEST    EAX,EAX
  JE      @@2
  TEST    EDX,EDX
  JE      @@3
  PUSH    EAX
  MOVZX   EAX,byte PTR [EAX]
  MOVZX   ECX,byte PTR [EDX]
  SUB     EAX,ECX
  JE      @@m
  POP     ECX
  RET
  @@m:    POP     EAX
  INC     EAX
  INC     EDX
  @@0:    TEST    CL,CL
  JE      @@5
  MOV     CL,byte PTR [EAX]
  MOV     CH,byte PTR [EDX]
  CMP     CL,CH
  JNE     @@ne
  TEST    CL,CL
  JE      @@5
  MOV     CL,byte PTR [EAX+1]
  MOV     CH,byte PTR [EDX+1]
  CMP     CL,CH
  JNE     @@ne
  TEST    CL,CL
  JE      @@5
  MOV     CL,byte PTR [EAX+2]
  MOV     CH,byte PTR [EDX+2]
  CMP     CL,CH
  JNE     @@ne
  TEST    CL,CL
  JE      @@5
  MOV     CL,byte PTR [EAX+3]
  MOV     CH,byte PTR [EDX+3]
  ADD     EAX,4
  ADD     EDX,4
  CMP     CL,CH
  JE      @@0
  @@ne:   MOVZX   EAX,CL
  MOVZX   EDX,CH
  SUB     EAX,EDX
  RET
  @@2:    TEST    EDX,EDX
  JE      @@7
  MOV     CH,byte PTR [EDX]
  TEST    CH,CH
  JE      @@7
  not     EAX
  RET
  @@3:    MOV     CL,byte PTR [EAX]
  TEST    CL,CL
  JE      @@5
  MOV     EAX,1
  RET
  @@5:    xor     EAX,EAX
  @@7:
end;

function Q_CompStrL(const S1, S2: string; MaxL: cardinal): integer;
asm
  TEST    ECX,ECX
  JE      @@1
  TEST    EAX,EAX
  JE      @@2
  TEST    EDX,EDX
  JE      @@3
  PUSH    EBX
  PUSH    ESI
  MOV     EBX,[EAX-4]
  MOV     ESI,[EDX-4]
  SUB     EBX,ESI
  JG      @@w1
  ADD     ESI,EBX
  @@w1:   CMP     ECX,ESI
  JA      @@fc
  @@dn:   POP     ESI
  @@lp:   DEC     ECX
  JS      @@zq
  MOV     BL,byte PTR [EAX]
  MOV     BH,byte PTR [EDX]
  CMP     BL,BH
  JNE     @@ne
  DEC     ECX
  JS      @@zq
  MOV     BL,byte PTR [EAX+1]
  MOV     BH,byte PTR [EDX+1]
  CMP     BL,BH
  JNE     @@ne
  DEC     ECX
  JS      @@zq
  MOV     BL,byte PTR [EAX+2]
  MOV     BH,byte PTR [EDX+2]
  CMP     BL,BH
  JNE     @@ne
  DEC     ECX
  JS      @@zq
  MOV     BL,byte PTR [EAX+3]
  MOV     BH,byte PTR [EDX+3]
  ADD     EAX,4
  ADD     EDX,4
  CMP     BL,BH
  JE      @@lp
  @@ne:   MOVZX   EAX,BL
  MOVZX   EDX,BH
  SUB     EAX,EDX
  POP     EBX
  RET
  @@fc:   LEA     ECX,[ESI+1]
  JMP     @@dn
  @@1:    xor     EAX,EAX
  RET
  @@2:    TEST    EDX,EDX
  JE      @@7
  MOV     CH,byte PTR [EDX]
  TEST    CH,CH
  JE      @@7
  not     EAX
  RET
  @@3:    MOV     CL,byte PTR [EAX]
  TEST    CL,CL
  JE      @@5
  MOV     EAX,1
  RET
  @@zq:   POP     EBX
  @@5:    xor     EAX,EAX
  @@7:
end;


function Q_PCompText(P1, P2: PChar): integer;
asm
  TEST    EAX,EAX
  JE      @@2
  TEST    EDX,EDX
  JE      @@3
  PUSH    ESI
  PUSH    EDI
  MOV     ESI,EAX
  MOV     EDI,EDX
  JMP     @@1
  @@0:    TEST    AL,AL
  JE      @@4
  INC     ESI
  INC     EDI
  @@1:    MOVZX   EAX,byte PTR [ESI]
  MOVZX   EDX,byte PTR [EDI]
  CMP     AL,DL
  JE      @@0
  MOV     AL,byte PTR [EAX+ToUpperChars]
  MOV     DL,byte PTR [EDX+ToUpperChars]
  CMP     AL,DL
  JE      @@0
  MOVZX   EAX,AL
  MOVZX   EDX,DL
  SUB     EAX,EDX
  POP     EDI
  POP     ESI
  RET
  @@2:    TEST    EDX,EDX
  JE      @@7
  MOV     CH,byte PTR [EDX]
  TEST    CH,CH
  JE      @@7
  not     EAX
  RET
  @@3:    MOV     CL,byte PTR [EAX]
  TEST    CL,CL
  JE      @@5
  MOV     EAX,1
  RET
  @@4:    POP     EDI
  POP     ESI
  @@5:    xor     EAX,EAX
  @@7:
end;

function Q_CompTextL(const S1, S2: string; MaxL: cardinal): integer;
asm
  TEST    ECX,ECX
  JE      @@5
  TEST    EAX,EAX
  JE      @@2
  TEST    EDX,EDX
  JE      @@3
  PUSH    ESI
  PUSH    EDI
  MOV     ESI,[EAX-4]
  MOV     EDI,[EDX-4]
  SUB     ESI,EDI
  JG      @@w1
  ADD     EDI,ESI
  @@w1:   CMP     ECX,EDI
  JA      @@fc
  @@dn:   MOV     ESI,EAX
  MOV     EDI,EDX
  @@lp:   DEC     ECX
  JS      @@zq
  MOVZX   EAX,byte PTR [ESI]
  MOVZX   EDX,byte PTR [EDI]
  INC     ESI
  INC     EDI
  CMP     AL,DL
  JE      @@lp
  MOV     AL,byte PTR [EAX+ToUpperChars]
  MOV     DL,byte PTR [EDX+ToUpperChars]
  CMP     AL,DL
  JE      @@lp
  @@ne:   MOVZX   EAX,AL
  MOVZX   EDX,DL
  SUB     EAX,EDX
  POP     EDI
  POP     ESI
  RET
  @@fc:   LEA     ECX,[EDI+1]
  JMP     @@dn
  @@2:    TEST    EDX,EDX
  JE      @@7
  MOV     CH,byte PTR [EDX]
  TEST    CH,CH
  JE      @@7
  not     EAX
  RET
  @@3:    MOV     CL,byte PTR [EAX]
  TEST    CL,CL
  JE      @@5
  MOV     EAX,1
  RET
  @@zq:   POP     EDI
  POP     ESI
  @@5:    xor     EAX,EAX
  @@7:
end;

procedure Int256Chars(P: Pointer);
asm
  MOV     ECX,8
  MOV     EDX,$03020100
  @@lp:   MOV[EAX],EDX
  ADD     EDX,$04040404
  MOV[EAX+4],EDX
  ADD     EDX,$04040404
  MOV[EAX+8],EDX
  ADD     EDX,$04040404
  MOV[EAX+12],EDX
  ADD     EDX,$04040404
  MOV[EAX+16],EDX
  ADD     EDX,$04040404
  MOV[EAX+20],EDX
  ADD     EDX,$04040404
  MOV[EAX+24],EDX
  ADD     EDX,$04040404
  MOV[EAX+28],EDX
  ADD     EDX,$04040404
  ADD     EAX,32
  DEC     ECX
  JNE     @@lp
end;

function Q_PStrToAnsi(P: PChar): PChar;
asm
  TEST    EAX,EAX
  JE      @@2
  PUSH    EAX
  JMP     @@1
  @@0:    MOV     CL,byte PTR [EDX+ToAnsiChars]
  MOV     byte PTR [EAX],CL
  INC     EAX
  @@1:    MOVZX   EDX,byte PTR [EAX]
  TEST    DL,DL
  JNE     @@0
  POP     EAX
  @@2:
end;

function Q_PStrToOem(P: PChar): PChar;
asm
  TEST    EAX,EAX
  JE      @@2
  PUSH    EAX
  JMP     @@1
  @@0:    MOV     CL,byte PTR [EDX+ToOemChars]
  MOV     byte PTR [EAX],CL
  INC     EAX
  @@1:    MOVZX   EDX,byte PTR [EAX]
  TEST    DL,DL
  JNE     @@0
  POP     EAX
  @@2:
end;

function Q_AnsiPCompStr(P1, P2: PChar): integer;
begin
  if (bCodePagesInitialized) then
  begin
    Q_PStrToAnsi(P1);
    Q_PStrToAnsi(P2);
    Result := Q_PCompStr(P1, P2);
    Q_PStrToOem(P1);
    Q_PStrToOem(P2);
  end
  else
    Result := AnsiStrComp(P1, P2);
end;

function Q_AnsiCompStrL(P1, P2: PChar; MaxL: cardinal): integer;
begin
  if (bCodePagesInitialized) then
  begin
    Q_PStrToAnsi(P1);
    Q_PStrToAnsi(P2);
    Result := Q_CompStrL(P1, P2, MaxL);
    Q_PStrToOem(P1);
    Q_PStrToOem(P2);
  end
  else
    Result := AnsiStrLComp(P1, P2, MaxL);
end;

function Q_AnsiPCompText(P1, P2: PChar): integer;
begin
  if (bCodePagesInitialized) then
  begin
    Q_PStrToAnsi(P1);
    Q_PStrToAnsi(P2);
    Result := Q_PCompText(P1, P2);
    Q_PStrToOem(P1);
    Q_PStrToOem(P2);
  end
  else
    Result := AnsiStrIComp(P1, P2);
end;

function Q_AnsiCompTextL(P1, P2: PChar; MaxL: cardinal): integer;
begin
  if (bCodePagesInitialized) then
  begin
    Q_PStrToAnsi(P1);
    Q_PStrToAnsi(P2);
    Result := Q_CompTextL(P1, P2, MaxL);
    Q_PStrToOem(P1);
    Q_PStrToOem(P2);
  end
  else
    Result := AnsiStrLIComp(P1, P2, MaxL);
end;


 //------------------------------------------------------------------------------
 // checks if string matches pattern
 //------------------------------------------------------------------------------
function IsStrMatchPattern(StrPtr: PChar; PatternPtr: PChar;
  bIgnoreCase: boolean = True): boolean;
var
  i:   integer;
  bEQ: boolean;
  tmp1, tmp2: array [0..1] of char;
  s1, s2: string;
begin
  tmp1[0] := #0;
  tmp1[1] := #0;
  tmp2[0] := #0;
  tmp2[1] := #0;
  if (StrComp(PatternPtr, WildCardAnyFile) = 0) then
  begin
    Result := True;
    exit;
  end;
  repeat
    if (StrComp(PatternPtr, WildCardMultipleChar) = 0) then
    begin
      Result := True;
      exit;
    end
    else if (StrPtr^ = #0) and (PatternPtr^ <> #0) then
    begin
      Result := False;
      exit;
    end
    else if (StrPtr^ = #0) then
    begin
      Result := True;
      exit;
    end
    else
    begin
      case PatternPtr^ of
        WildCardMultipleChar:
        begin
          for i := 0 to Length(StrPtr) - 1 do
          begin
            if IsStrMatchPattern(StrPtr + i, PatternPtr + 1, bIgnoreCase) then
            begin
              Result := True;
              exit;
            end;
          end;
          Result := False;
          exit;
        end;
        WildCardSingleChar:
        begin
          Inc(StrPtr);
          Inc(PatternPtr);
        end;
        else
        begin
           s1 := StrPtr^;
          s2 := PatternPtr^;
          if (bIgnoreCase) then
            bEQ := LowerCase(s1) = LowerCase(s2)
          else
            bEQ := s1 = s2;
          if (bEQ) then
          begin
            Inc(StrPtr);
            Inc(PatternPtr);
          end
          else
          begin
            Result := False;
            exit;
          end;
        end;
      end; // case
    end; // non-simple cases
  until False;
end;//IsStrMatchPattern


function DumbItDownFor95(const S1, S2: WideString; CmpFlags: Integer): Integer;
var
  a1, a2: AnsiString;
begin
  a1 := AnsiString(s1);
  a2 := AnsiString(s2);
  Result := CompareStringA(LOCALE_USER_DEFAULT, CmpFlags, PAnsiChar(a1), Length(a1),
    PAnsiChar(a2), Length(a2)) - 2;
end;
{$IFDEF D6H}
function WideCompareStrL(const S1, S2: WideString; MaxLength: Integer): Integer;
var
  Len: Integer;
begin
  Len := Min(Length(S1), Length(S2));
  Len := Min(Length(S1), MaxLength);
  SetLastError(0);
  Result := CompareStringW(LOCALE_USER_DEFAULT, 0, PWideChar(S1), MaxLength,
    PWideChar(S2), MaxLength) - 2;
  case GetLastError of
    0: ;
    ERROR_CALL_NOT_IMPLEMENTED: Result := DumbItDownFor95(S1, S2, NORM_IGNORECASE);
  else
    RaiseLastOSError;
  end;
end;


 //------------------------------------------------------------------------------
 // checks if string matches pattern
 //------------------------------------------------------------------------------
function WIsStrMatchPattern(StrPtr: PWideChar; PatternPtr: PWideChar;
  bIgnoreCase: boolean = True): boolean;
var
  i:   integer;
  bEQ: boolean;
  tmp1, tmp2: array [0..1] of WideChar;
begin
  tmp1[0] := #0;
  tmp1[1] := #0;
  tmp2[0] := #0;
  tmp2[1] := #0;

  if (WideCompareStr(PatternPtr, WildCardAnyFile) = 0) then
  begin
    Result := True;
    exit;
  end;
  repeat
    if (WideCompareStr(PatternPtr, WildCardMultipleChar) = 0) then
    begin
      Result := True;
      exit;
    end
    else if (StrPtr^ = #0) and (PatternPtr^ <> #0) then
    begin
      Result := False;
      exit;
    end
    else if (StrPtr^ = #0) then
    begin
      Result := True;
      exit;
    end
    else
    begin
      case PatternPtr^ of
        WildCardMultipleChar:
        begin
          for i := 0 to Length(StrPtr) - 1 do
          begin
            if WIsStrMatchPattern(StrPtr + i, PatternPtr + 1, bIgnoreCase) then
            begin
              Result := True;
              exit;
            end;
          end;
          Result := False;
          exit;
        end;
        WildCardSingleChar:
        begin
          Inc(StrPtr);
          Inc(PatternPtr);
        end;
        else
        begin
          tmp1[0] := StrPtr^;
          tmp2[0] := PatternPtr^;
          if (bIgnoreCase) then
            bEQ := (WideCompareStrL(WideUpperCase(tmp1), WideUpperCase(tmp2), 1) = 0)
          else
            bEQ := (WideCompareStrL(tmp1, tmp2, 1) = 0);
          if (bEQ) then
          begin
            Inc(StrPtr);
            Inc(PatternPtr);
          end
          else
          begin
            Result := False;
            exit;
          end;
        end;
      end; // case
    end; // non-simple cases
  until False;
end;//IsStrMatchPattern
{$ENDIF}


initialization
  LCID := GetUserDefaultLCID;

  // ToAnsiChars
  p1 := AllocMem(2);
  p2 := AllocMem(2);
  // turkish?
  if (LCID <> 1055) then
    for i := 0 to 255 do
    begin
      n   := 0;
      p1^ := chr(i);
      for j := 0 to 255 do
      begin
        p2^ := chr(j);
        if (AnsiStrLComp(p2, p1, 1) < 0) then
          Inc(n);
      end;
      ToAnsiChars[i] := chr(n);
    end
  else
    // Turkish charset
    for i := 0 to 255 do
      ToAnsiChars[i] := TurkishToAnsiChars[i];

  // ToOemChars
  for i := 0 to 255 do
    ToOemChars[byte(ToAnsiChars[i])] := chr(i);
  // check is table valid
  for i := 0 to 255 do
  begin
    bCodePagesInitialized := False;
    for j := 0 to 255 do
      if (ToAnsiChars[j] = chr(i)) then
      begin
        bCodePagesInitialized := True;
        break;
      end;
    if (not bCodePagesInitialized) then
      break;
  end;
  if (not bCodePagesInitialized) then
  begin
    Int256Chars(@ToUpperChars);
    CharToOemBuffA(PAnsiChar(@ToUpperChars), PAnsiChar(@ToOemChars), 256);
    OemToCharBuffA(PAnsiChar(@ToUpperChars), PAnsiChar(@ToAnsiChars), 256);
    Int256Chars(@ToLowerChars);
    CharUpperBuffA(PAnsiChar(@ToUpperChars), 256);
    CharLowerBuffA(PAnsiChar(@ToLowerChars), 256);
  end
  else
  begin
    for i := 0 to 255 do
    begin
      p1^ := chr(i);
      // Turkish charset?
      if (LCID <> 1055) then
        CharUpperBuff(p1, 1)
      else
        p1^ := TurkishToUpperChars[byte(p1^)];
      ToUpperChars[byte(ToAnsiChars[i])] := ToAnsiChars[byte(p1^)];
      p1^ := chr(i);
      // Turkish charset?
      if (LCID <> 1055) then
        CharLowerBuff(p1, 1)
      else
        p1^ := TurkishToLowerChars[byte(p1^)];
      ToLowerChars[byte(ToAnsiChars[i])] := ToAnsiChars[byte(p1^)];
    end;
  end;
  FreeMem(p1);
  FreeMem(p2);
end.


