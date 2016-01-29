unit VGComboBoxPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$VG"
// ������: "VGComboBoxPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VG::VGSceneWords::VGComboBoxPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVGScene)}
uses
  vg_listbox,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts AND not NoVGScene

implementation

{$If not defined(NoScripts) AND not defined(NoVGScene)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *4797480437D2ci*
//#UC END# *4797480437D2ci*
//#UC START# *4797480437D2cit*
//#UC END# *4797480437D2cit*
 TVGComboBoxPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *4797480437D2publ*
//#UC END# *4797480437D2publ*
 end;//TVGComboBoxPackResNameGetter

// start class TVGComboBoxPackResNameGetter

class function TVGComboBoxPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'VGComboBoxPack';
end;//TVGComboBoxPackResNameGetter.ResName

 {$R VGComboBoxPack.res}

type
 TkwVgComboBoxGetText = {final scriptword} class(TtfwClassLike)
  {* ����� ������� vg:ComboBox:GetText
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aComboBox vg:ComboBox:GetText >>> l_String
[code]  }
 private
 // private methods
   function VgComboBoxGetText(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): AnsiString;
     {* ���������� ����� ������� vg:ComboBox:GetText }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetText

// start class TkwVgComboBoxGetText

function TkwVgComboBoxGetText.VgComboBoxGetText(const aCtx: TtfwContext;
  aComboBox: TvgComboBox): AnsiString;
//#UC START# *E6AB0BAEC690_3D1B97A2F7D1_var*
//#UC END# *E6AB0BAEC690_3D1B97A2F7D1_var*
begin
//#UC START# *E6AB0BAEC690_3D1B97A2F7D1_impl*
 Result := aComboBox.ListBox.Selected.Binding['text'];
//#UC END# *E6AB0BAEC690_3D1B97A2F7D1_impl*
end;//TkwVgComboBoxGetText.VgComboBoxGetText

procedure TkwVgComboBoxGetText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aComboBox : TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((VgComboBoxGetText(aCtx, l_aComboBox)));
end;//TkwVgComboBoxGetText.DoDoIt

class function TkwVgComboBoxGetText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vg:ComboBox:GetText';
end;//TkwVgComboBoxGetText.GetWordNameForRegister

function TkwVgComboBoxGetText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwVgComboBoxGetText.GetResultTypeInfo

function TkwVgComboBoxGetText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwVgComboBoxGetText.GetAllParamsCount

function TkwVgComboBoxGetText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxGetText.ParamsTypes

type
 TkwVgComboBoxItemHeight = {final scriptword} class(TtfwClassLike)
  {* ����� ������� vg:ComboBox:ItemHeight
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:ItemHeight >>> l_Integer
[code]  }
 private
 // private methods
   function VgComboBoxItemHeight(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
     {* ���������� ����� ������� vg:ComboBox:ItemHeight }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxItemHeight

// start class TkwVgComboBoxItemHeight

function TkwVgComboBoxItemHeight.VgComboBoxItemHeight(const aCtx: TtfwContext;
  aComboBox: TvgComboBox): Integer;
//#UC START# *3D92BC0DA86C_6AF76187796E_var*
//#UC END# *3D92BC0DA86C_6AF76187796E_var*
begin
//#UC START# *3D92BC0DA86C_6AF76187796E_impl*
 Result := Round(aComboBox.ItemHeight);
//#UC END# *3D92BC0DA86C_6AF76187796E_impl*
end;//TkwVgComboBoxItemHeight.VgComboBoxItemHeight

procedure TkwVgComboBoxItemHeight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aComboBox : TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((VgComboBoxItemHeight(aCtx, l_aComboBox)));
end;//TkwVgComboBoxItemHeight.DoDoIt

class function TkwVgComboBoxItemHeight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vg:ComboBox:ItemHeight';
end;//TkwVgComboBoxItemHeight.GetWordNameForRegister

function TkwVgComboBoxItemHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwVgComboBoxItemHeight.GetResultTypeInfo

function TkwVgComboBoxItemHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwVgComboBoxItemHeight.GetAllParamsCount

function TkwVgComboBoxItemHeight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxItemHeight.ParamsTypes

type
 TkwVgComboBoxItemIndex = {final scriptword} class(TtfwClassLike)
  {* ����� ������� vg:ComboBox:ItemIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:ItemIndex >>> l_Integer
[code]  }
 private
 // private methods
   function VgComboBoxItemIndex(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
     {* ���������� ����� ������� vg:ComboBox:ItemIndex }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxItemIndex

// start class TkwVgComboBoxItemIndex

function TkwVgComboBoxItemIndex.VgComboBoxItemIndex(const aCtx: TtfwContext;
  aComboBox: TvgComboBox): Integer;
//#UC START# *FD2233CED588_E6401AA7CFD9_var*
//#UC END# *FD2233CED588_E6401AA7CFD9_var*
begin
//#UC START# *FD2233CED588_E6401AA7CFD9_impl*
 Result := aComboBox.ItemIndex;
//#UC END# *FD2233CED588_E6401AA7CFD9_impl*
end;//TkwVgComboBoxItemIndex.VgComboBoxItemIndex

procedure TkwVgComboBoxItemIndex.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aComboBox : TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((VgComboBoxItemIndex(aCtx, l_aComboBox)));
end;//TkwVgComboBoxItemIndex.DoDoIt

class function TkwVgComboBoxItemIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vg:ComboBox:ItemIndex';
end;//TkwVgComboBoxItemIndex.GetWordNameForRegister

function TkwVgComboBoxItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwVgComboBoxItemIndex.GetResultTypeInfo

function TkwVgComboBoxItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwVgComboBoxItemIndex.GetAllParamsCount

function TkwVgComboBoxItemIndex.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxItemIndex.ParamsTypes

type
 TkwVgComboBoxGetItem = {final scriptword} class(TtfwClassLike)
  {* ����� ������� vg:ComboBox:GetItem
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 anIndex aComboBox vg:ComboBox:GetItem >>> l_String
[code]  }
 private
 // private methods
   function VgComboBoxGetItem(const aCtx: TtfwContext;
    aComboBox: TvgComboBox;
    anIndex: Integer): AnsiString;
     {* ���������� ����� ������� vg:ComboBox:GetItem }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetItem

// start class TkwVgComboBoxGetItem

function TkwVgComboBoxGetItem.VgComboBoxGetItem(const aCtx: TtfwContext;
  aComboBox: TvgComboBox;
  anIndex: Integer): AnsiString;
//#UC START# *543B6C62927E_F404139FE541_var*
//#UC END# *543B6C62927E_F404139FE541_var*
begin
//#UC START# *543B6C62927E_F404139FE541_impl*
 Result := aComboBox.ListBox.Items[anIndex].Binding['text'];
//#UC END# *543B6C62927E_F404139FE541_impl*
end;//TkwVgComboBoxGetItem.VgComboBoxGetItem

procedure TkwVgComboBoxGetItem.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aComboBox : TvgComboBox;
 l_anIndex : Integer;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((VgComboBoxGetItem(aCtx, l_aComboBox, l_anIndex)));
end;//TkwVgComboBoxGetItem.DoDoIt

class function TkwVgComboBoxGetItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vg:ComboBox:GetItem';
end;//TkwVgComboBoxGetItem.GetWordNameForRegister

function TkwVgComboBoxGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwVgComboBoxGetItem.GetResultTypeInfo

function TkwVgComboBoxGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwVgComboBoxGetItem.GetAllParamsCount

function TkwVgComboBoxGetItem.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox), TypeInfo(Integer)]);
end;//TkwVgComboBoxGetItem.ParamsTypes

type
 TkwVgComboBoxGetHighLightItemIndex = {final scriptword} class(TtfwClassLike)
  {* ����� ������� vg:ComboBox:GetHighLightItemIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aComboBox vg:ComboBox:GetHighLightItemIndex >>> l_Integer
[code]  }
 private
 // private methods
   function VgComboBoxGetHighLightItemIndex(const aCtx: TtfwContext;
    aComboBox: TvgComboBox): Integer;
     {* ���������� ����� ������� vg:ComboBox:GetHighLightItemIndex }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVgComboBoxGetHighLightItemIndex

// start class TkwVgComboBoxGetHighLightItemIndex

function TkwVgComboBoxGetHighLightItemIndex.VgComboBoxGetHighLightItemIndex(const aCtx: TtfwContext;
  aComboBox: TvgComboBox): Integer;
//#UC START# *7E4219389025_4E17F992CC09_var*
var
 l_Item: TvgListBoxItem;
//#UC END# *7E4219389025_4E17F992CC09_var*
begin
//#UC START# *7E4219389025_4E17F992CC09_impl*
 l_Item := aComboBox.ListBox.HighlightItem;
 if Assigned(l_Item) 
  then Result := l_Item.Index
  else Result := -1;
//#UC END# *7E4219389025_4E17F992CC09_impl*
end;//TkwVgComboBoxGetHighLightItemIndex.VgComboBoxGetHighLightItemIndex

procedure TkwVgComboBoxGetHighLightItemIndex.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aComboBox : TvgComboBox;
begin
 try
  l_aComboBox := TvgComboBox(aCtx.rEngine.PopObjAs(TvgComboBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComboBox: TvgComboBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((VgComboBoxGetHighLightItemIndex(aCtx, l_aComboBox)));
end;//TkwVgComboBoxGetHighLightItemIndex.DoDoIt

class function TkwVgComboBoxGetHighLightItemIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vg:ComboBox:GetHighLightItemIndex';
end;//TkwVgComboBoxGetHighLightItemIndex.GetWordNameForRegister

function TkwVgComboBoxGetHighLightItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwVgComboBoxGetHighLightItemIndex.GetResultTypeInfo

function TkwVgComboBoxGetHighLightItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwVgComboBoxGetHighLightItemIndex.GetAllParamsCount

function TkwVgComboBoxGetHighLightItemIndex.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgComboBox)]);
end;//TkwVgComboBoxGetHighLightItemIndex.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ������������ �����������
 TVGComboBoxPackResNameGetter.Register;
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� vg_ComboBox_GetText
 TkwVgComboBoxGetText.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� vg_ComboBox_ItemHeight
 TkwVgComboBoxItemHeight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� vg_ComboBox_ItemIndex
 TkwVgComboBoxItemIndex.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� vg_ComboBox_GetItem
 TkwVgComboBoxGetItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� vg_ComboBox_GetHighLightItemIndex
 TkwVgComboBoxGetHighLightItemIndex.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� TvgComboBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgComboBox));
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVGScene

end.