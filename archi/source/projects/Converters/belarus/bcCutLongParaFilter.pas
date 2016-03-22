unit bcCutLongParaFilter;

{ $Id: bcCutLongParaFilter.pas,v 1.4 2016/03/16 11:37:25 fireton Exp $ }

interface
uses
 evdBufferedFilter,
 l3Variant;

type
 TbcCutLongParaFilter = class(TevdBufferedFilter)
 protected
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
    // internal methods
  function NeedStartBuffering(aID : Integer): Boolean; override;
 end;

implementation
uses
 SysUtils,
 l3Base,
 l3Interfaces,
 l3String,
 l3Chars,
 k2Base,
 k2Tags,
 TextPara_Const,

 nevTools;

const
 cMaxLen = 12 * 1024;  // 12 Kb

procedure TbcCutLongParaFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 l_Str: Tl3WString;
 l_IStr: Il3CString;
 l_NeedDeleteFirstChar: Boolean;
 l_Para, l_NewPara: Tl3Variant;
 l_Obj: InevObject;
 l_Point: InevPoint;
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  l_Para := aLeaf;
  while l_Para.PCharLenA[k2_tiText].SLen > cMaxLen do
  begin
   l_Str := l3Copy(l_Para.PCharLenA[k2_tiText], 0, cMaxLen);
   while (l_Str.SLen > 0) and ((not (l_Str.S[l_Str.SLen-1] in ['.', ';', ':', '?', '!'])) or (l_Str.S[l_Str.SLen] <> ' ')) and
   (l_Str.S[l_Str.SLen] <> cc_SoftEnter) do
    Dec(l_Str.SLen);
   if l_Str.SLen = 0 then
   begin
    l_Str := l3Copy(l_Para.PCharLenA[k2_tiText], 0, cMaxLen);
    while (l_Str.SLen > 0) and (not (l_Str.S[l_Str.SLen] in [' ', cc_Tab])) do
     Dec(l_Str.SLen);
    if l_Str.SLen = 0 then
     l_Str := l3Copy(l_Para.PCharLenA[k2_tiText], 0, cMaxLen);
   end;
   l_NeedDeleteFirstChar := l_Str.S[l_Str.SLen] in [cc_Tab, ' ', cc_SoftEnter];

   l_Para.QT(InevObject, l_Obj);
   l_Point := l_Obj.MakePoint;
   l_Point.PositionW := l_Str.SLen;
   l_NewPara := l_Point.Text.Modify.Split(nil, [], nil).AsObject;

   Generator.StartChild(TypeTable.TypeByHandle[-aTagId]);
   try
    l_Para.AsObject.WriteTag(Generator);
   finally
    Generator.Finish;
   end;

   if l_NeedDeleteFirstChar then
   begin
    l_NewPara.QT(InevObject, l_Obj);
    l_Point := l_Obj.MakePoint;
    l_Point.PositionW := 0;
    l_Point.Text.Modify.DeleteString(nil, 1);
   end;

   l_Para := l_NewPara;
  end; //while
  // дописываем последний кусок
  Generator.StartChild(TypeTable.TypeByHandle[-aTagId]);
  try
   l_Para.AsObject.WriteTag(Generator);
  finally
   Generator.Finish;
  end;
 end
 else
  inherited DoFlushBuffer(aLeaf, aTagId, aNeedCloseBracket);
end;

// start class TbcCutLongParaFilter

function TbcCutLongParaFilter.NeedStartBuffering(aID : Integer): Boolean;
var
 l_Type: Tk2Type;
begin
 Result := False;
 if aID < 0 then
 begin
  l_Type := TypeTable.TypeByHandle[-aID];
  Result := l_Type.IsKindOf(k2_typTextPara);
 end;
end;

end.