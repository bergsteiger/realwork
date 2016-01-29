{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcSyntaxReg;

interface

{$I dc.inc}
uses
  Classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  Controls, dcConsts, dcSyntax, dcSyEdForm;

type
  {$IFDEF D6}
  TDCDsgnProp=IProperty;
  {$ELSE}
  TDCDsgnProp=TPropertyEditor;
  {$ENDIF}

  TSyntaxSchemeProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TSyntaxParserEditor = class(TDefaultEditor)
  public
    {$IFDEF D6}
    procedure EditProperty(const PropertyEditor: TDCDsgnProp; var Continue: Boolean); override;
    {$ELSE}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ENDIF}
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

implementation

{$R *.res}

const
  SSyntaxScheme = 'SyntaxScheme'; //don't resource

{--------------------------------------------------------------------}

procedure TSyntaxSchemeProperty.Edit;
begin
  if EditSyntaxScheme(TSyntaxScheme(GetOrdValue)) then
    Modified;
end;

function TSyntaxSchemeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paReadOnly];
end;

{--------------------------------------------------------------------}

{$IFDEF D6}
procedure TSyntaxParserEditor.EditProperty(const PropertyEditor: TDCDsgnProp; var Continue: Boolean);
{$ELSE}
procedure TSyntaxParserEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ENDIF}
begin
  if PropertyEditor.GetName = SSyntaxScheme then
  begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;

{--------------------------------------------------------------------}

procedure TSyntaxParserEditor.ExecuteVerb(Index: Integer);
begin
  with TSyntaxParser(Component) do
    if EditSyntaxScheme(SyntaxScheme) then
      Designer.Modified;
end;

function TSyntaxParserEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := SSchemeEditor
  else
    Result := '';
end;

function TSyntaxParserEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{--------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDreamMemo, [TSyntaxParser]);
  RegisterPropertyEditor(TypeInfo(TSyntaxScheme), TSyntaxParser, SSyntaxScheme,
    TSyntaxSchemeProperty);
  RegisterComponentEditor(TSyntaxParser, TSyntaxParserEditor);

  RegisterPropertyEditor(TypeInfo(integer), TAttrItem, 'FontID', nil);
  RegisterPropertyEditor(TypeInfo(integer), TAttrItem, 'BlockID', nil);
  RegisterPropertyEditor(TypeInfo(Boolean), TAttrItem, 'UseDefFont', nil);
  RegisterPropertyEditor(TypeInfo(Boolean), TAttrItem, 'UseDefBack', nil);
  RegisterPropertyEditor(TypeInfo(string), TDefAttrItem, 'GlobalAttrID', nil);
end;

end.
