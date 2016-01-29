unit evBitmapSearcher;

{ $Id: evBitmapSearcher.pas,v 1.7 2014/04/08 14:16:55 lulin Exp $ }

// $Log: evBitmapSearcher.pas,v $
// Revision 1.7  2014/04/08 14:16:55  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.6  2014/04/08 07:04:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.5  2014/04/07 08:08:24  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.4  2014/03/04 14:44:07  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.3  2013/10/21 15:42:57  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.2  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.1  2012/02/27 09:32:29  fireton
// - searcher для изображений в тексте
//

interface
uses
 l3Types,
 l3CustomString,

 evTypes,
 evSearch,

 nevBase,
 nevTools,

 k2Interfaces;

type
 IevTagSearcher = interface(InevBase)
 ['{A8261BE3-A8B9-466B-8D2C-839DF0E170FF}']
  function pm_GetFoundTag: Tl3Variant;
  property FoundTag: Tl3Variant read pm_GetFoundTag;
 end;

 TevBitmapSearcher = class(TevStyleSearcher, IevTagSearcher)
 private
  f_FoundTag: Tl3Variant;
 protected
  function DoCheckBitmap(aBitmapPara: Tl3Variant): Boolean; virtual;
  function pm_GetFoundTag: Tl3Variant;
  procedure Cleanup; override;
 public
  class function Make(anOptions: TevSearchOptionSet = []; aNext: IevSearcher = nil): IevSearcher; reintroduce;
  function DoCheckText(aPara : Tl3Variant;
                       aText       : Tl3CustomString;
                       const aSel  : TevPair;
                       out theSel : TevPair): Bool; override;

 end;

implementation

uses
 SysUtils,
 
 evdTypes,
 evdStyles,
 BitmapPara_Const;

procedure TevBitmapSearcher.Cleanup;
begin
 FreeAndNil(f_FoundTag);
 inherited;
end;

function TevBitmapSearcher.DoCheckBitmap(aBitmapPara: Tl3Variant): Boolean;
begin
 // базовый класс ищет вообще все картинки
 Result := True;
end;

class function TevBitmapSearcher.Make(anOptions: TevSearchOptionSet = []; aNext: IevSearcher = nil): IevSearcher;
begin
 Result := inherited Make(ev_saObject, Ord(ev_slObjects), ev_spSegments, anOptions, aNext);
end;

function TevBitmapSearcher.DoCheckText(aPara : Tl3Variant;
                                       aText       : Tl3CustomString;
                                       const aSel  : TevPair;
                                        out theSel : TevPair): Bool;
begin
 Result := inherited DoCheckText(aPara, aText, aSel, theSel);
 if Result then
 begin
  Result := (f_CurrentSeg <> nil) and
            f_CurrentSeg.Child[0].IsKindOf(k2_typBitmapPara) and
            DoCheckBitmap(f_CurrentSeg.Child[0]);
  if Result then
   f_CurrentSeg.Child[0].SetRef(f_FoundTag);
 end;
end;

function TevBitmapSearcher.pm_GetFoundTag: Tl3Variant;
begin
 Result := f_FoundTag;
end;


end.