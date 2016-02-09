unit TextLoad;

// Модуль: "w:\common\components\gui\Garant\Daily\TextLoad.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessorPrim
;

type
 TTextLoad = class(TTextViaEditorProcessorPrim)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure LoadGK;
    {* Загрузка ГК }
   procedure LoadBigTableFromTextEVD;
    {* Загрузка боольшой таблицы из текстового EVD }
   procedure K_172361288;
    {* Тест по мотивам [RequestLink:172361288]. }
 end;//TTextLoad
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TextLoad_Form
 , TestFrameWork
 , k2Base
 , ddSectionRepair
 , k2DocumentBuffer
 , SysUtils
 , k2TagGen
 , l3Variant
 , vcmBase
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TTextLoad.LoadGK;
 {* Загрузка ГК }
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
 {* Загрузка боольшой таблицы из текстового EVD }
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

procedure TTextLoad.K_172361288;
 {* Тест по мотивам [RequestLink:172361288]. }
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
end;//TTextLoad.K_172361288

function TTextLoad.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TTextLoad.GetFolder

function TTextLoad.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B30C90601EB';
end;//TTextLoad.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TTextLoad.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
