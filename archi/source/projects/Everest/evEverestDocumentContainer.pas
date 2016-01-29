unit evEverestDocumentContainer;

{$Include Everest.inc}

interface

uses
 nevPrintableDocumentContainer,
 evArchiLikeDocumentContainer;

type
 TevEverestDocumentContainer = class(TevArchiLikeDocumentContainer)
 protected
  function HAFPainterClass: RevHAFPainter; override;
    {-}
 end;

implementation

uses
 evEverestHAFPainer;

{ TevEverestDocumentContainer }

function TevEverestDocumentContainer.HAFPainterClass: RevHAFPainter;
begin
 Result := TevEverestHAFPainer;
end;

end.
