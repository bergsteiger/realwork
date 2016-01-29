unit Design_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/Design_Schema.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi::Everest::Standard::Design
//
// ����� ��� ��������� ��� Design-time
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(DesignTimeLibrary)}
uses
  Everest_Schema,
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a}
  ;
{$IfEnd} //DesignTimeLibrary

{$If defined(DesignTimeLibrary)}

type
 TDesignSchema = class(TEverestSchema)
 protected
 // ���������� ����������� ������ �����
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//TDesignSchema

{$IfEnd} //DesignTimeLibrary

implementation

{$If defined(DesignTimeLibrary)}
uses
  Graphics,
  Design_AttrValues,
  dsgnTextStyle_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  k2List {a},
  k2NonOptimizeContext {a}
  ;
{$IfEnd} //DesignTimeLibrary


{$If defined(DesignTimeLibrary)}

// start class TDesignSchema

constructor TDesignSchema.Create;
begin
 inherited;
 // TextStyle
 with t_TextStyle do
 begin
  Recalc;
  // �������� ����
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -29;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenu_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenu_Font_Name_Value.AsStr;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 8;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // ����� ��������� ����, ���������� �����.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -29;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -31;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuConstPath_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
     BoolW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // ����� ��������� ����, ���������� �����.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -29;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -32;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuChangePath_Name_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // ��������� ��������� ����.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -29;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -33;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuHeader_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clWhite;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // ��������� ��������� ����, ���������� ��������������.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -33;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -34;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_MainMenuInteractiveHeader_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
 end;//TextStyle
 t_TextStyle.Recalc;
end;

// ���������� ����������� ������ �����


procedure TDesignSchema.Cleanup;
begin
 inherited;
end;

{$IfEnd} //DesignTimeLibrary


initialization
{$If defined(DesignTimeLibrary)}
 TDesignSchema.SetAsDefault;
{$IfEnd} //DesignTimeLibrary


end.