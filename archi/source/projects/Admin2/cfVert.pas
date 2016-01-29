unit cfVert;

{ $Id: cfVert.pas,v 1.2 2009/01/29 14:22:48 fireton Exp $}

// $Log: cfVert.pas,v $
// Revision 1.2  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmContainerForm, vcmEntities,
  vcmComponent, vcmBaseEntities, ExtCtrls, RXSplit, l3InterfacedComponent; 

type
  TcfVertical = class(TvcmContainerForm)
    Entities : TvcmEntities;
    zLeft: TPanel;
    zRight: TPanel;
    Splitter1: TRxSplitter;
    private
      { Private declarations }
    public
      { Public declarations }
  end;

implementation

{$R *.DFM}

end.
