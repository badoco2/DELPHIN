object MENUORINCIPAL: TMENUORINCIPAL
  Left = 0
  Top = 0
  Caption = 'MENU'
  ClientHeight = 270
  ClientWidth = 609
  Color = 12891332
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Menu: TMainMenu
    Left = 16
    Top = 16
    object C1: TMenuItem
      Caption = 'CADASTRO'
      object CLIENTE1: TMenuItem
        Caption = 'CLIENTE'
        ShortCut = 16460
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N1: TMenuItem
        Caption = 'CATEGORIA'
        ShortCut = 16451
        OnClick = N1Click
      end
      object PRODUTO1: TMenuItem
        Caption = 'PRODUTO'
        ShortCut = 16464
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object FECHAR1: TMenuItem
        Caption = 'FECHAR'
        ShortCut = 16454
        OnClick = FECHAR1Click
      end
    end
    object MOVIMENTAO1: TMenuItem
      Caption = 'MOVIMENTA'#199#195'O'
    end
    object RELATORIO1: TMenuItem
      Caption = 'RELATORIO'
    end
  end
end
