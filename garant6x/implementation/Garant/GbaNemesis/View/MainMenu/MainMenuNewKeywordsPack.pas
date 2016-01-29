unit MainMenuNewKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/MainMenuNewKeywordsPack.pas"
// �����: 09.09.2009 16:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������������ ��������::MainMenu::View::MainMenu::MainMenu$FP::MainMenuNewKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� MainMenuNew
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  MainMenuNew_Form
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenio
  {$IfEnd} //not NoImageEn
  
  {$If defined(Nemesis)}
  ,
  nscFocusLabel
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
  Tkw_Form_MainMenuNew = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� MainMenuNew
----
*������ �������������*:
[code]
'aControl' �����::MainMenuNew TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_MainMenuNew

// start class Tkw_Form_MainMenuNew

class function Tkw_Form_MainMenuNew.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::MainMenuNew';
end;//Tkw_Form_MainMenuNew.GetWordNameForRegister

function Tkw_Form_MainMenuNew.GetString: AnsiString;
 {-}
begin
 Result := 'en_MainMenuNew';
end;//Tkw_Form_MainMenuNew.GetString

type
  Tkw_MainMenuNew_Control_pnlBaseSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlBaseSearch
----
*������ �������������*:
[code]
�������::pnlBaseSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlBaseSearch

// start class Tkw_MainMenuNew_Control_pnlBaseSearch

class function Tkw_MainMenuNew_Control_pnlBaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBaseSearch';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBaseSearch.GetString: AnsiString;
 {-}
begin
 Result := 'pnlBaseSearch';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.GetString

class procedure Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlBaseSearch_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlBaseSearch
----
*������ �������������*:
[code]
�������::pnlBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push

// start class Tkw_MainMenuNew_Control_pnlBaseSearch_Push

procedure Tkw_MainMenuNew_Control_pnlBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlBaseSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBaseSearch_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBaseSearch:push';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pnlBaseSearchZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlBaseSearchZone
----
*������ �������������*:
[code]
�������::pnlBaseSearchZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone

// start class Tkw_MainMenuNew_Control_pnlBaseSearchZone

class function Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBaseSearchZone';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetString: AnsiString;
 {-}
begin
 Result := 'pnlBaseSearchZone';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetString

class procedure Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlBaseSearchZone
----
*������ �������������*:
[code]
�������::pnlBaseSearchZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push

// start class Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push

procedure Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlBaseSearchZone');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBaseSearchZone:push';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pnlLogo = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlLogo
----
*������ �������������*:
[code]
�������::pnlLogo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlLogo

// start class Tkw_MainMenuNew_Control_pnlLogo

class function Tkw_MainMenuNew_Control_pnlLogo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlLogo';
end;//Tkw_MainMenuNew_Control_pnlLogo.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlLogo.GetString: AnsiString;
 {-}
begin
 Result := 'pnlLogo';
end;//Tkw_MainMenuNew_Control_pnlLogo.GetString

class procedure Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlLogo_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlLogo
----
*������ �������������*:
[code]
�������::pnlLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlLogo_Push

// start class Tkw_MainMenuNew_Control_pnlLogo_Push

procedure Tkw_MainMenuNew_Control_pnlLogo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlLogo');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlLogo_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlLogo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlLogo:push';
end;//Tkw_MainMenuNew_Control_pnlLogo_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pbLogo = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pbLogo
----
*������ �������������*:
[code]
�������::pbLogo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pbLogo

// start class Tkw_MainMenuNew_Control_pbLogo

class function Tkw_MainMenuNew_Control_pbLogo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbLogo';
end;//Tkw_MainMenuNew_Control_pbLogo.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbLogo.GetString: AnsiString;
 {-}
begin
 Result := 'pbLogo';
end;//Tkw_MainMenuNew_Control_pbLogo.GetString

class procedure Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pbLogo_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pbLogo
----
*������ �������������*:
[code]
�������::pbLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pbLogo_Push

// start class Tkw_MainMenuNew_Control_pbLogo_Push

procedure Tkw_MainMenuNew_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbLogo');
 inherited;
end;//Tkw_MainMenuNew_Control_pbLogo_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbLogo:push';
end;//Tkw_MainMenuNew_Control_pbLogo_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pnlSearches = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlSearches
----
*������ �������������*:
[code]
�������::pnlSearches TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlSearches

// start class Tkw_MainMenuNew_Control_pnlSearches

class function Tkw_MainMenuNew_Control_pnlSearches.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlSearches';
end;//Tkw_MainMenuNew_Control_pnlSearches.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlSearches.GetString: AnsiString;
 {-}
begin
 Result := 'pnlSearches';
end;//Tkw_MainMenuNew_Control_pnlSearches.GetString

class procedure Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlSearches_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlSearches
----
*������ �������������*:
[code]
�������::pnlSearches:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlSearches_Push

// start class Tkw_MainMenuNew_Control_pnlSearches_Push

procedure Tkw_MainMenuNew_Control_pnlSearches_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlSearches');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlSearches_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlSearches_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlSearches:push';
end;//Tkw_MainMenuNew_Control_pnlSearches_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_flAttributeSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� flAttributeSearch
----
*������ �������������*:
[code]
�������::flAttributeSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_flAttributeSearch

// start class Tkw_MainMenuNew_Control_flAttributeSearch

class function Tkw_MainMenuNew_Control_flAttributeSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flAttributeSearch';
end;//Tkw_MainMenuNew_Control_flAttributeSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flAttributeSearch.GetString: AnsiString;
 {-}
begin
 Result := 'flAttributeSearch';
end;//Tkw_MainMenuNew_Control_flAttributeSearch.GetString

class procedure Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine

type
  Tkw_MainMenuNew_Control_flAttributeSearch_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� flAttributeSearch
----
*������ �������������*:
[code]
�������::flAttributeSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push

// start class Tkw_MainMenuNew_Control_flAttributeSearch_Push

procedure Tkw_MainMenuNew_Control_flAttributeSearch_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('flAttributeSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flAttributeSearch_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flAttributeSearch:push';
end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_flSituationSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� flSituationSearch
----
*������ �������������*:
[code]
�������::flSituationSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_flSituationSearch

// start class Tkw_MainMenuNew_Control_flSituationSearch

class function Tkw_MainMenuNew_Control_flSituationSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flSituationSearch';
end;//Tkw_MainMenuNew_Control_flSituationSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flSituationSearch.GetString: AnsiString;
 {-}
begin
 Result := 'flSituationSearch';
end;//Tkw_MainMenuNew_Control_flSituationSearch.GetString

class procedure Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine

type
  Tkw_MainMenuNew_Control_flSituationSearch_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� flSituationSearch
----
*������ �������������*:
[code]
�������::flSituationSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_flSituationSearch_Push

// start class Tkw_MainMenuNew_Control_flSituationSearch_Push

procedure Tkw_MainMenuNew_Control_flSituationSearch_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('flSituationSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flSituationSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flSituationSearch_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flSituationSearch:push';
end;//Tkw_MainMenuNew_Control_flSituationSearch_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_flPublishedSourceSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� flPublishedSourceSearch
----
*������ �������������*:
[code]
�������::flPublishedSourceSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch

// start class Tkw_MainMenuNew_Control_flPublishedSourceSearch

class function Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flPublishedSourceSearch';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetString: AnsiString;
 {-}
begin
 Result := 'flPublishedSourceSearch';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetString

class procedure Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine

type
  Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� flPublishedSourceSearch
----
*������ �������������*:
[code]
�������::flPublishedSourceSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push

// start class Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push

procedure Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('flPublishedSourceSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flPublishedSourceSearch:push';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_flDictionSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� flDictionSearch
----
*������ �������������*:
[code]
�������::flDictionSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_flDictionSearch

// start class Tkw_MainMenuNew_Control_flDictionSearch

class function Tkw_MainMenuNew_Control_flDictionSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flDictionSearch';
end;//Tkw_MainMenuNew_Control_flDictionSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flDictionSearch.GetString: AnsiString;
 {-}
begin
 Result := 'flDictionSearch';
end;//Tkw_MainMenuNew_Control_flDictionSearch.GetString

class procedure Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine

type
  Tkw_MainMenuNew_Control_flDictionSearch_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� flDictionSearch
----
*������ �������������*:
[code]
�������::flDictionSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_flDictionSearch_Push

// start class Tkw_MainMenuNew_Control_flDictionSearch_Push

procedure Tkw_MainMenuNew_Control_flDictionSearch_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('flDictionSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flDictionSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flDictionSearch_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::flDictionSearch:push';
end;//Tkw_MainMenuNew_Control_flDictionSearch_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pnlExpert = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlExpert
----
*������ �������������*:
[code]
�������::pnlExpert TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlExpert

// start class Tkw_MainMenuNew_Control_pnlExpert

class function Tkw_MainMenuNew_Control_pnlExpert.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlExpert';
end;//Tkw_MainMenuNew_Control_pnlExpert.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlExpert.GetString: AnsiString;
 {-}
begin
 Result := 'pnlExpert';
end;//Tkw_MainMenuNew_Control_pnlExpert.GetString

class procedure Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlExpert_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlExpert
----
*������ �������������*:
[code]
�������::pnlExpert:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlExpert_Push

// start class Tkw_MainMenuNew_Control_pnlExpert_Push

procedure Tkw_MainMenuNew_Control_pnlExpert_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlExpert');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlExpert_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlExpert_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlExpert:push';
end;//Tkw_MainMenuNew_Control_pnlExpert_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pbExpert = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pbExpert
----
*������ �������������*:
[code]
�������::pbExpert TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pbExpert

// start class Tkw_MainMenuNew_Control_pbExpert

class function Tkw_MainMenuNew_Control_pbExpert.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbExpert';
end;//Tkw_MainMenuNew_Control_pbExpert.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbExpert.GetString: AnsiString;
 {-}
begin
 Result := 'pbExpert';
end;//Tkw_MainMenuNew_Control_pbExpert.GetString

class procedure Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pbExpert_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pbExpert
----
*������ �������������*:
[code]
�������::pbExpert:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pbExpert_Push

// start class Tkw_MainMenuNew_Control_pbExpert_Push

procedure Tkw_MainMenuNew_Control_pbExpert_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbExpert');
 inherited;
end;//Tkw_MainMenuNew_Control_pbExpert_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbExpert_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbExpert:push';
end;//Tkw_MainMenuNew_Control_pbExpert_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pnlOnLine = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlOnLine
----
*������ �������������*:
[code]
�������::pnlOnLine TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlOnLine

// start class Tkw_MainMenuNew_Control_pnlOnLine

class function Tkw_MainMenuNew_Control_pnlOnLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlOnLine';
end;//Tkw_MainMenuNew_Control_pnlOnLine.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlOnLine.GetString: AnsiString;
 {-}
begin
 Result := 'pnlOnLine';
end;//Tkw_MainMenuNew_Control_pnlOnLine.GetString

class procedure Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlOnLine_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlOnLine
----
*������ �������������*:
[code]
�������::pnlOnLine:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlOnLine_Push

// start class Tkw_MainMenuNew_Control_pnlOnLine_Push

procedure Tkw_MainMenuNew_Control_pnlOnLine_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlOnLine');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlOnLine_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlOnLine_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlOnLine:push';
end;//Tkw_MainMenuNew_Control_pnlOnLine_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pbOnLine = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pbOnLine
----
*������ �������������*:
[code]
�������::pbOnLine TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pbOnLine

// start class Tkw_MainMenuNew_Control_pbOnLine

class function Tkw_MainMenuNew_Control_pbOnLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbOnLine';
end;//Tkw_MainMenuNew_Control_pbOnLine.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbOnLine.GetString: AnsiString;
 {-}
begin
 Result := 'pbOnLine';
end;//Tkw_MainMenuNew_Control_pbOnLine.GetString

class procedure Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pbOnLine_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pbOnLine
----
*������ �������������*:
[code]
�������::pbOnLine:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pbOnLine_Push

// start class Tkw_MainMenuNew_Control_pbOnLine_Push

procedure Tkw_MainMenuNew_Control_pbOnLine_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbOnLine');
 inherited;
end;//Tkw_MainMenuNew_Control_pbOnLine_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbOnLine_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbOnLine:push';
end;//Tkw_MainMenuNew_Control_pbOnLine_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pbIntranet = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pbIntranet
----
*������ �������������*:
[code]
�������::pbIntranet TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pbIntranet

// start class Tkw_MainMenuNew_Control_pbIntranet

class function Tkw_MainMenuNew_Control_pbIntranet.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbIntranet';
end;//Tkw_MainMenuNew_Control_pbIntranet.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbIntranet.GetString: AnsiString;
 {-}
begin
 Result := 'pbIntranet';
end;//Tkw_MainMenuNew_Control_pbIntranet.GetString

class procedure Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pbIntranet_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pbIntranet
----
*������ �������������*:
[code]
�������::pbIntranet:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pbIntranet_Push

// start class Tkw_MainMenuNew_Control_pbIntranet_Push

procedure Tkw_MainMenuNew_Control_pbIntranet_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbIntranet');
 inherited;
end;//Tkw_MainMenuNew_Control_pbIntranet_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbIntranet_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbIntranet:push';
end;//Tkw_MainMenuNew_Control_pbIntranet_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pbCourtsOnline = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pbCourtsOnline
----
*������ �������������*:
[code]
�������::pbCourtsOnline TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pbCourtsOnline

// start class Tkw_MainMenuNew_Control_pbCourtsOnline

class function Tkw_MainMenuNew_Control_pbCourtsOnline.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbCourtsOnline';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbCourtsOnline.GetString: AnsiString;
 {-}
begin
 Result := 'pbCourtsOnline';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.GetString

class procedure Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pbCourtsOnline_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pbCourtsOnline
----
*������ �������������*:
[code]
�������::pbCourtsOnline:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push

// start class Tkw_MainMenuNew_Control_pbCourtsOnline_Push

procedure Tkw_MainMenuNew_Control_pbCourtsOnline_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbCourtsOnline');
 inherited;
end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbCourtsOnline_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbCourtsOnline:push';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_hfTaxes = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� hfTaxes
----
*������ �������������*:
[code]
�������::hfTaxes TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_hfTaxes

// start class Tkw_MainMenuNew_Control_hfTaxes

class function Tkw_MainMenuNew_Control_hfTaxes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfTaxes';
end;//Tkw_MainMenuNew_Control_hfTaxes.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfTaxes.GetString: AnsiString;
 {-}
begin
 Result := 'hfTaxes';
end;//Tkw_MainMenuNew_Control_hfTaxes.GetString

class procedure Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine

type
  Tkw_MainMenuNew_Control_hfTaxes_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� hfTaxes
----
*������ �������������*:
[code]
�������::hfTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_hfTaxes_Push

// start class Tkw_MainMenuNew_Control_hfTaxes_Push

procedure Tkw_MainMenuNew_Control_hfTaxes_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfTaxes');
 inherited;
end;//Tkw_MainMenuNew_Control_hfTaxes_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfTaxes_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfTaxes:push';
end;//Tkw_MainMenuNew_Control_hfTaxes_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_tvTaxes = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvTaxes
----
*������ �������������*:
[code]
�������::tvTaxes TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_tvTaxes

// start class Tkw_MainMenuNew_Control_tvTaxes

class function Tkw_MainMenuNew_Control_tvTaxes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvTaxes';
end;//Tkw_MainMenuNew_Control_tvTaxes.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvTaxes.GetString: AnsiString;
 {-}
begin
 Result := 'tvTaxes';
end;//Tkw_MainMenuNew_Control_tvTaxes.GetString

class procedure Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine

type
  Tkw_MainMenuNew_Control_tvTaxes_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvTaxes
----
*������ �������������*:
[code]
�������::tvTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_tvTaxes_Push

// start class Tkw_MainMenuNew_Control_tvTaxes_Push

procedure Tkw_MainMenuNew_Control_tvTaxes_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvTaxes');
 inherited;
end;//Tkw_MainMenuNew_Control_tvTaxes_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvTaxes_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvTaxes:push';
end;//Tkw_MainMenuNew_Control_tvTaxes_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pnlBanner = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlBanner
----
*������ �������������*:
[code]
�������::pnlBanner TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlBanner

// start class Tkw_MainMenuNew_Control_pnlBanner

class function Tkw_MainMenuNew_Control_pnlBanner.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBanner';
end;//Tkw_MainMenuNew_Control_pnlBanner.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBanner.GetString: AnsiString;
 {-}
begin
 Result := 'pnlBanner';
end;//Tkw_MainMenuNew_Control_pnlBanner.GetString

class procedure Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlBanner_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlBanner
----
*������ �������������*:
[code]
�������::pnlBanner:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlBanner_Push

// start class Tkw_MainMenuNew_Control_pnlBanner_Push

procedure Tkw_MainMenuNew_Control_pnlBanner_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlBanner');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlBanner_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBanner_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlBanner:push';
end;//Tkw_MainMenuNew_Control_pnlBanner_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_ieBanner = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ieBanner
----
*������ �������������*:
[code]
�������::ieBanner TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_ieBanner

// start class Tkw_MainMenuNew_Control_ieBanner

class function Tkw_MainMenuNew_Control_ieBanner.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ieBanner';
end;//Tkw_MainMenuNew_Control_ieBanner.GetWordNameForRegister

function Tkw_MainMenuNew_Control_ieBanner.GetString: AnsiString;
 {-}
begin
 Result := 'ieBanner';
end;//Tkw_MainMenuNew_Control_ieBanner.GetString

class procedure Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TImageEnView);
end;//Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine

type
  Tkw_MainMenuNew_Control_ieBanner_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ieBanner
----
*������ �������������*:
[code]
�������::ieBanner:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_ieBanner_Push

// start class Tkw_MainMenuNew_Control_ieBanner_Push

procedure Tkw_MainMenuNew_Control_ieBanner_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ieBanner');
 inherited;
end;//Tkw_MainMenuNew_Control_ieBanner_Push.DoDoIt

class function Tkw_MainMenuNew_Control_ieBanner_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ieBanner:push';
end;//Tkw_MainMenuNew_Control_ieBanner_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� hfLastOpenDocsRightEdge
----
*������ �������������*:
[code]
�������::hfLastOpenDocsRightEdge TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge

// start class Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge

class function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfLastOpenDocsRightEdge';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetString: AnsiString;
 {-}
begin
 Result := 'hfLastOpenDocsRightEdge';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetString

class procedure Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine

type
  Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� hfLastOpenDocsRightEdge
----
*������ �������������*:
[code]
�������::hfLastOpenDocsRightEdge:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push

// start class Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push

procedure Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfLastOpenDocsRightEdge');
 inherited;
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfLastOpenDocsRightEdge:push';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Component_ieIO = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ieIO
----
*������ �������������*:
[code]
���������::ieIO TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Component_ieIO

// start class Tkw_MainMenuNew_Component_ieIO

class function Tkw_MainMenuNew_Component_ieIO.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::ieIO';
end;//Tkw_MainMenuNew_Component_ieIO.GetWordNameForRegister

function Tkw_MainMenuNew_Component_ieIO.GetString: AnsiString;
 {-}
begin
 Result := 'ieIO';
end;//Tkw_MainMenuNew_Component_ieIO.GetString

class procedure Tkw_MainMenuNew_Component_ieIO.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TImageEnIO);
end;//Tkw_MainMenuNew_Component_ieIO.RegisterInEngine

type
  Tkw_MainMenuNew_Control_hfReferences = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� hfReferences
----
*������ �������������*:
[code]
�������::hfReferences TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_hfReferences

// start class Tkw_MainMenuNew_Control_hfReferences

class function Tkw_MainMenuNew_Control_hfReferences.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfReferences';
end;//Tkw_MainMenuNew_Control_hfReferences.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfReferences.GetString: AnsiString;
 {-}
begin
 Result := 'hfReferences';
end;//Tkw_MainMenuNew_Control_hfReferences.GetString

class procedure Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine

type
  Tkw_MainMenuNew_Control_hfReferences_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� hfReferences
----
*������ �������������*:
[code]
�������::hfReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_hfReferences_Push

// start class Tkw_MainMenuNew_Control_hfReferences_Push

procedure Tkw_MainMenuNew_Control_hfReferences_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfReferences');
 inherited;
end;//Tkw_MainMenuNew_Control_hfReferences_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfReferences_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfReferences:push';
end;//Tkw_MainMenuNew_Control_hfReferences_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_tvReferences = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvReferences
----
*������ �������������*:
[code]
�������::tvReferences TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_tvReferences

// start class Tkw_MainMenuNew_Control_tvReferences

class function Tkw_MainMenuNew_Control_tvReferences.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvReferences';
end;//Tkw_MainMenuNew_Control_tvReferences.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvReferences.GetString: AnsiString;
 {-}
begin
 Result := 'tvReferences';
end;//Tkw_MainMenuNew_Control_tvReferences.GetString

class procedure Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine

type
  Tkw_MainMenuNew_Control_tvReferences_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvReferences
----
*������ �������������*:
[code]
�������::tvReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_tvReferences_Push

// start class Tkw_MainMenuNew_Control_tvReferences_Push

procedure Tkw_MainMenuNew_Control_tvReferences_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvReferences');
 inherited;
end;//Tkw_MainMenuNew_Control_tvReferences_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvReferences_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvReferences:push';
end;//Tkw_MainMenuNew_Control_tvReferences_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_hfLawNews = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� hfLawNews
----
*������ �������������*:
[code]
�������::hfLawNews TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_hfLawNews

// start class Tkw_MainMenuNew_Control_hfLawNews

class function Tkw_MainMenuNew_Control_hfLawNews.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfLawNews';
end;//Tkw_MainMenuNew_Control_hfLawNews.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLawNews.GetString: AnsiString;
 {-}
begin
 Result := 'hfLawNews';
end;//Tkw_MainMenuNew_Control_hfLawNews.GetString

class procedure Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine

type
  Tkw_MainMenuNew_Control_hfLawNews_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� hfLawNews
----
*������ �������������*:
[code]
�������::hfLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_hfLawNews_Push

// start class Tkw_MainMenuNew_Control_hfLawNews_Push

procedure Tkw_MainMenuNew_Control_hfLawNews_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfLawNews');
 inherited;
end;//Tkw_MainMenuNew_Control_hfLawNews_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLawNews_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfLawNews:push';
end;//Tkw_MainMenuNew_Control_hfLawNews_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_tvLawNews = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvLawNews
----
*������ �������������*:
[code]
�������::tvLawNews TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_tvLawNews

// start class Tkw_MainMenuNew_Control_tvLawNews

class function Tkw_MainMenuNew_Control_tvLawNews.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvLawNews';
end;//Tkw_MainMenuNew_Control_tvLawNews.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvLawNews.GetString: AnsiString;
 {-}
begin
 Result := 'tvLawNews';
end;//Tkw_MainMenuNew_Control_tvLawNews.GetString

class procedure Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine

type
  Tkw_MainMenuNew_Control_tvLawNews_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvLawNews
----
*������ �������������*:
[code]
�������::tvLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_tvLawNews_Push

// start class Tkw_MainMenuNew_Control_tvLawNews_Push

procedure Tkw_MainMenuNew_Control_tvLawNews_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvLawNews');
 inherited;
end;//Tkw_MainMenuNew_Control_tvLawNews_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvLawNews_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvLawNews:push';
end;//Tkw_MainMenuNew_Control_tvLawNews_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_pnlMain = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_pnlMain

// start class Tkw_MainMenuNew_Control_pnlMain

class function Tkw_MainMenuNew_Control_pnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlMain';
end;//Tkw_MainMenuNew_Control_pnlMain.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlMain.GetString: AnsiString;
 {-}
begin
 Result := 'pnlMain';
end;//Tkw_MainMenuNew_Control_pnlMain.GetString

class procedure Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine

type
  Tkw_MainMenuNew_Control_pnlMain_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_pnlMain_Push

// start class Tkw_MainMenuNew_Control_pnlMain_Push

procedure Tkw_MainMenuNew_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlMain_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnlMain:push';
end;//Tkw_MainMenuNew_Control_pnlMain_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_hfLastOpenDocs = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� hfLastOpenDocs
----
*������ �������������*:
[code]
�������::hfLastOpenDocs TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_hfLastOpenDocs

// start class Tkw_MainMenuNew_Control_hfLastOpenDocs

class function Tkw_MainMenuNew_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfLastOpenDocs';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLastOpenDocs.GetString: AnsiString;
 {-}
begin
 Result := 'hfLastOpenDocs';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.GetString

class procedure Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine

type
  Tkw_MainMenuNew_Control_hfLastOpenDocs_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� hfLastOpenDocs
----
*������ �������������*:
[code]
�������::hfLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push

// start class Tkw_MainMenuNew_Control_hfLastOpenDocs_Push

procedure Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::hfLastOpenDocs:push';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.GetWordNameForRegister

type
  Tkw_MainMenuNew_Control_tvLastOpenDocs = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvLastOpenDocs
----
*������ �������������*:
[code]
�������::tvLastOpenDocs TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MainMenuNew_Control_tvLastOpenDocs

// start class Tkw_MainMenuNew_Control_tvLastOpenDocs

class function Tkw_MainMenuNew_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvLastOpenDocs';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvLastOpenDocs.GetString: AnsiString;
 {-}
begin
 Result := 'tvLastOpenDocs';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.GetString

class procedure Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine

type
  Tkw_MainMenuNew_Control_tvLastOpenDocs_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvLastOpenDocs
----
*������ �������������*:
[code]
�������::tvLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push

// start class Tkw_MainMenuNew_Control_tvLastOpenDocs_Push

procedure Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvLastOpenDocs:push';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.GetWordNameForRegister

type
  TkwEnMainMenuNewPnlBaseSearch = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlBaseSearch
[panel]������� pnlBaseSearch ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlBaseSearch >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlBaseSearch(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlBaseSearch }
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
  end;//TkwEnMainMenuNewPnlBaseSearch

// start class TkwEnMainMenuNewPnlBaseSearch

function TkwEnMainMenuNewPnlBaseSearch.PnlBaseSearch(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlBaseSearch;
end;//TkwEnMainMenuNewPnlBaseSearch.PnlBaseSearch

procedure TkwEnMainMenuNewPnlBaseSearch.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlBaseSearch(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlBaseSearch.DoDoIt

class function TkwEnMainMenuNewPnlBaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlBaseSearch';
end;//TkwEnMainMenuNewPnlBaseSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBaseSearch', aCtx);
end;//TkwEnMainMenuNewPnlBaseSearch.SetValuePrim

function TkwEnMainMenuNewPnlBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlBaseSearch.GetResultTypeInfo

function TkwEnMainMenuNewPnlBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlBaseSearch.GetAllParamsCount

function TkwEnMainMenuNewPnlBaseSearch.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlBaseSearch.ParamsTypes

type
  TkwEnMainMenuNewPnlBaseSearchZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlBaseSearchZone
[panel]������� pnlBaseSearchZone ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlBaseSearchZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlBaseSearchZone(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlBaseSearchZone }
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
  end;//TkwEnMainMenuNewPnlBaseSearchZone

// start class TkwEnMainMenuNewPnlBaseSearchZone

function TkwEnMainMenuNewPnlBaseSearchZone.PnlBaseSearchZone(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlBaseSearchZone;
end;//TkwEnMainMenuNewPnlBaseSearchZone.PnlBaseSearchZone

procedure TkwEnMainMenuNewPnlBaseSearchZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlBaseSearchZone(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlBaseSearchZone.DoDoIt

class function TkwEnMainMenuNewPnlBaseSearchZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlBaseSearchZone';
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlBaseSearchZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBaseSearchZone', aCtx);
end;//TkwEnMainMenuNewPnlBaseSearchZone.SetValuePrim

function TkwEnMainMenuNewPnlBaseSearchZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetResultTypeInfo

function TkwEnMainMenuNewPnlBaseSearchZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetAllParamsCount

function TkwEnMainMenuNewPnlBaseSearchZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlBaseSearchZone.ParamsTypes

type
  TkwEnMainMenuNewPnlLogo = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlLogo
[panel]������� pnlLogo ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlLogo >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlLogo(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlLogo }
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
  end;//TkwEnMainMenuNewPnlLogo

// start class TkwEnMainMenuNewPnlLogo

function TkwEnMainMenuNewPnlLogo.PnlLogo(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlLogo;
end;//TkwEnMainMenuNewPnlLogo.PnlLogo

procedure TkwEnMainMenuNewPnlLogo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlLogo(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlLogo.DoDoIt

class function TkwEnMainMenuNewPnlLogo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlLogo';
end;//TkwEnMainMenuNewPnlLogo.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlLogo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLogo', aCtx);
end;//TkwEnMainMenuNewPnlLogo.SetValuePrim

function TkwEnMainMenuNewPnlLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlLogo.GetResultTypeInfo

function TkwEnMainMenuNewPnlLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlLogo.GetAllParamsCount

function TkwEnMainMenuNewPnlLogo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlLogo.ParamsTypes

type
  TkwEnMainMenuNewPbLogo = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pbLogo
[panel]������� pbLogo ����� Ten_MainMenuNew[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbLogo >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbLogo(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
     {* ���������� ����� ������� .Ten_MainMenuNew.pbLogo }
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
  end;//TkwEnMainMenuNewPbLogo

// start class TkwEnMainMenuNewPbLogo

function TkwEnMainMenuNewPbLogo.PbLogo(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {-}
begin
 Result := aen_MainMenuNew.pbLogo;
end;//TkwEnMainMenuNewPbLogo.PbLogo

procedure TkwEnMainMenuNewPbLogo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbLogo(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPbLogo.DoDoIt

class function TkwEnMainMenuNewPbLogo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pbLogo';
end;//TkwEnMainMenuNewPbLogo.GetWordNameForRegister

procedure TkwEnMainMenuNewPbLogo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbLogo', aCtx);
end;//TkwEnMainMenuNewPbLogo.SetValuePrim

function TkwEnMainMenuNewPbLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbLogo.GetResultTypeInfo

function TkwEnMainMenuNewPbLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPbLogo.GetAllParamsCount

function TkwEnMainMenuNewPbLogo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbLogo.ParamsTypes

type
  TkwEnMainMenuNewPnlSearches = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlSearches
[panel]������� pnlSearches ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlSearches >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlSearches(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlSearches }
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
  end;//TkwEnMainMenuNewPnlSearches

// start class TkwEnMainMenuNewPnlSearches

function TkwEnMainMenuNewPnlSearches.PnlSearches(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlSearches;
end;//TkwEnMainMenuNewPnlSearches.PnlSearches

procedure TkwEnMainMenuNewPnlSearches.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlSearches(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlSearches.DoDoIt

class function TkwEnMainMenuNewPnlSearches.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlSearches';
end;//TkwEnMainMenuNewPnlSearches.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlSearches.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlSearches', aCtx);
end;//TkwEnMainMenuNewPnlSearches.SetValuePrim

function TkwEnMainMenuNewPnlSearches.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlSearches.GetResultTypeInfo

function TkwEnMainMenuNewPnlSearches.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlSearches.GetAllParamsCount

function TkwEnMainMenuNewPnlSearches.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlSearches.ParamsTypes

type
  TkwEnMainMenuNewFlAttributeSearch = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.flAttributeSearch
[panel]������� flAttributeSearch ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscFocusLabel
*������:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flAttributeSearch >>> l_TnscFocusLabel
[code]  }
  private
  // private methods
   function FlAttributeSearch(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
     {* ���������� ����� ������� .Ten_MainMenuNew.flAttributeSearch }
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
  end;//TkwEnMainMenuNewFlAttributeSearch

// start class TkwEnMainMenuNewFlAttributeSearch

function TkwEnMainMenuNewFlAttributeSearch.FlAttributeSearch(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {-}
begin
 Result := aen_MainMenuNew.flAttributeSearch;
end;//TkwEnMainMenuNewFlAttributeSearch.FlAttributeSearch

procedure TkwEnMainMenuNewFlAttributeSearch.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FlAttributeSearch(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewFlAttributeSearch.DoDoIt

class function TkwEnMainMenuNewFlAttributeSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.flAttributeSearch';
end;//TkwEnMainMenuNewFlAttributeSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlAttributeSearch.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� flAttributeSearch', aCtx);
end;//TkwEnMainMenuNewFlAttributeSearch.SetValuePrim

function TkwEnMainMenuNewFlAttributeSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlAttributeSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlAttributeSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewFlAttributeSearch.GetAllParamsCount

function TkwEnMainMenuNewFlAttributeSearch.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlAttributeSearch.ParamsTypes

type
  TkwEnMainMenuNewFlSituationSearch = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.flSituationSearch
[panel]������� flSituationSearch ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscFocusLabel
*������:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flSituationSearch >>> l_TnscFocusLabel
[code]  }
  private
  // private methods
   function FlSituationSearch(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
     {* ���������� ����� ������� .Ten_MainMenuNew.flSituationSearch }
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
  end;//TkwEnMainMenuNewFlSituationSearch

// start class TkwEnMainMenuNewFlSituationSearch

function TkwEnMainMenuNewFlSituationSearch.FlSituationSearch(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {-}
begin
 Result := aen_MainMenuNew.flSituationSearch;
end;//TkwEnMainMenuNewFlSituationSearch.FlSituationSearch

procedure TkwEnMainMenuNewFlSituationSearch.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FlSituationSearch(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewFlSituationSearch.DoDoIt

class function TkwEnMainMenuNewFlSituationSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.flSituationSearch';
end;//TkwEnMainMenuNewFlSituationSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlSituationSearch.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� flSituationSearch', aCtx);
end;//TkwEnMainMenuNewFlSituationSearch.SetValuePrim

function TkwEnMainMenuNewFlSituationSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlSituationSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlSituationSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewFlSituationSearch.GetAllParamsCount

function TkwEnMainMenuNewFlSituationSearch.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlSituationSearch.ParamsTypes

type
  TkwEnMainMenuNewFlPublishedSourceSearch = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.flPublishedSourceSearch
[panel]������� flPublishedSourceSearch ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscFocusLabel
*������:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flPublishedSourceSearch >>> l_TnscFocusLabel
[code]  }
  private
  // private methods
   function FlPublishedSourceSearch(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
     {* ���������� ����� ������� .Ten_MainMenuNew.flPublishedSourceSearch }
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
  end;//TkwEnMainMenuNewFlPublishedSourceSearch

// start class TkwEnMainMenuNewFlPublishedSourceSearch

function TkwEnMainMenuNewFlPublishedSourceSearch.FlPublishedSourceSearch(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {-}
begin
 Result := aen_MainMenuNew.flPublishedSourceSearch;
end;//TkwEnMainMenuNewFlPublishedSourceSearch.FlPublishedSourceSearch

procedure TkwEnMainMenuNewFlPublishedSourceSearch.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FlPublishedSourceSearch(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewFlPublishedSourceSearch.DoDoIt

class function TkwEnMainMenuNewFlPublishedSourceSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.flPublishedSourceSearch';
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlPublishedSourceSearch.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� flPublishedSourceSearch', aCtx);
end;//TkwEnMainMenuNewFlPublishedSourceSearch.SetValuePrim

function TkwEnMainMenuNewFlPublishedSourceSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlPublishedSourceSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetAllParamsCount

function TkwEnMainMenuNewFlPublishedSourceSearch.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlPublishedSourceSearch.ParamsTypes

type
  TkwEnMainMenuNewFlDictionSearch = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.flDictionSearch
[panel]������� flDictionSearch ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscFocusLabel
*������:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flDictionSearch >>> l_TnscFocusLabel
[code]  }
  private
  // private methods
   function FlDictionSearch(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
     {* ���������� ����� ������� .Ten_MainMenuNew.flDictionSearch }
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
  end;//TkwEnMainMenuNewFlDictionSearch

// start class TkwEnMainMenuNewFlDictionSearch

function TkwEnMainMenuNewFlDictionSearch.FlDictionSearch(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {-}
begin
 Result := aen_MainMenuNew.flDictionSearch;
end;//TkwEnMainMenuNewFlDictionSearch.FlDictionSearch

procedure TkwEnMainMenuNewFlDictionSearch.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FlDictionSearch(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewFlDictionSearch.DoDoIt

class function TkwEnMainMenuNewFlDictionSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.flDictionSearch';
end;//TkwEnMainMenuNewFlDictionSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlDictionSearch.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� flDictionSearch', aCtx);
end;//TkwEnMainMenuNewFlDictionSearch.SetValuePrim

function TkwEnMainMenuNewFlDictionSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlDictionSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlDictionSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewFlDictionSearch.GetAllParamsCount

function TkwEnMainMenuNewFlDictionSearch.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlDictionSearch.ParamsTypes

type
  TkwEnMainMenuNewPnlExpert = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlExpert
[panel]������� pnlExpert ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlExpert >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlExpert(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlExpert }
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
  end;//TkwEnMainMenuNewPnlExpert

// start class TkwEnMainMenuNewPnlExpert

function TkwEnMainMenuNewPnlExpert.PnlExpert(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlExpert;
end;//TkwEnMainMenuNewPnlExpert.PnlExpert

procedure TkwEnMainMenuNewPnlExpert.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlExpert(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlExpert.DoDoIt

class function TkwEnMainMenuNewPnlExpert.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlExpert';
end;//TkwEnMainMenuNewPnlExpert.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlExpert.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlExpert', aCtx);
end;//TkwEnMainMenuNewPnlExpert.SetValuePrim

function TkwEnMainMenuNewPnlExpert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlExpert.GetResultTypeInfo

function TkwEnMainMenuNewPnlExpert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlExpert.GetAllParamsCount

function TkwEnMainMenuNewPnlExpert.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlExpert.ParamsTypes

type
  TkwEnMainMenuNewPbExpert = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pbExpert
[panel]������� pbExpert ����� Ten_MainMenuNew[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbExpert >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbExpert(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
     {* ���������� ����� ������� .Ten_MainMenuNew.pbExpert }
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
  end;//TkwEnMainMenuNewPbExpert

// start class TkwEnMainMenuNewPbExpert

function TkwEnMainMenuNewPbExpert.PbExpert(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {-}
begin
 Result := aen_MainMenuNew.pbExpert;
end;//TkwEnMainMenuNewPbExpert.PbExpert

procedure TkwEnMainMenuNewPbExpert.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbExpert(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPbExpert.DoDoIt

class function TkwEnMainMenuNewPbExpert.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pbExpert';
end;//TkwEnMainMenuNewPbExpert.GetWordNameForRegister

procedure TkwEnMainMenuNewPbExpert.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbExpert', aCtx);
end;//TkwEnMainMenuNewPbExpert.SetValuePrim

function TkwEnMainMenuNewPbExpert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbExpert.GetResultTypeInfo

function TkwEnMainMenuNewPbExpert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPbExpert.GetAllParamsCount

function TkwEnMainMenuNewPbExpert.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbExpert.ParamsTypes

type
  TkwEnMainMenuNewPnlOnLine = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlOnLine
[panel]������� pnlOnLine ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlOnLine >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlOnLine(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlOnLine }
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
  end;//TkwEnMainMenuNewPnlOnLine

// start class TkwEnMainMenuNewPnlOnLine

function TkwEnMainMenuNewPnlOnLine.PnlOnLine(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlOnLine;
end;//TkwEnMainMenuNewPnlOnLine.PnlOnLine

procedure TkwEnMainMenuNewPnlOnLine.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlOnLine(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlOnLine.DoDoIt

class function TkwEnMainMenuNewPnlOnLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlOnLine';
end;//TkwEnMainMenuNewPnlOnLine.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlOnLine.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlOnLine', aCtx);
end;//TkwEnMainMenuNewPnlOnLine.SetValuePrim

function TkwEnMainMenuNewPnlOnLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlOnLine.GetResultTypeInfo

function TkwEnMainMenuNewPnlOnLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlOnLine.GetAllParamsCount

function TkwEnMainMenuNewPnlOnLine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlOnLine.ParamsTypes

type
  TkwEnMainMenuNewPbOnLine = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pbOnLine
[panel]������� pbOnLine ����� Ten_MainMenuNew[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbOnLine >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbOnLine(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
     {* ���������� ����� ������� .Ten_MainMenuNew.pbOnLine }
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
  end;//TkwEnMainMenuNewPbOnLine

// start class TkwEnMainMenuNewPbOnLine

function TkwEnMainMenuNewPbOnLine.PbOnLine(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {-}
begin
 Result := aen_MainMenuNew.pbOnLine;
end;//TkwEnMainMenuNewPbOnLine.PbOnLine

procedure TkwEnMainMenuNewPbOnLine.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbOnLine(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPbOnLine.DoDoIt

class function TkwEnMainMenuNewPbOnLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pbOnLine';
end;//TkwEnMainMenuNewPbOnLine.GetWordNameForRegister

procedure TkwEnMainMenuNewPbOnLine.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbOnLine', aCtx);
end;//TkwEnMainMenuNewPbOnLine.SetValuePrim

function TkwEnMainMenuNewPbOnLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbOnLine.GetResultTypeInfo

function TkwEnMainMenuNewPbOnLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPbOnLine.GetAllParamsCount

function TkwEnMainMenuNewPbOnLine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbOnLine.ParamsTypes

type
  TkwEnMainMenuNewPbIntranet = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pbIntranet
[panel]������� pbIntranet ����� Ten_MainMenuNew[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbIntranet >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbIntranet(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
     {* ���������� ����� ������� .Ten_MainMenuNew.pbIntranet }
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
  end;//TkwEnMainMenuNewPbIntranet

// start class TkwEnMainMenuNewPbIntranet

function TkwEnMainMenuNewPbIntranet.PbIntranet(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {-}
begin
 Result := aen_MainMenuNew.pbIntranet;
end;//TkwEnMainMenuNewPbIntranet.PbIntranet

procedure TkwEnMainMenuNewPbIntranet.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbIntranet(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPbIntranet.DoDoIt

class function TkwEnMainMenuNewPbIntranet.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pbIntranet';
end;//TkwEnMainMenuNewPbIntranet.GetWordNameForRegister

procedure TkwEnMainMenuNewPbIntranet.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbIntranet', aCtx);
end;//TkwEnMainMenuNewPbIntranet.SetValuePrim

function TkwEnMainMenuNewPbIntranet.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbIntranet.GetResultTypeInfo

function TkwEnMainMenuNewPbIntranet.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPbIntranet.GetAllParamsCount

function TkwEnMainMenuNewPbIntranet.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbIntranet.ParamsTypes

type
  TkwEnMainMenuNewPbCourtsOnline = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pbCourtsOnline
[panel]������� pbCourtsOnline ����� Ten_MainMenuNew[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbCourtsOnline >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbCourtsOnline(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
     {* ���������� ����� ������� .Ten_MainMenuNew.pbCourtsOnline }
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
  end;//TkwEnMainMenuNewPbCourtsOnline

// start class TkwEnMainMenuNewPbCourtsOnline

function TkwEnMainMenuNewPbCourtsOnline.PbCourtsOnline(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {-}
begin
 Result := aen_MainMenuNew.pbCourtsOnline;
end;//TkwEnMainMenuNewPbCourtsOnline.PbCourtsOnline

procedure TkwEnMainMenuNewPbCourtsOnline.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbCourtsOnline(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPbCourtsOnline.DoDoIt

class function TkwEnMainMenuNewPbCourtsOnline.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pbCourtsOnline';
end;//TkwEnMainMenuNewPbCourtsOnline.GetWordNameForRegister

procedure TkwEnMainMenuNewPbCourtsOnline.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbCourtsOnline', aCtx);
end;//TkwEnMainMenuNewPbCourtsOnline.SetValuePrim

function TkwEnMainMenuNewPbCourtsOnline.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbCourtsOnline.GetResultTypeInfo

function TkwEnMainMenuNewPbCourtsOnline.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPbCourtsOnline.GetAllParamsCount

function TkwEnMainMenuNewPbCourtsOnline.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbCourtsOnline.ParamsTypes

type
  TkwEnMainMenuNewHfTaxes = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.hfTaxes
[panel]������� hfTaxes ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfTaxes >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfTaxes(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
     {* ���������� ����� ������� .Ten_MainMenuNew.hfTaxes }
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
  end;//TkwEnMainMenuNewHfTaxes

// start class TkwEnMainMenuNewHfTaxes

function TkwEnMainMenuNewHfTaxes.HfTaxes(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {-}
begin
 Result := aen_MainMenuNew.hfTaxes;
end;//TkwEnMainMenuNewHfTaxes.HfTaxes

procedure TkwEnMainMenuNewHfTaxes.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfTaxes(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewHfTaxes.DoDoIt

class function TkwEnMainMenuNewHfTaxes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.hfTaxes';
end;//TkwEnMainMenuNewHfTaxes.GetWordNameForRegister

procedure TkwEnMainMenuNewHfTaxes.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� hfTaxes', aCtx);
end;//TkwEnMainMenuNewHfTaxes.SetValuePrim

function TkwEnMainMenuNewHfTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfTaxes.GetResultTypeInfo

function TkwEnMainMenuNewHfTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewHfTaxes.GetAllParamsCount

function TkwEnMainMenuNewHfTaxes.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfTaxes.ParamsTypes

type
  TkwEnMainMenuNewTvTaxes = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.tvTaxes
[panel]������� tvTaxes ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvTaxes >>> l_TnscTreeViewHotTruck
[code]  }
  private
  // private methods
   function TvTaxes(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
     {* ���������� ����� ������� .Ten_MainMenuNew.tvTaxes }
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
  end;//TkwEnMainMenuNewTvTaxes

// start class TkwEnMainMenuNewTvTaxes

function TkwEnMainMenuNewTvTaxes.TvTaxes(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {-}
begin
 Result := aen_MainMenuNew.tvTaxes;
end;//TkwEnMainMenuNewTvTaxes.TvTaxes

procedure TkwEnMainMenuNewTvTaxes.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvTaxes(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewTvTaxes.DoDoIt

class function TkwEnMainMenuNewTvTaxes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.tvTaxes';
end;//TkwEnMainMenuNewTvTaxes.GetWordNameForRegister

procedure TkwEnMainMenuNewTvTaxes.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvTaxes', aCtx);
end;//TkwEnMainMenuNewTvTaxes.SetValuePrim

function TkwEnMainMenuNewTvTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvTaxes.GetResultTypeInfo

function TkwEnMainMenuNewTvTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewTvTaxes.GetAllParamsCount

function TkwEnMainMenuNewTvTaxes.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvTaxes.ParamsTypes

type
  TkwEnMainMenuNewPnlBanner = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlBanner
[panel]������� pnlBanner ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlBanner >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlBanner(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlBanner }
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
  end;//TkwEnMainMenuNewPnlBanner

// start class TkwEnMainMenuNewPnlBanner

function TkwEnMainMenuNewPnlBanner.PnlBanner(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlBanner;
end;//TkwEnMainMenuNewPnlBanner.PnlBanner

procedure TkwEnMainMenuNewPnlBanner.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlBanner(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlBanner.DoDoIt

class function TkwEnMainMenuNewPnlBanner.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlBanner';
end;//TkwEnMainMenuNewPnlBanner.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlBanner.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBanner', aCtx);
end;//TkwEnMainMenuNewPnlBanner.SetValuePrim

function TkwEnMainMenuNewPnlBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlBanner.GetResultTypeInfo

function TkwEnMainMenuNewPnlBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlBanner.GetAllParamsCount

function TkwEnMainMenuNewPnlBanner.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlBanner.ParamsTypes

type
  TkwEnMainMenuNewIeBanner = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.ieBanner
[panel]������� ieBanner ����� Ten_MainMenuNew[panel]
*��� ����������:* TImageEnView
*������:*
[code]
OBJECT VAR l_TImageEnView
 aen_MainMenuNew .Ten_MainMenuNew.ieBanner >>> l_TImageEnView
[code]  }
  private
  // private methods
   function IeBanner(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TImageEnView;
     {* ���������� ����� ������� .Ten_MainMenuNew.ieBanner }
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
  end;//TkwEnMainMenuNewIeBanner

// start class TkwEnMainMenuNewIeBanner

function TkwEnMainMenuNewIeBanner.IeBanner(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TImageEnView;
 {-}
begin
 Result := aen_MainMenuNew.ieBanner;
end;//TkwEnMainMenuNewIeBanner.IeBanner

procedure TkwEnMainMenuNewIeBanner.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((IeBanner(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewIeBanner.DoDoIt

class function TkwEnMainMenuNewIeBanner.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.ieBanner';
end;//TkwEnMainMenuNewIeBanner.GetWordNameForRegister

procedure TkwEnMainMenuNewIeBanner.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ieBanner', aCtx);
end;//TkwEnMainMenuNewIeBanner.SetValuePrim

function TkwEnMainMenuNewIeBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TImageEnView);
end;//TkwEnMainMenuNewIeBanner.GetResultTypeInfo

function TkwEnMainMenuNewIeBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewIeBanner.GetAllParamsCount

function TkwEnMainMenuNewIeBanner.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewIeBanner.ParamsTypes

type
  TkwEnMainMenuNewHfLastOpenDocsRightEdge = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.hfLastOpenDocsRightEdge
[panel]������� hfLastOpenDocsRightEdge ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.hfLastOpenDocsRightEdge >>> l_TvtPanel
[code]  }
  private
  // private methods
   function HfLastOpenDocsRightEdge(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.hfLastOpenDocsRightEdge }
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
  end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge

// start class TkwEnMainMenuNewHfLastOpenDocsRightEdge

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.HfLastOpenDocsRightEdge(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.hfLastOpenDocsRightEdge;
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.HfLastOpenDocsRightEdge

procedure TkwEnMainMenuNewHfLastOpenDocsRightEdge.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfLastOpenDocsRightEdge(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.DoDoIt

class function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.hfLastOpenDocsRightEdge';
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetWordNameForRegister

procedure TkwEnMainMenuNewHfLastOpenDocsRightEdge.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� hfLastOpenDocsRightEdge', aCtx);
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.SetValuePrim

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetResultTypeInfo

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetAllParamsCount

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.ParamsTypes

type
  TkwEnMainMenuNewIeIO = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.ieIO
[panel]������� ieIO ����� Ten_MainMenuNew[panel]
*��� ����������:* TImageEnIO
*������:*
[code]
OBJECT VAR l_TImageEnIO
 aen_MainMenuNew .Ten_MainMenuNew.ieIO >>> l_TImageEnIO
[code]  }
  private
  // private methods
   function IeIO(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TImageEnIO;
     {* ���������� ����� ������� .Ten_MainMenuNew.ieIO }
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
  end;//TkwEnMainMenuNewIeIO

// start class TkwEnMainMenuNewIeIO

function TkwEnMainMenuNewIeIO.IeIO(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TImageEnIO;
 {-}
begin
 Result := aen_MainMenuNew.ieIO;
end;//TkwEnMainMenuNewIeIO.IeIO

procedure TkwEnMainMenuNewIeIO.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((IeIO(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewIeIO.DoDoIt

class function TkwEnMainMenuNewIeIO.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.ieIO';
end;//TkwEnMainMenuNewIeIO.GetWordNameForRegister

procedure TkwEnMainMenuNewIeIO.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ieIO', aCtx);
end;//TkwEnMainMenuNewIeIO.SetValuePrim

function TkwEnMainMenuNewIeIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TImageEnIO);
end;//TkwEnMainMenuNewIeIO.GetResultTypeInfo

function TkwEnMainMenuNewIeIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewIeIO.GetAllParamsCount

function TkwEnMainMenuNewIeIO.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewIeIO.ParamsTypes

type
  TkwEnMainMenuNewHfReferences = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.hfReferences
[panel]������� hfReferences ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfReferences >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfReferences(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
     {* ���������� ����� ������� .Ten_MainMenuNew.hfReferences }
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
  end;//TkwEnMainMenuNewHfReferences

// start class TkwEnMainMenuNewHfReferences

function TkwEnMainMenuNewHfReferences.HfReferences(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {-}
begin
 Result := aen_MainMenuNew.hfReferences;
end;//TkwEnMainMenuNewHfReferences.HfReferences

procedure TkwEnMainMenuNewHfReferences.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfReferences(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewHfReferences.DoDoIt

class function TkwEnMainMenuNewHfReferences.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.hfReferences';
end;//TkwEnMainMenuNewHfReferences.GetWordNameForRegister

procedure TkwEnMainMenuNewHfReferences.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� hfReferences', aCtx);
end;//TkwEnMainMenuNewHfReferences.SetValuePrim

function TkwEnMainMenuNewHfReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfReferences.GetResultTypeInfo

function TkwEnMainMenuNewHfReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewHfReferences.GetAllParamsCount

function TkwEnMainMenuNewHfReferences.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfReferences.ParamsTypes

type
  TkwEnMainMenuNewTvReferences = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.tvReferences
[panel]������� tvReferences ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvReferences >>> l_TnscTreeViewHotTruck
[code]  }
  private
  // private methods
   function TvReferences(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
     {* ���������� ����� ������� .Ten_MainMenuNew.tvReferences }
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
  end;//TkwEnMainMenuNewTvReferences

// start class TkwEnMainMenuNewTvReferences

function TkwEnMainMenuNewTvReferences.TvReferences(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {-}
begin
 Result := aen_MainMenuNew.tvReferences;
end;//TkwEnMainMenuNewTvReferences.TvReferences

procedure TkwEnMainMenuNewTvReferences.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvReferences(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewTvReferences.DoDoIt

class function TkwEnMainMenuNewTvReferences.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.tvReferences';
end;//TkwEnMainMenuNewTvReferences.GetWordNameForRegister

procedure TkwEnMainMenuNewTvReferences.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvReferences', aCtx);
end;//TkwEnMainMenuNewTvReferences.SetValuePrim

function TkwEnMainMenuNewTvReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvReferences.GetResultTypeInfo

function TkwEnMainMenuNewTvReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewTvReferences.GetAllParamsCount

function TkwEnMainMenuNewTvReferences.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvReferences.ParamsTypes

type
  TkwEnMainMenuNewHfLawNews = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.hfLawNews
[panel]������� hfLawNews ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfLawNews >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfLawNews(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
     {* ���������� ����� ������� .Ten_MainMenuNew.hfLawNews }
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
  end;//TkwEnMainMenuNewHfLawNews

// start class TkwEnMainMenuNewHfLawNews

function TkwEnMainMenuNewHfLawNews.HfLawNews(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {-}
begin
 Result := aen_MainMenuNew.hfLawNews;
end;//TkwEnMainMenuNewHfLawNews.HfLawNews

procedure TkwEnMainMenuNewHfLawNews.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfLawNews(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewHfLawNews.DoDoIt

class function TkwEnMainMenuNewHfLawNews.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.hfLawNews';
end;//TkwEnMainMenuNewHfLawNews.GetWordNameForRegister

procedure TkwEnMainMenuNewHfLawNews.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� hfLawNews', aCtx);
end;//TkwEnMainMenuNewHfLawNews.SetValuePrim

function TkwEnMainMenuNewHfLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfLawNews.GetResultTypeInfo

function TkwEnMainMenuNewHfLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewHfLawNews.GetAllParamsCount

function TkwEnMainMenuNewHfLawNews.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfLawNews.ParamsTypes

type
  TkwEnMainMenuNewTvLawNews = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.tvLawNews
[panel]������� tvLawNews ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvLawNews >>> l_TnscTreeViewHotTruck
[code]  }
  private
  // private methods
   function TvLawNews(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
     {* ���������� ����� ������� .Ten_MainMenuNew.tvLawNews }
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
  end;//TkwEnMainMenuNewTvLawNews

// start class TkwEnMainMenuNewTvLawNews

function TkwEnMainMenuNewTvLawNews.TvLawNews(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {-}
begin
 Result := aen_MainMenuNew.tvLawNews;
end;//TkwEnMainMenuNewTvLawNews.TvLawNews

procedure TkwEnMainMenuNewTvLawNews.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvLawNews(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewTvLawNews.DoDoIt

class function TkwEnMainMenuNewTvLawNews.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.tvLawNews';
end;//TkwEnMainMenuNewTvLawNews.GetWordNameForRegister

procedure TkwEnMainMenuNewTvLawNews.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvLawNews', aCtx);
end;//TkwEnMainMenuNewTvLawNews.SetValuePrim

function TkwEnMainMenuNewTvLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvLawNews.GetResultTypeInfo

function TkwEnMainMenuNewTvLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewTvLawNews.GetAllParamsCount

function TkwEnMainMenuNewTvLawNews.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvLawNews.ParamsTypes

type
  TkwEnMainMenuNewPnlMain = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.pnlMain
[panel]������� pnlMain ����� Ten_MainMenuNew[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlMain >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlMain(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
     {* ���������� ����� ������� .Ten_MainMenuNew.pnlMain }
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
  end;//TkwEnMainMenuNewPnlMain

// start class TkwEnMainMenuNewPnlMain

function TkwEnMainMenuNewPnlMain.PnlMain(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {-}
begin
 Result := aen_MainMenuNew.pnlMain;
end;//TkwEnMainMenuNewPnlMain.PnlMain

procedure TkwEnMainMenuNewPnlMain.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlMain(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewPnlMain.DoDoIt

class function TkwEnMainMenuNewPnlMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.pnlMain';
end;//TkwEnMainMenuNewPnlMain.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlMain.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwEnMainMenuNewPnlMain.SetValuePrim

function TkwEnMainMenuNewPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlMain.GetResultTypeInfo

function TkwEnMainMenuNewPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewPnlMain.GetAllParamsCount

function TkwEnMainMenuNewPnlMain.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlMain.ParamsTypes

type
  TkwEnMainMenuNewHfLastOpenDocs = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.hfLastOpenDocs
[panel]������� hfLastOpenDocs ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfLastOpenDocs >>> l_TnscHideField
[code]  }
  private
  // private methods
   function HfLastOpenDocs(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
     {* ���������� ����� ������� .Ten_MainMenuNew.hfLastOpenDocs }
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
  end;//TkwEnMainMenuNewHfLastOpenDocs

// start class TkwEnMainMenuNewHfLastOpenDocs

function TkwEnMainMenuNewHfLastOpenDocs.HfLastOpenDocs(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {-}
begin
 Result := aen_MainMenuNew.hfLastOpenDocs;
end;//TkwEnMainMenuNewHfLastOpenDocs.HfLastOpenDocs

procedure TkwEnMainMenuNewHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HfLastOpenDocs(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewHfLastOpenDocs.DoDoIt

class function TkwEnMainMenuNewHfLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.hfLastOpenDocs';
end;//TkwEnMainMenuNewHfLastOpenDocs.GetWordNameForRegister

procedure TkwEnMainMenuNewHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� hfLastOpenDocs', aCtx);
end;//TkwEnMainMenuNewHfLastOpenDocs.SetValuePrim

function TkwEnMainMenuNewHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuNewHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewHfLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuNewHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfLastOpenDocs.ParamsTypes

type
  TkwEnMainMenuNewTvLastOpenDocs = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MainMenuNew.tvLastOpenDocs
[panel]������� tvLastOpenDocs ����� Ten_MainMenuNew[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvLastOpenDocs >>> l_TnscTreeViewHotTruck
[code]  }
  private
  // private methods
   function TvLastOpenDocs(const aCtx: TtfwContext;
     aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
     {* ���������� ����� ������� .Ten_MainMenuNew.tvLastOpenDocs }
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
  end;//TkwEnMainMenuNewTvLastOpenDocs

// start class TkwEnMainMenuNewTvLastOpenDocs

function TkwEnMainMenuNewTvLastOpenDocs.TvLastOpenDocs(const aCtx: TtfwContext;
  aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {-}
begin
 Result := aen_MainMenuNew.tvLastOpenDocs;
end;//TkwEnMainMenuNewTvLastOpenDocs.TvLastOpenDocs

procedure TkwEnMainMenuNewTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MainMenuNew : Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvLastOpenDocs(aCtx, l_aen_MainMenuNew)));
end;//TkwEnMainMenuNewTvLastOpenDocs.DoDoIt

class function TkwEnMainMenuNewTvLastOpenDocs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MainMenuNew.tvLastOpenDocs';
end;//TkwEnMainMenuNewTvLastOpenDocs.GetWordNameForRegister

procedure TkwEnMainMenuNewTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvLastOpenDocs', aCtx);
end;//TkwEnMainMenuNewTvLastOpenDocs.SetValuePrim

function TkwEnMainMenuNewTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuNewTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMainMenuNewTvLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuNewTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvLastOpenDocs.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_MainMenuNew
 Tkw_Form_MainMenuNew.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlBaseSearch
 Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlBaseSearch_Push
 Tkw_MainMenuNew_Control_pnlBaseSearch_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlBaseSearchZone
 Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push
 Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlLogo
 Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlLogo_Push
 Tkw_MainMenuNew_Control_pnlLogo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbLogo
 Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbLogo_Push
 Tkw_MainMenuNew_Control_pbLogo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlSearches
 Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlSearches_Push
 Tkw_MainMenuNew_Control_pnlSearches_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flAttributeSearch
 Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flAttributeSearch_Push
 Tkw_MainMenuNew_Control_flAttributeSearch_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flSituationSearch
 Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flSituationSearch_Push
 Tkw_MainMenuNew_Control_flSituationSearch_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flPublishedSourceSearch
 Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push
 Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flDictionSearch
 Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_flDictionSearch_Push
 Tkw_MainMenuNew_Control_flDictionSearch_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlExpert
 Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlExpert_Push
 Tkw_MainMenuNew_Control_pnlExpert_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbExpert
 Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbExpert_Push
 Tkw_MainMenuNew_Control_pbExpert_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlOnLine
 Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlOnLine_Push
 Tkw_MainMenuNew_Control_pnlOnLine_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbOnLine
 Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbOnLine_Push
 Tkw_MainMenuNew_Control_pbOnLine_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbIntranet
 Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbIntranet_Push
 Tkw_MainMenuNew_Control_pbIntranet_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbCourtsOnline
 Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pbCourtsOnline_Push
 Tkw_MainMenuNew_Control_pbCourtsOnline_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfTaxes
 Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfTaxes_Push
 Tkw_MainMenuNew_Control_hfTaxes_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvTaxes
 Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvTaxes_Push
 Tkw_MainMenuNew_Control_tvTaxes_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlBanner
 Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlBanner_Push
 Tkw_MainMenuNew_Control_pnlBanner_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_ieBanner
 Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_ieBanner_Push
 Tkw_MainMenuNew_Control_ieBanner_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge
 Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push
 Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Component_ieIO
 Tkw_MainMenuNew_Component_ieIO.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfReferences
 Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfReferences_Push
 Tkw_MainMenuNew_Control_hfReferences_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvReferences
 Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvReferences_Push
 Tkw_MainMenuNew_Control_tvReferences_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfLawNews
 Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfLawNews_Push
 Tkw_MainMenuNew_Control_hfLawNews_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvLawNews
 Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvLawNews_Push
 Tkw_MainMenuNew_Control_tvLawNews_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlMain
 Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_pnlMain_Push
 Tkw_MainMenuNew_Control_pnlMain_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfLastOpenDocs
 Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_hfLastOpenDocs_Push
 Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvLastOpenDocs
 Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MainMenuNew_Control_tvLastOpenDocs_Push
 Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlBaseSearch
 TkwEnMainMenuNewPnlBaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlBaseSearchZone
 TkwEnMainMenuNewPnlBaseSearchZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlLogo
 TkwEnMainMenuNewPnlLogo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pbLogo
 TkwEnMainMenuNewPbLogo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlSearches
 TkwEnMainMenuNewPnlSearches.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_flAttributeSearch
 TkwEnMainMenuNewFlAttributeSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_flSituationSearch
 TkwEnMainMenuNewFlSituationSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_flPublishedSourceSearch
 TkwEnMainMenuNewFlPublishedSourceSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_flDictionSearch
 TkwEnMainMenuNewFlDictionSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlExpert
 TkwEnMainMenuNewPnlExpert.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pbExpert
 TkwEnMainMenuNewPbExpert.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlOnLine
 TkwEnMainMenuNewPnlOnLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pbOnLine
 TkwEnMainMenuNewPbOnLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pbIntranet
 TkwEnMainMenuNewPbIntranet.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pbCourtsOnline
 TkwEnMainMenuNewPbCourtsOnline.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_hfTaxes
 TkwEnMainMenuNewHfTaxes.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_tvTaxes
 TkwEnMainMenuNewTvTaxes.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlBanner
 TkwEnMainMenuNewPnlBanner.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_ieBanner
 TkwEnMainMenuNewIeBanner.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_hfLastOpenDocsRightEdge
 TkwEnMainMenuNewHfLastOpenDocsRightEdge.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_ieIO
 TkwEnMainMenuNewIeIO.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_hfReferences
 TkwEnMainMenuNewHfReferences.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_tvReferences
 TkwEnMainMenuNewTvReferences.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_hfLawNews
 TkwEnMainMenuNewHfLawNews.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_tvLawNews
 TkwEnMainMenuNewTvLawNews.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_pnlMain
 TkwEnMainMenuNewPnlMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_hfLastOpenDocs
 TkwEnMainMenuNewHfLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MainMenuNew_tvLastOpenDocs
 TkwEnMainMenuNewTvLastOpenDocs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� MainMenuNew
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MainMenuNew));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscFocusLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFocusLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscHideField
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscTreeViewHotTruck
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TImageEnView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TImageEnIO
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.