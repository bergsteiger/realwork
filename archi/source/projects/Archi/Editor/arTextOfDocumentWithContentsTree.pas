unit arTextOfDocumentWithContentsTree;

interface

uses
 nevTools,

 DocIntf;

type
  TarTextOfDocumentWithContentsTree = class(TarTextOfDocument)
  protected
   function  DoMakeDocumentContainer: InevDocumentContainer;
     override;
     {-}
  end;

implementation

uses
 arDocumentContainerWithContentsTree;

function  TarTextOfDocumentWithContentsTree.DoMakeDocumentContainer: InevDocumentContainer;
begin
 Result := TarDocumentContainerWithContentsTree.Make;
end;

end.
 