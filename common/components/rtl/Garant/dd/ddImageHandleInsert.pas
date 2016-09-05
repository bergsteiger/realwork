unit ddImageHandleInsert;

{ $Id: ddImageHandleInsert.pas,v 1.11 2016/07/28 08:45:38 lulin Exp $ }

// $Log: ddImageHandleInsert.pas,v $
// Revision 1.11  2016/07/28 08:45:38  lulin
// - удаляем ненужное.
//
// Revision 1.10  2016/07/27 14:48:31  lulin
// - вычищаем устаревшее.
//
// Revision 1.9  2015/11/25 14:01:46  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.8  2015/04/03 13:50:41  lukyanets
// Изолируем HT
//
// Revision 1.7  2015/03/13 11:55:47  voba
// - локальное автосохранение документов
//
// Revision 1.6  2014/04/08 14:17:10  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.5  2014/04/08 07:19:38  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.4  2014/04/07 08:08:05  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.3  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.2  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.1  2012/02/27 09:45:48  fireton
// - модуль для подстановки ExternalHandle картинкам в тексте
//

interface
uses
 Classes,

 l3Types,

 k2Types,
 k2Interfaces,
 k2Base,
 k2TagGen,

 evdBufferedFilter;

(*type
 TddImageHandleInsertFilter = class(TevdBufferedFilter)
 private
  f_OnError: TNotifyEvent;
  procedure DoOnError;
 protected
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
  class function SetTo(var theGenerator: Tk2TagGenerator; aOnError: TNotifyEvent = nil): Pointer; overload;
  property OnError: TNotifyEvent read f_OnError write f_OnError;
 end;*)

(* function CheckExternalHandlesInBitmapParagraphs(aDocRoot: Tl3Variant): Boolean;*)

implementation
uses
 SysUtils,

 l3Base,

 BitmapPara_Const,

 k2Tags,

 evTypes,
 evSearch,
 evBitmapSearcher,

 nevTools,
 nevConfirm,

 daDataProvider,
 daSchemeConsts,
 DT_Const;

const
 c_SROptions = [ev_soFind, ev_soGlobal, ev_soConfirm, ev_soReplaceAll, ev_soNoException];

type
 TMissingExternalHandleInBitmapSearcher = class(TevBitmapSearcher)
 protected
  function DoCheckBitmap(aBitmapPara: Tl3Variant): Boolean; override;
 end;

 TNewHandleForBitmapReplacer = class(TevBaseReplacer)
 public
  class function Make: IevReplacer; reintroduce;
  function ReplaceFunc(const aView : InevView; const Container : InevOp; const aBlock : InevRange): Bool; override;
 end;

function CheckExternalHandlesInBitmapParagraphs(aDocRoot: Tl3Variant): Boolean;
var
 l_Doc: InevObject;
 l_Confirm: InevConfirm;
 l_Block   : InevRange;
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
begin
 if (aDocRoot <> nil) and aDocRoot.QT(InevObject, l_Doc) then
 begin
  l_Block := l_Doc.Range;
  l_Confirm := TnevConfirm.Make;
  l_Searcher := TMissingExternalHandleInBitmapSearcher.Make;
  l_Searcher.Options :=  c_SROptions;
  l_Replacer := TNewHandleForBitmapReplacer.Make;
  l_Replacer.Options := c_SROptions;
  l_Replacer.Searcher := l_Searcher;
  l_Block.SearchReplace(l_Searcher, l_Replacer, l_Confirm, nil, nil, False);
 end;
end;

(*procedure TddImageHandleInsertFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typBitmapPara) and (AtomIndex = k2_tiExternalHandle) and
    (Value.AsInteger > 0) then
  f_HasExternalHandle := True;
 inherited;
end;*)
(*
procedure TddImageHandleInsertFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 l_Handle: LongWord;
begin
 if aLeaf.IntA[k2_tiExternalHandle] = 0 then
 begin
  l_Handle := GlobalDataProvider.GetFreeExtObjID(CurrentFamily);
  if l_Handle > 0 then
   aLeaf.IntW[k2_tiExternalHandle, Context] := l_Handle
  else
   DoOnError;
 end;
 inherited;
end;

procedure TddImageHandleInsertFilter.DoOnError;
begin
 if Assigned(f_OnError) then
  f_OnError(Self);
end;

function TddImageHandleInsertFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -k2_idBitmapPara;
 //Result := (aID = -k2_idExtDataPara) or (aID = -k2_idBitmapPara);
end;

class function TddImageHandleInsertFilter.SetTo(var theGenerator: Tk2TagGenerator; aOnError: TNotifyEvent = nil):
    Pointer;
  {-}
var
 l_Filter : TddImageHandleInsertFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.OnError:= aOnError;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;
*)

function TMissingExternalHandleInBitmapSearcher.DoCheckBitmap(aBitmapPara: Tl3Variant): Boolean;
begin
 Result := (not aBitmapPara.Attr[k2_tiExternalHandle].IsValid) or
           (aBitmapPara.IntA[k2_tiExternalHandle] <= 0);
end;

class function TNewHandleForBitmapReplacer.Make: IevReplacer;
begin
 Result := inherited Make('');
end;

function TNewHandleForBitmapReplacer.ReplaceFunc(const aView : InevView; const Container : InevOp; const aBlock :
    InevRange): Bool;
var
 l_Handle: LongWord;
 l_TS: IevTagSearcher;
begin
 Assert(Supports(Searcher, IevTagSearcher, l_TS), 'TNewHandleForBitmapReplacer needs IevTagSearcher!');
 l_Handle := GlobalDataProvider.GetFreeExtObjID(CurrentFamily);
 l_TS.FoundTag.IntW[k2_tiExternalHandle, Container] := l_Handle;
 Result := True;
end;

end.