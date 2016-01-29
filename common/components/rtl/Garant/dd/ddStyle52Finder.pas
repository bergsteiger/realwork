unit ddStyle52Finder;

{  }

{ $Id: ddStyle52Finder.pas,v 1.3 2014/04/29 14:06:17 lulin Exp $ }

// $Log: ddStyle52Finder.pas,v $
// Revision 1.3  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.2  2012/02/20 10:48:14  narry
// ¬ывод в лог номера топика
//
// Revision 1.1  2012/01/11 10:27:20  narry
// ¬озврат к обработке через хранилище
//

interface

uses
  evdLeafParaFilter, k2Interfaces, l3Types, k2Types, k2TagFilter, l3RegEx,
  k2tagGen, l3Interfaces;

type
 TddDocStatus = (dd_dsChanged, dd_dsAbsent, dd_dsNotFinished, dd_dsIDAbsent);
 TddDocStatusEvent = procedure (DocID: Integer; DocStatus: TddDocStatus) of object;
 TddStyle52Finder = class(TevdLeafParaFilter, Il3DocIDSource)
 private
  f_Changed: Boolean;
  f_DocID: Integer;
  f_OnDocumentStatus: TddDocStatusEvent;
 protected
  procedure DoDocumentWork(aDocStatus: TddDocStatus);
  procedure DoWritePara(aLeaf: Tl3Tag); override;
        {-}
  function ParaTypeForFiltering: Long; override;
   function pm_GetDocID: Integer;
   procedure pm_SetDocID(aValue: Integer);
 public
  procedure StartChild(TypeID: Long); override;
  property DocID: Integer
   read pm_GetDocID
   write pm_SetDocID;
  property OnDocumentStatus: TddDocStatusEvent read f_OnDocumentStatus write
      f_OnDocumentStatus;
 end;

implementation

uses
  Document_Const, k2Tags, StrUtils, TextPara_Const, evdStyles, Math, SysUtils,
  l3String, l3Chars, evParaTools, evTextParaTools, NevTools, evTypes, evSearch,
  l3PrimString, l3Base;

procedure TddStyle52Finder.DoDocumentWork(aDocStatus: TddDocStatus);
begin
 if Assigned(f_OnDocumentStatus) then f_OnDocumentStatus(f_DocID, aDocStatus);
end;

procedure TddStyle52Finder.DoWritePara(aLeaf: Tl3Tag);
begin
 if not f_Changed then
 begin
  if (aLeaf.IntA[k2_tiStyle] = ev_saChangesInfo) then
  begin
   f_Changed:= True;
   DoDocumentWork(dd_dsChanged);
  end;
 end; // f_DocID > 0
 inherited;
end;

function TddStyle52Finder.ParaTypeForFiltering: Long;
begin
 Result := k2_idTextPara;
end;

procedure TddStyle52Finder.StartChild(TypeID: Long);
begin
 inherited StartChild(TypeID);
 if CurrentType.InheritsFrom(k2_idDocument) then
  f_Changed:= False;
end;


function TddStyle52Finder.pm_GetDocID: Integer;
begin
 Result:= f_DocID;
end;

procedure TddStyle52Finder.pm_SetDocID(aValue: Integer);
begin
 f_DocID:= aValue;
 l3System.Msg2Log(IntToStr(aValue));
end;

end.
