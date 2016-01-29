unit NOT_FINISHED_ddRTFWriter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_ddRTFWriter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::Writers::ddRTFWriter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddRTFExpandedTextWriter,
  ddRTFProperties,
  ddCharacterProperty,
  ddParagraphProperty
  ;

type
 TCustomRTFObjectGenerator = class(TddRTFExpandedTextWriter)
 protected
 // realized methods
   function Style2RTF(aStyle: TddStyleEntry;
     aBlockIndent: Integer;
     anIgnoreLeftIndent: Boolean): AnsiString; override;
   function CHP2RTF(aCHP: TddCharacterProperty;
     aParent: TddCharacterProperty;
     const WithStyle: Boolean = True): AnsiString; override;
   function DIffCHP2RTF(aCHP1: TddCharacterProperty;
     aCHP2: TddCharacterProperty): AnsiString; override;
   function PAP2RTF(aPAP: TddParagraphProperty;
     aBlockIndent: Integer;
     anIgnoreLeftIndent: Boolean;
     WithStyle: Boolean = True): AnsiString; override;
 end;//TCustomRTFObjectGenerator

 TevRTFObjectGenerator = class(TCustomRTFObjectGenerator)
 end;//TevRTFObjectGenerator

implementation

uses
  ddDocument
  ;

// start class TCustomRTFObjectGenerator

function TCustomRTFObjectGenerator.Style2RTF(aStyle: TddStyleEntry;
  aBlockIndent: Integer;
  anIgnoreLeftIndent: Boolean): AnsiString;
//#UC START# *52DCEC00024A_52DCDACA038A_var*
//#UC END# *52DCEC00024A_52DCDACA038A_var*
begin
//#UC START# *52DCEC00024A_52DCDACA038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52DCEC00024A_52DCDACA038A_impl*
end;//TCustomRTFObjectGenerator.Style2RTF

function TCustomRTFObjectGenerator.CHP2RTF(aCHP: TddCharacterProperty;
  aParent: TddCharacterProperty;
  const WithStyle: Boolean = True): AnsiString;
//#UC START# *52DCEC4C0176_52DCDACA038A_var*
//#UC END# *52DCEC4C0176_52DCDACA038A_var*
begin
//#UC START# *52DCEC4C0176_52DCDACA038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52DCEC4C0176_52DCDACA038A_impl*
end;//TCustomRTFObjectGenerator.CHP2RTF

function TCustomRTFObjectGenerator.DIffCHP2RTF(aCHP1: TddCharacterProperty;
  aCHP2: TddCharacterProperty): AnsiString;
//#UC START# *52DCEC9D0243_52DCDACA038A_var*
//#UC END# *52DCEC9D0243_52DCDACA038A_var*
begin
//#UC START# *52DCEC9D0243_52DCDACA038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52DCEC9D0243_52DCDACA038A_impl*
end;//TCustomRTFObjectGenerator.DIffCHP2RTF

function TCustomRTFObjectGenerator.PAP2RTF(aPAP: TddParagraphProperty;
  aBlockIndent: Integer;
  anIgnoreLeftIndent: Boolean;
  WithStyle: Boolean = True): AnsiString;
//#UC START# *52DCF547032A_52DCDACA038A_var*
//#UC END# *52DCF547032A_52DCDACA038A_var*
begin
//#UC START# *52DCF547032A_52DCDACA038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52DCF547032A_52DCDACA038A_impl*
end;//TCustomRTFObjectGenerator.PAP2RTF
end.