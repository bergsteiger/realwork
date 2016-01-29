unit dd_lcPageNumberEliminator;
{ Удаляет псевдономера страниц из текста судебных постановлений }

interface

uses
 evdBufferedFilter, k2Interfaces, ddTypes, l3RegEx;

type
 Tdd_lcPageNumberEliminator = class(TevdChildBufferedFilter)
 private
  f_OnError: TddErrorEvent;
  f_REPageNumber: Tl3RegularSearch;
  function IsTextPara(aTag: Tl3Variant): Boolean;
  function ParaWithText(aTag: Tl3Variant): Boolean;
  procedure WriteError(errorKind: Integer);
  function  pm_GetREPageNumber: Tl3RegularSearch;
 protected
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
  procedure Cleanup; override;
  property REPageNumber: Tl3RegularSearch read pm_GetREPageNumber;
 public
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

implementation

uses
 SysUtils,
 l3Base, l3String, k2Tags, textPara_Const, l3Chars, Document_Const;

procedure Tdd_lcPageNumberEliminator.Cleanup;
begin
 FreeAndNil(f_REPageNumber);
 inherited;
end;

procedure Tdd_lcPageNumberEliminator.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 i, j: Integer;
 l_T, l_loCase: Tl3Variant;
 l_MP: Tl3MatchPosition;
 l_Text: AnsiString;
begin
 i:= 0;
 while i < aLeaf.ChildrenCount do
 begin
  l_T:= aLeaf.Child[i];
  if IstextPara(l_T) then
  begin
   if ParaWithText(l_T)
      and (l_T.PCharLenA[k2_tiText].SLen  < 5)
      and REPageNumber.SearchInString(l_T.PCharLenA[k2_tiText], l_MP) then
   begin
    aLeaf.DeleteChild(i);
    WriteError(0);
    //Dec(i); // оказались на предыдущем

    if i < aLeaf.ChildrenCount then
    begin
     l_T:= aLeaf.Child[i];
     if IsTextPara(l_T) then
     begin
      if ParaWithText(l_T) and (l_T.StrA[k2_tiText][1] in cc_LoRussian) then
      begin // Теперь нужно идти вверх до первого непустого абзаца, если i+1 начинается с маленькой буквы
       l_LoCase:= l_T;
       j:= Pred(i);
       while (j > 0) do
       begin
        l_T:= aLeaf.Child[j];
        if IsTextPara(l_T) then
        begin
         if ParaWithText(l_T) then
         begin
          l_Text:= l_T.StrA[k2_tiText];
          if l_Text[Length(l_text)] in ['.', '!', '?'] then
           break
          else
          begin
           if l_Text[Length(l_text)] = '-' then
           // удаляем дефис
            Delete(l_Text, Length(l_Text), 1)
           else
           // добавляем пробел
            l_Text:= l_Text + ' ';
           // склеиваем абзацы и удаляем лишние
           l_T.StrA[k2_tiText]:= l_Text + l_LoCase.StrA[k2_tiText];
           while i <> j do
           begin
            WriteError(1);
            aLeaf.DeleteChild(i);
            Dec(i);
           end;
           break;
          end
         end
         else
          Dec(j);
        end
        else
         dec(j);
       end;
      end
     end
    end;
   end;
  end; // l_T.IsValid
  inc(i);
 end;// while i
 inherited;
end;

function Tdd_lcPageNumberEliminator.IsTextPara(aTag: Tl3Variant): Boolean;
begin
 Result := (aTag.IsValid) and aTag.IsKindOf(k2_typTextPara);
end;

function Tdd_lcPageNumberEliminator.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -k2_idDocument;
end;

function Tdd_lcPageNumberEliminator.ParaWithText(aTag: Tl3Variant): Boolean;
begin
 Result := aTag.Attr[k2_tiText].IsValid and not aTag.Attr[k2_tiText].IsNull and (aTag.StrA[k2_tiText] <> '');
end;

procedure Tdd_lcPageNumberEliminator.WriteError(errorKind: Integer);
{$IFNDEF nsTest}
var
 l_msg: AnsiString;
{$ENDIF}
begin
 {$IFNDEF nsTest}
 case ErrorKind of
  0: l_Msg:= 'Удален номер страницы';
  1: l_Msg:= 'Соединены абзацы';
 end;
 if Assigned(f_OnError) then
  f_Onerror(l_Msg)
 else
  l3System.Msg2Log(l_Msg);
 {$ENDIF}
end;

function Tdd_lcPageNumberEliminator.pm_GetREPageNumber: Tl3RegularSearch;
begin
 if f_REPageNumber = nil then
 begin
  f_REPageNumber := Tl3RegularSearch.Create;
  f_REPageNumber.IgnoreCase := True;
  f_REPageNumber.SearchPattern := '^\s*\d+\s*(\s+\c?[\d\-\\\/\(\)]+)?';
 end;
 Result := f_REPageNumber;
end;


end.
