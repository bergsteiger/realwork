unit evAdjustNSRCToPage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/Tools/evAdjustNSRCToPage.pas"
// Начат: 17.11.2010 12:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Tools::TevAdjustNSRCToPage
//
// {RequestLink:241012792}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

type
 TevAdjustNSRCToPage = class
  {* [RequestLink:241012792] }
 public
 // public methods
   class procedure ProcessFile(const aFile: AnsiString);
 end;//TevAdjustNSRCToPage

implementation

uses
  ddSectionWithSub2Para,
  ddSectionRepair,
  ddNSRCGenerator,
  evdNSRCReader,
  l3Filer,
  evCustomTextFormatter,
  evSimpleTextPainter,
  l3Chars,
  k2TagGen,
  l3Base,
  l3Types,
  SysUtils,
  evEmptyTableEliminator
  ;

// start class TevAdjustNSRCToPage

class procedure TevAdjustNSRCToPage.ProcessFile(const aFile: AnsiString);
//#UC START# *4CE399BC02E3_4CE3998200D9_var*
var
 l_R : TevdNSRCReader;
 l_W : TddNSRCGenerator;
 l_Painter : TevCustomTextFormatter;
 l_G : Tk2TagGenerator;
 l_F : Tl3CustomDOSFiler;
//#UC END# *4CE399BC02E3_4CE3998200D9_var*
begin
//#UC START# *4CE399BC02E3_4CE3998200D9_impl*
 l_G := nil;
 try
  l_R := TevdNSRCReader.Make(aFile);
  try
   l_R.StrictFormat := false;
   l_W := TddNSRCGenerator.Create;
   try
    l_Painter := TevSimpleTextPainter.Create;
    try
     l_F := Tl3CustomDOSFiler.Make(ChangeFileExt(aFile, '.out'), l3_fmWrite);
     try
      l_W.Filer := l_F;
     finally
      FreeAndNil(l_F);
     end;//try..finally
     l_W.CodePage := CP_KeepExisting;
     with l_Painter do
     begin
      CodePage := CP_OEMLite;
      SBSDelimeter := '|';
      Generator := l_W;
      FormatOrdinalParas := true;
     end;//with l_Painter
     l3Set(l_G, l_Painter);
     TddSectionRepairFilter.SetTo(l_G);
     TddSectionWithSub2ParaFilter.SetTo(l_G);
     TevEmptyTableEliminator.SetTo(l_G);
     l_R.Generator := l_G;
    finally
     FreeAndNil(l_Painter);
    end;//try..finally
   finally
    FreeAndNil(l_W);
   end;//try..finally
   l_R.Execute;
  finally
   FreeAndNil(l_R);
  end;//try..finally
 finally
  FreeAndNil(l_G);
 end;//try..finally
//#UC END# *4CE399BC02E3_4CE3998200D9_impl*
end;//TevAdjustNSRCToPage.ProcessFile

end.