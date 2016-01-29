unit DefineSearchDateKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/DefineSearchDateKeywordsPack.pas"
// �����: 08.09.2009 15:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������� ����������::Search::View::Search::Search::DefineSearchDateKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� DefineSearchDate
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
  vtPanel,
  DefineSearchDate_Form,
  vtDblClickDateEdit,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtRadioButton,
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
  Tkw_Form_DefineSearchDate = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� DefineSearchDate
----
*������ �������������*:
[code]
'aControl' �����::DefineSearchDate TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_DefineSearchDate

// start class Tkw_Form_DefineSearchDate

class function Tkw_Form_DefineSearchDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::DefineSearchDate';
end;//Tkw_Form_DefineSearchDate.GetWordNameForRegister

function Tkw_Form_DefineSearchDate.GetString: AnsiString;
 {-}
begin
 Result := 'en_DefineSearchDate';
end;//Tkw_Form_DefineSearchDate.GetString

type
  Tkw_DefineSearchDate_Control_Panel1 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Panel1
----
*������ �������������*:
[code]
�������::Panel1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_Panel1

// start class Tkw_DefineSearchDate_Control_Panel1

class function Tkw_DefineSearchDate_Control_Panel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Panel1';
end;//Tkw_DefineSearchDate_Control_Panel1.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_Panel1.GetString: AnsiString;
 {-}
begin
 Result := 'Panel1';
end;//Tkw_DefineSearchDate_Control_Panel1.GetString

class procedure Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_Panel1_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Panel1
----
*������ �������������*:
[code]
�������::Panel1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_Panel1_Push

// start class Tkw_DefineSearchDate_Control_Panel1_Push

procedure Tkw_DefineSearchDate_Control_Panel1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Panel1');
 inherited;
end;//Tkw_DefineSearchDate_Control_Panel1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_Panel1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Panel1:push';
end;//Tkw_DefineSearchDate_Control_Panel1_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_ElLabel1 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ElLabel1
----
*������ �������������*:
[code]
�������::ElLabel1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_ElLabel1

// start class Tkw_DefineSearchDate_Control_ElLabel1

class function Tkw_DefineSearchDate_Control_ElLabel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ElLabel1';
end;//Tkw_DefineSearchDate_Control_ElLabel1.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel1.GetString: AnsiString;
 {-}
begin
 Result := 'ElLabel1';
end;//Tkw_DefineSearchDate_Control_ElLabel1.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_ElLabel1_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ElLabel1
----
*������ �������������*:
[code]
�������::ElLabel1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_ElLabel1_Push

// start class Tkw_DefineSearchDate_Control_ElLabel1_Push

procedure Tkw_DefineSearchDate_Control_ElLabel1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ElLabel1');
 inherited;
end;//Tkw_DefineSearchDate_Control_ElLabel1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ElLabel1:push';
end;//Tkw_DefineSearchDate_Control_ElLabel1_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_ElLabel2 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ElLabel2
----
*������ �������������*:
[code]
�������::ElLabel2 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_ElLabel2

// start class Tkw_DefineSearchDate_Control_ElLabel2

class function Tkw_DefineSearchDate_Control_ElLabel2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ElLabel2';
end;//Tkw_DefineSearchDate_Control_ElLabel2.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel2.GetString: AnsiString;
 {-}
begin
 Result := 'ElLabel2';
end;//Tkw_DefineSearchDate_Control_ElLabel2.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_ElLabel2_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ElLabel2
----
*������ �������������*:
[code]
�������::ElLabel2:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_ElLabel2_Push

// start class Tkw_DefineSearchDate_Control_ElLabel2_Push

procedure Tkw_DefineSearchDate_Control_ElLabel2_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ElLabel2');
 inherited;
end;//Tkw_DefineSearchDate_Control_ElLabel2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel2_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ElLabel2:push';
end;//Tkw_DefineSearchDate_Control_ElLabel2_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_ElLabel3 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ElLabel3
----
*������ �������������*:
[code]
�������::ElLabel3 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_ElLabel3

// start class Tkw_DefineSearchDate_Control_ElLabel3

class function Tkw_DefineSearchDate_Control_ElLabel3.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ElLabel3';
end;//Tkw_DefineSearchDate_Control_ElLabel3.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_ElLabel3.GetString: AnsiString;
 {-}
begin
 Result := 'ElLabel3';
end;//Tkw_DefineSearchDate_Control_ElLabel3.GetString

class procedure Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_ElLabel3_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ElLabel3
----
*������ �������������*:
[code]
�������::ElLabel3:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_ElLabel3_Push

// start class Tkw_DefineSearchDate_Control_ElLabel3_Push

procedure Tkw_DefineSearchDate_Control_ElLabel3_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ElLabel3');
 inherited;
end;//Tkw_DefineSearchDate_Control_ElLabel3_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_ElLabel3_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ElLabel3:push';
end;//Tkw_DefineSearchDate_Control_ElLabel3_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_dD1EqD2 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� dD1EqD2
----
*������ �������������*:
[code]
�������::dD1EqD2 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_dD1EqD2

// start class Tkw_DefineSearchDate_Control_dD1EqD2

class function Tkw_DefineSearchDate_Control_dD1EqD2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD1EqD2';
end;//Tkw_DefineSearchDate_Control_dD1EqD2.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1EqD2.GetString: AnsiString;
 {-}
begin
 Result := 'dD1EqD2';
end;//Tkw_DefineSearchDate_Control_dD1EqD2.GetString

class procedure Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_dD1EqD2_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� dD1EqD2
----
*������ �������������*:
[code]
�������::dD1EqD2:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push

// start class Tkw_DefineSearchDate_Control_dD1EqD2_Push

procedure Tkw_DefineSearchDate_Control_dD1EqD2_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('dD1EqD2');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1EqD2_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD1EqD2:push';
end;//Tkw_DefineSearchDate_Control_dD1EqD2_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_rbEq = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� rbEq
----
*������ �������������*:
[code]
�������::rbEq TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_rbEq

// start class Tkw_DefineSearchDate_Control_rbEq

class function Tkw_DefineSearchDate_Control_rbEq.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbEq';
end;//Tkw_DefineSearchDate_Control_rbEq.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbEq.GetString: AnsiString;
 {-}
begin
 Result := 'rbEq';
end;//Tkw_DefineSearchDate_Control_rbEq.GetString

class procedure Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_rbEq_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� rbEq
----
*������ �������������*:
[code]
�������::rbEq:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_rbEq_Push

// start class Tkw_DefineSearchDate_Control_rbEq_Push

procedure Tkw_DefineSearchDate_Control_rbEq_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbEq');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbEq_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbEq_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbEq:push';
end;//Tkw_DefineSearchDate_Control_rbEq_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_rbInt = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� rbInt
----
*������ �������������*:
[code]
�������::rbInt TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_rbInt

// start class Tkw_DefineSearchDate_Control_rbInt

class function Tkw_DefineSearchDate_Control_rbInt.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbInt';
end;//Tkw_DefineSearchDate_Control_rbInt.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbInt.GetString: AnsiString;
 {-}
begin
 Result := 'rbInt';
end;//Tkw_DefineSearchDate_Control_rbInt.GetString

class procedure Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_rbInt_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� rbInt
----
*������ �������������*:
[code]
�������::rbInt:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_rbInt_Push

// start class Tkw_DefineSearchDate_Control_rbInt_Push

procedure Tkw_DefineSearchDate_Control_rbInt_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbInt');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbInt_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbInt_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbInt:push';
end;//Tkw_DefineSearchDate_Control_rbInt_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_rbD2Only = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� rbD2Only
----
*������ �������������*:
[code]
�������::rbD2Only TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_rbD2Only

// start class Tkw_DefineSearchDate_Control_rbD2Only

class function Tkw_DefineSearchDate_Control_rbD2Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbD2Only';
end;//Tkw_DefineSearchDate_Control_rbD2Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbD2Only.GetString: AnsiString;
 {-}
begin
 Result := 'rbD2Only';
end;//Tkw_DefineSearchDate_Control_rbD2Only.GetString

class procedure Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_rbD2Only_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� rbD2Only
----
*������ �������������*:
[code]
�������::rbD2Only:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_rbD2Only_Push

// start class Tkw_DefineSearchDate_Control_rbD2Only_Push

procedure Tkw_DefineSearchDate_Control_rbD2Only_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbD2Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbD2Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbD2Only_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbD2Only:push';
end;//Tkw_DefineSearchDate_Control_rbD2Only_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_dD1Only = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� dD1Only
----
*������ �������������*:
[code]
�������::dD1Only TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_dD1Only

// start class Tkw_DefineSearchDate_Control_dD1Only

class function Tkw_DefineSearchDate_Control_dD1Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD1Only';
end;//Tkw_DefineSearchDate_Control_dD1Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1Only.GetString: AnsiString;
 {-}
begin
 Result := 'dD1Only';
end;//Tkw_DefineSearchDate_Control_dD1Only.GetString

class procedure Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_dD1Only_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� dD1Only
----
*������ �������������*:
[code]
�������::dD1Only:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_dD1Only_Push

// start class Tkw_DefineSearchDate_Control_dD1Only_Push

procedure Tkw_DefineSearchDate_Control_dD1Only_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('dD1Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD1Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1Only_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD1Only:push';
end;//Tkw_DefineSearchDate_Control_dD1Only_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_dD2Only = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� dD2Only
----
*������ �������������*:
[code]
�������::dD2Only TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_dD2Only

// start class Tkw_DefineSearchDate_Control_dD2Only

class function Tkw_DefineSearchDate_Control_dD2Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD2Only';
end;//Tkw_DefineSearchDate_Control_dD2Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD2Only.GetString: AnsiString;
 {-}
begin
 Result := 'dD2Only';
end;//Tkw_DefineSearchDate_Control_dD2Only.GetString

class procedure Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_dD2Only_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� dD2Only
----
*������ �������������*:
[code]
�������::dD2Only:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_dD2Only_Push

// start class Tkw_DefineSearchDate_Control_dD2Only_Push

procedure Tkw_DefineSearchDate_Control_dD2Only_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('dD2Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD2Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD2Only_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD2Only:push';
end;//Tkw_DefineSearchDate_Control_dD2Only_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_dD1 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� dD1
----
*������ �������������*:
[code]
�������::dD1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_dD1

// start class Tkw_DefineSearchDate_Control_dD1

class function Tkw_DefineSearchDate_Control_dD1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD1';
end;//Tkw_DefineSearchDate_Control_dD1.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD1.GetString: AnsiString;
 {-}
begin
 Result := 'dD1';
end;//Tkw_DefineSearchDate_Control_dD1.GetString

class procedure Tkw_DefineSearchDate_Control_dD1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD1.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_dD1_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� dD1
----
*������ �������������*:
[code]
�������::dD1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_dD1_Push

// start class Tkw_DefineSearchDate_Control_dD1_Push

procedure Tkw_DefineSearchDate_Control_dD1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('dD1');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD1_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD1:push';
end;//Tkw_DefineSearchDate_Control_dD1_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_rbD1Only = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� rbD1Only
----
*������ �������������*:
[code]
�������::rbD1Only TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_rbD1Only

// start class Tkw_DefineSearchDate_Control_rbD1Only

class function Tkw_DefineSearchDate_Control_rbD1Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbD1Only';
end;//Tkw_DefineSearchDate_Control_rbD1Only.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_rbD1Only.GetString: AnsiString;
 {-}
begin
 Result := 'rbD1Only';
end;//Tkw_DefineSearchDate_Control_rbD1Only.GetString

class procedure Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_rbD1Only_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� rbD1Only
----
*������ �������������*:
[code]
�������::rbD1Only:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_rbD1Only_Push

// start class Tkw_DefineSearchDate_Control_rbD1Only_Push

procedure Tkw_DefineSearchDate_Control_rbD1Only_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbD1Only');
 inherited;
end;//Tkw_DefineSearchDate_Control_rbD1Only_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_rbD1Only_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::rbD1Only:push';
end;//Tkw_DefineSearchDate_Control_rbD1Only_Push.GetWordNameForRegister

type
  Tkw_DefineSearchDate_Control_dD2 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� dD2
----
*������ �������������*:
[code]
�������::dD2 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DefineSearchDate_Control_dD2

// start class Tkw_DefineSearchDate_Control_dD2

class function Tkw_DefineSearchDate_Control_dD2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD2';
end;//Tkw_DefineSearchDate_Control_dD2.GetWordNameForRegister

function Tkw_DefineSearchDate_Control_dD2.GetString: AnsiString;
 {-}
begin
 Result := 'dD2';
end;//Tkw_DefineSearchDate_Control_dD2.GetString

class procedure Tkw_DefineSearchDate_Control_dD2.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_DefineSearchDate_Control_dD2.RegisterInEngine

type
  Tkw_DefineSearchDate_Control_dD2_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� dD2
----
*������ �������������*:
[code]
�������::dD2:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DefineSearchDate_Control_dD2_Push

// start class Tkw_DefineSearchDate_Control_dD2_Push

procedure Tkw_DefineSearchDate_Control_dD2_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('dD2');
 inherited;
end;//Tkw_DefineSearchDate_Control_dD2_Push.DoDoIt

class function Tkw_DefineSearchDate_Control_dD2_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::dD2:push';
end;//Tkw_DefineSearchDate_Control_dD2_Push.GetWordNameForRegister

type
  TkwEnDefineSearchDatePanel1 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.Panel1
[panel]������� Panel1 ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_DefineSearchDate .Ten_DefineSearchDate.Panel1 >>> l_TvtPanel
[code]  }
  private
  // private methods
   function Panel1(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtPanel;
     {* ���������� ����� ������� .Ten_DefineSearchDate.Panel1 }
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
  end;//TkwEnDefineSearchDatePanel1

// start class TkwEnDefineSearchDatePanel1

function TkwEnDefineSearchDatePanel1.Panel1(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtPanel;
 {-}
begin
 Result := aen_DefineSearchDate.Panel1;
end;//TkwEnDefineSearchDatePanel1.Panel1

procedure TkwEnDefineSearchDatePanel1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Panel1(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDatePanel1.DoDoIt

class function TkwEnDefineSearchDatePanel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.Panel1';
end;//TkwEnDefineSearchDatePanel1.GetWordNameForRegister

procedure TkwEnDefineSearchDatePanel1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Panel1', aCtx);
end;//TkwEnDefineSearchDatePanel1.SetValuePrim

function TkwEnDefineSearchDatePanel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnDefineSearchDatePanel1.GetResultTypeInfo

function TkwEnDefineSearchDatePanel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDatePanel1.GetAllParamsCount

function TkwEnDefineSearchDatePanel1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDatePanel1.ParamsTypes

type
  TkwEnDefineSearchDateElLabel1 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.ElLabel1
[panel]������� ElLabel1 ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aen_DefineSearchDate .Ten_DefineSearchDate.ElLabel1 >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ElLabel1(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
     {* ���������� ����� ������� .Ten_DefineSearchDate.ElLabel1 }
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
  end;//TkwEnDefineSearchDateElLabel1

// start class TkwEnDefineSearchDateElLabel1

function TkwEnDefineSearchDateElLabel1.ElLabel1(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {-}
begin
 Result := aen_DefineSearchDate.ElLabel1;
end;//TkwEnDefineSearchDateElLabel1.ElLabel1

procedure TkwEnDefineSearchDateElLabel1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ElLabel1(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateElLabel1.DoDoIt

class function TkwEnDefineSearchDateElLabel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.ElLabel1';
end;//TkwEnDefineSearchDateElLabel1.GetWordNameForRegister

procedure TkwEnDefineSearchDateElLabel1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ElLabel1', aCtx);
end;//TkwEnDefineSearchDateElLabel1.SetValuePrim

function TkwEnDefineSearchDateElLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnDefineSearchDateElLabel1.GetResultTypeInfo

function TkwEnDefineSearchDateElLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateElLabel1.GetAllParamsCount

function TkwEnDefineSearchDateElLabel1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateElLabel1.ParamsTypes

type
  TkwEnDefineSearchDateElLabel2 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.ElLabel2
[panel]������� ElLabel2 ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aen_DefineSearchDate .Ten_DefineSearchDate.ElLabel2 >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ElLabel2(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
     {* ���������� ����� ������� .Ten_DefineSearchDate.ElLabel2 }
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
  end;//TkwEnDefineSearchDateElLabel2

// start class TkwEnDefineSearchDateElLabel2

function TkwEnDefineSearchDateElLabel2.ElLabel2(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {-}
begin
 Result := aen_DefineSearchDate.ElLabel2;
end;//TkwEnDefineSearchDateElLabel2.ElLabel2

procedure TkwEnDefineSearchDateElLabel2.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ElLabel2(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateElLabel2.DoDoIt

class function TkwEnDefineSearchDateElLabel2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.ElLabel2';
end;//TkwEnDefineSearchDateElLabel2.GetWordNameForRegister

procedure TkwEnDefineSearchDateElLabel2.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ElLabel2', aCtx);
end;//TkwEnDefineSearchDateElLabel2.SetValuePrim

function TkwEnDefineSearchDateElLabel2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnDefineSearchDateElLabel2.GetResultTypeInfo

function TkwEnDefineSearchDateElLabel2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateElLabel2.GetAllParamsCount

function TkwEnDefineSearchDateElLabel2.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateElLabel2.ParamsTypes

type
  TkwEnDefineSearchDateElLabel3 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.ElLabel3
[panel]������� ElLabel3 ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aen_DefineSearchDate .Ten_DefineSearchDate.ElLabel3 >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ElLabel3(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
     {* ���������� ����� ������� .Ten_DefineSearchDate.ElLabel3 }
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
  end;//TkwEnDefineSearchDateElLabel3

// start class TkwEnDefineSearchDateElLabel3

function TkwEnDefineSearchDateElLabel3.ElLabel3(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtLabel;
 {-}
begin
 Result := aen_DefineSearchDate.ElLabel3;
end;//TkwEnDefineSearchDateElLabel3.ElLabel3

procedure TkwEnDefineSearchDateElLabel3.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ElLabel3(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateElLabel3.DoDoIt

class function TkwEnDefineSearchDateElLabel3.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.ElLabel3';
end;//TkwEnDefineSearchDateElLabel3.GetWordNameForRegister

procedure TkwEnDefineSearchDateElLabel3.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ElLabel3', aCtx);
end;//TkwEnDefineSearchDateElLabel3.SetValuePrim

function TkwEnDefineSearchDateElLabel3.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnDefineSearchDateElLabel3.GetResultTypeInfo

function TkwEnDefineSearchDateElLabel3.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateElLabel3.GetAllParamsCount

function TkwEnDefineSearchDateElLabel3.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateElLabel3.ParamsTypes

type
  TkwEnDefineSearchDateDD1EqD2 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.dD1EqD2
[panel]������� dD1EqD2 ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD1EqD2 >>> l_TvtDblClickDateEdit
[code]  }
  private
  // private methods
   function DD1EqD2(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
     {* ���������� ����� ������� .Ten_DefineSearchDate.dD1EqD2 }
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
  end;//TkwEnDefineSearchDateDD1EqD2

// start class TkwEnDefineSearchDateDD1EqD2

function TkwEnDefineSearchDateDD1EqD2.DD1EqD2(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {-}
begin
 Result := aen_DefineSearchDate.dD1EqD2;
end;//TkwEnDefineSearchDateDD1EqD2.DD1EqD2

procedure TkwEnDefineSearchDateDD1EqD2.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DD1EqD2(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateDD1EqD2.DoDoIt

class function TkwEnDefineSearchDateDD1EqD2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.dD1EqD2';
end;//TkwEnDefineSearchDateDD1EqD2.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD1EqD2.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� dD1EqD2', aCtx);
end;//TkwEnDefineSearchDateDD1EqD2.SetValuePrim

function TkwEnDefineSearchDateDD1EqD2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD1EqD2.GetResultTypeInfo

function TkwEnDefineSearchDateDD1EqD2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateDD1EqD2.GetAllParamsCount

function TkwEnDefineSearchDateDD1EqD2.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD1EqD2.ParamsTypes

type
  TkwEnDefineSearchDateRbEq = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.rbEq
[panel]������� rbEq ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbEq >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbEq(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
     {* ���������� ����� ������� .Ten_DefineSearchDate.rbEq }
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
  end;//TkwEnDefineSearchDateRbEq

// start class TkwEnDefineSearchDateRbEq

function TkwEnDefineSearchDateRbEq.RbEq(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {-}
begin
 Result := aen_DefineSearchDate.rbEq;
end;//TkwEnDefineSearchDateRbEq.RbEq

procedure TkwEnDefineSearchDateRbEq.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbEq(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateRbEq.DoDoIt

class function TkwEnDefineSearchDateRbEq.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.rbEq';
end;//TkwEnDefineSearchDateRbEq.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbEq.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� rbEq', aCtx);
end;//TkwEnDefineSearchDateRbEq.SetValuePrim

function TkwEnDefineSearchDateRbEq.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbEq.GetResultTypeInfo

function TkwEnDefineSearchDateRbEq.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateRbEq.GetAllParamsCount

function TkwEnDefineSearchDateRbEq.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbEq.ParamsTypes

type
  TkwEnDefineSearchDateRbInt = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.rbInt
[panel]������� rbInt ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbInt >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbInt(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
     {* ���������� ����� ������� .Ten_DefineSearchDate.rbInt }
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
  end;//TkwEnDefineSearchDateRbInt

// start class TkwEnDefineSearchDateRbInt

function TkwEnDefineSearchDateRbInt.RbInt(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {-}
begin
 Result := aen_DefineSearchDate.rbInt;
end;//TkwEnDefineSearchDateRbInt.RbInt

procedure TkwEnDefineSearchDateRbInt.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbInt(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateRbInt.DoDoIt

class function TkwEnDefineSearchDateRbInt.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.rbInt';
end;//TkwEnDefineSearchDateRbInt.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbInt.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� rbInt', aCtx);
end;//TkwEnDefineSearchDateRbInt.SetValuePrim

function TkwEnDefineSearchDateRbInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbInt.GetResultTypeInfo

function TkwEnDefineSearchDateRbInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateRbInt.GetAllParamsCount

function TkwEnDefineSearchDateRbInt.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbInt.ParamsTypes

type
  TkwEnDefineSearchDateRbD2Only = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.rbD2Only
[panel]������� rbD2Only ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbD2Only >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbD2Only(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
     {* ���������� ����� ������� .Ten_DefineSearchDate.rbD2Only }
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
  end;//TkwEnDefineSearchDateRbD2Only

// start class TkwEnDefineSearchDateRbD2Only

function TkwEnDefineSearchDateRbD2Only.RbD2Only(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {-}
begin
 Result := aen_DefineSearchDate.rbD2Only;
end;//TkwEnDefineSearchDateRbD2Only.RbD2Only

procedure TkwEnDefineSearchDateRbD2Only.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbD2Only(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateRbD2Only.DoDoIt

class function TkwEnDefineSearchDateRbD2Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.rbD2Only';
end;//TkwEnDefineSearchDateRbD2Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbD2Only.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� rbD2Only', aCtx);
end;//TkwEnDefineSearchDateRbD2Only.SetValuePrim

function TkwEnDefineSearchDateRbD2Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbD2Only.GetResultTypeInfo

function TkwEnDefineSearchDateRbD2Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateRbD2Only.GetAllParamsCount

function TkwEnDefineSearchDateRbD2Only.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbD2Only.ParamsTypes

type
  TkwEnDefineSearchDateDD1Only = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.dD1Only
[panel]������� dD1Only ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD1Only >>> l_TvtDblClickDateEdit
[code]  }
  private
  // private methods
   function DD1Only(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
     {* ���������� ����� ������� .Ten_DefineSearchDate.dD1Only }
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
  end;//TkwEnDefineSearchDateDD1Only

// start class TkwEnDefineSearchDateDD1Only

function TkwEnDefineSearchDateDD1Only.DD1Only(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {-}
begin
 Result := aen_DefineSearchDate.dD1Only;
end;//TkwEnDefineSearchDateDD1Only.DD1Only

procedure TkwEnDefineSearchDateDD1Only.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DD1Only(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateDD1Only.DoDoIt

class function TkwEnDefineSearchDateDD1Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.dD1Only';
end;//TkwEnDefineSearchDateDD1Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD1Only.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� dD1Only', aCtx);
end;//TkwEnDefineSearchDateDD1Only.SetValuePrim

function TkwEnDefineSearchDateDD1Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD1Only.GetResultTypeInfo

function TkwEnDefineSearchDateDD1Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateDD1Only.GetAllParamsCount

function TkwEnDefineSearchDateDD1Only.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD1Only.ParamsTypes

type
  TkwEnDefineSearchDateDD2Only = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.dD2Only
[panel]������� dD2Only ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD2Only >>> l_TvtDblClickDateEdit
[code]  }
  private
  // private methods
   function DD2Only(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
     {* ���������� ����� ������� .Ten_DefineSearchDate.dD2Only }
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
  end;//TkwEnDefineSearchDateDD2Only

// start class TkwEnDefineSearchDateDD2Only

function TkwEnDefineSearchDateDD2Only.DD2Only(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {-}
begin
 Result := aen_DefineSearchDate.dD2Only;
end;//TkwEnDefineSearchDateDD2Only.DD2Only

procedure TkwEnDefineSearchDateDD2Only.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DD2Only(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateDD2Only.DoDoIt

class function TkwEnDefineSearchDateDD2Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.dD2Only';
end;//TkwEnDefineSearchDateDD2Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD2Only.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� dD2Only', aCtx);
end;//TkwEnDefineSearchDateDD2Only.SetValuePrim

function TkwEnDefineSearchDateDD2Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD2Only.GetResultTypeInfo

function TkwEnDefineSearchDateDD2Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateDD2Only.GetAllParamsCount

function TkwEnDefineSearchDateDD2Only.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD2Only.ParamsTypes

type
  TkwEnDefineSearchDateDD1 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.dD1
[panel]������� dD1 ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD1 >>> l_TvtDblClickDateEdit
[code]  }
  private
  // private methods
   function DD1(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
     {* ���������� ����� ������� .Ten_DefineSearchDate.dD1 }
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
  end;//TkwEnDefineSearchDateDD1

// start class TkwEnDefineSearchDateDD1

function TkwEnDefineSearchDateDD1.DD1(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {-}
begin
 Result := aen_DefineSearchDate.dD1;
end;//TkwEnDefineSearchDateDD1.DD1

procedure TkwEnDefineSearchDateDD1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DD1(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateDD1.DoDoIt

class function TkwEnDefineSearchDateDD1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.dD1';
end;//TkwEnDefineSearchDateDD1.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� dD1', aCtx);
end;//TkwEnDefineSearchDateDD1.SetValuePrim

function TkwEnDefineSearchDateDD1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD1.GetResultTypeInfo

function TkwEnDefineSearchDateDD1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateDD1.GetAllParamsCount

function TkwEnDefineSearchDateDD1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD1.ParamsTypes

type
  TkwEnDefineSearchDateRbD1Only = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.rbD1Only
[panel]������� rbD1Only ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtRadioButton
*������:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_DefineSearchDate .Ten_DefineSearchDate.rbD1Only >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbD1Only(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
     {* ���������� ����� ������� .Ten_DefineSearchDate.rbD1Only }
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
  end;//TkwEnDefineSearchDateRbD1Only

// start class TkwEnDefineSearchDateRbD1Only

function TkwEnDefineSearchDateRbD1Only.RbD1Only(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtRadioButton;
 {-}
begin
 Result := aen_DefineSearchDate.rbD1Only;
end;//TkwEnDefineSearchDateRbD1Only.RbD1Only

procedure TkwEnDefineSearchDateRbD1Only.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbD1Only(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateRbD1Only.DoDoIt

class function TkwEnDefineSearchDateRbD1Only.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.rbD1Only';
end;//TkwEnDefineSearchDateRbD1Only.GetWordNameForRegister

procedure TkwEnDefineSearchDateRbD1Only.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� rbD1Only', aCtx);
end;//TkwEnDefineSearchDateRbD1Only.SetValuePrim

function TkwEnDefineSearchDateRbD1Only.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnDefineSearchDateRbD1Only.GetResultTypeInfo

function TkwEnDefineSearchDateRbD1Only.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateRbD1Only.GetAllParamsCount

function TkwEnDefineSearchDateRbD1Only.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateRbD1Only.ParamsTypes

type
  TkwEnDefineSearchDateDD2 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_DefineSearchDate.dD2
[panel]������� dD2 ����� Ten_DefineSearchDate[panel]
*��� ����������:* TvtDblClickDateEdit
*������:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_DefineSearchDate .Ten_DefineSearchDate.dD2 >>> l_TvtDblClickDateEdit
[code]  }
  private
  // private methods
   function DD2(const aCtx: TtfwContext;
     aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
     {* ���������� ����� ������� .Ten_DefineSearchDate.dD2 }
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
  end;//TkwEnDefineSearchDateDD2

// start class TkwEnDefineSearchDateDD2

function TkwEnDefineSearchDateDD2.DD2(const aCtx: TtfwContext;
  aen_DefineSearchDate: Ten_DefineSearchDate): TvtDblClickDateEdit;
 {-}
begin
 Result := aen_DefineSearchDate.dD2;
end;//TkwEnDefineSearchDateDD2.DD2

procedure TkwEnDefineSearchDateDD2.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_DefineSearchDate : Ten_DefineSearchDate;
begin
 try
  l_aen_DefineSearchDate := Ten_DefineSearchDate(aCtx.rEngine.PopObjAs(Ten_DefineSearchDate));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_DefineSearchDate: Ten_DefineSearchDate : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DD2(aCtx, l_aen_DefineSearchDate)));
end;//TkwEnDefineSearchDateDD2.DoDoIt

class function TkwEnDefineSearchDateDD2.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_DefineSearchDate.dD2';
end;//TkwEnDefineSearchDateDD2.GetWordNameForRegister

procedure TkwEnDefineSearchDateDD2.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� dD2', aCtx);
end;//TkwEnDefineSearchDateDD2.SetValuePrim

function TkwEnDefineSearchDateDD2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnDefineSearchDateDD2.GetResultTypeInfo

function TkwEnDefineSearchDateDD2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnDefineSearchDateDD2.GetAllParamsCount

function TkwEnDefineSearchDateDD2.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_DefineSearchDate)]);
end;//TkwEnDefineSearchDateDD2.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_DefineSearchDate
 Tkw_Form_DefineSearchDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_Panel1
 Tkw_DefineSearchDate_Control_Panel1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_Panel1_Push
 Tkw_DefineSearchDate_Control_Panel1_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_ElLabel1
 Tkw_DefineSearchDate_Control_ElLabel1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_ElLabel1_Push
 Tkw_DefineSearchDate_Control_ElLabel1_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_ElLabel2
 Tkw_DefineSearchDate_Control_ElLabel2.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_ElLabel2_Push
 Tkw_DefineSearchDate_Control_ElLabel2_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_ElLabel3
 Tkw_DefineSearchDate_Control_ElLabel3.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_ElLabel3_Push
 Tkw_DefineSearchDate_Control_ElLabel3_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD1EqD2
 Tkw_DefineSearchDate_Control_dD1EqD2.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD1EqD2_Push
 Tkw_DefineSearchDate_Control_dD1EqD2_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbEq
 Tkw_DefineSearchDate_Control_rbEq.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbEq_Push
 Tkw_DefineSearchDate_Control_rbEq_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbInt
 Tkw_DefineSearchDate_Control_rbInt.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbInt_Push
 Tkw_DefineSearchDate_Control_rbInt_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbD2Only
 Tkw_DefineSearchDate_Control_rbD2Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbD2Only_Push
 Tkw_DefineSearchDate_Control_rbD2Only_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD1Only
 Tkw_DefineSearchDate_Control_dD1Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD1Only_Push
 Tkw_DefineSearchDate_Control_dD1Only_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD2Only
 Tkw_DefineSearchDate_Control_dD2Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD2Only_Push
 Tkw_DefineSearchDate_Control_dD2Only_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD1
 Tkw_DefineSearchDate_Control_dD1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD1_Push
 Tkw_DefineSearchDate_Control_dD1_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbD1Only
 Tkw_DefineSearchDate_Control_rbD1Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_rbD1Only_Push
 Tkw_DefineSearchDate_Control_rbD1Only_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD2
 Tkw_DefineSearchDate_Control_dD2.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DefineSearchDate_Control_dD2_Push
 Tkw_DefineSearchDate_Control_dD2_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_Panel1
 TkwEnDefineSearchDatePanel1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_ElLabel1
 TkwEnDefineSearchDateElLabel1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_ElLabel2
 TkwEnDefineSearchDateElLabel2.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_ElLabel3
 TkwEnDefineSearchDateElLabel3.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_dD1EqD2
 TkwEnDefineSearchDateDD1EqD2.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_rbEq
 TkwEnDefineSearchDateRbEq.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_rbInt
 TkwEnDefineSearchDateRbInt.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_rbD2Only
 TkwEnDefineSearchDateRbD2Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_dD1Only
 TkwEnDefineSearchDateDD1Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_dD2Only
 TkwEnDefineSearchDateDD2Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_dD1
 TkwEnDefineSearchDateDD1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_rbD1Only
 TkwEnDefineSearchDateRbD1Only.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_DefineSearchDate_dD2
 TkwEnDefineSearchDateDD2.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� DefineSearchDate
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_DefineSearchDate));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtDblClickDateEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtDblClickDateEdit));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtRadioButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.