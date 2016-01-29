unit evSBSRowHotSpotTester;

{ Библиотека "Эверест"    }
{ Начал: Инишев Д.А.       }
{ Модуль: evSBSRowHotSpotTester - }
{ Начат: 29.11.2011 17:15 }
{ $Id: evSBSRowHotSpotTester.pas,v 1.1 2011/11/29 13:46:26 dinishev Exp $ }

// $Log: evSBSRowHotSpotTester.pas,v $
// Revision 1.1  2011/11/29 13:46:26  dinishev
// {Requestlink:109904163}
//

{$Include evDefine.inc }

interface

uses
 evTableRowHotSpot,
 evTableColumnHotSpot;

type
 TevSBSRowHotSpotTester = class(TevTableRowHotSpotTester)
 protected
  function GetTableColumnHotSpot: RevTableColumnHotSpot;
    override;
     {-}
 end;

implementation

uses
 evSBSColumnHotSpot;

{ TevSBSRowHotSpotTester }

function TevSBSRowHotSpotTester.GetTableColumnHotSpot: RevTableColumnHotSpot;
begin
 Result := TevSBSColumnHotSpot;
end;

end.

