unit Main;

// $Id: Main.pas,v 1.1 2003/12/09 18:28:26 law Exp $

// $Log: Main.pas,v $
// Revision 1.1  2003/12/09 18:28:26  law
// no message
//
// Revision 1.8  2003/12/08 16:49:45  law
// - начал реализовывать мысли насчет библиотеки PlugIn'ов.
//
// Revision 1.7  2003/12/02 17:40:51  law
// - new operations: Edit.Cut, Copy, Paste, Delete.
//
// Revision 1.6  2003/12/02 14:59:49  law
// - выставлены директивы CVS.
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, l3Base, vpLoadPlugins, vcmMainForm, vcmBaseMenuManager, vcmMenuManager, StdRes,
  vcmInterfaces,
  vcmBase,
  vcmBaseEntities, vcmEntities;

type
  TevpMain = class(TvcmMainForm)
    Entities: TvcmEntities;
    procedure FileExitExecute(var aParams: IvcmParams);
    procedure vcmMainFormCloseQuery(Sender: TObject;
      var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    protected
    // internal methods
      procedure RegisterModules;
        override;
        {* - регистрирует все модули приложения. }
  end;

var
  evpMain: TevpMain;

implementation

uses
  moDocument
  ;

{$R *.dfm}

procedure TevpMain.RegisterModules;
  //override;
  {* - регистрирует все модули приложения. }
begin
 inherited;
 RegisterModule(TevpDocument);
end;

procedure TevpMain.FileExitExecute(var aParams: IvcmParams);
begin
 Close;
end;

procedure TevpMain.vcmMainFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if CanClose AND (SDI OR (Application.MainForm = Self)) then
  CanClose := (l3System.CheckClipboard <> IDCancel);
end;

end.
