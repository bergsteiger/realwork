unit PreviewForm;

{ $Id: PreviewForm.pas,v 1.5 2011/05/23 11:31:28 dinishev Exp $ }

// $Log: PreviewForm.pas,v $
// Revision 1.5  2011/05/23 11:31:28  dinishev
// [$266421641]
//
// Revision 1.4  2005/05/27 14:44:23  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  l3Base,
  evPreviewPanel, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwCustomCommonControlPrim, afwCustomCommonControl, vtPreviewPanel
  ;

type
  TfmPreview = class(TForm)
    vtPreviewPanel1: TvtPreviewPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;{TfmPreview}

implementation

{$R *.DFM}

end.
