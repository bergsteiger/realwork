object DSServerExpertsCreatorsModule: TDSServerExpertsCreatorsModule
  OldCreateOrder = False
  Height = 541
  Width = 604
  object CommonTemplateProperties: TExpertsTemplateProperties
    Left = 272
    Top = 16
  end
  object ServerContainerModule: TExpertsModule
    SourceTemplateFile = ServerContainerModuleSourceTemplate
    InterfaceTemplateFile = ServerContainerModuleIntfTemplate
    FormTemplateFile = ServerContainerDFMTemplate
    TemplateProperties = CommonTemplateProperties
    AncestorName = 'DataModule'
    FileName = 'ServerContainerUnit%d'
    FormName = 'ServerContainer%d'
    Left = 64
    Top = 288
  end
  object ProjectTemplate: TExpertsTemplateFile
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 64
    Top = 72
  end
  object DSStandAloneProject: TExpertsProject
    ProjectType = ptApplication
    ProjectTemplateFile = ProjectTemplate
    TemplateProperties = CommonTemplateProperties
    OnCreateModules = DSStandAloneProjectCreateModules
    Left = 64
    Top = 24
  end
  object ConsoleSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapVCLFormSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 464
    Top = 136
  end
  object ServerContainerModuleIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapModuleIntf=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 80
    Top = 344
  end
  object ServerContainerModuleSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapModuleSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 80
    Top = 448
  end
  object ServerContainerDFMTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapModuleDFMSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 80
    Top = 400
  end
  object ConsoleModule: TExpertsModule
    SourceTemplateFile = ConsoleSourceTemplate
    InterfaceTemplateFile = ConsoleIntfTemplate
    TemplateProperties = CommonTemplateProperties
    AncestorName = 'Form'
    Left = 464
    Top = 80
  end
  object ConsoleIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapVCLFormIntf=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 464
    Top = 192
  end
  object DataSnapTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles
    DelphiTemplateFile = 'newdatasnapmodules.pas'
    CBuilderTemplateFile = 'cpp\newdatasnapmodules.cpp'
    Left = 224
    Top = 272
  end
  object ServerConstSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'ServerConstSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 418
    Top = 396
  end
  object ServerConstIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'ServerConstIntf=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 416
    Top = 448
  end
  object ServerContainerConst: TExpertsUnit
    SourceTemplateFile = ServerConstSourceTemplate
    InterfaceTemplateFile = ServerConstIntfTemplate
    TemplateProperties = CommonTemplateProperties
    FileName = 'ServerConst%d'
    Left = 416
    Top = 336
  end
end
