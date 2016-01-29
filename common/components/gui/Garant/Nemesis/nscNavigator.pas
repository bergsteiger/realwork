unit nscNavigator;

// Библиотека : "Визуальные компоненты проекта Немезис"
// Автор      : М. Морозов.
// Начат      : 06.12.2006 г.
// Назначение : Компонент с вкладками
// Версия     : $Id: nscNavigator.pas,v 1.14 2015/04/24 14:55:31 lulin Exp $

// $Log: nscNavigator.pas,v $
// Revision 1.14  2015/04/24 14:55:31  lulin
// - правильный define.
//
// Revision 1.13  2015/03/13 13:22:56  morozov
// {RequestLink: 590762196}
//
// Revision 1.12  2015/03/04 12:07:20  lulin
// {RequestLink:590512167}
//
// Revision 1.11  2015/02/19 08:34:42  morozov
// {RequestLink: 588832246}
//
// Revision 1.10  2015/02/06 18:58:34  lulin
// - стараемся уйти от авторегистрируемых слов.
//
// Revision 1.9  2014/09/10 12:27:29  morozov
// {RequestLink: 564993305}
//
// Revision 1.8  2014/07/02 14:45:30  lulin
// - собираем библиотеки.
//
// Revision 1.7  2014/05/27 08:42:03  kostitsin
// {requestlink: 342868625 } - регистрируем ещё один класс для тестов
//
// Revision 1.6  2014/01/10 16:24:53  kostitsin
// [$510593012]
//
// Revision 1.5  2009/01/12 17:38:11  lulin
// - <K>: 133138664. № 24.
//
// Revision 1.4  2009/01/12 09:14:30  oman
// - new: Учим навигатор закрываться по Ctrl+F4 (К-113508400)
//
// Revision 1.3  2007/08/20 09:06:07  mmorozov
// - new: уведомление об изменении активной вкладки (CQ: OIT5-26352);
//
// Revision 1.2  2006/12/12 11:42:27  mmorozov
// - new: возможность определять класс плавающего окна;
//
// Revision 1.1  2006/12/07 14:23:11  mmorozov
// - new: используем единые настройки для компонента с вкладками (CQ: OIT5-23819);
//

interface

{$Include nscDefine.inc}

uses
  Classes,
  Controls,

  ElPgCtl,

  vcmExternalInterfaces,
  vcmInterfaces,

  nscInterfaces,

  vtNavigator
  ;

{$IfNDef NoVCM}  
type
  _nscDestPageControl_ = TnpPageControl;
  {$Include nscPageControl.inc}
  TnscNavigatorPageControl = class(_nscPageControl_)
  protected
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
  end;

  TnscNavigator = class(TvtNavigator,
                        IvcmOperationsProvider,
                        IvcmMainFormDependent)
  private
    procedure CloseChildExecute(const aParams : IvcmExecuteParamsPrim);
      {-}
    procedure CloseChildTest(const aParams : IvcmTestParamsPrim);
      {-}
  protected
  // IvcmOperationsProvider
    procedure ProvideOps(const aPublisher : IvcmOperationsPublisher);
      {* - предоставить список доступных операций. }
  // IvcmMainFormDependent
   procedure MainFormChanged(aNewMainForm: TControl);
      {* - изменилась главная форма. }
  protected
  // methods
    function GetPageControlClass: RnpPageControl;
      override;
      {-}
    function GetFloatingWindowClass: RnpFloatingWindow;
      override;
      {* - получить класс плавающего окна. }
  end;//TnscNavigator

  TnscFloatingWindow = class(TnpFloatingWindow)
  {* Плавающего окно навигатора. }
  protected
  // methods
    function GetNavigatorClass: RvtNavigator;
      override;
      {* - ссылка на класс навигатора. }
  end;//TnscFloatingWindow
{$EndIf NoVCM}  

implementation

uses
  SysUtils,
  Graphics,

  afwVCL,

  {$IfNDef DesignTimeLibrary}
  vcmBase,
  {$EndIf DesignTimeLibrary}

  nscNewInterfaces,
  nscTabFont,
  vcmEntityForm

  {$If not defined(NoScripts)}
  ,
  tfwClassRef
  {$IfEnd} //not NoScripts
  ;

{$IfNDef NoVCM}  
const
 vcm_deEnclosedForms = 'EnclosedForms';
  vcm_doCloseChild = 'CloseChild';

{$Include nscPageControl.inc}

{ TnscNavigatorPageControl }

procedure TnscNavigatorPageControl.CMDockClient(var Message: TCMDockClient);
begin
 inherited;
 Change;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=588575925,
 // http://mdp.garant.ru/pages/viewpage.action?pageId=588832246,
end;

{ TnscNavigator }

procedure TnscNavigator.CloseChildExecute(
  const aParams: IvcmExecuteParamsPrim);
begin
 f_Header.CloseButton.Click
end;

procedure TnscNavigator.CloseChildTest(const aParams: IvcmTestParamsPrim);
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := Assigned(f_Header.CloseButton) and f_Header.CloseButton.Visible;
end;

function TnscNavigator.GetFloatingWindowClass: RnpFloatingWindow;
begin
 Result := TnscFloatingWindow;
end;

function TnscNavigator.GetPageControlClass: RnpPageControl;
begin
 Result := TnscNavigatorPageControl;
end;//GetPageControlClass

procedure TnscNavigator.ProvideOps(
  const aPublisher: IvcmOperationsPublisher);
begin
 aPublisher.PublishOp(vcm_deEnclosedForms, vcm_doCloseChild, CloseChildExecute, CloseChildTest);
end;

procedure TnscNavigator.MainFormChanged(aNewMainForm: TControl);
begin
 UpdateMainForm(aNewMainForm As TvcmEntityForm);
end;

{ TnscFloatingWindow }

function TnscFloatingWindow.GetNavigatorClass: RvtNavigator;
begin
 Result := TnscNavigator;
end;

initialization
 {$If not defined(NoScripts)}
 TtfwClassRef.Register(TnscNavigatorPageControl);
 TtfwClassRef.Register(TnscNavigator);
 TtfwClassRef.Register(TnscFloatingWindow);
 {$IfEnd}
{$EndIf NoVCM}
end.
