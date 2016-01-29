unit afDocumentCleaner;
{ Удаляет параметры бумаги из документа }

// $Id: afDocumentCleaner.pas,v 1.1 2013/04/16 08:09:55 narry Exp $

// $Log: afDocumentCleaner.pas,v $
// Revision 1.1  2013/04/16 08:09:55  narry
// Автоматические форматировщики
//

interface

uses
 k2TagFilter, k2Types, l3Types;

type
 TafDocumentCleaner = class(Tk2TagFilter)
 protected
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 public
 end;

implementation

uses
  Document_Const, k2Tags;

procedure TafDocumentCleaner.DoAddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
  //virtual;
  {-}
begin
 if CurrentType.InheritsFrom(k2_idDocument) then
  if AtomIndex in [k2_tiWidth, k2_tiLeftIndent, k2_tiRightIndent] then
   exit;
 inherited;  
end;

end.
