unit g2nHeaderGenerator;

{ $Id: g2nHeaderGenerator.pas,v 1.1 2015/02/04 12:18:31 fireton Exp $ }

interface

uses
 l3Types,
 l3Variant,
 
 k2Types,
 k2TagGen,
 k2Tags,
 k2TagFilter,

 g2nTypes;

type
 Tg2nHeaderGenerator = class(Tk2TagFilter)
 private
  f_OnGetDocID: Tg2nGetDocIDEvent;
  f_OnGetTitle: Tg2nGetTitleEvent;
  procedure DoGenerateHeader;
 public
  procedure StartChild(aTypeID: Tl3VariantDef); override;
  property OnGetTitle: Tg2nGetTitleEvent read f_OnGetTitle write f_OnGetTitle;
  property OnGetDocID: Tg2nGetDocIDEvent read f_OnGetDocID write f_OnGetDocID;
 end;

implementation
uses
 Document_Const;

procedure Tg2nHeaderGenerator.DoGenerateHeader;
var
 l_DocID : Integer;
 l_Title : string;
begin
 l_DocID := 0;
 l_Title := '';
 if Assigned(f_OnGetDocID) then
  f_OnGetDocID(l_DocID);
 if Assigned(f_OnGetTitle) then
  f_OnGetTitle(l_Title);
 if l_DocID > 0 then
  Generator.AddIntegerAtom(k2_tiExternalHandle, l_DocID);
 if l_Title <> '' then
  Generator.AddStringAtom(k2_tiName, l_Title);
end;

procedure Tg2nHeaderGenerator.StartChild(aTypeID: Tl3VariantDef);
begin
 inherited;
 if aTypeID = k2_typDocument then
  DoGenerateHeader;
end;

end.