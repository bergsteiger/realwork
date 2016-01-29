unit moDocument;

// $Id: moDocument.pas,v 1.2 2004/10/07 11:52:38 lulin Exp $

// $Log: moDocument.pas,v $
// Revision 1.2  2004/10/07 11:52:38  lulin
// - не компилировалось без define Nemesis.
//
// Revision 1.1  2003/12/09 18:28:27  law
// no message
//
// Revision 1.7  2003/12/02 16:46:38  law
// - change: добавлены форматы RTF, HTML и другие.
//
// Revision 1.6  2003/12/02 16:01:06  law
// - new operation: Save.
//
// Revision 1.5  2003/12/02 15:35:46  law
// - new operation: Open.
//
// Revision 1.4  2003/12/02 14:59:51  law
// - выставлены директивы CVS.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmModule, vcmModuleDef, vcmBase, vcmOperations,
  l3InterfacedComponent, evLoadDocumentManager, evSaveDocumentManager,
  vcmComponent;

type
  TevpDocument = class(TvcmModule)
      ModuleDef : TvcmModuleDef;
    LoadManager: TevLoadDocumentManager;
    SaveManager: TevSaveDocumentManager;
    procedure ModuleDefNewExecute(var aParams: IvcmParams);
    procedure ModuleDefOpenExecute(var aParams: IvcmParams);
    procedure ModuleDefGetSaveManagerExecute(var aParams: IvcmParams);
    private
      { Private declarations }
    public
      { Public declarations }
    protected
    // internal methods
      class procedure GetEntityForms(aList : TvcmVList);
        override;
        {* - возвращает список форм сущностей. }
  end;

implementation

uses
  evExtFormat,
  
  enText
  ;

{$R *.DFM}

class procedure TevpDocument.GetEntityForms(aList : TvcmVList);
  //override;
  {-}
begin
 inherited;
 aList.Add(TevpText);
end;

procedure TevpDocument.ModuleDefNewExecute(var aParams: IvcmParams);
begin
 TevpText.Make(Module, vcmCleanUserParams(aParams));
end;

procedure TevpDocument.ModuleDefOpenExecute(var aParams: IvcmParams);
begin
 if LoadManager.QueryName then
  TevpText.Make(Module, vcmCleanUserParams(aParams).Add(TvcmHolder.Make(LoadManager)));
end;

procedure TevpDocument.ModuleDefGetSaveManagerExecute(
  var aParams: IvcmParams);
begin
 with aParams do
  if (Count > 0) then
   AsIU[0] := TvcmHolder.Make(SaveManager)
  else
   Add(TvcmHolder.Make(SaveManager));
end;

end.
