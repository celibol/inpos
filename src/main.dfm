object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #304'npos Test - http://www.elibolyazilim.com'
  ClientHeight = 522
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 656
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 74
      Height = 13
      Caption = 'Uygulama Nosu'
    end
    object Label2: TLabel
      Left = 27
      Top = 43
      Width = 63
      Height = 13
      Caption = 'Cihaz Seri No'
    end
    object Label3: TLabel
      Left = 400
      Top = 16
      Width = 41
      Height = 13
      Caption = 'IP Adres'
    end
    object Label4: TLabel
      Left = 421
      Top = 43
      Width = 20
      Height = 13
      Caption = 'Port'
    end
    object appNo: TcxTextEdit
      Left = 96
      Top = 13
      TabOrder = 0
      Text = '1'
      Width = 265
    end
    object serNo: TcxTextEdit
      Left = 96
      Top = 40
      TabOrder = 1
      Width = 265
    end
    object port: TcxTextEdit
      Left = 447
      Top = 40
      TabOrder = 2
      Text = '59000'
      Width = 122
    end
    object ipAddr: TcxTextEdit
      Left = 447
      Top = 13
      TabOrder = 3
      Text = '000.000.000.000'
      Width = 122
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 73
    Width = 656
    Height = 399
    Align = alClient
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = uDS
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,#0.#0'
          Kind = skSum
          FieldName = 'TUTARI'
          Column = cxGrid1DBTableView1TUTARI
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      object cxGrid1DBTableView1RecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object cxGrid1DBTableView1CINSI: TcxGridDBColumn
        Caption = 'Cinsi'
        DataBinding.FieldName = 'CINSI'
        Width = 496
      end
      object cxGrid1DBTableView1MIKTARI: TcxGridDBColumn
        Caption = 'Miktar'#305
        DataBinding.FieldName = 'MIKTARI'
        Width = 90
      end
      object cxGrid1DBTableView1FIYATI: TcxGridDBColumn
        Caption = 'Fiyat'#305
        DataBinding.FieldName = 'FIYATI'
        Width = 90
      end
      object cxGrid1DBTableView1TUTARI: TcxGridDBColumn
        Caption = 'Tutar'#305
        DataBinding.FieldName = 'TUTARI'
        Options.Editing = False
        Options.Focusing = False
        Options.Grouping = False
        Width = 125
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 472
    Width = 656
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Button1: TButton
      AlignWithMargins = True
      Left = 389
      Top = 3
      Width = 129
      Height = 44
      Align = alRight
      Caption = 'Ba'#287'lan'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 524
      Top = 3
      Width = 129
      Height = 44
      Align = alRight
      Caption = #304'nit'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 134
      Height = 44
      Align = alLeft
      Caption = 'G'#246'nder'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 143
      Top = 3
      Width = 146
      Height = 44
      Align = alLeft
      Caption = 'Section Data'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object uD: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F03000000340000000100060043494E534900080000
      00060007004649594154490008000000060008004D494B544152490001060000
      0044454E454D4501000000000000284001000000000080364001040000005445
      535401000000000000364001333333333333C33F0107000000322E2054455354
      016666666666E62640010000000000000040}
    SortOptions = []
    Left = 336
    Top = 136
    object uDCINSI: TStringField
      FieldName = 'CINSI'
      Size = 52
    end
    object uDFIYATI: TFloatField
      FieldName = 'FIYATI'
      DisplayFormat = '#,#0.#0'
    end
    object uDMIKTARI: TFloatField
      FieldName = 'MIKTARI'
      DisplayFormat = '#,#0.#0'
    end
    object uDTUTARI: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TUTARI'
      DisplayFormat = '#,#0.#0'
      Calculated = True
    end
  end
  object uDS: TDataSource
    DataSet = uD
    OnDataChange = uDSDataChange
    Left = 432
    Top = 136
  end
end
