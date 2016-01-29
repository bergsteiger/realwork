unit fsSearchConsult;

interface

uses
  Windows, 
  Messages, 
  SysUtils, 
  Classes, 
  Graphics, 
  Controls, 
  Forms,
  Dialogs, 

  vcmInterfaces, 
  vcmBase, 
  vcmFormSetFactory,
  vcmFormSetFormsCollectionItem
  ;

type
  Tfs_SearchConsult = class(TvcmFormSetFactory)
    private
      { Private declarations }
    public
      { Public declarations }
  end;

implementation

{$R *.DFM}

end.
