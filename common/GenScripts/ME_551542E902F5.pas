unit l3HugeMessageDlgWithWikiHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3HugeMessageDlgWithWikiHelper.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3HugeMessageDlgWithWikiHelper" MUID: (551542E902F5)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3WikiLinkClicked = procedure(const aLinkData: AnsiString) of object;

 (*
 Ml3HugeMessageDlgWithWikiHelper = interface
  {* Контракт сервиса Tl3HugeMessageDlgWithWikiHelper }
  procedure Say(const aText: AnsiString;
   aClickCallback: Tl3WikiLinkClicked);
  function FormatLink(const aLinkText: AnsiString;
   const aLinkData: AnsiString): AnsiString;
  function FormatCloak(const aCaption: AnsiString;
   const aText: AnsiString): AnsiString;
  function CanUseWiki: Boolean;
 end;//Ml3HugeMessageDlgWithWikiHelper
 *)

 Il3HugeMessageDlgWithWikiHelper = interface
  {* Интерфейс сервиса Tl3HugeMessageDlgWithWikiHelper }
  procedure Say(const aText: AnsiString;
   aClickCallback: Tl3WikiLinkClicked);
  function FormatLink(const aLinkText: AnsiString;
   const aLinkData: AnsiString): AnsiString;
  function FormatCloak(const aCaption: AnsiString;
   const aText: AnsiString): AnsiString;
  function CanUseWiki: Boolean;
 end;//Il3HugeMessageDlgWithWikiHelper

 Tl3HugeMessageDlgWithWikiHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3HugeMessageDlgWithWikiHelper;
    {* Внешняя реализация сервиса Il3HugeMessageDlgWithWikiHelper }
  protected
   procedure pm_SetAlien(const aValue: Il3HugeMessageDlgWithWikiHelper);
   procedure ClearFields; override;
  public
   procedure Say(const aText: AnsiString;
    aClickCallback: Tl3WikiLinkClicked);
   function FormatLink(const aLinkText: AnsiString;
    const aLinkData: AnsiString): AnsiString;
   function FormatCloak(const aCaption: AnsiString;
    const aText: AnsiString): AnsiString;
   function CanUseWiki: Boolean;
   class function Instance: Tl3HugeMessageDlgWithWikiHelper;
    {* Метод получения экземпляра синглетона Tl3HugeMessageDlgWithWikiHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3HugeMessageDlgWithWikiHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3HugeMessageDlgWithWikiHelper }
 end;//Tl3HugeMessageDlgWithWikiHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Forms
 , Controls
 , SysUtils
 , StdCtrls
 , ExtCtrls
 , l3Base
;

var g_Tl3HugeMessageDlgWithWikiHelper: Tl3HugeMessageDlgWithWikiHelper = nil;
 {* Экземпляр синглетона Tl3HugeMessageDlgWithWikiHelper }

procedure Tl3HugeMessageDlgWithWikiHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3HugeMessageDlgWithWikiHelper }
begin
 l3Free(g_Tl3HugeMessageDlgWithWikiHelper);
end;//Tl3HugeMessageDlgWithWikiHelperFree

procedure Tl3HugeMessageDlgWithWikiHelper.pm_SetAlien(const aValue: Il3HugeMessageDlgWithWikiHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3HugeMessageDlgWithWikiHelper.pm_SetAlien

procedure Tl3HugeMessageDlgWithWikiHelper.Say(const aText: AnsiString;
 aClickCallback: Tl3WikiLinkClicked);
//#UC START# *03211FE23BF3_551542E902F5_var*
 procedure SimpleSay(const aInfo: AnsiString);
 var
  l_Form: TForm;
  l_Memo: TMemo;
  l_Panel: TPanel;
  l_Button: TButton;
 begin
  l_Form := TForm.Create(nil);
  try
   with l_Form do
   begin
    Position := poScreenCenter;
    BorderStyle := bsDialog;
    Caption := 'Information';
    Width := 640;
    Height := 480;
   end;
   l_Button := TButton.Create(l_Form);
   with l_Button do
   begin
    Caption := 'OK';
    ModalResult := mrCancel;
    Default := True;
    Cancel := True;
   end;
   l_Panel := TPanel.Create(l_Form);
   with l_Panel do
   begin
    Height := l_Button.Height + 16;
    BevelOuter := bvNone;
    Parent := l_Form;
    Align := alBottom;
   end;
   with l_Button do
   begin
    Parent := l_Panel;
    Left := (l_Panel.ClientWidth - Width) div 2;
    Top := 8;
   end;
   l_Memo := TMemo.Create(l_Form);
   with l_Memo do
   begin
    Parent := l_Form;
    Align := alClient;
    ScrollBars := ssBoth;
    Text := aInfo;
   end;
   l_Form.ShowModal;
  finally
   FreeAndNil(l_Form);
  end;
 end;
//#UC END# *03211FE23BF3_551542E902F5_var*
begin
//#UC START# *03211FE23BF3_551542E902F5_impl*
 if Assigned(f_Alien) then
  f_Alien.Say(aText, aClickCallback)
 else
  SimpleSay(aText);
//#UC END# *03211FE23BF3_551542E902F5_impl*
end;//Tl3HugeMessageDlgWithWikiHelper.Say

function Tl3HugeMessageDlgWithWikiHelper.FormatLink(const aLinkText: AnsiString;
 const aLinkData: AnsiString): AnsiString;
//#UC START# *5AFFFDE1F6AB_551542E902F5_var*
//#UC END# *5AFFFDE1F6AB_551542E902F5_var*
begin
//#UC START# *5AFFFDE1F6AB_551542E902F5_impl*
 if Assigned(f_Alien) then
  Result := f_Alien.FormatLink(aLinkText, aLinkData)
 else
  Result := aLinkText;
//#UC END# *5AFFFDE1F6AB_551542E902F5_impl*
end;//Tl3HugeMessageDlgWithWikiHelper.FormatLink

function Tl3HugeMessageDlgWithWikiHelper.FormatCloak(const aCaption: AnsiString;
 const aText: AnsiString): AnsiString;
//#UC START# *3CDB8D32C712_551542E902F5_var*
//#UC END# *3CDB8D32C712_551542E902F5_var*
begin
//#UC START# *3CDB8D32C712_551542E902F5_impl*
 if Assigned(f_Alien) then
  Result := f_Alien.FormatCloak(aCaption, aText)
 else
  Result := aCaption + #13#10 + aText + #13#10;
//#UC END# *3CDB8D32C712_551542E902F5_impl*
end;//Tl3HugeMessageDlgWithWikiHelper.FormatCloak

function Tl3HugeMessageDlgWithWikiHelper.CanUseWiki: Boolean;
//#UC START# *CDCC556698E5_551542E902F5_var*
//#UC END# *CDCC556698E5_551542E902F5_var*
begin
//#UC START# *CDCC556698E5_551542E902F5_impl*
 Result := Assigned(f_Alien) and f_Alien.CanUseWiki;
//#UC END# *CDCC556698E5_551542E902F5_impl*
end;//Tl3HugeMessageDlgWithWikiHelper.CanUseWiki

class function Tl3HugeMessageDlgWithWikiHelper.Instance: Tl3HugeMessageDlgWithWikiHelper;
 {* Метод получения экземпляра синглетона Tl3HugeMessageDlgWithWikiHelper }
begin
 if (g_Tl3HugeMessageDlgWithWikiHelper = nil) then
 begin
  l3System.AddExitProc(Tl3HugeMessageDlgWithWikiHelperFree);
  g_Tl3HugeMessageDlgWithWikiHelper := Create;
 end;
 Result := g_Tl3HugeMessageDlgWithWikiHelper;
end;//Tl3HugeMessageDlgWithWikiHelper.Instance

class function Tl3HugeMessageDlgWithWikiHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3HugeMessageDlgWithWikiHelper <> nil;
end;//Tl3HugeMessageDlgWithWikiHelper.Exists

procedure Tl3HugeMessageDlgWithWikiHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3HugeMessageDlgWithWikiHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
