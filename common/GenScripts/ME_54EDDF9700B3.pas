unit evParaWordsPack;

interface

uses
 l3IntfUses
 , nevTools
 , l3Variant
 , l3Interfaces
 , evCustomEditorWindow
 , l3Types
 , k2Interfaces
 , nevBase
 , k2Prim
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3String
 , k2OpMisc
 , k2Facade
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TevParaWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TevParaWordsPackResNameGetter
 
 TkwParaBoolA = class(TtfwClassLike)
  {* ����� ������� Para:BoolA
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTag aPara Para:BoolA >>> l_Boolean
[code]  }
  function BoolA(const aCtx: TtfwContext;
   const aPara: InevPara;
   aTag: Integer): Boolean;
   {* ���������� ����� ������� Para:BoolA }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaBoolA
 
 TkwParaBoolW = class(TtfwClassLike)
  {* ����� ������� Para:BoolW
*������:*
[code]
 aTag aValue anEditor aPara Para:BoolW
[code]  }
  procedure BoolW(const aCtx: TtfwContext;
   const aPara: InevPara;
   anEditor: TevCustomEditorWindow;
   aValue: Boolean;
   aTag: Integer);
   {* ���������� ����� ������� Para:BoolW }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaBoolW
 
 TkwParaGetParent = class(TtfwClassLike)
  {* ����� ������� Para:GetParent
*��� ����������:* InevPara
*������:*
[code]
INTERFACE VAR l_InevPara
 aPara Para:GetParent >>> l_InevPara
[code]  }
  function GetParent(const aCtx: TtfwContext;
   const aPara: InevPara): InevPara;
   {* ���������� ����� ������� Para:GetParent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaGetParent
 
 TkwParaGetType = class(TtfwClassLike)
  {* ����� ������� Para:GetType
*��� ����������:* Tl3VariantDef
*������:*
[code]
OBJECT VAR l_Tl3VariantDef
 aPara Para:GetType >>> l_Tl3VariantDef
[code]  }
  function GetType(const aCtx: TtfwContext;
   const aPara: InevPara): Tl3VariantDef;
   {* ���������� ����� ������� Para:GetType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaGetType
 
 TkwParaIntA = class(TtfwClassLike)
  {* ����� ������� Para:IntA
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aTag aPara Para:IntA >>> l_Integer
[code]  }
  function IntA(const aCtx: TtfwContext;
   const aPara: InevPara;
   aTag: Integer): Integer;
   {* ���������� ����� ������� Para:IntA }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaIntA
 
 TkwParaIntW = class(TtfwClassLike)
  {* ����� ������� Para:IntW
*������:*
[code]
 aTag aValue anEditor aPara Para:IntW
[code]  }
  procedure IntW(const aCtx: TtfwContext;
   const aPara: InevPara;
   anEditor: TevCustomEditorWindow;
   aValue: Integer;
   aTag: Integer);
   {* ���������� ����� ������� Para:IntW }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaIntW
 
 TkwParaIsSame = class(TtfwClassLike)
  {* ����� ������� Para:IsSame
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aPara Para:IsSame >>> l_Boolean
[code]  }
  function IsSame(const aCtx: TtfwContext;
   const aPara: InevPara;
   const anOther: InevPara): Boolean;
   {* ���������� ����� ������� Para:IsSame }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaIsSame
 
 TkwParaStrA = class(TtfwClassLike)
  {* ����� ������� Para:StrA
*��� ����������:* Tl3WString
*������:*
[code]
STRING VAR l_Tl3WString
 aTag aPara Para:StrA >>> l_Tl3WString
[code]  }
  function StrA(const aCtx: TtfwContext;
   const aPara: InevPara;
   aTag: Integer): Tl3WString;
   {* ���������� ����� ������� Para:StrA }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaStrA
 
 TkwParaStyleName = class(TtfwClassLike)
  {* ����� ������� Para:StyleName
*��� ����������:* Tl3WString
*������:*
[code]
STRING VAR l_Tl3WString
 aPara Para:StyleName >>> l_Tl3WString
[code]  }
  function StyleName(const aCtx: TtfwContext;
   const aPara: InevPara): Tl3WString;
   {* ���������� ����� ������� Para:StyleName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaStyleName
 
 TkwParaText = class(TtfwClassLike)
  {* ����� ������� Para:Text
*��� ����������:* Tl3WString
*������:*
[code]
STRING VAR l_Tl3WString
 aPara Para:Text >>> l_Tl3WString
[code]  }
  function Text(const aCtx: TtfwContext;
   const aPara: InevPara): Tl3WString;
   {* ���������� ����� ������� Para:Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaText
 
 TkwParaTypeInherits = class(TtfwClassLike)
  {* ����� ������� Para:Type:Inherits
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTypeID aPara Para:Type:Inherits >>> l_Boolean
[code]  }
  function Type_Inherits(const aCtx: TtfwContext;
   const aPara: InevPara;
   aTypeID: Integer): Boolean;
   {* ���������� ����� ������� Para:Type:Inherits }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParaTypeInherits
 
end.
