object frmGerador: TfrmGerador
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Conversor de XML para PDF - Documento fiscais'
  ClientHeight = 492
  ClientWidth = 642
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 458
    Width = 642
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 742
    object btnBuscar: TSpeedButton
      Left = 282
      Top = 0
      Width = 180
      Height = 34
      Cursor = crHandPoint
      Hint = 'Localizar e selecionar arquivos xml'
      Align = alRight
      Caption = 'Buscar xml'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      Glyph.Data = {
        760C0000424D760C00000000000036000000280000001C0000001C0000000100
        200000000000400C000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000ACB84D2BADB54DC9ACB64DFCACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFCACB64DC8ACB84D2BACB64DCAACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DC8ACB64DFCACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFCACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFB1BA57FFF1F3E1FFC1C97BFFCED496FFE9ECD0FFC4CB81FFE8EBCEFFBEC5
        73FFE7EACBFFBFC775FFEEF0DBFFB6BF63FFF4F5E7FFF4F5E7FFF4F5E7FFB2BB
        5AFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFDCE0B4FFE3E7C4FFF1F3
        E2FFCED496FFC8CF89FFF1F3E2FFD7DBA8FFFDFDFAFFCAD08DFFF8F9F0FFB8C0
        66FFFFFFFFFFB4BD5EFFB2BB59FFACB64EFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFB6BF63FFFDFDFAFFF7F8EEFFAFB853FFC8CF89FFEEF0DBFFEEF0
        DBFFDDE2B7FFDEE2B9FFF8F9F0FFB8C066FFFFFFFFFFAFB853FFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFB4BD5EFFFCFDF9FFF5F6
        E9FFAEB750FFC8CF89FFF3F4E5FFF0F2E0FFC0C878FFF3F4E4FFF8F9F0FFB8C0
        66FFFFFFFFFFAFB853FFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFD9DDADFFE5E8C8FFF3F4E5FFCBD18FFFC8CF89FFFFFFFFFFDBDF
        B2FFAEB851FFFBFCF7FFF8F9F0FFB8C066FFFFFFFFFFAFB853FFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFB0BA56FFF5F6E9FFC4CB81FFD1D7
        9DFFECEED6FFC6CD85FFF9FAF3FFC4CB81FFACB64DFFE5E8C6FFF3F4E5FFB7BF
        64FFF9FAF3FFAEB852FFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFCACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFCACB64DCBACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFADB54DC9AEB44B2CACB6
        4DCBACB64DFCACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB64DFFACB6
        4DFCACB64DCAACB84D2B00000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnBuscarClick
      OnMouseEnter = btnBuscarMouseEnter
      OnMouseLeave = btnBuscarMouseLeave
      ExplicitLeft = 242
    end
    object btnExportar: TSpeedButton
      Left = 462
      Top = 0
      Width = 180
      Height = 34
      Cursor = crHandPoint
      Hint = 'Exportar dos arquivos xml para pdf'
      Align = alRight
      Caption = 'Exportar dados'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      Glyph.Data = {
        760C0000424D760C00000000000036000000280000001C0000001C0000000100
        200000000000400C000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000066574223645B45A6555555030000
        00000000000000000000000000000000000000000000000000002159FF172256
        FF442256FF442256FF442256FF442256FF442256FF442256FF442256FF442256
        FF442256FF442256FF442256FF442256FF442256FF442256FF443D6EFF644D72
        F07B615D57E4645A45FF645B4687000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2F60FFFF6287FEFF646A82FF645A45FF645A45FF645A45FE635A
        46580000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF275BFFFF5D84FFFF6574A8FF645A
        45FF645A45FF645A45FF645A45FF645A46F5665B442D00000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2358
        FFFF527CFFFF657DCDFF645B47FF645A45FF645A45FF645A45FF645A45FF645A
        45FF635A45DF66594014000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF7193FFFFBBCCFFFF5C83FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF3E6DFFFF6587F4FF646777FF64646AFF6460
        5BFF645A45FF645A45FF645A45FF635945D0645A45CC645A4585000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFFC7D4FFFFFFFF
        FFFFFAFBFFFF577FFFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF4470
        FFFF658AFFFF658AFFFF658AFFFF6576B1FF645A45FF645A45FF645A45FF6155
        49150000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF4A75FFFFE4EBFFFFFFFFFFFFE3EAFFFF2C5FFFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF4975FFFF6576
        B1FF645A45FF645A45FF645A45FF615549150000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2B5E
        FFFF8CA7FFFFF4F6FFFFE0E7FFFF87A4FFFF3968FFFF2257FFFF2559FFFF6D90
        FFFF9BB3FFFF87A3FFFF4D77FFFF6576B1FF645A45FF645A45FF645A45FF6155
        49150000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF6F92FFFFFFFFFFFFD5DF
        FFFFFCFDFFFFD5DFFFFFD5DFFFFFFFFFFFFFFFFFFFFFFFFFFFFF688CFFFF6478
        B8FF645E54FF625B4EF6645A45EB5E5E43130000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2559FFFFE1E8FFFF7999FFFF527BFFFFFCFDFFFFC5D3FFFFD2DD
        FFFFE2E9FFFFC1D0FFFF517AFFFF658AFFFF658AFFFF4A75FF8E000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF87A3FFFFD5DF
        FFFFD7E1FFFFAABEFFFF2358FFFF2257FFFF2257FFFF2257FFFF2559FFFF275A
        FFFF275AFFFF2559FF5900000000000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF3968FFFFFCFDFFFFDDE5FFFF2A5DFFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2157FF55000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF3867FFFFFBFC
        FFFF86A3FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2157FF5500000000000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF89A5FFFFFFFFFFFFADC0FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2157FF55000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFFB7C8FFFFFFFF
        FFFFCED9FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2157FF5500000000000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFFABBFFFFFFFFFFFFFB8C9FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2157FF55000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF3A69FFFF82A0
        FFFF3969FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2157FF5500000000000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2157FF55000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF255AFFFF4975FEFF4975FEFF4975FEFF4975FEFF4975
        FEFF3162FFFF2157FF5500000000000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF3263FFFFE7E9
        FBFFE7E9FBFFE7E9FBFFE7E9FBFFB9C6FCFF2B5EFFF72458FF31000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF3263FFFFE7E9FBFFE7E9FBFFE7E9FBFFB9C6FCFF2B5E
        FFF92156FF4D0000000000000000000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF3263FFFFE7E9
        FBFFE7E9FBFFB9C6FCFF2B5EFFF92156FF4D0000000000000000000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF3263FFFFE7E9FBFFB9C6FCFF2B5EFFF92156FF4D0000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000002157FF552257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF3263FFFFB9C6
        FCFF2B5EFFF92156FF4D00000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000002157FF552257
        FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF275BFFFF2B5DFFF92156FF4D00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000002159FF172256FF442256FF442256FF442256FF442256
        FF442256FF442256FF442256FF442256FF442256FF442256FF442256FF442455
        FF2A000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnExportarClick
      OnMouseEnter = btnBuscarMouseEnter
      OnMouseLeave = btnBuscarMouseLeave
      ExplicitLeft = 442
    end
    object lblNotifica: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 222
      Height = 28
      Align = alLeft
      Caption = '------------------------------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 642
    Height = 458
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = -3
    ExplicitWidth = 742
    object dadosanexos: TGroupBox
      Left = 0
      Top = 71
      Width = 642
      Height = 387
      Align = alClient
      Caption = '[Anexos]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 198
      ExplicitTop = 187
      ExplicitWidth = 637
      ExplicitHeight = 351
      object ListBox1: TListBox
        Left = 2
        Top = 15
        Width = 638
        Height = 257
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 633
        ExplicitHeight = 317
      end
      object ProgressBar1: TProgressBar
        Left = 2
        Top = 368
        Width = 638
        Height = 17
        Align = alBottom
        TabOrder = 2
        ExplicitTop = 332
        ExplicitWidth = 633
      end
      object GroupBox2: TGroupBox
        Left = 2
        Top = 272
        Width = 638
        Height = 96
        Align = alBottom
        Caption = 'log'
        TabOrder = 1
        object Memo1: TMemo
          Left = 2
          Top = 15
          Width = 634
          Height = 79
          Align = alClient
          BorderStyle = bsNone
          ScrollBars = ssVertical
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 14
          ExplicitHeight = 88
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 642
      Height = 71
      Align = alTop
      Caption = 'Diret'#243'rio dos arquivos para exporta'#231#227'o'
      TabOrder = 0
      ExplicitWidth = 742
      object btnDir: TSpeedButton
        Left = 421
        Top = 35
        Width = 23
        Height = 22
        Hint = 'Clique para informar o local para exportar'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000008066FF14806AFF24806AFF248066
          FF14000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007E6AFDD77E6AFDFF7E6AFDFF7E6A
          FDD7000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007E69FDDC7E6AFDFF7E6AFDFF7E69
          FDDC000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007E69FDDC7E6AFDFF7E6AFDFF7E69
          FDDC000000000000000000000000000000000000000000000000000000000000
          00008066FF14806AFF24806AFF24806AFF247E6BFDE17E6AFDFF7E6AFDFF7E6B
          FDE1806AFF24806AFF24806AFF248066FF140000000000000000000000000000
          00007E6AFDD47E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6A
          FDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDD70000000000000000000000000000
          00007E69FDDC7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6A
          FDFF7E6AFDFF7E6AFDFF7E6AFDFF7E69FDDC0000000000000000000000000000
          00007E69FDDC7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6AFDFF7E6A
          FDFF7E6AFDFF7E6AFDFF7E6AFDFF7E69FDDC0000000000000000000000000000
          00007D69FD727E6AFD987E6AFD987E6AFD987E6AFDF17E6AFDFF7E6AFDFF7E6A
          FDF17E6AFD987E6AFD987E6AFD987E6BFD750000000000000000000000000000
          0000000000000000000000000000000000007E69FDDC7E6AFDFF7E6AFDFF7E69
          FDDC000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007E69FDDC7E6AFDFF7E6AFDFF7E69
          FDDC000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007E69FDDC7E6AFDFF7E6AFDFF7E69
          FDDC000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007D69FD727E6AFD987E6AFD987D69
          FD72000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnDirClick
        OnMouseEnter = btnBuscarMouseEnter
        OnMouseLeave = btnBuscarMouseLeave
      end
      object Label1: TLabel
        Left = 450
        Top = 15
        Width = 108
        Height = 13
        Caption = 'Tipo do documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object CheckBox1: TCheckBox
        Left = 15
        Top = 15
        Width = 386
        Height = 17
        Hint = 'Selecione para informar local manual'
        Caption = 'Alterar local para exporta'#231#227'o (padr'#227'o: app/files/)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object edtDiretorio: TEdit
        Left = 14
        Top = 35
        Width = 404
        Height = 21
        Enabled = False
        TabOrder = 1
        TextHint = 'local dos arquivos a serem exportados '
      end
      object tipodados: TComboBox
        Left = 450
        Top = 35
        Width = 177
        Height = 21
        Cursor = crHandPoint
        Style = csDropDownList
        CharCase = ecUpperCase
        TabOrder = 2
        TextHint = 'Selecione o documento'
        OnClick = btnBuscarClick
        Items.Strings = (
          'NFE/NFCE'
          'SAT'
          'MDFE'
          'NFSE'
          'CTE'
          'BPE'
          'GNRE')
      end
    end
  end
end
