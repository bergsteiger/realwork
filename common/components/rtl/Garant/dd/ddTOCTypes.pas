//..........................................................................................................................................................................................................................................................
unit ddTOCTypes;

// $Id: ddTOCTypes.pas,v 1.11 2010/02/24 17:39:55 lulin Exp $ 

// $Log: ddTOCTypes.pas,v $
// Revision 1.11  2010/02/24 17:39:55  lulin
// - удал€ем излишнюю виртуальность.
//
// Revision 1.10  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.9  2004/03/15 15:45:57  narry
// - bug fix: лишн€€ точка после цифры
//
// Revision 1.8  2003/07/25 14:50:03  narry
// - update: обработка "неправильных" номеров статей (e.g. 12-1, 14.5)
//
// Revision 1.7  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.6  2003/04/15 15:22:45  law
// - bug fix: не компилировалс€ Ёверест.
//
// Revision 1.5  2002/10/08 12:30:20  narry
// - bug fix: приложени€, имеющие составной номер (1.1) форматировались неправильно
//
// Revision 1.4  2002/09/19 13:09:15  narry
// - remove unit: ddHTML.
//
// Revision 1.3  2001/06/21 15:40:39  law
// - new CVS directives: ID, Log.
//

{$I ddDefine.inc }

interface

Uses
  Classes,
  l3Base, l3Types;

type
 TddContentType = (dd_ctNone, dd_ctHeader, dd_ctAppendix, dd_ctArticle, dd_ctPoint);
 TddContentItem = class(Tl3String)
 private
  f_SubID  : Long;
  f_AddID  : Long;
  f_StartNo: ShortString;
  f_StopNo : ShortString;
  f_Level  : Long;
  f_Type   : TddContentType;
  f_Closed : Boolean;
  f_Original: Boolean;
    f_PseudoDot: Integer;
 protected
 public
  procedure InitFields;
   override;
  procedure Assign(P: TPersistent); override;
 public
  property AddID: Long
   read f_AddID
   write f_AddID;
  property SubID: Long
   read f_SubID
   write f_SubID;
  property StartNo: ShortString
   read f_StartNo
   write f_StartNo;
  property StopNo: ShortString
   read f_StopNo
   write f_StopNo;
  property Level: Long
   read f_Level
   write f_Level;
  property ItemType: TddContentType
   read f_Type
   write f_Type;
  property Closed: Boolean
   read f_Closed
   write f_Closed;
  property Original: Boolean
   read f_Original
   write f_Original;
  property PseudoDot: Integer
   read f_PseudoDot
   write f_PseudoDot;
 end;

implementation

procedure TddContentItem.InitFields;
begin
 inherited;
 f_AddID  := -1;
 f_SubID  := -1;
 f_StartNo:= '';
 f_StopNo := '';
 f_Level  := 1;
 f_Type   := dd_ctNone;
 f_Closed := False;
 f_Original:= true;
 f_PseudoDot:= 0;
end;

procedure TddContentItem.Assign(P: TPersistent);
begin
 inherited;
 if P is TddContentItem then
 begin
  AddID:= TddContentItem(P).AddID;
  SubID:= TddContentItem(P).SubID;
  StartNo:= TddContentItem(P).StartNo;
  StopNo:= TddContentItem(P).StopNo;
  Level:= TddContentItem(P).Level;
  f_Type:= TddContentItem(P).ItemType;
  f_CLosed:= TddContentItem(P).Closed;
  f_Original:= TddContentItem(P).Original;
  f_PseudoDot:= TddContentItem(P).PseudoDot;
 end;
end;

end.
