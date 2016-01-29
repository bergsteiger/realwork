unit ReplaceSoftEnterFilter;

{  }

{ $Id: ReplaceSoftEnterFilter.pas,v 1.2 2014/04/30 13:11:40 lulin Exp $ }

// $Log: ReplaceSoftEnterFilter.pas,v $
// Revision 1.2  2014/04/30 13:11:40  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.1  2012/02/07 06:49:01  narry
// Утилита по замене мягких переносов (335580209)
//
// Revision 1.1  2012/01/11 10:27:20  narry
// Возврат к обработке через хранилище
//

interface

uses
  evdLeafParaFilter, k2Interfaces, l3Types, k2Types, k2TagFilter, l3RegEx,
  k2tagGen, l3Interfaces;

type
 TddDocStatus = (dd_dsChanged, dd_dsAbsent, dd_dsNotFinished, dd_dsIDAbsent);
 TddDocStatusEvent = procedure (DocID: Integer; DocStatus: TddDocStatus) of object;
 TReplaceSoftEnterFilter = class(TevdLeafParaFilter, Il3DocIDSource)
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

procedure TReplaceSoftEnterFilter.DoDocumentWork(aDocStatus: TddDocStatus);
begin
 if Assigned(f_OnDocumentStatus) then f_OnDocumentStatus(f_DocID, aDocStatus);
end;

procedure TReplaceSoftEnterFilter.DoWritePara(aLeaf: Tl3Tag);
var
 l_S: String;
begin
 if (aLeaf.IntA[k2_tiStyle] = ev_saChangesInfo) then
 begin
  l_S:= AnsiReplaceStr(aLeaf.StrA[k2_tiText], #29, ' ');
  l_S:= AnsiReplaceStr(l_S, #10, ' ');
  aLeaf.StrW[k2_tiText, nil]:= l_S;
  DoDocumentWork(dd_dsChanged);
 end;
 inherited;
end;

function TReplaceSoftEnterFilter.ParaTypeForFiltering: Long;
begin
 Result := k2_idTextPara;
end;

procedure TReplaceSoftEnterFilter.StartChild(TypeID: Long);
begin
 inherited StartChild(TypeID);
end;


function TReplaceSoftEnterFilter.pm_GetDocID: Integer;
begin
 Result:= f_DocID;
end;

procedure TReplaceSoftEnterFilter.pm_SetDocID(aValue: Integer);
begin
 f_DocID:= aValue;
 l3System.Msg2Log(IntToStr(aValue));
end;

end.
