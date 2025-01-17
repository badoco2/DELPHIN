unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls, uDTMConexao, uEnum;

type
  TfrmTelaHerenca = class(TForm)
    pgcPrincipal: TPageControl;
    Panel1: TPanel;
    TabListagem: TTabSheet;
    TabManutencao: TTabSheet;
    penListaTop: TPanel;
    mskPesquisa: TMaskEdit;
    btnPesquizar: TBitBtn;
    gridLista: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnFechar: TBitBtn;
    btnApagar: TBitBtn;
    btnNavigator: TDBNavigator;
    qryLista: TZQuery;
    dataLista: TDataSource;
    lblPesquisa: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridListaTitleClick(Column: TColumn);
    procedure mskPesquisaChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure gridListaDblClick(Sender: TObject);
  private

    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
    btnApagar:TBitBtn; btnNavigator:TDBNavigator; pgcPrincipal:TPageControl;
    Flag:Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; i: Integer);
    function RetornaCampoTraduzido(Campo: String): string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;

  public
     EstadoDoCadastro:TEstadoDoCadastro;
    IndiceAtual:string;
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; virtual;
    function Novo:Boolean; virtual;

  end;

var
  frmTelaHerenca: TfrmTelaHerenca;


implementation

{$R *.dfm}

{$region 'Fun�oes e procedimentos'}

procedure TfrmTelaHerenca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator,pgcPrincipal, false);
  EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHerenca.btnApagarClick(Sender: TObject);
begin
  try
    if (Apagar) then begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator,pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparEdits;
      qryLista.Refresh;
    end
    else begin
      qryLista.Refresh;
    end;
  finally
    EstadoDoCadastro := ecNenhum
  end;
end;

procedure TfrmTelaHerenca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator,pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
  LimparEdits

end;



procedure TfrmTelaHerenca.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmTelaHerenca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator,pgcPrincipal, false);
  EstadoDoCadastro := ecInserir;
  LimparEdits
end;

procedure TfrmTelaHerenca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TBitBtn;
  btnNavigator:TDBNavigator; pgcPrincipal:TPageControl; Flag: Boolean);
begin
      btnNovo.Enabled := Flag;
      btnAlterar.Enabled := Flag;
      btnCancelar.Enabled := Flag;
      btnGravar.Enabled := Flag;
      btnApagar.Enabled := Flag;
      btnNavigator.Enabled := Flag;
      pgcPrincipal .Pages[0].TabVisible := Flag;
      btnCancelar.Enabled := not(Flag);
      btnGravar.Enabled := not(Flag);
  end;

procedure TfrmTelaHerenca.ControlarIndiceTab(pgcPrincipal:TPageControl; i:Integer);
begin
  if(pgcPrincipal.Pages[i].TabVisible) then
    pgcPrincipal.TabIndex := i;
end;

procedure TfrmTelaHerenca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryLista.Close;
end;

procedure TfrmTelaHerenca.FormCreate(Sender: TObject);
begin
  qryLista.Connection := DTMPrincipal.ConexaoDB;
  dataLista.DataSet :=  qryLista;
  gridLista.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmTelaHerenca.FormShow(Sender: TObject);
begin
  if (qryLista.SQL.Text<>EmptyStr) then
    begin
      qryLista.IndexFieldNames:= IndiceAtual;
      ExibirLabelIndice(IndiceAtual, lblPesquisa);
      qryLista.Open;
    end;
    ControlarIndiceTab(pgcPrincipal, 0);
    DesabilitarEditPK;
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                    btnNavigator,pgcPrincipal, true);

end;







procedure TfrmTelaHerenca.gridListaDblClick(Sender: TObject);
begin
btnAlterar.Click;
end;

procedure TfrmTelaHerenca.gridListaTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  qryLista.IndexFieldNames:= IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblPesquisa);
end;

procedure TfrmTelaHerenca.mskPesquisaChange(Sender: TObject);
begin
  qryLista.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;



function TfrmTelaHerenca.RetornaCampoTraduzido(Campo:String):string;
  var I:Integer;
begin
  for I := 0 to qryLista.Fields.Count -1 do
    begin
      if LowerCase(qryLista.Fields[i].FieldName) = LowerCase(Campo) then
      begin
        Result:= qryLista.Fields[i].DisplayLabel;
        Break ;
      end;

    end;

end;

procedure TfrmTelaHerenca.ExibirLabelIndice(Campo:string; aLabel:TLabel);
begin
  aLabel.Caption:=RetornaCampoTraduzido(Campo);
end;

function TfrmTelaHerenca.ExisteCampoObrigatorio:Boolean;
Var i:Integer;
begin
  Result:= False;
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
         (TLabeledEdit(Components[i]).Text=EmptyStr) then begin
         MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption
         + ' � um campo Obrigatorio *', mtInformation, [mbOK],0);
         TLabeledEdit(Components[i]).SetFocus;
         Result := true;
         Break;
      end;

    end;
  end;

end;
//tag 1 � pra campos desabilitados
// Tag 2 � para campos obrigatorios

procedure TfrmTelaHerenca.DesabilitarEditPK;
var i:integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
        TLabeledEdit(Components[i]).Enabled:=false;
          Break;
      end;
    end;
  end;

end;

procedure TfrmTelaHerenca.LimparEdits;
var i:integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
      TLabeledEdit(Components[i]).Text:=EmptyStr;
    end
    else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text:=EmptyStr;

  end;

end;

{$endregion}

{$Region 'Metodos de Excluir'}
function TfrmTelaHerenca.Apagar: Boolean;
begin
  ShowMessage('Deletado');
  result:= True;
end;

function TfrmTelaHerenca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
       if(EstadoDoCadastro = ecInserir ) then
      ShowMessage('Inserido com sucesso')
    else if (EstadoDoCadastro = ecAlterar) then
         ShowMessage('Alterado com sucesso')
    else
      ShowMessage('Nenhuma altera��o foi feita');
end;

function TfrmTelaHerenca.Novo: Boolean;
begin

end;

{$endregion}


procedure TfrmTelaHerenca.btnGravarClick(Sender: TObject);
begin
  if (ExisteCampoObrigatorio) then begin
    abort;
  end;
  Try
    if Gravar(EstadoDoCadastro) then begin //Metodo Virtual
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavigator, pgcPrincipal,true);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro:=ecNenhum;
      LimparEdits;
      qryLista.Refresh;
    end
    else begin
      MessageDlg('Erro na grava��o!! ', mtWarning, [mbok],0)
    end;

  Finally
  End;
end;


end.
