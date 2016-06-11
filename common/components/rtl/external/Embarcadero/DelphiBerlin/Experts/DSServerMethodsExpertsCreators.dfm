object DSServerMethodsCreatorModule: TDSServerMethodsCreatorModule
  OldCreateOrder = False
  Height = 329
  Width = 585
  object ServerMethodsModuleSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DSServerModuleTemplate=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 416
    Top = 240
  end
  object DataSnapTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles
    DelphiTemplateFile = 'newdatasnapmodules.pas'
    CBuilderTemplateFile = 'cpp\newdatasnapmodules.cpp'
    Left = 128
    Top = 216
  end
  object ServerMethodsModuleIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DSServerModuleTemplateIntf=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 416
    Top = 184
  end
  object ServerMethodsModule: TExpertsModule
    SourceTemplateFile = ServerMethodsModuleSourceTemplate
    InterfaceTemplateFile = ServerMethodsModuleIntfTemplate
    FileName = 'ServerMethodsUnit%d'
    FormName = 'ServerMethods%d'
    Left = 416
    Top = 128
  end
  object ServerMethodUnitSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapServerMethodsClassTemplate=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 88
    Top = 144
  end
  object ServerMethodsUnitIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapServerMethodsClassTemplateIntf=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 88
    Top = 88
  end
  object ServerMethodsClassUnit: TExpertsClassUnit
    SourceTemplateFile = ServerMethodUnitSourceTemplate
    InterfaceTemplateFile = ServerMethodsUnitIntfTemplate
    FileName = 'ServerMethodsUnit%d'
    UnitClassName = 'ServerMethods%d'
    Left = 88
    Top = 40
  end
  object CommonTemplateProperties: TExpertsTemplateProperties
    Properties.Strings = (
      'IncludeSampleMethods=True'
      'ServerMethodsClass=True'
      'ServerMethodsUnitName=ServerMethodsUnit1'
      'ServerMethodsClassName=ServerMethodsClass1')
    Left = 272
    Top = 16
  end
end
