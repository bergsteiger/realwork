unit ddDocumentFilter;

interface

uses evdBufferedFilter, k2Interfaces,
 k2Base
 ;

type
 TddDocumentFilter = class(TevdCustomChildBufferedFilter)
 private
 protected
  function ChildTypeForFiltering: Tk2Type; override;
 public
 end;

implementation

uses
 Document_Const;

function TddDocumentFilter.ChildTypeForFiltering: Tk2Type;
begin
 Result := k2_typDocument;
end;

end.
