unit TextLoad;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/TextLoad.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TTextLoad
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TextViaEditorProcessorPrim
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TTextLoad = class(TTextViaEditorProcessorPrim)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure LoadGK;
     {* Загрузка ГК }
   procedure LoadBigTableFromTextEVD;
     {* Загрузка боольшой таблицы из текстового EVD }
   procedure K172361288;
     {* Тест по мотивам [RequestLink:172361288]. }
 end;//TTextLoad
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  k2Base,
  ddSectionRepair,
  k2DocumentBuffer,
  SysUtils,
  k2TagGen,
  l3Variant,
  TextLoad_Form,
  TestFrameWork,
  vcmBase
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TTextLoad

procedure TTextLoad.LoadGK;
//#UC START# *4B30E6A60217_4B30C90601EB_var*
var
 l_F  : _FormClass_;
//#UC END# *4B30E6A60217_4B30C90601EB_var*
begin
//#UC START# *4B30E6A60217_4B30C90601EB_impl*
 //Assert(false);
 l_F := MakeForm;
 try
  l_F.Show;
  Load(l_F, 'gkbp2.evd', 'Load');
  Scroll(l_F, '1st');
  Scroll(l_F, '2nd');
  Scroll(l_F, '3rd');
  Scroll(l_F, '4th');
 finally
  l_F.Free;
 end;//try..finally
//#UC END# *4B30E6A60217_4B30C90601EB_impl*
end;//TTextLoad.LoadGK

procedure TTextLoad.LoadBigTableFromTextEVD;
//#UC START# *4B3248DC01E6_4B30C90601EB_var*
var
 l_F  : _FormClass_;
//#UC END# *4B3248DC01E6_4B30C90601EB_var*
begin
//#UC START# *4B3248DC01E6_4B30C90601EB_impl*
 l_F := MakeForm;
 try
  l_F.Show;
  Inc(g_DisableCheckDisabledChildren);
  try
   Load(l_F, 'bigTable.evd', 'Load');
  finally
   Dec(g_DisableCheckDisabledChildren);
  end;//try..finally
 finally
  l_F.Free;
 end;//try..finally
//#UC END# *4B3248DC01E6_4B30C90601EB_impl*
end;//TTextLoad.LoadBigTableFromTextEVD

procedure TTextLoad.K172361288;
//#UC START# *4B32542D039D_4B30C90601EB_var*
var
 l_F  : _FormClass_;
 l_G  : Tk2TagGenerator;
//#UC END# *4B32542D039D_4B30C90601EB_var*
begin
//#UC START# *4B32542D039D_4B30C90601EB_impl*
 l_F := MakeForm;
 try
  //l_F.Show;
  Inc(g_DisableCheckDisabledChildren);
  try
   Load(l_F, 'bigTable.evd', 'Load');
   l_G := Tk2DocumentBuffer.Create;
   try
    try
     TddSectionRepairFilter.SetTo(l_G);
     StartTimer;
     try
      l_F.TextSource.Save(l_G);
     finally
      StopTimer('Save');
     end;//try..finally
    except
     Ik2TagGenerator(l_G).NextGenerator := nil;
     raise;
    end;//try..except
   finally
    FreeAndNil(l_G);
   end;//try..finally
  finally
   Dec(g_DisableCheckDisabledChildren);
  end;//try..finally
 finally
  l_F.Free;
 end;//try..finally
//#UC END# *4B32542D039D_4B30C90601EB_impl*
end;//TTextLoad.K172361288

function TTextLoad.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TTextLoad.GetFolder

function TTextLoad.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B30C90601EB';
end;//TTextLoad.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

initialization
 TestFramework.RegisterTest(TTextLoad.Suite);

end.