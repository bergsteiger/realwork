unit MedicMainMenuKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/MedicMainMenuKeywordsPack.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::MedicMainMenuKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы MedicMainMenu
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  vtPanel,
  MedicMainMenu_Form
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_MedicMainMenu = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы MedicMainMenu
----
*Пример использования*:
[code]
'aControl' форма::MedicMainMenu TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_MedicMainMenu

// start class Tkw_Form_MedicMainMenu

class function Tkw_Form_MedicMainMenu.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetWordNameForRegister

function Tkw_Form_MedicMainMenu.GetString: AnsiString;
 {-}
begin
 Result := 'en_MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetString

type
  Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола hfReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::hfReferencesAndDictionaries TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries

// start class Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries

class function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetString: AnsiString;
 {-}
begin
 Result := 'hfReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetString

class procedure Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола hfReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::hfReferencesAndDictionaries:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push

// start class Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push

procedure Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfReferencesAndDictionaries');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfReferencesAndDictionaries:push';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tvReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::tvReferencesAndDictionaries TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries

// start class Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries

class function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetString: AnsiString;
 {-}
begin
 Result := 'tvReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetString

class procedure Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tvReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::tvReferencesAndDictionaries:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push

// start class Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push

procedure Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvReferencesAndDictionaries');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvReferencesAndDictionaries:push';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола hfReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::hfReferencePharmaceuticalInformation TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation

// start class Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation

class function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetString: AnsiString;
 {-}
begin
 Result := 'hfReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetString

class procedure Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола hfReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::hfReferencePharmaceuticalInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push

// start class Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push

procedure Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfReferencePharmaceuticalInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfReferencePharmaceuticalInformation:push';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tvReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::tvReferencePharmaceuticalInformation TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation

// start class Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation

class function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetString: AnsiString;
 {-}
begin
 Result := 'tvReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetString

class procedure Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tvReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::tvReferencePharmaceuticalInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push

// start class Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push

procedure Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvReferencePharmaceuticalInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvReferencePharmaceuticalInformation:push';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_hfMainFeatures = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола hfMainFeatures
----
*Пример использования*:
[code]
контрол::hfMainFeatures TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_hfMainFeatures

// start class Tkw_MedicMainMenu_Control_hfMainFeatures

class function Tkw_MedicMainMenu_Control_hfMainFeatures.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfMainFeatures';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfMainFeatures.GetString: AnsiString;
 {-}
begin
 Result := 'hfMainFeatures';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.GetString

class procedure Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_hfMainFeatures_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола hfMainFeatures
----
*Пример использования*:
[code]
контрол::hfMainFeatures:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push

// start class Tkw_MedicMainMenu_Control_hfMainFeatures_Push

procedure Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfMainFeatures');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfMainFeatures_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfMainFeatures:push';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_tvMainFeatures = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tvMainFeatures
----
*Пример использования*:
[code]
контрол::tvMainFeatures TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_tvMainFeatures

// start class Tkw_MedicMainMenu_Control_tvMainFeatures

class function Tkw_MedicMainMenu_Control_tvMainFeatures.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvMainFeatures';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvMainFeatures.GetString: AnsiString;
 {-}
begin
 Result := 'tvMainFeatures';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.GetString

class procedure Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_tvMainFeatures_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tvMainFeatures
----
*Пример использования*:
[code]
контрол::tvMainFeatures:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push

// start class Tkw_MedicMainMenu_Control_tvMainFeatures_Push

procedure Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvMainFeatures');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvMainFeatures_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvMainFeatures:push';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_hfRegulatoryInformation = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола hfRegulatoryInformation
----
*Пример использования*:
[code]
контрол::hfRegulatoryInformation TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation

// start class Tkw_MedicMainMenu_Control_hfRegulatoryInformation

class function Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetString: AnsiString;
 {-}
begin
 Result := 'hfRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetString

class procedure Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола hfRegulatoryInformation
----
*Пример использования*:
[code]
контрол::hfRegulatoryInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push

// start class Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push

procedure Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfRegulatoryInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfRegulatoryInformation:push';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_tvRegulatoryInformation = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tvRegulatoryInformation
----
*Пример использования*:
[code]
контрол::tvRegulatoryInformation TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation

// start class Tkw_MedicMainMenu_Control_tvRegulatoryInformation

class function Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetString: AnsiString;
 {-}
begin
 Result := 'tvRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetString

class procedure Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tvRegulatoryInformation
----
*Пример использования*:
[code]
контрол::tvRegulatoryInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push

// start class Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push

procedure Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvRegulatoryInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvRegulatoryInformation:push';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_pnlMain = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_pnlMain

// start class Tkw_MedicMainMenu_Control_pnlMain

class function Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_pnlMain.GetString: AnsiString;
 {-}
begin
 Result := 'pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetString

class procedure Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_pnlMain_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_pnlMain_Push

// start class Tkw_MedicMainMenu_Control_pnlMain_Push

procedure Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlMain:push';
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_hfLastOpenDocs = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола hfLastOpenDocs
----
*Пример использования*:
[code]
контрол::hfLastOpenDocs TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs

// start class Tkw_MedicMainMenu_Control_hfLastOpenDocs

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString: AnsiString;
 {-}
begin
 Result := 'hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола hfLastOpenDocs
----
*Пример использования*:
[code]
контрол::hfLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push

// start class Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push

procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::hfLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister

type
  Tkw_MedicMainMenu_Control_tvLastOpenDocs = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tvLastOpenDocs
----
*Пример использования*:
[code]
контрол::tvLastOpenDocs TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs

// start class Tkw_MedicMainMenu_Control_tvLastOpenDocs

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString: AnsiString;
 {-}
begin
 Result := 'tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine

type
  Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tvLastOpenDocs
----
*Пример использования*:
[code]
контрол::tvLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push

// start class Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push

procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister

type
  TkwEnMedicMainMenuHfReferencesAndDictionaries = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries
[panel]Контрол hfReferencesAndDictionaries формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfReferencesAndDictionaries >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfReferencesAndDictionaries(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
     {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuHfReferencesAndDictionaries

// start class TkwEnMedicMainMenuHfReferencesAndDictionaries

function TkwEnMedicMainMenuHfReferencesAndDictionaries.HfReferencesAndDictionaries(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {-}
begin
 Result := aen_MedicMainMenu.hfReferencesAndDictionaries;
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.HfReferencesAndDictionaries

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfReferencesAndDictionaries(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt

class function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.hfReferencesAndDictionaries';
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfReferencesAndDictionaries', aCtx);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.SetValuePrim

function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetResultTypeInfo

function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetAllParamsCount

function TkwEnMedicMainMenuHfReferencesAndDictionaries.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.ParamsTypes

type
  TkwEnMedicMainMenuTvReferencesAndDictionaries = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries
[panel]Контрол tvReferencesAndDictionaries формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvReferencesAndDictionaries >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function TvReferencesAndDictionaries(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuTvReferencesAndDictionaries

// start class TkwEnMedicMainMenuTvReferencesAndDictionaries

function TkwEnMedicMainMenuTvReferencesAndDictionaries.TvReferencesAndDictionaries(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_MedicMainMenu.tvReferencesAndDictionaries;
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.TvReferencesAndDictionaries

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvReferencesAndDictionaries(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt

class function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.tvReferencesAndDictionaries';
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvReferencesAndDictionaries', aCtx);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.SetValuePrim

function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetResultTypeInfo

function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetAllParamsCount

function TkwEnMedicMainMenuTvReferencesAndDictionaries.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.ParamsTypes

type
  TkwEnMedicMainMenuHfReferencePharmaceuticalInformation = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation
[panel]Контрол hfReferencePharmaceuticalInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
     {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation

// start class TkwEnMedicMainMenuHfReferencePharmaceuticalInformation

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.HfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {-}
begin
 Result := aen_MedicMainMenu.hfReferencePharmaceuticalInformation;
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.HfReferencePharmaceuticalInformation

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfReferencePharmaceuticalInformation(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt

class function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.hfReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfReferencePharmaceuticalInformation', aCtx);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.SetValuePrim

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetResultTypeInfo

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetAllParamsCount

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.ParamsTypes

type
  TkwEnMedicMainMenuTvReferencePharmaceuticalInformation = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation
[panel]Контрол tvReferencePharmaceuticalInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function TvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation

// start class TkwEnMedicMainMenuTvReferencePharmaceuticalInformation

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.TvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_MedicMainMenu.tvReferencePharmaceuticalInformation;
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.TvReferencePharmaceuticalInformation

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvReferencePharmaceuticalInformation(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt

class function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.tvReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvReferencePharmaceuticalInformation', aCtx);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.SetValuePrim

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetResultTypeInfo

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetAllParamsCount

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.ParamsTypes

type
  TkwEnMedicMainMenuHfMainFeatures = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.hfMainFeatures
[panel]Контрол hfMainFeatures формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfMainFeatures >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfMainFeatures(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
     {* Реализация слова скрипта .Ten_MedicMainMenu.hfMainFeatures }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuHfMainFeatures

// start class TkwEnMedicMainMenuHfMainFeatures

function TkwEnMedicMainMenuHfMainFeatures.HfMainFeatures(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {-}
begin
 Result := aen_MedicMainMenu.hfMainFeatures;
end;//TkwEnMedicMainMenuHfMainFeatures.HfMainFeatures

procedure TkwEnMedicMainMenuHfMainFeatures.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfMainFeatures(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuHfMainFeatures.DoDoIt

class function TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.hfMainFeatures';
end;//TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfMainFeatures', aCtx);
end;//TkwEnMedicMainMenuHfMainFeatures.SetValuePrim

function TkwEnMedicMainMenuHfMainFeatures.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfMainFeatures.GetResultTypeInfo

function TkwEnMedicMainMenuHfMainFeatures.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuHfMainFeatures.GetAllParamsCount

function TkwEnMedicMainMenuHfMainFeatures.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfMainFeatures.ParamsTypes

type
  TkwEnMedicMainMenuTvMainFeatures = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.tvMainFeatures
[panel]Контрол tvMainFeatures формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MedicMainMenu .Ten_MedicMainMenu.tvMainFeatures >>> l_TnscTreeViewHotTruck
[code]  }
  private
  // private methods
   function TvMainFeatures(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
     {* Реализация слова скрипта .Ten_MedicMainMenu.tvMainFeatures }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuTvMainFeatures

// start class TkwEnMedicMainMenuTvMainFeatures

function TkwEnMedicMainMenuTvMainFeatures.TvMainFeatures(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {-}
begin
 Result := aen_MedicMainMenu.tvMainFeatures;
end;//TkwEnMedicMainMenuTvMainFeatures.TvMainFeatures

procedure TkwEnMedicMainMenuTvMainFeatures.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvMainFeatures(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuTvMainFeatures.DoDoIt

class function TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.tvMainFeatures';
end;//TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvMainFeatures', aCtx);
end;//TkwEnMedicMainMenuTvMainFeatures.SetValuePrim

function TkwEnMedicMainMenuTvMainFeatures.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMedicMainMenuTvMainFeatures.GetResultTypeInfo

function TkwEnMedicMainMenuTvMainFeatures.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuTvMainFeatures.GetAllParamsCount

function TkwEnMedicMainMenuTvMainFeatures.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvMainFeatures.ParamsTypes

type
  TkwEnMedicMainMenuHfRegulatoryInformation = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.hfRegulatoryInformation
[panel]Контрол hfRegulatoryInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfRegulatoryInformation >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfRegulatoryInformation(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
     {* Реализация слова скрипта .Ten_MedicMainMenu.hfRegulatoryInformation }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuHfRegulatoryInformation

// start class TkwEnMedicMainMenuHfRegulatoryInformation

function TkwEnMedicMainMenuHfRegulatoryInformation.HfRegulatoryInformation(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {-}
begin
 Result := aen_MedicMainMenu.hfRegulatoryInformation;
end;//TkwEnMedicMainMenuHfRegulatoryInformation.HfRegulatoryInformation

procedure TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfRegulatoryInformation(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt

class function TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.hfRegulatoryInformation';
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfRegulatoryInformation', aCtx);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.SetValuePrim

function TkwEnMedicMainMenuHfRegulatoryInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetResultTypeInfo

function TkwEnMedicMainMenuHfRegulatoryInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetAllParamsCount

function TkwEnMedicMainMenuHfRegulatoryInformation.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.ParamsTypes

type
  TkwEnMedicMainMenuTvRegulatoryInformation = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.tvRegulatoryInformation
[panel]Контрол tvRegulatoryInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvRegulatoryInformation >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function TvRegulatoryInformation(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .Ten_MedicMainMenu.tvRegulatoryInformation }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuTvRegulatoryInformation

// start class TkwEnMedicMainMenuTvRegulatoryInformation

function TkwEnMedicMainMenuTvRegulatoryInformation.TvRegulatoryInformation(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_MedicMainMenu.tvRegulatoryInformation;
end;//TkwEnMedicMainMenuTvRegulatoryInformation.TvRegulatoryInformation

procedure TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvRegulatoryInformation(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt

class function TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.tvRegulatoryInformation';
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvRegulatoryInformation', aCtx);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.SetValuePrim

function TkwEnMedicMainMenuTvRegulatoryInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetResultTypeInfo

function TkwEnMedicMainMenuTvRegulatoryInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetAllParamsCount

function TkwEnMedicMainMenuTvRegulatoryInformation.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.ParamsTypes

type
  TkwEnMedicMainMenuPnlMain = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.pnlMain
[panel]Контрол pnlMain формы Ten_MedicMainMenu[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicMainMenu .Ten_MedicMainMenu.pnlMain >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlMain(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
     {* Реализация слова скрипта .Ten_MedicMainMenu.pnlMain }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuPnlMain

// start class TkwEnMedicMainMenuPnlMain

function TkwEnMedicMainMenuPnlMain.PnlMain(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
 {-}
begin
 Result := aen_MedicMainMenu.pnlMain;
end;//TkwEnMedicMainMenuPnlMain.PnlMain

procedure TkwEnMedicMainMenuPnlMain.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlMain(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuPnlMain.DoDoIt

class function TkwEnMedicMainMenuPnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.pnlMain';
end;//TkwEnMedicMainMenuPnlMain.GetWordNameForRegister

procedure TkwEnMedicMainMenuPnlMain.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlMain', aCtx);
end;//TkwEnMedicMainMenuPnlMain.SetValuePrim

function TkwEnMedicMainMenuPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicMainMenuPnlMain.GetResultTypeInfo

function TkwEnMedicMainMenuPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuPnlMain.GetAllParamsCount

function TkwEnMedicMainMenuPnlMain.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuPnlMain.ParamsTypes

type
  TkwEnMedicMainMenuHfLastOpenDocs = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.hfLastOpenDocs
[panel]Контрол hfLastOpenDocs формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfLastOpenDocs >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfLastOpenDocs(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
     {* Реализация слова скрипта .Ten_MedicMainMenu.hfLastOpenDocs }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuHfLastOpenDocs

// start class TkwEnMedicMainMenuHfLastOpenDocs

function TkwEnMedicMainMenuHfLastOpenDocs.HfLastOpenDocs(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {-}
begin
 Result := aen_MedicMainMenu.hfLastOpenDocs;
end;//TkwEnMedicMainMenuHfLastOpenDocs.HfLastOpenDocs

procedure TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfLastOpenDocs(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt

class function TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.hfLastOpenDocs';
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfLastOpenDocs', aCtx);
end;//TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim

function TkwEnMedicMainMenuHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetResultTypeInfo

function TkwEnMedicMainMenuHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetAllParamsCount

function TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes

type
  TkwEnMedicMainMenuTvLastOpenDocs = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicMainMenu.tvLastOpenDocs
[panel]Контрол tvLastOpenDocs формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MedicMainMenu .Ten_MedicMainMenu.tvLastOpenDocs >>> l_TnscTreeViewHotTruck
[code]  }
  private
  // private methods
   function TvLastOpenDocs(const aCtx: TtfwContext;
     aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
     {* Реализация слова скрипта .Ten_MedicMainMenu.tvLastOpenDocs }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicMainMenuTvLastOpenDocs

// start class TkwEnMedicMainMenuTvLastOpenDocs

function TkwEnMedicMainMenuTvLastOpenDocs.TvLastOpenDocs(const aCtx: TtfwContext;
  aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {-}
begin
 Result := aen_MedicMainMenu.tvLastOpenDocs;
end;//TkwEnMedicMainMenuTvLastOpenDocs.TvLastOpenDocs

procedure TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicMainMenu : Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvLastOpenDocs(aCtx, l_aen_MedicMainMenu)));
end;//TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt

class function TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicMainMenu.tvLastOpenDocs';
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvLastOpenDocs', aCtx);
end;//TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim

function TkwEnMedicMainMenuTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetResultTypeInfo

function TkwEnMedicMainMenuTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetAllParamsCount

function TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_MedicMainMenu
 Tkw_Form_MedicMainMenu.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries
 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push
 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries
 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push
 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation
 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push
 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation
 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push
 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfMainFeatures
 Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfMainFeatures_Push
 Tkw_MedicMainMenu_Control_hfMainFeatures_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvMainFeatures
 Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvMainFeatures_Push
 Tkw_MedicMainMenu_Control_tvMainFeatures_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfRegulatoryInformation
 Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push
 Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvRegulatoryInformation
 Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push
 Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_pnlMain
 Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_pnlMain_Push
 Tkw_MedicMainMenu_Control_pnlMain_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfLastOpenDocs
 Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push
 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvLastOpenDocs
 Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push
 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_hfReferencesAndDictionaries
 TkwEnMedicMainMenuHfReferencesAndDictionaries.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_tvReferencesAndDictionaries
 TkwEnMedicMainMenuTvReferencesAndDictionaries.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_hfReferencePharmaceuticalInformation
 TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_tvReferencePharmaceuticalInformation
 TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_hfMainFeatures
 TkwEnMedicMainMenuHfMainFeatures.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_tvMainFeatures
 TkwEnMedicMainMenuTvMainFeatures.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_hfRegulatoryInformation
 TkwEnMedicMainMenuHfRegulatoryInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_tvRegulatoryInformation
 TkwEnMedicMainMenuTvRegulatoryInformation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_pnlMain
 TkwEnMedicMainMenuPnlMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_hfLastOpenDocs
 TkwEnMedicMainMenuHfLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicMainMenu_tvLastOpenDocs
 TkwEnMedicMainMenuTvLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа MedicMainMenu
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicMainMenu));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscHideField
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewHotTruck
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.