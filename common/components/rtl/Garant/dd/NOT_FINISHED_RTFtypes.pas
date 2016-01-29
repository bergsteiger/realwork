unit NOT_FINISHED_RTFtypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_RTFtypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::ddCommon::RTFtypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\dd\ddDefine.inc}

interface

const
  { TddMainConst }
 rtfTwip = 1440;

type
 TddBorderRules = (
   
 );//TddBorderRules

 TPropType = (
   propNone
 , propChp
 , propPap
 , propSep
 , propDop
 , propStyle
 , propRow
 , propCell
 , propFrame
 , propFont
 , propTAB
 , propPict
 , propFormField
 , propLevel
 , propList
 , propColorTable
 );//TPropType

 TIProp = System.Integer;

 TRDS = (
   rdsSkip
 , rdsNorm
 , rdsFontTable
 , rdsStyleSheet
 , rdsColorTable
 , rdsFalt
 , rdsHeader
 , rdsFooter
 , rdsFName
 , rdsFootnote
 , rdsPicture
 , rdsPanose
 , rdsPictureProp
 , rdsField
 , rdsFieldInstruction
 , rdsFieldResult
 , rdsFormField
 , rdsFormFieldItem
 , rdsInfo
 , rdsTitle
 , rdsAuthor
 , rdsOperator
 , rdsCreaTim
 , rdsRevTim
 , rdsCompany
 , rdsUpr
 , rdsParaNum
 , rdsAnnotation
 , rdsNone
 , rdsListText
 , rdsBookmarkStart
 , rdsBookmarkEnd
 , rdsParaNumbered
 , rdsSkipGroup
 , rdsShp
 , rdsShpInst
 , rdsShpRslt
 , rdsShpTxt
 , rdsListTable
 , rdsListLevel
 , rdsLevelText
 , rdsList
 , rdslistoverride
 , rdslistoverridetable
 , rdslistpicture
 , rdsliststylename
 , rdsListName
 , rdsLevelNumbers
 , rdsOldParaNumbering
 );//TRDS

 TddBreakType = (
   breakPage
 , breakColumn
 , breakSection
 );//TddBreakType

 TddBorderType = (
   
 );//TddBorderType

 TddBorderParts = (
   bpTop
 , bpLeft
 , bpBottom
 , bpRight
 , bpHorizontal
 , bpVertical
 , bpBox
 );//TddBorderParts

 TrtfCharacterSet = (
   rtfANSI
 , rtfMac
 , rtfPC
 , rtfPCA
 );//TrtfCharacterSet

 TPGN = (
   pgDec
 , pgURom
 , pgLRom
 , pgULtr
 , pgLLtr
 , pgNotDefined
 );//TPGN

 TSBK = (
   sbkNon
 , sbkCol
 , sbkEvn
 , sbkOdd
 , sbkPg
 , sbkNotDefined
 );//TSBK

 TddStyleDef = (
   sdParagraph
 , sdCharacter
 , sdSection
 );//TddStyleDef

 TCharPosition = (
   cpNone
 , cpSuperScript
 , cpSubScript
 , cpNotDefined
 );//TCharPosition

 TUnderline = (
   utNone
 , utThick
 , utDotted
 , utDash
 , utDotDash
 , utDotDotDash
 , utDouble
 , utWord
 , utWave
 , utNotDefined
 );//TUnderline

 TFontFamily = (
   ffNil
 , ffRoman
 , ffSwiss
 , ffModern
 , ffScript
 , ffDecor
 , ffTech
 , ffBidi
 , ffNotDefined
 );//TFontFamily

 TFontType = (
   ftNil
 , ftTrueType
 , ftNotDefined
 );//TFontType

 TRTFPictureSkip = (
   rtf_psNo
 , rtf_psYes
 , rtf_psWMF
 );//TRTFPictureSkip

 TddFieldType = (
   dd_fieldUnknown
 , dd_fieldHyperlink
 , dd_fieldSymbol
 , dd_fieldForm
 , dd_fieldHyperlinkMailTo
 , dd_fieldPAGE
 );//TddFieldType

implementation

end.