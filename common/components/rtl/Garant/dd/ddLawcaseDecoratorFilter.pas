unit ddLawcaseDecoratorFilter;

{ $Id: ddLawcaseDecoratorFilter.pas,v 1.3 2014/04/29 14:06:17 lulin Exp $ }

// $Log: ddLawcaseDecoratorFilter.pas,v $
// Revision 1.3  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.2  2009/03/04 16:25:56  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.1  2008/09/23 12:17:48  fireton
// - импорт/экспорт номера судебного дела
//

interface

uses
 k2Interfaces,
 ddHeaderFilter
 ;

type
 TddLawcaseDecoratorFilter = class(TddHeaderFilter)
 protected
  procedure AfterFlushHeader(aHeaderRoot: Tl3Tag); override;
 end;

implementation
uses
 evdTypes,
 evdStyles,

 k2Tags,

 DT_Types,

 DecorTextPara_Const,
 SegmentsLayer_Const,
 Hyperlink_Const,
 Address_Const
 ;

const
 cLCDText = 'См. досье по данному судебному делу';
 cLCDHLStart = 5;
 cLCDHLEnd   = 9;

procedure TddLawcaseDecoratorFilter.AfterFlushHeader(aHeaderRoot: Tl3Tag);
var
 I: Integer;
 l_DN: Tl3Tag;
begin
 if Generator = nil then
  Exit;

 with aHeaderRoot.Attr[k2_tiNumAndDates] do
  if not IsNull then
   for I := 0 to Pred(ChildrenCount) do
   begin
    l_DN := Child[I];
    if TDNType(l_DN.IntA[k2_tiType]) = dnLawCaseNum then
    begin
     with Generator do
     try
      StartChild(k2_idDecorTextPara);
      // стиль оформления
      AddIntegerAtom(k2_tiStyle, ev_saTxtComment);
      // ссылка
      StartTag(k2_tiSegments);
      try
       StartChild(k2_idSegmentsLayer);
       try
        AddIntegerAtom(k2_tiHandle, ev_slHyperlinks);
        StartChild(k2_idHyperlink);
        try
         AddIntegerAtom(k2_tiStart, cLCDHLStart);
         AddIntegerAtom(k2_tiFinish, cLCDHLEnd);
         StartChild(k2_idAddress);
         try
          AddIntegerAtom(k2_tiDocID, l_DN.IntA[k2_tiDocID]);
         finally
          Finish;
         end; // idAddress
        finally
         Finish;
        end; // idHyperlink
       finally
        Finish;
       end; // idSegmentsLayer
      finally
       Finish;
      end;
      // собственно, текст
      AddStringAtom(k2_tiText, cLCDText);
     finally
      Finish;
     end;
    end;
   end;
end;


end.
