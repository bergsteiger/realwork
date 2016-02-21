unit Design_AttrValues;
 {* ������������ �������� ��������� �������� ����� ������� ����� Design }

// ������: "w:\common\components\gui\Garant\Everest\Design_AttrValues.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
{$If Defined(DesignTimeLibrary)}
 {* ������������ ������ AttrValues }
 str_TextStyle_MainMenu_Font_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenu_Font_Name_Value'; rValue : 'Verdana');
  {* ������������ �������� �������� TextStyle_MainMenu_Font_Name_Value }
 str_TextStyle_MainMenu_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenu_Name_Value'; rValue : '�������� ����');
  {* ������������ �������� �������� TextStyle_MainMenu_Name_Value }
 str_TextStyle_MainMenuConstPath_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuConstPath_Name_Value'; rValue : '���������� �����');
  {* ������������ �������� �������� TextStyle_MainMenuConstPath_Name_Value }
 str_TextStyle_MainMenuChangePath_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuChangePath_Name_Value'; rValue : '���������� �����');
  {* ������������ �������� �������� TextStyle_MainMenuChangePath_Name_Value }
 str_TextStyle_MainMenuHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuHeader_Name_Value'; rValue : '���������');
  {* ������������ �������� �������� TextStyle_MainMenuHeader_Name_Value }
 str_TextStyle_MainMenuInteractiveHeader_Name_Value: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_MainMenuInteractiveHeader_Name_Value'; rValue : '�������������');
  {* ������������ �������� �������� TextStyle_MainMenuInteractiveHeader_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenu_Font_Name_Value.Init;
 {* ������������� str_TextStyle_MainMenu_Font_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenu_Name_Value.Init;
 {* ������������� str_TextStyle_MainMenu_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuConstPath_Name_Value.Init;
 {* ������������� str_TextStyle_MainMenuConstPath_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuChangePath_Name_Value.Init;
 {* ������������� str_TextStyle_MainMenuChangePath_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuHeader_Name_Value.Init;
 {* ������������� str_TextStyle_MainMenuHeader_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)
{$If Defined(DesignTimeLibrary)}
 str_TextStyle_MainMenuInteractiveHeader_Name_Value.Init;
 {* ������������� str_TextStyle_MainMenuInteractiveHeader_Name_Value }
{$IfEnd} // Defined(DesignTimeLibrary)

end.
