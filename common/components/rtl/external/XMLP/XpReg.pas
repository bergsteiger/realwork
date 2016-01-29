{*********************************************************}
{* XMLPartner: XpReg.PAS 2.56                            *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XML component registration                *}
{*********************************************************}

{$I XpDefine.inc}

unit XpReg;

interface

procedure Register;

implementation

uses
{$IFDEF WIN32}
{$IFDEF DCC6OrLater}                                                   {!!.56}
  DesignIntf,
  DesignEditors,
{$ELSE}
  dsgnintf,
{$ENDIF}
  forms,
  XpAboutw,
{$ENDIF}
{$IFDEF LINUX}
  DesignIntf,
  DesignEditors,
  QForms,
  XpAbout,
{$ENDIF}
  Classes,
  XpBase,
  XpDom,
  XpParser;

type
  TXpVersionProperty = class(TStringProperty)
    public
      function GetAttributes: TPropertyAttributes; override;
      procedure Edit; override;
  end;

{===TXpVersionProperty===============================================}
function TXpVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;
{--------}
procedure TXpVersionProperty.Edit;
var
  AboutBox : TXpAboutBox;
begin
  AboutBox := TXpAboutBox.Create(Application);
  try
    AboutBox.Caption := 'About XMLPartner Components';
    AboutBox.ProgramName.Caption := XpProductName;                     {!!.51}
    AboutBox.ShowModal;
  finally
    AboutBox.Free;
  end;
end;
{====================================================================}

procedure Register;
begin
  { Register XMLPartner components }
  RegisterComponents(XpProductName,[                                   {!!.51}
                                    TXpParser,
                                    TXpObjModel
                                    ]);
  {Register the Version property editor. }
  RegisterPropertyEditor(TypeInfo(AnsiString), TXpParser, 'Version',
                         TXpVersionProperty);
  RegisterPropertyEditor(TypeInfo(AnsiString), TXpObjModel, 'Version',
                         TXpVersionProperty);
end;

end.
