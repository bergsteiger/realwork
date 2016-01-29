unit ddExtAnnoPipe;

//$Id: ddExtAnnoPipe.pas,v 1.11 2014/04/04 07:14:47 dinishev Exp $

// $Log: ddExtAnnoPipe.pas,v $
// Revision 1.11  2014/04/04 07:14:47  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.10  2013/10/21 15:43:17  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.9  2013/10/21 10:31:06  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.8  2013/10/18 16:01:27  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.7  2013/04/11 16:46:46  lulin
// - отлаживаем под XE3.
//
// Revision 1.6  2009/03/04 16:25:58  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.5  2008/06/23 08:27:52  narry
// - не собиралось
//
// Revision 1.4  2008/02/05 12:49:15  lulin
// - упрощаем базовые объекты.
//
// Revision 1.3  2005/03/18 16:23:40  narry
// - update: замена прямого оформления стилевым
//
// Revision 1.2  2005/03/16 12:48:30  narry
// - bug fix: закрывалась лишняя скобка
//
// Revision 1.1  2005/03/11 16:00:30  narry
// - update:
//

interface

Uses
 l3Base, l3Types,
 k2TagTerminator, k2Types;

type
 TddExtAnnotationFilter = class(Tk2TagTerminator)
 private
   f_DocumentStarted: Boolean;
   procedure FinishDocument;
   function IsName(aText: Tl3CustomString): Boolean;
   function IsNewDocument(aText: Tl3CustomString; out theID: Longint): Boolean;
 protected
   procedure CloseStructure(NeedUndo: Boolean); override;
     {-вызывается на закрывающуюся скобку}
 public
     {-}
   procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
     {-}
 end;

implementation

Uses
 k2Tags, 
 evdStyles,
 StrUtils, SysUtils,

 TextPara_Const,
 AnnoTopic_Const,
 Document_Const
 ;

procedure TddExtAnnotationFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_ID : Longint;
begin
 if CurrentType.IsKindOf(k2_typTextPara) and (AtomIndex = k2_tiText) then
 begin
  { находим !TOPIC - это начало нового документа
    находим !ANNONAME - это имя документа
    Все остальное - это абзацы
  }
  if IsNewDocument(Value.AsString As Tl3CustomString, l_ID) then
  begin
   FinishDocument;
   f_DocumentStarted := True;
   Generator.StartChild(k2_typAnnoTopic);
   Generator.AddIntegerAtom(k2_tiExternalHandle, l_ID);
  end
  else
  if f_DocumentStarted then
  begin
   if IsName(Value.AsString As Tl3CustomString) then
     Generator.AddStringAtom(k2_tiName, Value.AsString.AsWStr)
   else
   begin
    Generator.StartChild(k2_typTextPara);
    try
     Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalAnno);
     Generator.AddStringAtom(k2_tiText, Value.AsString.AsWStr);
    finally
     Generator.Finish;
    end;
   end;
  end; // f_DocumentStarted
 end;
end;

procedure TddExtAnnotationFilter.CloseStructure(NeedUndo: Boolean);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  FinishDocument;
 inherited;
end;

procedure TddExtAnnotationFilter.FinishDocument;
begin
 if f_DocumentStarted then
 begin
  Generator.Finish;
  f_DocumentStarted := False;
 end;
end;

function TddExtAnnotationFilter.IsName(aText: Tl3CustomString): Boolean;
begin
 Result := False;
 if not aText.Empty then
 begin
  if ANSIStartsText('!ANNONAME ', aText.AsString) then
  begin
   aText.Delete(0, 10);
   Result := True;
  end; // ANSIStartsText('!ANNONAME ', aText.AsString)
 end; // not aText.Empty
end;

function TddExtAnnotationFilter.IsNewDocument(aText: Tl3CustomString; out
    theID: Longint): Boolean;
var
 l_IDString: AnsiString;
 i: Integer;
begin
 Result := False;
 if not aText.Empty then
 begin
  if ANSIStartsText('!TOPIC ', aText.AsString) then
  begin
   i:= 7; l_IDString := '';
   while (i < aText.Len) and (aText.Ch[i] in ['0'..'9']) do
   begin
    l_IDString := l_IDString + aText.Ch[i];
    Inc(i);
   end;
   theID := StrToIntDef(l_IDString, -1);
   Result := theID <> -1;
  end; // ANSIStartsText('!TOPIC ', aText.AsString)
 end; // not aText.Empty
end;

end.
